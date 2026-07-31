# Check the dataset structure
dim(students)
names(students)

# Check missing values
missing_values <- colSums(is.na(students))
missing_values

# Check duplicate rows
duplicate_rows <- sum(duplicated(students))
duplicate_rows

# Confirm expected outcome categories
table(students$target)

# Basic validation message
if (sum(missing_values) == 0 && duplicate_rows == 0) {
  message("Data validation passed: no missing values or duplicate rows were found.")
} else {
  message("Data validation warning: review missing values or duplicate rows.")
}
