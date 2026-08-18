# Olist E-Commerce: Growth, Churn & Customer Lifetime Analytics

Welcome to my end-to-end e-commerce data analytics portfolio project. This repository contains an enterprise data pipeline analyzing 100,000+ Brazilian retail orders to uncover customer churn drivers, segment purchasing behaviors (RFM), and evaluate customer satisfaction using AI sentiment intelligence.

---

## Tech Stack

* **Database Engine:** MySQL Workbench
* **Querying Techniques:** DDL Schemas, Relational Joins, CTEs, Window Functions (`NTILE`)
* **Programming & NLP:** Python (`pandas`, `SQLAlchemy`, `pymysql`, `NLTK/VADER`)
* **Business Intelligence:** Power BI (Star Schema Modeling, DAX Measures, Cohort Retention)
* **Tools & Workflow:** Git, GitHub, VS Code

---

## Project Structure & Modules Index

* 📁 **[sql/](./sql/)**
  * [`01_schema_setup.sql`](./sql/01_schema_setup.sql): Database initialization, relational table constraints, and ingestion health checks.
  * [`02_rfm_customer_segmentation.sql`](./sql/02_rfm_customer_segmentation.sql): RFM metric scoring and quartile ranking using window functions.
  * [`03_delivery_and_churn_analysis.sql`](./sql/03_delivery_and_churn_analysis.sql): Freight costs, delivery delay metrics, and customer churn drivers.

* 📁 **[python/](./load_data.py)**
  * [`load_data.py`](./load_data.py): Automated batch ETL pipeline inserting 443k+ records into MySQL in seconds.
  * [`nlp_sentiment_analysis.py`](./load_data.py): Natural language sentiment scoring on Portuguese customer review feedback.

* 📁 **power_bi/**
  * `olist_customer_growth_and_churn_dashboard.pbix`: Interactive multi-page executive BI report.

* 📁 **[docs/](./docs/)**
  * [`project_architecture.md`](./docs/project_architecture.md): System design blueprints and data dictionary.

---

## Key Analytics Highlights

* **Automated Batch Ingestion:** Built a Python ETL loader batch-inserting ~443,000 records across 6 relational tables into MySQL.
* **RFM Customer Segmentation:** Classified 90k+ unique consumers into *Champions*, *Loyal Customers*, *Recent Buyers*, and *At-Risk Churn* tiers using SQL quartile window functions.
* **AI Sentiment Intelligence:** Applied NLP sentiment analysis on Portuguese review feedback to isolate logistics bottlenecks and return drivers.
* **Executive Dashboards:** Designed interactive Power BI reports tracking Revenue KPIs, Customer Retention, and Delivery Risk Matrix.
