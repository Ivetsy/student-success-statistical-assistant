# Academic Progress Analysis Skill

## Purpose

Use this skill to compare first-semester academic progress across students who dropped out, remained enrolled, or graduated.

## User Question

How does first-semester academic progress differ among the Dropout, Enrolled, and Graduate groups?

## Required Inputs

- Dataset
- Student outcome variable
- First-semester enrolled units
- First-semester approved units
- First-semester grade

## Validation

Before running the analysis:

1. Confirm that the dataset exists.
2. Confirm that all required variables exist.
3. Confirm that academic variables are numeric.
4. Confirm that enrolled and approved units are not negative.
5. Confirm that approved units do not exceed enrolled units.
6. Prevent division by zero when calculating approval rates.
7. Confirm that approval rates remain between 0 and 1.
8. Stop and explain the problem if any validation rule fails.

Example validation messages:

- A required academic variable is missing.
- Approved units cannot exceed enrolled units.
- Approval rate cannot be calculated when enrolled units equal zero.
- The selected academic variable must be numeric.

## R Workflow

1. Load the dataset.
2. Run `R/academic_progress_analysis.R`.
3. Create the first-semester approval-rate variable.
4. Calculate group sample sizes.
5. Calculate mean and median grades.
6. Calculate mean enrolled and approved units.
7. Calculate mean and median approval rates.
8. Create a grade boxplot.
9. Create an approval-rate bar chart.
10. Run a Kruskal-Wallis test.
11. Update the Academic Progress section of the Quarto report.

## Main Output

Return:

- Sample size for each outcome group
- Mean and median grade
- Mean enrolled units
- Mean approved units
- Mean and median approval rate
- Grade boxplot
- Approval-rate chart
- Kruskal-Wallis test result
- Plain-language interpretation
- Limitation

## Interpretation Guidance

Explain how first-semester academic progress differs across the three student outcome groups.

The results should be used to identify broad patterns that may support tutoring, advising, or early academic support.

Do not automatically label an individual student based on one grade or approval rate.

## Limitation

This is a retrospective analysis.

The observed differences do not prove that first-semester grades or approval rates caused students to drop out or graduate.

Other academic, financial, personal, and institutional factors may also influence outcomes.
