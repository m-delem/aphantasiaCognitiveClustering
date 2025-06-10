#' Reduce the number of variables to prepare for clustering
#'
#' @param df A data frame containing the variables to be reduced. It should
#' contain the following columns:
#' - `vviq`: VVIQ scores
#' - `osivq_o`: OSIVQ Object scores
#' - `osivq_s`: OSIVQ Spatial scores
#' - `osivq_v`: OSIVQ Verbal scores
#' - `psiq_vis`: Psi-Q Visual scores
#' - `psiq_aud`: Psi-Q Auditory scores
#' - `psiq_od`: Psi-Q Olfactory scores
#' - `psiq_gout`: Psi-Q Gustatory scores
#' - `psiq_tou`: Psi-Q Tactile scores
#' - `psiq_sens`: Psi-Q Sensory scores
#' - `psiq_feel`: Psi-Q Feelings scores
#' - `score_raven`: Raven Matrices scores
#' - `score_sri`: SRI scores
#' - `span_spatial`: Spatial Span scores
#' - `span_digit`: Digit Span scores
#' - `wcst_accuracy`: WCST accuracy scores
#' - `score_similarities`: Similarities scores
#' - `score_comprehension`: Comprehension scores
#' @param min Numeric. The minimum value of the scaled range. Default is 0.
#' @param max Numeric. The maximum value of the scaled range. Default is 1.
#'
#' @returns A data frame with reduced variables, including:
#' - `visual_imagery`: Merged VVIQ, OSIVQ Object, and Psi-Q Visual scores
#' - `auditory_imagery`: Psi-Q Auditory scores
#' - `sensory_imagery`: Merged Psi-Q scores on other modalities
#' - `spatial_imagery`: Merged SRI and OSIVQ Spatial scores
#' - `verbal_strategies`: OSIVQ Verbal scores
#' - `fluid_intelligence`: Merged Raven and Digit Span scores
#' - `verbal_reasoning`: Similarities scores
#' - `span_spatial`: Spatial Span scores
#' @export
#'
#' @examples
#' df_reduced <- scale_reduce_vars(study_data)
#' head(df_reduced)
#' colnames(df_reduced)
scale_reduce_vars <- function(df, min = 0, max = 1){
  df_reduced <-
    df |>
    scale_vars(min = min, max = max) |>
    dplyr::mutate(
      # merging the normalized vviq, osviq-o, and psiq visual scores
      visual_imagery = round(
        (16 * .data$vviq + 15 * .data$osivq_o + 3 * .data$psiq_vis) / 34,
        digits = 3
      ),
      # merging the normalized psiq scores on the other modalities
      sensory_imagery = round(
        (.data$psiq_od +
           .data$psiq_gout +
           .data$psiq_tou +
           .data$psiq_sens +
           .data$psiq_feel
         ) / 5,
        digits = 3
      ),
      # merging SRI and OSIVQ-S relative to their number of items
      spatial_imagery = round(
        (30 * .data$score_sri + 15 * .data$osivq_s) / 45,
        digits = 3
      ),
      # merging raven and digit span according to partial correlations
      fluid_intelligence = round(
        (.data$score_raven + .data$span_digit) / 2,
        digits = 3
      ),
      # merging SRI and Raven relative to their number of items (old tests)
      non_verbal_reasoning = round(
        (30 * .data$score_sri + 18 * .data$score_raven) / 48,
        digits = 3
      )
    ) |>
    dplyr::select(
      "visual_imagery",
      "auditory_imagery" = "psiq_aud",
      "sensory_imagery",
      "spatial_imagery",
      "verbal_strategies" = "osivq_v",
      "fluid_intelligence",
      # non_verbal_reasoning,
      "verbal_reasoning" = "score_similarities",
      "span_spatial"
    )

  return(df_reduced)
}
