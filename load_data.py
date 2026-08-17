import os
import pandas as pd
from sqlalchemy import URL, create_engine

# 1. Database Configuration
DB_USER = "root"
DB_PASS = "Ayush12@#"  # <-- Put your actual MySQL root password here
DB_HOST = "localhost"
DB_PORT = 3306
DB_NAME = "olist_analytics_db"

# Create connection URL safely handling special characters
connection_url = URL.create(
    drivername="mysql+pymysql",
    username=DB_USER,
    password=DB_PASS,
    host=DB_HOST,
    port=DB_PORT,
    database=DB_NAME,
)

engine = create_engine(connection_url)

# 2. Dataset Mapping
base_dir = os.path.dirname(os.path.abspath(__file__))
tables = {
    "olist_customers": "olist_customers_dataset.csv",
    "olist_orders": "olist_orders_dataset.csv",
    "olist_order_items": "olist_order_items_dataset.csv",
    "olist_products": "olist_products_dataset.csv",
    "olist_order_reviews": "olist_order_reviews_dataset.csv",
    "product_category_name_translation": "product_category_name_translation.csv",
}

# 3. Batch Loading Loop
print("Starting database ingestion...\n" + "-" * 40)
for table_name, file_name in tables.items():
    raw_path = os.path.join(base_dir, "data", "raw", file_name)
    root_path = os.path.join(base_dir, file_name)
    file_path = (
        raw_path
        if os.path.exists(raw_path)
        else (root_path if os.path.exists(root_path) else None)
    )

    if file_path:
        print(f"Reading {file_name}...")
        df = pd.read_csv(file_path)
        df.to_sql(
            table_name,
            con=engine,
            if_exists="append",
            index=False,
            chunksize=5000,
        )
        print(f"✓ {table_name}: Loaded {len(df):,} rows.")
    else:
        print(f"⚠ File not found: {file_name}")

print("-" * 40 + "\nAll datasets successfully loaded into MySQL!")