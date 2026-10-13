# =============================================================================
# run_all.R
#
# Reproduces the entire project from raw data to the rendered full report.
#
# Someone who has this repository and access to the data should be able to open
# the .Rproj file, run this one script, and get every result. If that is not
# true, the project is not reproducible -- and the fix belongs in the scripts,
# not in a set of instructions someone has to follow by hand.
#
# Run it periodically, not just at the end. The longer you wait to find out
# that step 3 depends on something you deleted, the more painful it is.
# =============================================================================

source(here::here("code", "00_setup.R"))

source(here("code", "01_clean.R"))
source(here("code", "02_analyze.R"))

# Render the full report so it never shows numbers from a previous run. The
# report is the record of the study; a stale one is worse than none, because
# people will quote it. Requires Quarto (bundled with recent RStudio).
quarto::quarto_render(here("reports", "full_report.qmd"))

message(
  "\n--- Pipeline complete: ",
  format(Sys.time(), "%Y-%m-%d %H:%M"),
  " ---"
)
