# Explore first-semester grade distribution

# Descriptive statistics
explore_summary <- students |>
  summarise(
    observations = n(),
    missing_values = sum(is.na(curricular_units_1st_sem_grade)),
    mean_grade = mean(curricular_units_1st_sem_grade, na.rm = TRUE),
    median_grade = median(curricular_units_1st_sem_grade, na.rm = TRUE),
    standard_deviation = sd(curricular_units_1st_sem_grade, na.rm = TRUE),
    minimum = min(curricular_units_1st_sem_grade, na.rm = TRUE),
    first_quartile = quantile(
      curricular_units_1st_sem_grade,
      0.25,
      na.rm = TRUE
    ),
    third_quartile = quantile(
      curricular_units_1st_sem_grade,
      0.75,
      na.rm = TRUE
    ),
    maximum = max(curricular_units_1st_sem_grade, na.rm = TRUE),
    range = maximum - minimum
  )

explore_summary

# Investigate zero-grade records
zero_grade_summary <- students |>
  filter(curricular_units_1st_sem_grade == 0) |>
  summarise(
    zero_grade_count = n(),
    zero_grade_percentage = n() / nrow(students) * 100,
    average_units_enrolled =
      mean(curricular_units_1st_sem_enrolled),
    average_units_approved =
      mean(curricular_units_1st_sem_approved),
    average_without_evaluations =
      mean(curricular_units_1st_sem_without_evaluations)
  )

zero_grade_summary

# Histogram
ggplot(
  students,
  aes(x = curricular_units_1st_sem_grade)
) +
  geom_histogram(bins = 30) +
  labs(
    title = "Distribution of First-Semester Grades",
    x = "First-Semester Grade",
    y = "Number of Students"
  ) +
  theme_minimal()

# Boxplot
ggplot(
  students,
  aes(y = curricular_units_1st_sem_grade)
) +
  geom_boxplot() +
  labs(
    title = "First-Semester Grade Boxplot",
    y = "First-Semester Grade"
  ) +
  theme_minimal()
