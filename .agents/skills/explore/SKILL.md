# Explore Data Skill

## Purpose

Use this skill to explore the distribution of a numeric variable in the student-success dataset.

## User Question

What does the distribution of a selected numeric variable look like?

## Required Inputs

- Dataset
- Name of one numeric variable

## Validation

Before running the analysis:

1. Confirm that the dataset exists.
2. Confirm that the selected variable exists.
3. Confirm that the selected variable is numeric.
4. Count missing values.
5. Stop and explain the problem if the variable is missing or not numeric.

Example validation messages:

- The selected variable does not exist in the dataset.
- The selected variable must be numeric for this analysis.

## R Workflow

1. Load the dataset.
2. Run `R/explore.R`.
3. Calculate descriptive statistics.
4. Create a histogram.
5. Create a boxplot.
6. Investigate unusual or zero values.
7. Update the Explore section of the Quarto report.

## Main Output

Return:

- Number of observations
- Missing-value count
- Mean
- Median
- Standard deviation
- Minimum
- First quartile
- Third quartile
- Maximum
- Range
- Histogram
- Boxplot
- Plain-language interpretation
- Limitation

## Interpretation Guidance

Explain the center, spread, shape, and unusual values in plain language.

Do not automatically remove zero values or outliers. Investigate whether they may be meaningful.

## Limitation

This analysis describes the selected variable. It does not explain why the observed pattern occurred and does not establish causation.
