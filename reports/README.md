# Reports

This folder holds the **full report**: the definitive record of the study.
Every statistic, table, and figure the project produced lives in
`full_report.qmd`, and every number in it comes from code. The rendered
version, `full_report.md`, is tracked by Git so that anyone can read it on
github.com without installing R.

Every foundry10 project has a full report. The manuscript, white paper, brief,
or preprint are written *from* it, never the other way round; see
[`../products/README.md`](../products/README.md). What the full report must
contain is set out in
[`../docs/reporting-standards.md`](../docs/reporting-standards.md), and
`/check-report` checks a rendered report against that list.

---

## Two rules, because this folder is tracked

**1. Every number comes from code.** No number in the report is typed by
hand. Write `` `r nrow(dat)` ``, not `228`. Tables come from
`knitr::kable()` on a table in `results/`, not from numbers copied out of the
console. If a number you need is not in `results/`, add it to
`code/02_analyze.R`. A typed number is right on the day you type it and
silently wrong after the next re-run.

**2. No chunk prints individual-level data.** A rendered report contains
whatever your code chunks printed. One `head(dat)` left in while debugging
puts six rows of participant data into a tracked file, permanently. Before
committing:

- [ ] No chunk prints raw or individual-level data — no `head()`, no `View()`,
      no `print(dat)`, no `glimpse()` left over from debugging
- [ ] No table has one row per participant
- [ ] Cell sizes are large enough that nobody is identifiable. A cross-tab with
      a single participant in a cell identifies that person to anyone who knows
      the study.
- [ ] **Read the rendered `.md` itself**, not just the source. What renders is
      what gets committed.

`echo: false` in the YAML header hides your code but **does not hide its
output**. It is a formatting choice, not a safety feature.

---

## Where figures come from

Figures are drawn in the report's own chunks, not saved by a script and
imported. The reason is practical: when a `gfm` report imports an image from
`output/figures/`, the rendered file contains a link to that path, and since
`output/` is not tracked, the figure is broken on GitHub. A figure drawn in a
chunk is saved by Quarto into `full_report_files/`, which is tracked, and
displays correctly.

If a product needs a high-resolution PNG, add a `ggsave()` line to the same
chunk writing to `output/figures/`. One place for the figure code, two
outputs.

---

## Format: use `gfm`

| Format | Renders on github.com? | Notes |
|---|---|---|
| **`gfm`** (GitHub markdown) | **Yes, natively** | The default. Diffs as plain text, so you can see what changed between versions. |
| `pdf` | Yes, inline viewer | Good for attaching to an email. Requires a LaTeX install (`tinytex::install_tinytex()`). |
| `html` | **No** | GitHub shows the raw source, not the page. Fine locally, useless to the colleague you are trying to reach. |

---

## Contents

```
reports/
├── full_report.qmd        Source — the file you edit
├── full_report.md         Rendered — the file people read
└── full_report_files/     Figures for the rendered version; commit these
```

Other reports are welcome alongside it. A **data quality report** (sample
sizes, missingness, attrition by wave) is useful early and often, and a
**partner-facing summary** in plain language is often what a school or
district actually wants. They follow the same two rules.

---

## Rendering

`code/run_all.R` renders the full report at the end of the pipeline, so
running the pipeline is the normal way to update it. To render on its own,
open the `.qmd` in RStudio and click **Render**, or from R:

```r
quarto::quarto_render(here::here("reports", "full_report.qmd"))
```

**Re-render before committing.** A report showing numbers from an analysis you
have since revised is worse than no report at all — it looks current, and
people will quote it.

---

## What does not go here

- **Manuscripts, white papers, briefs.** Those are written in Google Docs or
  Word and linked from [`../products/README.md`](../products/README.md).
- **Raw model output.** Dumping `summary(model)` into a document is not a
  report. Use `broom::tidy()` and `knitr::kable()`.
- **Anything with participant-level rows.** See the checklist above.
