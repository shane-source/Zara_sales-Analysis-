# scripts/clean_data.py

import pandas as pd

# Load raw data
df = pd.read_csv('../data/raw_data.csv')

# Drop nulls in essential fields
df = df.dropna(subset=['Itemname', 'Sales_Volume', 'Price', 'Revenue'])

# Clean formatting
df.columns = df.columns.str.strip().str.lower()
df['itemname'] = df['itemname'].str.title().str.strip()
df['section'] = df['section'].str.title().str.strip()
df['promotion_type'] = df['promotion_type'].str.capitalize().str.strip()

# Save clean file
df.to_csv('../data/cleaned_data.csv', index=False