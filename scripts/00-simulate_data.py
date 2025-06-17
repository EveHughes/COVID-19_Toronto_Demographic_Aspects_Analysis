#### Preamble ####
# Purpose: Simulates the dataset of COVID-19 cases in Toronto
# Author: Amie Liu
# Date: 16 January 2024
# Contact: amie.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
import numpy as np
import pandas as pd

#### Simulate data ####
# Number of cases and types of gender and age groups for simulating data
case_num = 412122
simulated_gender = ["Male", "Female", "Other"]
simulated_age = ["0-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80-89", "90+"]

# Set a random seed
np.random.seed(123)

# Generate simulated data
simulated_data = pd.DataFrame({
    "case_id": np.arange(1, case_num + 1),
    "gender": np.random.choice(simulated_gender, size=case_num, replace=True),
    "age_group": np.random.choice(simulated_age, size=case_num, replace=True)
})

print(simulated_data)

#### Test data ####
# Check if "gender" contains 3 genders
print(len(simulated_data["gender"].unique()) == 3)

# Check if "gender" contains 3 specified variables: "Male", "Female", and "Other"
print(set(simulated_data["gender"].unique()).issubset(set(["Male", "Female", "Other"])))

# Check if "age_group" contains 9 groups
print(len(simulated_data["age_group"].unique()) == 9)

# Check if the minimum value of "case_id" is 1
print(simulated_data["case_id"].min() == 1)

# Check if the length of "case_id" is 412122
print(len(simulated_data["case_id"]) == 412122)
