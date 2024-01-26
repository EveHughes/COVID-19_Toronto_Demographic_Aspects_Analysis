#### Preamble ####
# Purpose: Downloads and saves the data from the Open Data Toronto portal
# Author: Amie Liu
# Date: 16 January 2024
# Contact: amie.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
# install.packages("opendatatoronto")
# install.packages("tidyverse")

library(opendatatoronto)
library(tidyverse)

#### Download COVID-19 cases in Toronto data ####
# COVID-19 cases Dataset and code are from: https://open.toronto.ca/dataset/covid-19-cases-in-toronto/
# Get all resources from this package
resources <- list_package_resources("64b54586-6180-4485-83eb-81e8fae3b8fe")

# Identify datastore resources in csv format
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# Load the COVID-19 cases.csv
raw_case_data <- filter(datastore_resources, row_number()==2) |> get_resource()

raw_case_data

#### Save data ####
write_csv(raw_case_data, "inputs/data/raw_data.csv")

# Rename the file for raw data
file.rename("inputs/data/raw_data.csv", "inputs/data/raw_case_data.csv")
