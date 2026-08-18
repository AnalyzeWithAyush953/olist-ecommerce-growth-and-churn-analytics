/* ==============================================================================
   PROJECT: Olist E-Commerce Growth & Churn Analytics
   SCRIPT: 03_rfm_customer_segmentation.sql
   DESCRIPTION: RFM customer segmentation using CTEs and NTILE(4) quartiles.
   ============================================================================== */

USE olist_analytics_db;

-- ------------------------------------------------------------------------------
-- 1. RFM METRICS & STATISTICAL QUARTILES CALCULATION
-- ------------------------------------------------------------------------------
WITH customer_rfm_raw AS (
    SELECT 
        c.customer_unique_id,
        -- Recency: Days between latest purchase and benchmark anchor date
        DATEDIFF('2018-09-03', MAX(o.order_purchase_timestamp)) AS recency_days,
        
        -- Frequency: Total distinct delivered orders placed
        COUNT(DISTINCT o.order_id) AS frequency_orders,
        
        -- Monetary: Total gross spend (item price + freight value)
        ROUND(SUM(oi.price + oi.freight_value), 2) AS monetary_value
    FROM olist_customers c
    JOIN olist_orders o 
        ON c.customer_id = o.customer_id
    JOIN olist_order_items oi 
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
rfm_quartiles AS (
    SELECT 
        customer_unique_id,
        recency_days,
        frequency_orders,
        monetary_value,
        -- Recency Score: Lower recency days = higher score (4 = Most Recent)
        NTILE(4) OVER (ORDER BY recency_days DESC) AS r_score,
        
        -- Frequency Score: Higher orders = higher score
        NTILE(4) OVER (ORDER BY frequency_orders ASC) AS f_score,
        
        -- Monetary Score: Higher total spend = higher score
        NTILE(4) OVER (ORDER BY monetary_value ASC) AS m_score
    FROM customer_rfm_raw
),
customer_segments AS (
    SELECT 
        customer_unique_id,
        recency_days,
        frequency_orders,
        monetary_value,
        CASE 
            WHEN r_score = 4 AND f_score >= 3 AND m_score >= 3 THEN 'Champions (VIP)'
            WHEN r_score >= 3 AND f_score >= 2 THEN 'Loyal Customers'
            WHEN r_score >= 3 AND f_score = 1 THEN 'Recent Buyers'
            WHEN r_score = 1 AND f_score >= 2 THEN 'At-Risk (High Value Churn)'
            WHEN r_score = 1 AND f_score = 1 THEN 'Lost / Churned'
            ELSE 'Potential Growth'
        END AS customer_segment
    FROM rfm_quartiles
)

-- ------------------------------------------------------------------------------
-- 2. SEGMENT AGGREGATION & REVENUE CONTRIBUTION SUMMARY
-- ------------------------------------------------------------------------------
SELECT 
    customer_segment,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_segments), 2) AS pct_of_customers,
    ROUND(AVG(recency_days), 1) AS avg_recency_days,
    ROUND(AVG(monetary_value), 2) AS avg_spend_per_customer,
    ROUND(SUM(monetary_value), 2) AS total_segment_revenue
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_segment_revenue DESC;