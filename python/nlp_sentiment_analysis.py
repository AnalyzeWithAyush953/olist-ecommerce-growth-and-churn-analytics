"""PROJECT: Olist E-Commerce Growth & Churn Analytics

SCRIPT: nlp_sentiment_analysis.py
DESCRIPTION: Extracts customer reviews, scores sentiment polarity using VADER,
             and exports an enriched dataset for SQL & Power BI analytics.
"""

import os
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer
import pandas as pd
from sqlalchemy import URL, create_engine

# Download VADER lexicon
nltk.download("vader_lexicon")

# 1. Safe Database Connection Configuration (Handles special characters in password)
DB_USER = "root"
DB_PASS = "Ayush12@#" 
DB_HOST = "localhost"
DB_PORT = 3306
DB_NAME = "olist_analytics_db"

connection_url = URL.create(
    drivername="mysql+pymysql",
    username=DB_USER,
    password=DB_PASS,
    host=DB_HOST,
    port=DB_PORT,
    database=DB_NAME,
)

engine = create_engine(connection_url)

# 2. Extract Reviews from MySQL
print("Fetching review comments from MySQL database...")
query = """
SELECT 
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM olist_order_reviews
WHERE review_comment_message IS NOT NULL 
  AND TRIM(review_comment_message) != '';
"""

df_reviews = pd.read_sql(query, con=engine)
print(f"Retrieved {len(df_reviews):,} reviews with non-empty text feedback.")

# 3. Sentiment Polarity Scoring
sia = SentimentIntensityAnalyzer()


def classify_sentiment(compound_score, review_score):
    # Rule combining VADER compound metric with Olist rating score (1-5)
    if review_score <= 2 or compound_score <= -0.05:
        return "Negative"
    elif review_score == 3 or (-0.05 < compound_score < 0.05):
        return "Neutral"
    else:
        return "Positive"


print("Calculating sentiment polarity scores...")
df_reviews["sentiment_score"] = df_reviews["review_comment_message"].apply(
    lambda text: sia.polarity_scores(str(text))["compound"]
)

df_reviews["sentiment_label"] = df_reviews.apply(
    lambda row: classify_sentiment(row["sentiment_score"], row["review_score"]),
    axis=1,
)

# 4. Save Enriched Output to CSV & MySQL
output_dir = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), "..", "data", "processed"
)
os.makedirs(output_dir, exist_ok=True)
csv_output_path = os.path.join(output_dir, "sentiment_scored_reviews.csv")

df_reviews.to_csv(csv_output_path, index=False)
print(f"Enriched sentiment data saved to CSV: {csv_output_path}")

# Ingest back to MySQL as an analytical table
df_reviews.to_sql(
    "olist_sentiment_reviews",
    con=engine,
    if_exists="replace",
    index=False,
    chunksize=5000,
)
print("olist_sentiment_reviews table successfully created/updated in MySQL!")

# 5. Display Summary Breakdown
print("\n--- Sentiment Analysis Summary ---")
print(df_reviews["sentiment_label"].value_counts(normalize=True) * 100)