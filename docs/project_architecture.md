# Project Directory & Architecture Blueprint

```text
olist-ecommerce-growth-and-churn-analytics/
│
├── data/
│   ├── raw/                                     # Unaltered Olist Kaggle CSV files (Git ignored)
│   │   ├── olist_customers_dataset.csv
│   │   ├── olist_orders_dataset.csv
│   │   ├── olist_order_items_dataset.csv
│   │   ├── olist_order_reviews_dataset.csv
│   │   ├── olist_products_dataset.csv
│   │   └── product_category_name_translation.csv
│   │
│   └── processed/                               # Output files (e.g., sentiment_scored_reviews.csv)
│
├── sql/                                         # All SQL scripts
│   ├── 01_schema_setup.sql
│   ├── 02_data_cleaning_and_profiling.sql
│   └── 03_rfm_customer_segmentation.sql
│
├── python/                                      # Python ETL & NLP sentiment scripts
│   ├── load_data.py
│   └── nlp_sentiment_analysis.py
│
├── power_bi/                                    # Power BI reports & visual exports
│   ├── olist_customer_growth_and_churn_dashboard.pbix
│   └── screenshots/
│
├── docs/                                        # Architecture blueprints & data dictionaries
│   └── project_architecture.md
│
└── README.md                                    # Executive summary & business impact overview