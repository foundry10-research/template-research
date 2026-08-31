# =============================================================================
# 01_clean.R
#
# Reads raw data, cleans it, and writes an analysis-ready file to
# data/processed/. Nothing in this script modifies anything in data/raw/.
#
# Input:  data/raw/[FILENAME]
# Output: data/processed/analysis_sample.rds
# =============================================================================

source(here::here("code", "00_setup.R"))


# --- Important ---------------------------------------------------------------
#
# RAW DATA IS READ-ONLY. Never edit a file in data/raw/, never overwrite one,
# and never "just fix" a value by hand in Excel. Every correction, recode,
# exclusion, and renaming happens in this script, in code, where it is visible
# and reversible.
#
# If someone asks "why is n = 214 and not 250?", the answer should be readable
# in this file. If the answer is "I deleted some rows in a spreadsheet in
# March", the study is not reproducible.

# --- Read raw data -----------------------------------------------------------

raw <- read_csv(file.path(path_raw, "[FILENAME].csv"))


# --- Inspect -----------------------------------------------------------------
# Look before you leap. Comment these out once you know the data.

# glimpse(raw)
# summary(raw)
# colSums(is.na(raw))

# --- Clean -------------------------------------------------------------------
# Document each decision in a comment. Your future self is a stranger.

clean <- raw |>
  # Standardize names to lowercase snake_case
  janitor::clean_names() |>

  # EXAMPLE: recode missingness. Survey used -99 for "prefer not to answer".
  # mutate(across(where(is.numeric), ~ na_if(.x, -99))) |>

  # EXAMPLE: apply exclusion criteria. Record WHY, not just what.
  # Preregistered exclusion: completion time under 3 minutes indicates
  # non-engagement (see docs/decisions.md, 2026-08-27).
  # filter(duration_min >= 3) |>

  identity()


# --- Check your work ---------------------------------------------------------
# It's better to have a cleaning script that crashes than one that silently
# drops half your sample. Make your assumptions explicit so the script fails
# loudly if they are ever violated.

stopifnot(
  nrow(clean) > 0,
  !any(duplicated(clean$participant_id))
)

message("Rows in:  ", nrow(raw))
message("Rows out: ", nrow(clean))


# --- Save --------------------------------------------------------------------
# Processed files are disposable by design: anyone can regenerate them by
# re-running this script. That is why data/processed/ is not tracked by Git.

saveRDS(clean, file.path(path_processed, "analysis_sample.rds"))
