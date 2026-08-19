# Olist E-Commerce: Growth, Churn & Customer Lifetime Analytics

Welcome to my end-to-end e-commerce data analytics portfolio project. This repository contains an enterprise data pipeline analyzing 100,000+ Brazilian retail orders to uncover customer churn drivers, segment purchasing behaviors (RFM), and evaluate customer satisfaction using AI sentiment intelligence.

---

## Tech Stack

* **Database Engine:** MySQL Workbench
* **Querying Techniques:** DDL Schemas, Relational Joins, CTEs, Window Functions (`NTILE`), `COALESCE` Imputation
* **Programming & NLP:** Python (`pandas`, `SQLAlchemy`, `pymysql`, `NLTK/VADER`)
* **Business Intelligence:** Power BI (Star Schema Modeling, DAX Measures, Cohort Retention)
* **Tools & Workflow:** Git, GitHub, VS Code

---

## Project Structure & Modules Index

* 📁 **[sql/](./sql/)**
  * [`01_schema_setup.sql`](./sql/01_schema_setup.sql): Database initialization, relational table constraints, and ingestion health checks.
  * [`02_data_cleaning_and_profiling.sql`](./sql/02_data_cleaning_and_profiling.sql): Missing value audit, timestamp imputation via `COALESCE`, and delivery performance classification.
  * [`03_rfm_customer_segmentation.sql`](./sql/03_rfm_customer_segmentation.sql): Customer RFM scoring and statistical quartile ranking using `NTILE(4)`.

* 📁 **[python/](./python/)**
  * [`load_data.py`](./python/load_data.py): Automated batch ETL pipeline inserting 443k+ records into MySQL in seconds.
  * [`nlp_sentiment_analysis.py`](./python/nlp_sentiment_analysis.py): Natural language sentiment scoring on Portuguese customer review feedback using NLTK VADER.

* 📁 **power_bi/**
  * `olist_customer_growth_and_churn_dashboard.pbix`: Interactive multi-page executive BI report.

* 📁 **[docs/](./docs/)**
  * [`project_architecture.md`](./docs/project_architecture.md): System design blueprints and data dictionary.

---

## Key Analytics Highlights

* **Automated Batch Ingestion:** Built a Python ETL loader batch-inserting ~443,000 records across 6 relational tables into MySQL.
* **Data Profiling & Cleaning:** Audited 2,965 missing delivery dates across 99,441 orders and constructed clean analytical views using `COALESCE` without row leakage.
* **RFM Customer Segmentation:** Classified 93,358 unique consumers into *Champions*, *Loyal Customers*, *Recent Buyers*, *Potential Growth*, and *At-Risk Churn* tiers using SQL quartile window functions.
* **AI Sentiment Intelligence:** Applied NLP sentiment analysis on Portuguese review feedback to isolate logistics bottlenecks and return drivers.
* **Executive Dashboards:** Designed interactive Power BI reports tracking Revenue KPIs, Customer Retention, and Delivery Risk Matrix.
