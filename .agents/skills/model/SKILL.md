# Statistical Model Skill

## Purpose

Use this skill to build and evaluate a statistical model for student outcomes.

## User Question

Which factors are associated with whether a student drops out or graduates?

## Required Inputs

- Dataset
- Binary outcome variable
- Predictor variables
- Training and test data

## Validation

Before running the model:

1. Confirm that the dataset exists.
2. Confirm that the outcome variable exists.
3. Confirm that all predictor variables exist.
4. Confirm that the outcome contains exactly two valid categories.
5. Confirm that the selected model is appropriate for the outcome type.
6. Confirm that required prediction inputs are present.
7. Confirm that new category values appeared in the training data.
8. Stop and explain the problem if any validation rule fails.

Example validation messages:

- The selected outcome does not exist.
- Logistic regression requires a binary outcome.
- A required predictor is missing.
- The requested category did not appear in the training data.
- Prediction cannot be completed because required inputs are missing.

## R Workflow

1. Load the dataset.
2. Run `R/model.R`.
3. Keep only Dropout and Graduate outcomes.
4. Code Graduate as 0 and Dropout as 1.
5. Prepare numeric and categorical predictors.
6. Remove rows with missing required values.
7. Create a reproducible training and test split using `set.seed(123)`.
8. Fit a binary logistic regression model.
9. Calculate coefficients and odds ratios.
10. Generate test-set predictions.
11. Create a confusion matrix.
12. Calculate accuracy, sensitivity, and specificity.
13. Update the Model section of the Quarto report.

## Main Output

Return:

- Model type
- Outcome definition
- Predictor list
- Coefficients
- Odds ratios
- P-values
- Confusion matrix
- Accuracy
- Sensitivity
- Specificity
- Plain-language interpretation
- Limitation

## Interpretation Guidance

Explain odds ratios in plain language.

An odds ratio above 1 indicates higher estimated odds of Dropout, while an odds ratio below 1 indicates lower estimated odds, holding the other predictors constant.

Do not describe the model as proof that a predictor caused dropout.

Do not use the model to deny services, punish students, or make automatic decisions about individual students.

## Limitation

The model excludes students whose outcome was Enrolled because it compares only Dropout and Graduate outcomes.

The model identifies associations and may make prediction errors. It should support further review rather than replace professional judgment.
