# =============================================================================
# 02_analyze.R
#
# Fits the models and writes the numbers the full report needs.
#
# Input:  data/processed/analysis_sample.rds
# Output: results/*.csv       aggregate tables, read by reports/full_report.qmd
#         output/models/      fitted model objects (not tracked: they hold data)
#
# Figures are not made here. They are drawn in reports/full_report.qmd, where
# Quarto saves them to a tracked folder so they display on GitHub. See
# reports/README.md.
# =============================================================================

source(here::here("code", "00_setup.R"))

dat <- readRDS(file.path(path_processed, "analysis_sample.rds"))


# --- Sample flow -------------------------------------------------------------
# How many participants at each stage, so the report can state exclusions
# with numbers that come from the data rather than from memory.

# sample_flow <- tibble(
#   stage = c("Started survey", "Completed survey", "Passed attention check"),
#   n     = c(nrow(raw), sum(raw$finished), nrow(dat))
# )
# write_csv(sample_flow, file.path(path_results, "sample_flow.csv"))


# --- Descriptives ------------------------------------------------------------
# Aggregate only. One row per variable or per group, never per participant,
# because results/ is tracked by Git.

# descriptives <- dat |>
#   summarize(
#     n        = n(),
#     mean_age = mean(age, na.rm = TRUE),
#     sd_age   = sd(age, na.rm = TRUE)
#   )
# write_csv(descriptives, file.path(path_results, "descriptives.csv"))


# --- Primary analysis --------------------------------------------------------
# If your study is preregistered, say so and link the hypothesis. If an
# analysis was not preregistered, label it exploratory -- here, in the code,
# not only in the write-up.
#
# broom::tidy() turns a model into a table with one row per term. That table
# is what the report reads, so every coefficient in the report traces back to
# this line. Do not round here; round in the report where the number is shown.

# H1 (preregistered): [state the hypothesis]
# model_h1 <- lm(outcome ~ condition + covariate, data = dat)
# write_csv(
#   broom::tidy(model_h1, conf.int = TRUE),
#   file.path(path_results, "model_h1.csv")
# )
#
# Keep the fitted object too, for anything the tidy table does not carry.
# It goes in output/ because it contains the data it was fit on.
# saveRDS(model_h1, file.path(here("output", "models"), "model_h1.rds"))


# --- Exploratory analyses ----------------------------------------------------
# Label them. A reader of the code should be able to tell which analyses were
# planned without opening the preregistration.

# EXPLORATORY: [describe]
# model_exp1 <- lm(...)
# write_csv(broom::tidy(model_exp1, conf.int = TRUE),
#           file.path(path_results, "model_exp1.csv"))


# --- Check your work ---------------------------------------------------------
# results/ is tracked, so make sure nothing participant-level was written.
# Every results table should have far fewer rows than the sample.

results_files <- list.files(path_results, pattern = "\\.csv$", full.names = TRUE)
for (f in results_files) {
  stopifnot(nrow(read_csv(f, show_col_types = FALSE)) < nrow(dat))
}


# --- Record the environment --------------------------------------------------
# Which package versions produced these results. Worth its weight in gold when
# a result changes two years from now and nobody knows why.
#
# This writes to docs/ rather than output/ because output/ is not tracked by
# Git -- see output/README.md. Package versions contain no data and are worth
# keeping in the repository permanently.

writeLines(
  capture.output(sessionInfo()),
  here("docs", "session-info.txt")
)
