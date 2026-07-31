# Data Quality Audit Skill

## Purpose

Use this skill to determine whether the student dataset is ready for statistical analysis.

## User Question

Are missing values, duplicate records, invalid category codes, or logical inconsistencies affecting the reliability of the dataset?

## Required Inputs

- Dataset
- Target variable
- Course variable
- Academic variables
- Financial-status variables

## Validation

Before completing the audit:

1. Confirm that the dataset exists.
2. Confirm that the dataset contains observations and variables.
3. Confirm that required variables exist.
4. Check missing values.
5. Check duplicate rows.
6. Confirm that target contains only Dropout, Enrolled, and Graduate.
7. Confirm that binary variables contain only 0 and 1.
8. Confirm that academic values are not negative.
9. Confirm that approved units do not exceed enrolled units.
10. Treat valid zero values differently from missing values.
11. Stop and explain the problem if the dataset or required variables are unavailable.

Example validation messages:

- The dataset could not be found.
- A required variable is missing.
- The target variable contains an invalid category.
- Approved units cannot exceed enrolled units.
- The dataset requires cleaning before analysis.

## R Workflow

1. Load the dataset.
2. Run `R/data_quality_audit.R`.
3. Report the number of observations and variables.
4. Count missing values.
5. Count duplicate rows.
6. Check expected category codes.
7. Check academic logic.
8. Create an issue summary table.
9. Create a data-quality chart.
10. Calculate the number and percentage of records affected.
11. Calculate the data-quality score.
12. Assign a readiness result.
13. Update the Data Quality Audit section of the Quarto report.

## Main Output

Return:

- Number of observations
- Number of variables
- Missing-value count
- Duplicate-row count
- Invalid-category counts
- Academic logic results
- Issue summary table
- Data-quality chart
- Records affected
- Data-quality score
- Readiness result
- Plain-language interpretation
- Limitation

## Interpretation Guidance

Explain whether the dataset is:

- Ready for analysis
- Ready with warnings
- Cleaning required

Do not automatically remove unusual values.

Investigate whether zero values or extreme values may contain meaningful information before changing the dataset.

## Limitation

Passing automated validation checks does not prove that every value is correct.

Some incorrect values may still fall within expected ranges, and some unusual values may be legitimate.

The audit identifies possible problems for review but does not replace documentation or expert judgment.
