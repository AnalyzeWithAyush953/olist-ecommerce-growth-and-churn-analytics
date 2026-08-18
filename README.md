#  Olist E-Commerce: Growth, Churn & Customer Lifetime Analytics

An end-to-end data analytics engineering pipeline analyzing 100,000+ real Brazilian e-commerce orders to uncover customer churn drivers, segment purchasing behaviors (RFM), and evaluate customer satisfaction via NLP sentiment intelligence.

---

##  Project Architecture
Project Directory & Architecture Breakdown

olist-ecommerce-growth-and-churn-analytics/ (Root Project Folder)

data/

raw/: Unaltered Olist Kaggle CSV files (excluded by .gitignore)

processed/: Enriched and processed outputs (e.g., sentiment_scored_reviews.csv)

sql/: Relational database scripts

01_schema_setup.sql: Database creation, table schemas, and primary/foreign keys

02_rfm_customer_segmentation.sql: RFM segmentation and quartile window functions

03_delivery_and_churn_analysis.sql: Logistics metrics, freight costs, and churn analysis

python/: ETL pipelines and machine learning/NLP scripts

load_data.py: Automated batch data loader into MySQL

nlp_sentiment_analysis.py: Portuguese review text sentiment scoring

power_bi/: Visual business intelligence files

olist_customer_growth_and_churn_dashboard.pbix: Interactive dashboard report

screenshots/: Image exports for reports and portfolio presentation

docs/: Technical documentation and architecture records

project_architecture.md: System design, data dictionary, and folder schemas

.gitignore: Configuration file keeping large CSV files off GitHub

Tech Stack & Skills
Database & Querying: MySQL Workbench (DDL Schema, Relational Joins, CTEs, Window Functions NTILE)

Data Ingestion & AI/NLP: Python (pandas, SQLAlchemy, pymysql, NLTK/VADER)

Business Intelligence: Power BI (Star Schema Modeling, DAX Measures, Cohort Retention)

Version Control & Collaboration: Git, GitHub, VS Code

Analytics Highlights & Workflow
Automated Batch Ingestion: Built a Python ETL loader batch-inserting ~443,000 records across 6 relational tables into MySQL in seconds.

RFM Customer Segmentation: Analyzed 90k+ unique consumers into Champions, Loyal Customers, Recent Buyers, and At-Risk Churn tiers using SQL quartile window functions.

AI Sentiment Intelligence: Applied NLP sentiment analysis on Portuguese review feedback to isolate logistics bottlenecks and return drivers.

Executive Dashboards: Designed interactive Power BI reports tracking Revenue KPIs, Customer Retention, and Delivery Risk Matrix.



README.md: Executive project summary and business outcomes

