# Guidance for AI assistants

This file gives context to AI coding assistants (Claude Code, Copilot, Cursor)
working in this repository. Humans are welcome to read it, but
[`CONVENTIONS.md`](CONVENTIONS.md) is the version written for them.

---

## What this repository is

A foundry10 research project. The people working here are researchers — often
with deep methodological expertise and little or no software engineering
background. Optimize for **clarity and reproducibility over cleverness.**

A researcher should be able to read any code you write and understand what it
does without knowing an idiom you introduced. Assume the audience of the work is
comfortable with a straightforward analysis in R: read a file, clean it with
dplyr, fit a model with `lm()` or `lmer()`, make a ggplot. Write at that level
unless the researcher asks for more.

The researcher is responsible for understanding and verifying everything you
produce. Your job is to make that possible, not to replace it. See
`docs/working-with-ai.md` for the reasoning and the section *Working with the
researcher* below for what it asks of you.

---

## Hard rules

**Never write data into version control.** No file from `data/` is ever
committed, and `.gitignore` is not to be loosened to allow one. If a task seems
to require committing a data file, stop and ask. Git history is permanent, this
data involves human subjects, and the repository may become public later.

**Never use absolute paths.** Use `here::here("data", "raw", "file.csv")` in R,
`pathlib` with a project-root constant in Python. No `setwd()`, ever.

**Never commit credentials.** API keys and tokens live in `.Renviron` or `.env`
and are read with `Sys.getenv()`.

**Never modify anything in `data/raw/`.** All transformations happen in
`code/01_clean.R` and write to `data/processed/`.

**Never hand-edit files in `output/` or `results/`.** They are generated. Fix
the code that generates them.

**Never commit anything from `output/`.** It is ignored for a reason: a fitted
model object contains the full model frame, meaning participant-level data. Do
not suggest `git add -f` on a model object, and do not loosen the ignore rule.

**Never hardcode a number in a report or a table.** Every number that appears
in `reports/` or `results/` is produced by code: a chunk that reads from
`results/` or `data/processed/`, or inline R such as `` `r nrow(dat)` ``. If
a researcher types "n = 228" into a `.qmd` by hand, replace it with code that
computes it, and say so. The same rule applies to numbers Claude writes: never
write a plausible-looking result, sample size, or coefficient into a report,
table, or comment. If a value should come from the data, it comes from running
the code.

**Never print raw or individual-level data in a `reports/` chunk.** Files in
`reports/` are tracked, so anything a chunk prints is committed permanently. No
`head()`, `View()`, `glimpse()`, or `print(dat)` in a report. Report aggregate
counts and model summaries only. Note that `echo: false` hides code, not
output.

**Never write participant-level rows to `results/`.** That folder is tracked.
It holds aggregate tables only: one row per model term, per group, per
timepoint. Never one row per participant.

---

## Structure

```
code/00_setup.R          Packages, paths, seed. Sourced by every other script.
code/01_clean.R          Raw → processed
code/02_analyze.R        Models; writes results tables
code/run_all.R           Full pipeline, including rendering the full report
code/functions/          Project functions. Usually only theme_foundry10.R.
data/raw/                Read-only, never tracked
data/processed/          Generated, never tracked
output/                  Generated, NOT tracked (model objects contain data)
results/                 Generated aggregate tables (CSV), tracked
reports/full_report.qmd  The definitive record of the study. Every statistic.
products/                Links to the manuscript, white paper, brief, preprint
docs/decisions.md        Log of substantive analytic choices
docs/reporting-standards.md  What every full report must contain
.claude/commands/        /check-report and other project commands
```

New scripts follow the numbering (`03_`, `04_`) and get added to `run_all.R`.
Make sure the order of the scripts makes sense -- it may help to rename scripts
as new changes or analyses are implemented. Make sure the names in `run_all.R`
match the correct order.

---

## Style: packages first, simplest thing that works

**Use an existing, well-tested package before writing anything yourself.**
Writing a project-specific function is the exception, not the default. Before
writing one, ask: does base R, the tidyverse, or one of the packages below
already do this? If so, use it, even if the call is slightly longer than a
wrapper would be. A wrapper hides what is happening from the researcher and is
one more place for a bug to live.

The default toolkit. Reach for these before anything else:

| Task | Use |
|---|---|
| Reading, cleaning, reshaping | `readr`, `dplyr`, `tidyr`, `janitor::clean_names()` |
| Descriptives | `dplyr::summarize()`, `psych::describe()` |
| Scale scores, reliability | `psych::alpha()`, `rowMeans()` |
| Models | `lm()`, `glm()`, `lme4::lmer()`, `lavaan` |
| Tidy model output | `broom::tidy(conf.int = TRUE)`, `broom.mixed::tidy()` |
| Tables for reports | `knitr::kable()`, `gtsummary`, `modelsummary` |
| Figures | `ggplot2` with `theme_foundry10()` |
| Paths | `here::here()` |

Write a custom function only when **both** are true: no package does the job,
and the same block would otherwise appear three or more times. Then propose it
to the researcher first, put it in `code/functions/` as its own file, and keep
it short and plain. Never write a function that reimplements something that
exists, such as a z-score function when `scale()` exists.

**Stay on the bottom rung of the complexity ladder unless asked to climb.**
Default to `lm()`, dplyr verbs, and ggplot2. Do not introduce `purrr::map()`,
nested functions, tidy evaluation (`{{ }}`, `!!`), S3 classes, environments,
or custom operators unless the researcher asks for them or the task is
impossible without them. Two copies of a block are fine; repetition a
researcher can read beats abstraction they cannot.

- Base R and tidyverse are both fine; match whatever the file already uses
- `snake_case` throughout
- Header comment on every script: purpose, inputs, outputs
- Comment the **why**, not the what — the reasoning behind an exclusion, a
  recode, a model choice
- Prefer explicit, readable code over compact code. A researcher debugging this
  at 11pm should not have to unpick a nested pipeline of anonymous functions.
- Add `stopifnot()` checks after cleaning steps so silent data loss fails loudly

---

## Working with the researcher

Producing an analysis is now cheap. Understanding it and verifying it are not,
and they no longer happen automatically because the researcher did not write
the code. The errors that matter are hidden choices, not typos: reporting only
the results that look good, running analyses in response to stray remarks,
searching specifications until one matches an expectation, and quietly
breaking a rule that was set. None of these shows in the table you hand over.

**Report everything you ran.** If you fit five models and show one, say that
you fit five and why the other four are not shown. If an analysis was tried
and dropped, it goes in `docs/decisions.md`. Never present a subset as if it
were the whole.

**Do not act on cues.** The researcher mentioning what a literature finds, or
what result they expect, or a document that happens to be in the folder, is
not an instruction to change the estimator, the sample, the covariates, or the
outcome. If something you read suggests a different specification, name what
you read, say what it suggests, and ask. Do not search for a specification
that produces an expected result.

**Follow the stated rules, and say so when you cannot.** Preregistration,
sample definitions, exclusion criteria, and entries in `docs/decisions.md`
are rules. If a task cannot be done within them, stop and say which rule is in
the way. Do not work around it.

**Make every change reviewable.** One table or one figure per change, small
enough to read as a diff. After a change, say what to look at and how to check
it: which file, which rendered output, which number should match which.

**Explain before you introduce.** Before using a package, method, or
construction the project has not used, explain it in two or three plain
sentences. If a simpler version exists that the researcher could read without
that explanation, prefer the simpler version.

**Say what you verified, and only that.** "Done" means you ran it and looked
at the output. If you did not run the code, say so. If you ran it but did not
check a result, say which. Never describe output as checked when it was not.

**Offer an independent check for a headline number.** When a result will be
reported, offer to refit it a second way: a different package, or base R
against a package, and compare. Agreement is evidence; disagreement is a bug
or a named default, and the comparison says which.

**The decisions are the researcher's.** Present options with their
consequences. Do not choose a model, an exclusion, or an operationalization on
the researcher's behalf, even when one choice seems obvious.

---

## Statistical work

**Do not silently change an analytic decision.** Sample definitions, exclusion
criteria, covariate sets, and model specifications are substantive research
choices, not implementation details. If a change would alter any of them,
say so explicitly rather than folding it into a refactor.

**Flag, do not fix, apparent statistical errors.** If an analysis looks wrong —
a mis-specified model, a test that does not match the design, a multiple
comparisons problem — describe the concern and let the researcher decide. They
have context about the study design that this repository does not contain.

**Preregistration matters.** If `README.md` links a preregistration, treat
deviations from it as significant. Analyses that were not preregistered should
be labeled exploratory in the code, not just in the write-up.

**Log decisions.** When a substantive analytic choice is made, add an entry to
`docs/decisions.md`.

---

## Reporting

**The full report is the record of the study.** `reports/full_report.qmd`
holds every statistic, table, and figure the study produced, organized to
match `docs/reporting-standards.md`. It is rendered by `run_all.R` so it
cannot show stale numbers. Everything else the project publishes — a
manuscript, a white paper, a brief, a preprint — is derived from it.

**Derived products live outside the repository.** They are written in Google
Docs or Word and linked from `products/README.md`. The rule for a product is
that every number in it appears in the full report. When asked to help with a
product, pull the numbers from the rendered `reports/full_report.md`, and flag
any number the product needs that the full report does not contain. The fix is
to add it to the report, never to compute it on the side.

**`/check-report` verifies the report against the standard.** Run it before a
report is shared and before a product goes out. It reports what is present,
missing, or still a placeholder. It does not edit files.

**Figures are drawn in the report, not imported from `output/`.** A `gfm`
render leaves an imported image as a link into `output/`, which is not
tracked, so the figure is broken on GitHub. Draw the figure in a chunk; Quarto
saves it to `reports/full_report_files/`, which is tracked. If a product needs
a high-resolution copy, add `ggsave()` to the same chunk, writing to
`output/figures/`.

**Writing the prose.** When drafting or revising prose in a report, write in
the first-person plural and active voice, lead with why a thing was done, and
restate technical claims in plain language. Label exploratory analyses as
exploratory. No bullet lists in body prose.

---

## Privacy

This is research with human participants, frequently young people and schools.

- Never paste raw data, participant responses, or identifiers into a commit
  message, comment, issue, or code example
- Do not construct example data that mimics real participant records
- If you notice something that looks like identifiable information in a tracked
  file, flag it immediately rather than quietly removing it — if it has already
  been committed, deleting it does not remove it from history, and the
  remediation is different (see `docs/before-going-public.md`)
