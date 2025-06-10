#' Scale original quantitative variables to a defined range
#'
#' The function does not require any of the variables to be present in the
#' dataframe, so any dataframe can be used. The function simply modifies the
#' columns of interest if they
#'
#' @param df A data frame containing the variables to be scaled, usually
#' `study_data`.
#' @param min Numeric. The minimum value of the scaled range. Default is 0.
#' @param max Numeric. The maximum value of the scaled range. Default is 1.
#'
#' @returns A data frame with the original variables scaled to the specified
#' range.
#' @export
#'
#' @examples
#' df_scaled <- scale_vars(study_data, min = 0, max = 1)
#' head(df_scaled)
#' colnames(df_scaled)
scale_vars <- function(df, min = 0, max = 1){
  df_scaled <-
    df |>
    dplyr::mutate(
      dplyr::across(
        tidyselect::starts_with("age"),
        ~ scales::rescale(., c(min, max), c(min(age),max(age)))
      ),
      dplyr::across(
        tidyselect::contains("vviq"),
        ~ scales::rescale(., c(min, max), c(16,80))
      ),
      dplyr::across(
        tidyselect::contains("osivq"),
        ~ scales::rescale(., c(min, max), c(15, 75))
      ),
      dplyr::across(
        tidyselect::contains("psiq"),
        ~ scales::rescale(., c(min, max), c(1, 10))
      ),
      dplyr::across(
        tidyselect::contains("raven"),
        ~ scales::rescale(., c(min, max), c(0, 36))
      ),
      dplyr::across(
        tidyselect::contains("sri"),
        ~ scales::rescale(., c(min, max), c(0, 30))
      ),
      dplyr::across(
        tidyselect::contains("span"),
        ~ scales::rescale(., c(min, max), c(0, max(.)))
      ),
      dplyr::across(
        tidyselect::contains("wcst"),
        ~ scales::rescale(., c(min, max), c(0, 100))
      ),
      dplyr::across(
        tidyselect::contains("similar"),
        ~ scales::rescale(., c(min, max), c(0, 36))
      ),
      dplyr::across(
        tidyselect::contains("comprehension"),
        ~ scales::rescale(., c(min, max), c(0, max(.) + 3))
      ),
      dplyr::across(tidyselect::any_of(c(
        tidyselect::contains("age"),
        tidyselect::contains("vviq"),
        tidyselect::contains("osivq"),
        tidyselect::contains("psiq"),
        tidyselect::contains("score"),
        tidyselect::contains("span"),
        tidyselect::contains("wcst")
      )),
      ~ round(., 3)
      )
    )
  return(df_scaled)
}
