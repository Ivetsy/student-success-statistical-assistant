# Compare dropout rates by tuition-payment status

# Prepare the comparison variables
compare_data <- students |>
  mutate(
    dropout_status = if_else(
      target == "Dropout",
      "Dropout",
      "Not Dropout"
    ),
    tuition_status = if_else(
      tuition_fees_up_to_date == 1,
      "Up to date",
      "Not up to date"
    )
  )

# Group summary
compare_summary <- compare_data |>
  group_by(tuition_status) |>
  summarise(
    sample_size = n(),
    dropout_count = sum(dropout_status == "Dropout"),
    not_dropout_count = sum(dropout_status == "Not Dropout"),
    dropout_percentage =
      mean(dropout_status == "Dropout") * 100,
    .groups = "drop"
  )

compare_summary

# Proportion test
dropout_counts <- c(
  sum(
    compare_data$dropout_status == "Dropout" &
      compare_data$tuition_status == "Not up to date"
  ),
  sum(
    compare_data$dropout_status == "Dropout" &
      compare_data$tuition_status == "Up to date"
  )
)

group_sizes <- c(
  sum(compare_data$tuition_status == "Not up to date"),
  sum(compare_data$tuition_status == "Up to date")
)

comparison_test <- prop.test(
  x = dropout_counts,
  n = group_sizes,
  correct = FALSE
)

comparison_test

# Difference in dropout proportions
dropout_proportions <- dropout_counts / group_sizes

difference_in_proportions <-
  dropout_proportions[1] - dropout_proportions[2]

difference_in_proportions
comparison_test$conf.int
