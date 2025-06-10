#' Correlate the original variables with a chosen method and correction
#'
#' @param df A data frame containing the variables to be correlated, usually
#' `study_data`.
#' @param method A string indicating the correlation method to use. Default is
#' "pearson". Other options include "spearman" and "kendall". See
#' `?correlation::correlation()` for more details.
#' @param partial Logical. Whether to compute partial correlations. Default is
#' TRUE. If FALSE, computes simple correlations.
#' @param correction A string indicating the p-value correction method to use.
#' Default is "bonferroni". Other options include "holm", "fdr", or "none".
#' See `?correlation::correlation()` for more details.
#'
#' @returns A data frame containing the correlations between the variables, with
#' the parameters renamed for better readability.
#' @export
#'
#' @examples
#' simple_correlations <- correlate_vars(study_data, partial = FALSE)
#' format(head(simple_correlations))
correlate_vars <- function(
    df,
    method  = "pearson",
    partial = TRUE,
    correction = "bonferroni"
) {
  rlang::check_installed("correlation")

  correlations <-
    df |>
    scale_vars() |>
    dplyr::select("vviq":"score_comprehension") |>
    correlation::correlation(
      method   = method,
      partial  = partial,
      p_adjust = correction
    ) |>
    dplyr::mutate(
      dplyr::across(
        c("Parameter1", "Parameter2"),
        ~dplyr::case_match(
          .x,
          "vviq" ~ "VVIQ",
          "osivq_o" ~ "OSIVQ\nObject",
          "osivq_s" ~ "OSIVQ\nSpatial",
          "osivq_v" ~ "OSIVQ\nVerbal",
          "psiq_vis" ~ "Psi-Q\nVisual",
          "psiq_aud" ~ "Psi-Q\nAudition",
          "psiq_od" ~ "Psi-Q\nSmell",
          "psiq_gout" ~ "Psi-Q\nTaste",
          "psiq_tou" ~ "Psi-Q\nTouch",
          "psiq_sens" ~ "Psi-Q\nSensations",
          "psiq_feel" ~ "Psi-Q\nFeelings",
          "score_raven" ~ "Raven\nMatrices",
          "score_sri" ~ "SRI",
          "span_spatial" ~ "Spatial\nspan",
          "span_digit" ~ "Digit\nspan",
          "wcst_accuracy" ~ "WCST",
          "score_similarities" ~ "Similarities",
          "score_comprehension" ~ "Reading",
          .default = .x
        )
      )
    )

  return(correlations)
}
