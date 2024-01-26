#### Preamble ####
# Purpose: Cleans the raw COVID-19 cases data
# Author: Amie Liu
# Date: 16 January 2024
# Contact: amie.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites:
#   00-simulate_data.R
#   01-download_data.R

#### Workspace setup ####
# install.packages("tidyverse")
# install.packages("janitor")

library(tidyverse)
library(janitor)

#### Clean data ####
# Read data
raw_case_data <- read_csv("inputs/data/raw_case_data.csv")

# Clean data, including case ID, age group, and gender
# Reference: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
cleaned_case_data <-
  raw_case_data |>
  # Clean the column names
  clean_names() |>
  # Transform the existing "age_group" values into standardized age groups
  mutate(
    age_group =
      case_match(
        age_group,
        "19 and younger" ~ "0-19",
        "20 to 29 Years" ~ "20-29",
        "30 to 39 Years" ~ "30-39",
        "40 to 49 Years" ~ "40-49",
        "50 to 59 Years" ~ "50-59",
        "60 to 69 Years" ~ "60-69",
        "70 to 79 Years" ~ "70-79",
        "80 to 89 Years" ~ "80-89",
        "90 and older" ~ "90+",
      )
  ) |>
  # Transform the existing "gender" values into standardized categories ("Female", "Male", or "Other")
  mutate(
    client_gender =
      case_match(
        client_gender,
        "FEMALE" ~ "Female",
        "MALE" ~ "Male",
        "UNKNOWN" ~ "Other",
        "NON-BINARY" ~ "Other",
        "OTHER" ~ "Other",
        "TRANSGENDER" ~ "Other",
        "TRANS WOMAN" ~ "Other",
        "TRANS MAN" ~ "Other",
        "NOT LISTED, PLEASE SPECIFY" ~ "Other",
      )
  ) |>
  # Rename the columns
  select(assigned_id, age_group, client_gender) |>
  rename(case_id = assigned_id,
         gender = client_gender
         ) |>
  # Remove any rows with missing values (NA) in the dataset
  tidyr::drop_na()

# Analyzed data, including age group and gender
analyzed_case_data <-
  cleaned_case_data |>
  select(age_group, gender)

#### Save data ####
# Save cleaned data
write_csv(cleaned_case_data, "outputs/data/cleaned_data.csv")

# Rename the cleaned data file
file.rename("outputs/data/cleaned_data.csv", "outputs/data/cleaned_case_data.csv")

# Save analyzed data
write_csv(analyzed_case_data, "outputs/data/analysis_data.csv")

# Rename the analyzed data file
file.rename("outputs/data/analysis_data.csv", "outputs/data/analyzed_case_data.csv")
