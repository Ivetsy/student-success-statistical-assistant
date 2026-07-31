# Compare first-semester academic progress by student outcome

# Create approval-rate variable
academic_progress <- students |>
  mutate(
    approval_rate = if_else(
      curricular_units_1st_sem_enrolled > 0,
      curricular_units_1st_sem_approved /
        curricular_units_1st_sem_enrolled,
      NA_real_
    )
  )

# Validation checks
academic_validation <- academic_progress |>
  summarise(
    negative_enrolled =
      sum(curricular_units_1st_sem_enrolled < 0),

    negative_approved =
      sum(curricular_units_1st_sem_approved < 0),

    approved_greater_than_enrolled =
      sum(
        curricular_units_1st_sem_approved >
          curricular_units_1st_sem_enrolled
      ),

    invalid_approval_rate =
      sum(
        approval_rate < 0 |
          approval_rate > 1,
        na.rm = TRUE
      ),

    missing_approval_rate =
      sum(is.na(approval_rate))
  )

academic_validation

# Group summary
academic_summary <- academic_progress |>
  group_by(target) |>
  summarise(
    sample_size = n(),

    mean_grade =
      mean(curricular_units_1st_sem_grade, na.rm = TRUE),

    median_grade =
      median(curricular_units_1st_sem_grade, na.rm = TRUE),

    mean_units_enrolled =
      mean(curricular_units_1st_sem_enrolled, na.rm = TRUE),

    mean_units_approved =
      mean(curricular_units_1st_sem_approved, na.rm = TRUE),

    mean_approval_rate =
      mean(approval_rate, na.rm = TRUE) * 100,

    median_approval_rate =
      median(approval_rate, na.rm = TRUE) * 100,

    .groups = "drop"
  )

academic_summary

# Grade boxplot
ggplot(
  academic_progress,
  aes(
    x = target,
    y = curricular_units_1st_sem_grade
  )
) +
  geom_boxplot() +
  labs(
    title = "First-Semester Grades by Student Outcome",
    x = "Student Outcome",
    y = "First-Semester Grade"
  ) +
  theme_minimal()

# Approval-rate chart
ggplot(
  academic_summary,
  aes(
    x = target,
    y = mean_approval_rate
  )
) +
  geom_col() +
  labs(
    title = "Average First-Semester Approval Rate by Outcome",
    x = "Student Outcome",
    y = "Average Approval Rate (%)"
  ) +
  theme_minimal()

# Kruskal-Wallis test
grade_test <- kruskal.test(
  curricular_units_1st_sem_grade ~ target,
  data = academic_progress
)

grade_test
