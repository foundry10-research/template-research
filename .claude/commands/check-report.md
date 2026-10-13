---
description: Check the full report against docs/reporting-standards.md and, optionally, check a product's numbers against the report
---

Check this project's full report against the reporting standard. Do not edit
any file. Report what you find.

## What to read

1. `docs/reporting-standards.md` — the list of required elements.
2. `reports/full_report.qmd` — the source.
3. `reports/full_report.md` — the rendered report. If it does not exist or is
   older than the `.qmd` or than any file in `results/`, say so first: the
   check is only meaningful on a fresh render. Offer to run
   `quarto::quarto_render(here::here("reports", "full_report.qmd"))`.
4. Every `.csv` in `results/`.
5. If the user pasted product text with the command (`$ARGUMENTS`), that text.

## Checks

**A. Required elements.** For every checklist item in the standard, decide
whether the rendered report satisfies it. Three statuses:

- `present` — the element is there with real content
- `placeholder` — the section exists but still holds template text in
  `[square brackets]`, a commented-out chunk, or is empty
- `missing` — the section or element is not there

**B. Numbers come from code.** In the `.qmd`, look at prose outside code
chunks and outside inline `` `r ...` `` expressions. Flag any digit sequence
that looks like a statistic, sample size, percentage, or coefficient. Ignore
years, dates, section numbers, item counts that describe an instrument
("a 10-item scale"), and numbers inside URLs. For each flag, quote the line.
These need human judgment; say "likely hand-typed" rather than asserting.

**C. No individual-level data.** In the `.qmd`, flag any `head(`, `glimpse(`,
`View(`, `print(dat`, or a bare data-frame name on its own line in a chunk.
In the rendered `.md`, flag any table with more than about 30 rows, or a
column that looks like an identifier. In `results/`, flag any CSV with a
column named like an ID (`id`, `participant`, `respondent`, `pid`) or with a
row count close to or above the analytic sample size stated in the report.

**D. Everything run is reported.** Compare `code/02_analyze.R` (and any
later numbered script) with the rendered report. List every model fitted or
results table written in the code, and for each say whether the report shows
it. Flag: a table in `results/` the report never reads; a model fitted in code
whose results are written nowhere; an analysis marked exploratory in the code
that the report presents without that label; and a model the report shows
that no script produces. A reader of the report should be able to see every
analysis that was run, not only the ones that look good.

**E. Products match (only if text was pasted).** Extract every number from
the pasted text that is a statistic, sample size, percentage, or estimate.
For each one, search the rendered report for it, allowing for rounding to one
fewer decimal place. List the ones not found. These are numbers the report
needs to gain, or the product needs to lose.

## Output

A short verdict line, then one table for check A with columns
`Section | Item | Status | Where`, then the flags from B, C, D, and E as lists
with quoted lines. End with the three most important things to fix, in
order. Do not pad; if everything passes, say so in two lines.
