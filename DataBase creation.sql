/* ==============================================================================
   PROJECT: Olist E-Commerce Growth & Churn Analytics
   SCRIPT: 01_schema_setup.sql
   DESCRIPTION: Complete database setup, DDL schema creation with primary/foreign 
                key structures, and post-import record validation checks.
   ============================================================================== */

-- ------------------------------------------------------------------------------
-- STEP 1: DATABASE INITIALIZATION
-- ------------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS olist_analytics_db;
USE olist_analytics_db;


-- ------------------------------------------------------------------------------
-- STEP 2: SCHEMA DEFINITIONS (DDL)
-- ------------------------------------------------------------------------------

-- 1. Customers Dimension Table
CREATE TABLE IF NOT EXISTS olist_customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10) );

-- 2. Orders Fact Table
CREATE TABLE IF NOT EXISTS olist_orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME);

-- 3. Order Items Fact Table (Composite Primary Key)
CREATE TABLE IF NOT EXISTS olist_order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
    PRIMARY KEY (order_id, order_item_id));

-- 4. Products Dimension Table
CREATE TABLE IF NOT EXISTS olist_products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT);

-- 5. Order Reviews Fact Table
CREATE TABLE IF NOT EXISTS olist_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME);

-- 6. Category Name Translation Lookup Table
CREATE TABLE IF NOT EXISTS product_category_name_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);

-- Verifying table structure
show tables;
describe olist_customers;
describe  olist_orders;
describe olist_products;
describe olist_order_reviews;
describe olist_order_items;
describe product_category_name_translation;


