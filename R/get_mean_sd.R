#' Get the mean and standard deviation of a variable in a clean table
#'
#' The point of the function is to get the mean/SD in a clean formatted string.
#' It does not add much on top of `dplyr` functions, but allows to perform the
#' required computations in a single line of code to use them inside other
#' functions (e.g., [get_full_model_table()]).
#'
#' @param df A data frame containing the variable to be summarised in long
#' format, with its name in a column and the associated values in a `value`
#' column. This is for example the output of `get_longer(study_data)`.
#'
#' @param groups A grouping variable (e.g. `Group` or `Cluster`) without quotes.
#'
#' @returns A data frame summarising the mean and standard deviation of the
#' variable for each group in a wide format with one column per group.
#'
#' @export
#' @examples
#' df_vviq  <- study_data |> get_longer() |> dplyr::filter(Variable == "VVIQ")
#' vviq_mean_sd <- get_mean_sd(df_vviq, Group)
#' print(vviq_mean_sd)
get_mean_sd <- function(df, groups) {
  stats <-
    df |>
    dplyr::group_by({{ groups }}) |>
    dplyr::reframe(stats = paste0(
      glue::glue("{round(mean(value), digits = 2)} "),
      glue::glue("({round(sd(value), digits = 2)})")
    )
    ) |>
    tidyr::pivot_wider(
      names_from = {{ groups }},
      values_from = stats
    )
  return(stats)
}
