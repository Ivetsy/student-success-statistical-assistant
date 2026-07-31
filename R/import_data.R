# Load required packages
library(tidyverse)
library(janitor)

# Import the student success dataset
students <- read_delim(
  "data.csv",
  delim = ";",
  show_col_types = FALSE
) |>
  clean_names()

# Display the dataset dimensions
dim(students)
