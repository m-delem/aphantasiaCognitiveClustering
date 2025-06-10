#' Create a table summarising the models for each variable
#'
#' @description
#' This macro-function runs various computations to model the variables in the
#' `Variable` column of a long format data that have their values in a `value`
#' column with a grouping variable (e.g., `Group`, `Cluster`) and an `Age`
#' variable. It wraps the [get_mean_sd()], [get_bf_inclusion()], and
#' [get_contrast_bf()] functions to compute the mean and standard deviation
#' for each group, the Bayes Factor for Inclusion of the grouping variable and
#' the `Age` covariate, and the contrasts between the levels of the grouping
#' variable, respectively. The results are then formatted in a clean table
#' with one row per variable and columns for the mean, standard deviation,
#' Bayes Factor for Inclusion, and contrasts.
#'
#' @param df_long A data frame in long format containing the variables to be
#' analysed with a `Variable` column, a `value` column, a grouping variable
#' (e.g., `Group`, `Cluster`), and an `Age` covariate. This is for example the
#' output of `get_longer(study_data)`.
#' @param ... A grouping variable (e.g. `Group` or `Cluster`) without quotes.
#'
#' @returns A data frame summarising the models for each variable.
#'
#' @export
#' @examples
#' df_merged <- merge_clusters(
#'   df_raw     = study_data,
#'   df_red     = scale_reduce_vars(study_data),
#'   clustering = cluster_selected_vars(study_data)
#' )
#' df_long_example <-
#'  df_merged |>
#'  get_longer() |>
#'  dplyr::filter(Variable %in% c("VVIQ"))
#'
#' cluster_models <- get_full_model_table(df_long_example, Cluster)
#' print(cluster_models)
get_full_model_table <- function(df_long, ...) {
  withr::local_options(list(warn = -1))
  groups_str <- deparse(substitute(...))

  model_table <-
    df_long |>
    dplyr::group_by(.data$Variable) |>
    tidyr::nest() |>
    dplyr::rowwise() |>
    dplyr::mutate(
      stats    = list(get_mean_sd(data, ...)),
      model_bf = list(get_bf_inclusion(data, ..., progress = FALSE)$log_BF),
      contrast = list(get_contrast_bf(data, ...))
    ) |>
    tidyr::unnest_wider("stats") |>
    tidyr::unnest_wider("model_bf", names_sep = "_") |>
    tidyr::unnest_longer("contrast") |>
    tidyr::unnest_wider("contrast") |>
    dplyr::select(!data) |>
    dplyr::mutate(dplyr::across(
      tidyselect::where(is.numeric),
      ~ round(., digits = 2))
    ) |>
    dplyr::rename(
      {{ groups_str }} := "model_bf_1",
      Age               = "model_bf_2",
      !!glue::glue("{groups_str} $\\times$ Age") := "model_bf_3"
    )

  return(model_table)
}
