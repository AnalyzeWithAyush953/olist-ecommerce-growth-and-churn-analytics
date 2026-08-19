import os
import pandas as pd
from sqlalchemy import URL, create_engine

# Database Connection Details
DB_USER = "root"
DB_PASS = "Ayush12@#"
DB_HOST = "localhost"
DB_PORT = 3306
DB_NAME = "olist_analytics_db"

# URL.create handles '@' and '#' safely without URL parse breaks
connection_url = URL.create(
    drivername="mysql+pymysql",
    username=DB_USER,
    password=DB_PASS,
    host=DB_HOST,
    port=DB_PORT,
    database=DB_NAME,
)
engine = create_engine(connection_url)

# Output directory path
output_dir = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), "..", "data", "processed"
)
os.makedirs(output_dir, exist_ok=True)

# 6 Clean Analytical Tables to Export
tables = [
    "olist_customers",
    "olist_orders",
    "olist_order_items",
    "olist_products",
    "olist_sentiment_reviews",
    "view_clean_orders_logistics",
]

print("Exporting cleaned MySQL tables to CSV for Power BI...")
for table in tables:
    df = pd.read_sql_table(table, con=engine)
    file_path = os.path.join(output_dir, f"{table}.csv")
    df.to_csv(file_path, index=False)
    print(f"✓ Exported {table} ({len(df):,} rows) -> {file_path}")

print("\nAll tables exported successfully to data/processed/!")