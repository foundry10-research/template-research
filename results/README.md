# Results

Aggregate tables written by `code/02_analyze.R` and read by
`reports/full_report.qmd`. One CSV per table: a sample-flow table, a
descriptives table, one `broom::tidy()` table per model.

**Unlike `output/`, this folder is tracked by Git.** That is what makes the
full report reproducible for a reader: every number in it traces to a file
here, and that file traces to a line in `02_analyze.R`.

## What may go here

Tables with one row per **model term, group, timepoint, or variable**. Think
of anything you would put in a results table in a paper.

## What may never go here

Anything with one row per **participant**. Not a cleaned dataset, not
residuals, not predicted values per person, not a "small" sample "just for
checking". `02_analyze.R` ends with a check that every file here has fewer
rows than the analytic sample, which catches the obvious case. It does not
catch a small-cell cross-tab that identifies someone to anyone who knows the
study, so look at what you write.

Only `.csv` files are tracked here. An `.rds` placed in this folder stays
ignored, because an R object can carry data that a CSV cannot hide.

## Rounding

Do not round when writing a table here; round in the report where the number
is shown (`knitr::kable(digits = 2)` or `round()` in inline code). Rounded
inputs produce wrong downstream calculations and make it impossible to report
a number at a different precision later.
