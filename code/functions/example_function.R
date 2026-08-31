# =============================================================================
# Project functions
#
# Anything you write yourself and use more than once belongs here, in its own
# file, rather than being pasted into three scripts. 00_setup.R sources
# everything in this folder automatically.
#
# The rule of thumb: the third time you copy and paste a block of code, make it
# a function. Copy-pasted code is where inconsistencies hide -- you fix a bug in
# two of the three copies and never notice the third.
#
# Delete this file once you have written a real one.
# =============================================================================

#' Convert a numeric vector to z-scores
#'
#' @param x A numeric vector.
#' @param na_rm Logical. Drop missing values when computing mean and SD?
#' @return A numeric vector of the same length as x.

z_score <- function(x, na_rm = TRUE) {
  (x - mean(x, na.rm = na_rm)) / sd(x, na.rm = na_rm)
}
