# Program Support Prioritization Skill

## Purpose

Use this skill to identify academic programs with high observed dropout percentages that may require further review.

## User Question

Which academic programs have the highest observed dropout percentages and may need additional support review?

## Required Inputs

- Dataset
- Course variable
- Student outcome variable

## Validation

Before running the analysis:

1. Confirm that the dataset exists.
2. Confirm that the course variable exists.
3. Confirm that the target variable exists.
4. Confirm that the target contains only Dropout, Enrolled, and Graduate.
5. Confirm that course values are not missing.
6. Calculate sample sizes for every program.
7. Flag programs with fewer than 30 students.
8. Stop and explain the problem if the required variables are missing or invalid.

Example validation messages:

- The course variable does not exist.
- The target variable contains an unexpected category.
- A program contains fewer than 30 observations and must be interpreted carefully.
- Program ranking cannot be completed without valid outcome values.

## R Workflow

1. Load the dataset.
2. Run `R/program_support_prioritization.R`.
3. Group students by academic program.
4. Calculate sample size for each program.
5. Calculate Dropout, Enrolled, and Graduate counts.
6. Calculate outcome percentages.
7. Rank programs by dropout percentage.
8. Add small-sample warnings.
9. Calculate approximate 95% confidence intervals.
10. Create a horizontal bar chart.
11. Update the Program Support Prioritization section of the Quarto report.

## Main Output

Return:

- Program code
- Program sample size
- Dropout count and percentage
- Enrolled count and percentage
- Graduate count and percentage
- Approximate confidence interval
- Sample-size warning
- Ranked program table
- Horizontal bar chart
- Practical interpretation
- Limitation

## Interpretation Guidance

Prioritize programs for further investigation using both dropout percentage and sample size.

Do not treat a high dropout percentage as proof that a program is low quality.

Programs may serve students with different academic preparation, financial circumstances, employment responsibilities, and personal obligations.

## Limitation

This analysis identifies program-level associations.

It does not prove that an academic program caused students to drop out.

Small programs may have unstable percentages and wide confidence intervals. The results should guide further review rather than automatic funding or staffing decisions.
