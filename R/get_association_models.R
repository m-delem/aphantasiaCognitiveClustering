#' Fit and report Bayes Factors for associations with education, fields and
#' occupations
#'
#' @description
#' This function computes the Bayes Factors for associations between a grouping
#' variable (e.g., `Group`, `Cluster`) and the variables `education`,
#' `field`, and `occupation` in a data frame. It uses the
#' [BayesFactor::contingencyTableBF()] function to compute the Bayes Factor
#' for each variable and returns a tidy data frame with the results.
#'
#' @param df A data frame containing the variables `education`, `field`, and
#' `occupation`, along with the grouping variable.
#' @param groups A grouping variable (e.g. `Group` or `Cluster`) without quotes.
#' @param type A character string specifying the type of contingency table
#' model to use. Default is `"indepMulti"`, which indicates an independent
#' multinomial model. See `?BayesFactor::contingencyTableBF` for more details
#' and options.
#'
#' @returns A data frame summarising the Bayes Factors for associations
#' between the grouping variable and the variables `education`, `field`, and
#' `occupation`, with the variable name in a `Variable` column, the
#' contingency table in a `table` column, and the log Bayes Factor in a
#' `log_bf10` column. The variable names are capitalised for better readability.
#' @export
#'
#' @examples
#' df_merged <- merge_clusters(
#'   df_raw     = study_data,
#'   df_red     = scale_reduce_vars(study_data),
#'   clustering = cluster_selected_vars(study_data)
#' )
#' get_association_models(df_merged, group)
#' get_association_models(df_merged, cluster)
#' get_association_models(df_merged, subcluster)
#' get_association_models(df_merged, group)$table
get_association_models <- function(df, groups, type = "indepMulti") {
  rlang::check_installed("BayesFactor")

  associations <-
    df |>
    tidyr::pivot_longer(
      c("education", "field", "occupation"),
      names_to = "Variable",
      values_to = "value"
    ) |>
    dplyr::select({{ groups }}, "Variable", "value") |>
    dplyr::group_by(.data$Variable) |>
    tidyr::nest() |>
    dplyr::rowwise() |>
    dplyr::mutate(
      table = list(
        data |>
          dplyr::group_by({{ groups }}, .data$value) |>
          dplyr::count() |>
          tidyr::pivot_wider(
            names_from = {{ groups }},
            values_from = "n"
          ) |>
          tibble::as_tibble() |>
          dplyr::mutate(dplyr::across(
            !c("value"),
            ~tidyr::replace_na(., 0)
            ))
      ),
      log_bf10 =
        BayesFactor::contingencyTableBF(
          as.matrix(table[, names(table) != "value"]),
          sampleType = type,
          fixedMargin = "cols"
        ) |>
        tibble::as_tibble() |>
        dplyr::pull("bf") |>
        log() |>
        round(2),
      Variable = stringr::str_to_title(.data$Variable)
    )

  return(associations)
}
