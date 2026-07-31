# Audit the student dataset for data-quality issues

# Basic dataset summary
data_quality_summary <- tibble(
  observations = nrow(students),
  variables = ncol(students),
  total_missing_values = sum(is.na(students)),
  duplicate_rows = sum(duplicated(students))
)

data_quality_summary

# Missing values by variable
missing_summary <- students |>
  summarise(
    across(
      everything(),
      ~ sum(is.na(.))
    )
  ) |>
  pivot_longer(
    cols = everything(),
    names_to = "variable",
    values_to = "missing_count"
  ) |>
  mutate(
    missing_percentage =
      missing_count / nrow(students) * 100
  ) |>
  arrange(desc(missing_count))

missing_summary

# Check category values
category_checks <- tibble(
  invalid_target =
    sum(
      !students$target %in%
        c("Dropout", "Enrolled", "Graduate")
    ),

  invalid_tuition_status =
    sum(
      !students$tuition_fees_up_to_date %in%
        c(0, 1)
    ),

  invalid_debtor_status =
    sum(
      !students$debtor %in%
        c(0, 1)
    ),

  invalid_scholarship_status =
    sum(
      !students$scholarship_holder %in%
        c(0, 1)
    )
)

category_checks

# Check academic logic
academic_checks <- tibble(
  negative_enrolled =
    sum(
      students$curricular_units_1st_sem_enrolled < 0
    ),

  negative_approved =
    sum(
      students$curricular_units_1st_sem_approved < 0
    ),

  approved_greater_than_enrolled =
    sum(
      students$curricular_units_1st_sem_approved >
        students$curricular_units_1st_sem_enrolled
    ),

  negative_grade =
    sum(
      students$curricular_units_1st_sem_grade < 0
    ),

  zero_first_semester_grade =
    sum(
      students$curricular_units_1st_sem_grade == 0
    ),

  zero_enrolled_units =
    sum(
      students$curricular_units_1st_sem_enrolled == 0
    )
)

academic_checks

# Create issue summary
issue_summary <- tibble(
  issue = c(
    "Missing values",
    "Duplicate rows",
    "Invalid target values",
    "Invalid tuition codes",
    "Invalid debtor codes",
    "Invalid scholarship codes",
    "Negative enrolled units",
    "Negative approved units",
    "Approved units exceed enrolled units",
    "Negative grades"
  ),

  issue_count = c(
    sum(is.na(students)),
    sum(duplicated(students)),
    category_checks$invalid_target,
    category_checks$invalid_tuition_status,
    category_checks$invalid_debtor_status,
    category_checks$invalid_scholarship_status,
    academic_checks$negative_enrolled,
    academic_checks$negative_approved,
    academic_checks$approved_greater_than_enrolled,
    academic_checks$negative_grade
  )
)

issue_summary

# Create issue chart
ggplot(
  issue_summary,
  aes(
    x = reorder(issue, issue_count),
    y = issue_count
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Detected Data Quality Issues",
    x = "Data Quality Check",
    y = "Number of Issues"
  ) +
  theme_minimal()

# Flag records with major issues
students_with_flags <- students |>
  mutate(
    quality_issue =
      if_any(
        everything(),
        is.na
      ) |
      duplicated(students) |
      !target %in%
        c("Dropout", "Enrolled", "Graduate") |
      !tuition_fees_up_to_date %in%
        c(0, 1) |
      !debtor %in%
        c(0, 1) |
      !scholarship_holder %in%
        c(0, 1) |
      curricular_units_1st_sem_enrolled < 0 |
      curricular_units_1st_sem_approved < 0 |
      curricular_units_1st_sem_approved >
        curricular_units_1st_sem_enrolled |
      curricular_units_1st_sem_grade < 0
  )

records_affected <- sum(
  students_with_flags$quality_issue
)

records_affected_percentage <-
  records_affected / nrow(students) * 100

data_quality_score <-
  100 - records_affected_percentage

readiness_result <- case_when(
  records_affected == 0 ~
    "Ready for analysis",

  records_affected_percentage <= 5 ~
    "Ready with warnings",

  TRUE ~
    "Cleaning required"
)

quality_result <- tibble(
  records_affected = records_affected,
  records_affected_percentage =
    records_affected_percentage,
  data_quality_score =
    data_quality_score,
  readiness_result =
    readiness_result
)

quality_result
