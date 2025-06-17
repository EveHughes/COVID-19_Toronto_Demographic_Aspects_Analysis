#### Preamble ####
# Purpose: Test cleaned COVID-19 cases data
# Author: Amie Liu
# Date: 25 January 2024
# Contact: amie.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   00-simulate_data.py
#   01-download_data.py
#   02-data_cleaning.py

#### Workspace setup ####
import unittest
import pandas as pd
import numpy as np

class TestCleanedCovidData(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.df = pd.read_csv("outputs/data/cleaned_case_data.csv")

    def test_column_names_and_order(self):
        expected_columns = ["case_id", "age_group", "gender"]
        self.assertEqual(list(self.df.columns), expected_columns, "Column names or order are incorrect")

    def test_case_id_min_value(self):
        self.assertEqual(self.df["case_id"].min(), 1, "Minimum case_id is not 1")

    def test_case_id_length(self):
        self.assertEqual(len(self.df["case_id"]), 411700, "case_id length is not 411700")

    def test_case_id_is_numeric(self):
        self.assertTrue(np.issubdtype(self.df["case_id"].dtype, np.number), "case_id is not numeric")

    def test_age_group_unique_count(self):
        self.assertEqual(self.df["age_group"].nunique(), 9, "age_group does not contain 9 unique values")

    def test_age_group_length(self):
        self.assertEqual(len(self.df["age_group"]), 411700, "age_group length is not 411700")

    def test_gender_unique_count(self):
        self.assertEqual(self.df["gender"].nunique(), 3, "gender does not contain 3 unique values")

    def test_gender_allowed_values(self):
        valid_genders = {"Male", "Female", "Other"}
        actual_values = set(self.df["gender"].unique())
        self.assertTrue(actual_values.issubset(valid_genders), f"Unexpected gender values: {actual_values}")

    def test_gender_length(self):
        self.assertEqual(len(self.df["gender"]), 411700, "gender length is not 411700")

if __name__ == "__main__":
    unittest.main()
