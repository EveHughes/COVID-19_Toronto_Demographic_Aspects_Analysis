#### Preamble ####
# Purpose: Simulates the dataset of COVID-19 cases in Toronto
# Author: Amie Liu
# Date: 16 January 2024
# Contact: amie.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
# install.packages("tidyverse")
# install.packages("janitor")

library(tidyverse)
library(janitor)

#### Simulate data ####
# Number of cases and types of gender and age groups for simulating data
case_num <- 412122
simulated_gender <- c("Male", "Female")
simulated_age <- c("0-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70-79", "80-89", "90+")

# Generate a dataset containing COVID-19 cases and genders
# Reference: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html#simulate
# Set a random seed
set.seed(123)

simulated_data <-
  tibble(
    # Use 1 through case_num to represent each case_id
    case_id = c(1:case_num),
    # Randomly pick an option for gender, with replacement, case_num times
    gender = sample(
      x = simulated_gender,
      size = case_num,
      replace = TRUE
    ),
    # Randomly pick an option for age group, with replacement, case_num times
    age_group = sample(
      x = simulated_age,
      size = case_num,
      replace = TRUE
    )
  )

simulated_data

#### Test data ####
# Reference: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html#simulate-2
# Check if "gender" contains 2 genders
simulated_data$gender |>
  unique() |>
  length() == 2

# Check if "age_group" contains 9 groups
simulated_data$age_group |>
  unique() |>
  length() == 9

# Check if the minimum value of "case_id" is 1
simulated_data$case_id |> min() == 1

# Check if the length of "case_id" is 412122
simulated_data$case_id |> length() == 412122
