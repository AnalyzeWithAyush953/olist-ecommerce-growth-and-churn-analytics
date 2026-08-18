/* ==============================================================================
   PROJECT: Olist E-Commerce Growth & Churn Analytics
   SCRIPT: 02_data_cleaning_and_profiling.sql
   DESCRIPTION: Missing value audit, timestamp imputation using COALESCE,
                and logistics delivery performance classification.
   ============================================================================== */

USE olist_analytics_db;

-- ------------------------------------------------------------------------------
-- 1. IDENTIFY MISSING VALUES & DATA PROFILING AUDIT
-- ------------------------------------------------------------------------------
SELECT 
    COUNT(*) AS total_orders,
    COUNT(order_delivered_customer_date) AS delivered_recorded,
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS missing_delivery_dates,
    SUM(CASE WHEN order_status = 'canceled' THEN 1 ELSE 0 END) AS canceled_orders,
    SUM(CASE WHEN order_status = 'unavailable' THEN 1 ELSE 0 END) AS unavailable_orders
FROM olist_orders;

-- ------------------------------------------------------------------------------
-- 2. CREATE CLEANED LOGISTICS & ORDERS ANALYTICAL VIEW
-- ------------------------------------------------------------------------------
CREATE OR REPLACE VIEW view_clean_orders_logistics AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_estimated_delivery_date,
    o.order_delivered_customer_date,
    
    -- Impute missing delivery timestamp with estimated date for non-canceled orders
    COALESCE(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS effective_delivery_date,
    
    -- Calculate delivery lead time (in days)
    DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp) AS delivery_days_actual,
    
    -- Calculate logistics delay (positive = late, negative/zero = on-time)
    DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS delivery_delay_vs_estimated_days,
    
    -- Categorical delivery performance flag
    CASE 
        WHEN o.order_status = 'canceled' THEN 'Order Canceled'
        WHEN o.order_delivered_customer_date IS NULL THEN 'In Transit / Pending'
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Delayed Delivery'
        ELSE 'On-Time / Early'
    END AS delivery_performance_status
FROM olist_orders o;

-- ------------------------------------------------------------------------------
-- 3. AUDIT DELIVERY PERFORMANCE ACROSS DATASET
-- ------------------------------------------------------------------------------
SELECT 
    delivery_performance_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM view_clean_orders_logistics), 2) AS pct_of_total_orders
FROM view_clean_orders_logistics
GROUP BY delivery_performance_status
ORDER BY total_orders DESC;