#  Olist E-Commerce: Growth, Churn & Customer Lifetime Analytics

An end-to-end data analytics engineering pipeline analyzing 100,000+ real Brazilian e-commerce orders to uncover customer churn drivers, segment purchasing behaviors (RFM), and evaluate customer satisfaction via NLP sentiment intelligence.

---

##  Project Architecture

```text
olist-ecommerce-growth-and-churn-analytics/
│
├── data/
│   ├── raw/                      # Raw Kaggle CSV datasets (Git ignored)
│   └── processed/                # Enriched output files
│
├── sql/                          # Relational schema & analytical queries
│   ├── 01_schema_setup.sql
│   ├── 02_rfm_customer_segmentation.sql
│   └── 03_delivery_and_churn_analysis.sql
│
├── python/                       # Ingestion scripts & NLP sentiment analysis
│   ├── load_data.py
│   └── nlp_sentiment_analysis.py
│
├── power_bi/                     # Power BI reports & visual exports
│   ├── olist_customer_growth_and_churn_dashboard.pbix
│   └── screenshots/
│
├── docs/                         # Architecture blueprints & data dictionaries
│   └── project_architecture.md
│
└── README.md                     # Executive project summary & business outcomes

## Tech Stack & Skills
Database & Querying: MySQL Workbench (DDL Schema, Relational Joins, CTEs, Window Functions NTILE)

Data Ingestion & AI/NLP: Python (pandas, SQLAlchemy, pymysql, NLTK/VADER)

Business Intelligence: Power BI (Star Schema Modeling, DAX Measures, Cohort Retention)

Version Control & Collaboration: Git, GitHub, VS Code

## Analytics Highlights & Workflow
Automated Batch Ingestion: Built a Python ETL loader batch-inserting ~443,000 records across 6 relational tables into MySQL in seconds.

RFM Customer Segmentation: Analyzed 90k+ unique consumers into Champions, Loyal Customers, Recent Buyers, and At-Risk Churn tiers using SQL quartile window functions.

AI Sentiment Intelligence: Applied NLP sentiment analysis on Portuguese review feedback to isolate logistics bottlenecks and return drivers.

Executive Dashboards: Designed interactive Power BI reports tracking Revenue KPIs, Customer Retention, and Delivery Risk Matrix.





