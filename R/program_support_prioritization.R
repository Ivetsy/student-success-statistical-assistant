# Rank academic programs by observed dropout percentage

# Create program-level outcome summary
program_summary <- students |>
  group_by(course) |>
  summarise(
    sample_size = n(),
    dropout_count = sum(target == "Dropout"),
    enrolled_count = sum(target == "Enrolled"),
    graduate_count = sum(target == "Graduate"),
    dropout_percentage =
      mean(target == "Dropout") * 100,
    enrolled_percentage =
      mean(target == "Enrolled") * 100,
    graduate_percentage =
      mean(target == "Graduate") * 100,
    .groups = "drop"
  ) |>
  arrange(desc(dropout_percentage))

# Add sample-size warnings
program_summary <- program_summary |>
  mutate(
    sample_size_warning = if_else(
      sample_size < 30,
      "Small sample — interpret carefully",
      "Adequate sample size"
    )
  )

# Add approximate 95% confidence intervals
program_summary <- program_summary |>
  mutate(
    dropout_proportion =
      dropout_count / sample_size,

    standard_error =
      sqrt(
        dropout_proportion *
          (1 - dropout_proportion) /
          sample_size
      ),

    confidence_low =
      pmax(
        0,
        dropout_proportion -
          1.96 * standard_error
      ) * 100,

    confidence_high =
      pmin(
        1,
        dropout_proportion +
          1.96 * standard_error
      ) * 100
  )

program_summary

# Show the five highest dropout percentages
top_five_programs <- program_summary |>
  slice_head(n = 5)

top_five_programs

# Validation checks
program_validation <- students |>
  summarise(
    missing_course =
      sum(is.na(course)),

    missing_target =
      sum(is.na(target)),

    unexpected_target_values =
      sum(
        !target %in% c(
          "Dropout",
          "Enrolled",
          "Graduate"
        )
      ),

    number_of_programs =
      n_distinct(course)
  )

program_validation

# Create ranking chart
ggplot(
  program_summary,
  aes(
    x = reorder(
      as.factor(course),
      dropout_percentage
    ),
    y = dropout_percentage
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Observed Dropout Percentage by Academic Program",
    x = "Course Code",
    y = "Dropout Percentage"
  ) +
  scale_y_continuous(
    labels = scales::label_percent(scale = 1)
  ) +
  theme_minimal()
