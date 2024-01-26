#### Preamble ####
# Purpose: Test cleaned COVID-19 cases data
# Author: Amie Liu
# Date: 25 January 2024
# Contact: amie.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   00-simulate_data.R
#   01-download_data.R
#   02-data_cleaning.R

#### Workspace setup ####
# install.packages("tidyverse")
# install.packages("janitor")

library(tidyverse)
library(janitor)

#### Test data ####
# Read data
cleaned_case_data <- read_csv("outputs/data/cleaned_case_data.csv")

# Test cleaned data
# Check if all column names match the specified names and order: "case_id", "age_group", "gender"
all(colnames(cleaned_case_data) == c("case_id", "age_group", "gender"))

# Check if the minimum value of "case_id" is 1
cleaned_case_data$case_id |> min() == 1

# Check if the length of "case_id" is 411700
cleaned_case_data$case_id |> length() == 411700

# Check if the class of "case_id" is numeric
cleaned_case_data$case_id |> class() == "numeric"

# Check if "age_group" contains 9 groups
cleaned_case_data$age_group |>
  unique() |>
  length() == 9

# Check if the length of "age_group" is 411700
cleaned_case_data$age_group |> length() == 411700

# Check if "gender" contains 3 genders
cleaned_case_data$gender |>
  unique() |>
  length() == 3

# Check if "gender" contains 3 specified variables: "Male", "Female", and "Other"
all(unique(cleaned_case_data$gender) %in% c("Male", "Female", "Other"))

# Check if the length of "gender" is 411700
cleaned_case_data$gender |> length() == 411700

