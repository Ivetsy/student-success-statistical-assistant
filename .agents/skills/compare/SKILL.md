# Compare Two Groups Skill

## Purpose

Use this skill to compare an outcome between exactly two groups in the student-success dataset.

## User Question

Does the selected outcome differ between two groups?

## Required Inputs

- Dataset
- Grouping variable
- Outcome variable
- Two valid groups

## Validation

Before running the analysis:

1. Confirm that the dataset exists.
2. Confirm that the grouping variable exists.
3. Confirm that the outcome variable exists.
4. Confirm that the grouping variable contains exactly two valid groups.
5. Confirm that each group has enough observations.
6. Confirm that the selected statistical method matches the outcome type.
7. Stop and explain the problem if any validation rule fails.

Example validation messages:

- The selected grouping variable does not exist.
- The grouping variable must contain exactly two valid groups.
- One group contains too few observations.
- The selected method is not appropriate for this outcome type.

## R Workflow

1. Load the dataset.
2. Run `R/compare.R`.
3. Prepare the two-group comparison variables.
4. Calculate group sample sizes.
5. Calculate outcome counts and percentages.
6. Calculate the estimated difference between groups.
7. Calculate a confidence interval.
8. Run the appropriate statistical test.
9. Update the Compare section of the Quarto report.

## Main Output

Return:

- Group names
- Group sample sizes
- Outcome counts
- Group percentages
- Estimated difference
- Confidence interval
- Statistical-test result
- P-value when appropriate
- Plain-language interpretation
- Limitation

## Interpretation Guidance

Explain whether the observed difference is small or large and whether it is statistically supported.

Describe the result as an association unless the data and research design support a causal conclusion.

## Limitation

A group difference does not prove that the grouping variable caused the outcome.

Other academic, financial, personal, and institutional factors may explain part of the observed difference.
