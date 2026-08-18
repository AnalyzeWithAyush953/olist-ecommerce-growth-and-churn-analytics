#  Olist E-Commerce: Growth, Churn & Customer Lifetime Analytics

An end-to-end data analytics engineering pipeline analyzing 100,000+ real Brazilian e-commerce orders to uncover customer churn drivers, segment purchasing behaviors (RFM), and evaluate customer satisfaction via NLP sentiment intelligence.

---

##  Project Architecture
```text
olist-ecommerce-growth-and-churn-analytics/
│
├── data/raw/                 # Raw Kaggle CSV datasets (Git ignored)
├── sql/                      # Relational schema, data cleaning & RFM queries
│   ├── 01_schema_setup.sql
│   └── 02_rfm_customer_segmentation.sql
├── python/                   # Ingestion scripts & NLP sentiment analysis
│   └── load_data.py
├── power_bi/                 # Power BI dashboards (.pbix) & visual exports
├── docs/                     # Data dictionary & project architecture blueprints
│   └── project_architecture.md
└── README.md                 # Executive project summary & business outcomes
