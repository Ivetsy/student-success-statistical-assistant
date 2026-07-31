# Build a logistic regression model for Dropout versus Graduate

# Keep only Dropout and Graduate outcomes
model_data <- students |>
  filter(target %in% c("Dropout", "Graduate")) |>
  mutate(
    dropout_outcome = if_else(
      target == "Dropout",
      1,
      0
    ),
    tuition_fees_up_to_date =
      factor(tuition_fees_up_to_date),
    debtor =
      factor(debtor),
    scholarship_holder =
      factor(scholarship_holder)
  ) |>
  select(
    dropout_outcome,
    curricular_units_1st_sem_grade,
    curricular_units_1st_sem_approved,
    tuition_fees_up_to_date,
    debtor,
    scholarship_holder,
    admission_grade,
    age_at_enrollment
  ) |>
  drop_na()

# Reproducible train-test split
set.seed(123)

training_rows <- sample(
  seq_len(nrow(model_data)),
  size = floor(0.80 * nrow(model_data))
)

training_data <- model_data[training_rows, ]
test_data <- model_data[-training_rows, ]

# Fit logistic regression model
dropout_model <- glm(
  dropout_outcome ~
    curricular_units_1st_sem_grade +
    curricular_units_1st_sem_approved +
    tuition_fees_up_to_date +
    debtor +
    scholarship_holder +
    admission_grade +
    age_at_enrollment,
  data = training_data,
  family = binomial()
)

summary(dropout_model)

# Odds ratios
odds_ratios <- exp(coef(dropout_model))
odds_ratios

# Predict on test data
predicted_probability <- predict(
  dropout_model,
  newdata = test_data,
  type = "response"
)

predicted_class <- if_else(
  predicted_probability >= 0.50,
  1,
  0
)

# Confusion matrix
confusion_matrix <- table(
  Predicted = predicted_class,
  Actual = test_data$dropout_outcome
)

confusion_matrix

# Evaluation metrics
true_negative <- confusion_matrix["0", "0"]
false_negative <- confusion_matrix["0", "1"]
false_positive <- confusion_matrix["1", "0"]
true_positive <- confusion_matrix["1", "1"]

accuracy <- (
  true_positive + true_negative
) / sum(confusion_matrix)

sensitivity <- true_positive / (
  true_positive + false_negative
)

specificity <- true_negative / (
  true_negative + false_positive
)

model_metrics <- tibble(
  accuracy = accuracy,
  sensitivity = sensitivity,
  specificity = specificity
)

model_metrics
