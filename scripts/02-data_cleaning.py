#### Preamble ####
# Purpose: Cleans the raw COVID-19 cases data
# Author: Amie Liu
# Date: 16 January 2024
# Contact: amie.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   00-simulate_data.py
#   01-download_data.py

#### Workspace setup ####
import pandas as pd
import numpy as np

#### Clean data ####
# Read raw data
raw_case_data = pd.read_csv("inputs/data/raw_case_data.csv")

# Standardize column names to snake_case
raw_case_data.columns = (
    raw_case_data.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
    .str.replace("-", "_")
)

# Map age group values
age_group_mapping = {
    "19 and younger": "0-19",
    "20 to 29 Years": "20-29",
    "30 to 39 Years": "30-39",
    "40 to 49 Years": "40-49",
    "50 to 59 Years": "50-59",
    "60 to 69 Years": "60-69",
    "70 to 79 Years": "70-79",
    "80 to 89 Years": "80-89",
    "90 and older": "90+"
}

# Map gender values
gender_mapping = {
    "FEMALE": "Female",
    "MALE": "Male",
    "UNKNOWN": "Other",
    "NON-BINARY": "Other",
    "OTHER": "Other",
    "TRANSGENDER": "Other",
    "TRANS WOMAN": "Other",
    "TRANS MAN": "Other",
    "NOT LISTED, PLEASE SPECIFY": "Other"
}

# Apply transformations
cleaned_case_data = raw_case_data.copy()
cleaned_case_data["age_group"] = cleaned_case_data["age_group"].map(age_group_mapping)
cleaned_case_data["client_gender"] = cleaned_case_data["client_gender"].map(gender_mapping)

# Select and rename columns
cleaned_case_data = cleaned_case_data[["assigned_id", "age_group", "client_gender"]].rename(
    columns={"assigned_id": "case_id", "client_gender": "gender"}
)

# Drop rows with any missing values
cleaned_case_data = cleaned_case_data.dropna()

# Select for analysis
analyzed_case_data = cleaned_case_data[["age_group", "gender"]]

# Save cleaned data
cleaned_case_data.to_csv("outputs/data/cleaned_case_data.csv", index=False)

# Save analyzed data
analyzed_case_data.to_csv("analyzed_case_data.csv", index=False)