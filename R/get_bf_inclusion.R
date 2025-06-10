#' Compute Bayes Factor for Inclusion for the groups and age covariate
#'
#' @description
#' This function computes the Bayes Factor for Inclusion (BFI) for a given
#' grouping variable (e.g., `Group`, `Cluster`) and the `Age` covariate when
#' predicting a variable (e.g., `VVIQ`, `OSIVQ-Spatial`, etc.) from the `value`
#' column. As such, it requires a data frame with a `value` column, a
#' `Variable` column, the grouping variable, and the `Age` covariate.
#'
#' @param df A data frame in long format containing the variable to be analysed
#' and the required columns.
#' @param groups A grouping variable (e.g. `Group` or `Cluster`) without quotes.
#' @param progress Logical. If `TRUE`, the function will show a progress bar
#' while computing the Bayes Factor. Default is `FALSE`.
#'
#' @returns A data frame summarising the Bayes Factor for Inclusion for the
#' specified grouping variable and the `Age` covariate, with the variable name
#' in a `Variable` column and the Bayes Factor in a `log_BF` column.
#'
#' @export
#' @examples
#' df_vviq  <- study_data |> get_longer() |> dplyr::filter(Variable == "VVIQ")
#' vviq_bfi <- get_bf_inclusion(df_vviq, Group, progress = FALSE)
#' print(vviq_bfi)
get_bf_inclusion <- function(df, groups, progress = FALSE) {
  rlang::check_installed("BayesFactor")
  rlang::check_installed("bayestestR")
  rlang::check_installed("datawizard")
  withr::local_options(list(warn = -1))

  groups_str <- deparse(substitute(groups))
  formula    <- stats::as.formula(glue::glue("value ~ {groups_str} * Age"))

  bf_inclusion_table <-
    BayesFactor::generalTestBF(
      formula  = formula,
      data     = as.data.frame(df),
      progress = progress
    ) |>
    bayestestR::bf_inclusion() |>
    datawizard::rownames_as_column(var = "Variable") |>
    dplyr::mutate(dplyr::across(tidyselect::where(is.numeric), ~round(., 2)))

  return(bf_inclusion_table)
}
