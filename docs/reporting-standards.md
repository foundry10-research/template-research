# Reporting standards

What every foundry10 full report must contain. `reports/full_report.qmd`
mirrors this list section for section, and `/check-report` checks a rendered
report against it.

> **Status: provisional.** This is a working draft to give the template a
> shape. The foundry10 reporting standard, once adopted, replaces the list
> below, and the template is updated so that every new project starts with the
> current version. Until then, treat this as the minimum.

The list draws on the APA Journal Article Reporting Standards for quantitative
research (JARS-Quant). Where foundry10 adds a requirement, it is marked.

---

## 1. Summary

- [ ] A plain-language statement of what we found, two to four sentences
- [ ] Every number in it is inline code, not typed

## 2. Study information

- [ ] Design, in one line
- [ ] Preregistration link, or an explicit "not preregistered"
- [ ] IRB protocol number, or "not human subjects research"
- [ ] Data collection dates
- [ ] Where the data live (a pointer to `data/README.md`)

## 3. Sample

- [ ] How participants were recruited and from where
- [ ] Number of participants at each stage, from first contact to the analytic
      sample, as a table produced by code
- [ ] Every exclusion criterion, the number excluded by each, and the reason
- [ ] Sample characteristics as aggregate counts and percentages
- [ ] No cell small enough to identify a participant *(foundry10)*

## 4. Measures

- [ ] For each measure: what it measures, number of items, response scale
- [ ] How each score was computed
- [ ] Reliability in this sample, from code
- [ ] Any measure that was collected and not analyzed, and why

## 5. Missing data

- [ ] Amount of missingness, by variable
- [ ] Whether missingness differed by condition or by key covariates
- [ ] How missing data were handled, and why that method

## 6. Analysis plan

- [ ] For each hypothesis or question: the model, in words
- [ ] Which analyses were preregistered and which were exploratory
- [ ] Covariates and the reason for including them
- [ ] Any correction for multiple comparisons

## 7. Results

- [ ] Descriptive statistics for all study variables
- [ ] For each primary analysis: the full table of estimates with confidence
      intervals, produced by `broom::tidy()` or equivalent
- [ ] Effect sizes with uncertainty, not p-values alone
- [ ] A plain-language interpretation of each estimate
- [ ] Exploratory analyses clearly labelled as exploratory
- [ ] Robustness checks: what changed and whether the conclusion held
- [ ] Figures follow `docs/visual-style.md` *(foundry10)*

## 8. Deviations from preregistration

- [ ] Each deviation, what was done instead, and why; or an explicit "None"
- [ ] Each deviation also appears in `docs/decisions.md`

## 9. Limitations

- [ ] What the design cannot tell us
- [ ] What a partner organization would need to know before acting on the
      findings *(foundry10)*

## 10. Reproducibility

- [ ] Render date and commit hash, from code
- [ ] Pointer to `docs/session-info.txt`
- [ ] Pointer to `docs/decisions.md`

---

## Rules that apply throughout

- [ ] **Every number comes from code.** No statistic, sample size, or
      coefficient is typed by hand anywhere in the report.
- [ ] **No individual-level data.** No chunk prints participant rows; no table
      has one row per participant.
- [ ] **No placeholders remain.** No `[bracketed text]` from the template.
- [ ] **Products match.** Every number in the manuscript, white paper, brief,
      or preprint appears in the full report.
