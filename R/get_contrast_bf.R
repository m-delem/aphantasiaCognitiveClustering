#' Get contrasts between groups in a Bayesian model
#'
#' @description
#' This function wraps the machinery needed to compute the contrasts between the
#' levels of a grouping variable in our data (e.g., `Group`, `Cluster`) for a
#' given variable. It fits Bayesian models using the [fit_stan_glm()] function
#' for the prior and posterior distributions, computes the contrasts using
#' [emmeans::emmeans()] and [pairs()], and then computes the Bayes Factor for
#' the contrasts using [bayestestR::bf_parameters()]. The results are then
#' formatted in a clean table.
#'
#' @param df A data frame in long format containing the variable to be analysed
#' and the required columns. This is for example the output of
#' `get_longer(study_data)`.
#' @param groups A grouping variable (e.g. `Group` or `Cluster`) without quotes.
#'
#' @returns A data frame summarising the contrasts between the levels of the
#' grouping variable, with the variable name in a `Variable` column, the
#' comparison in a `Comparison` column, the difference in a
#' `Difference ($\Delta$)` column, the 95% credible interval in a
#' `95% CrI` column, and the log Bayes Factor in a `$log(BF_{10})$` column.
#'
#' @export
#' @examples
#' df_vviq <- study_data |> get_longer() |> dplyr::filter(Variable == "VVIQ")
#' vviq_contrast <- get_contrast_bf(df_vviq, Group)
#' print(vviq_contrast)
get_contrast_bf <- function(df, groups) {
  rlang::check_installed("bayestestR")
  rlang::check_installed("emmeans")
  rlang::check_installed("logspline")

  withr::local_options(list(warn = -1))

  groups_str <- deparse(substitute(groups))
  formula    <- stats::as.formula(glue::glue("value ~ {groups_str} * Age"))

  fit_post  <- fit_stan_glm(df, formula)
  fit_prior <- fit_stan_glm(df, formula, prior_PD = TRUE)

  contrast_post  <-
    emmeans::emmeans(fit_post,  specs = groups_str) |>
    graphics::pairs() |>
    suppressMessages() |>
    suppressWarnings()
  contrast_prior <-
    emmeans::emmeans(fit_prior, specs = groups_str) |>
    graphics::pairs() |>
    suppressMessages() |>
    suppressWarnings()
  contrast_bf    <-
    bayestestR::bf_parameters(
      posterior = contrast_post,
      prior     = contrast_prior
    )

  df_contrasts <-
    dplyr::left_join(
      contrast_post |> tibble::as_tibble() |> dplyr::rename("contrast" = 1),
      contrast_bf   |> tibble::as_tibble() |> dplyr::rename("contrast" = 1),
      by = "contrast"
    ) |>
    dplyr::rename(
      "Comparison" = "contrast",
      `Difference ($\\Delta$)` = "estimate",
      `$log(BF_{10})$` = "log_BF"
    ) |>
    dplyr::mutate(dplyr::across(
      tidyselect::where(is.numeric),
      ~ round(., digits = 2))
    ) |>
    tidyr::unite(
      "95% CrI",
      c("lower.HPD", "upper.HPD"),
      sep = ", "
    ) |>
    dplyr::mutate(`95% CrI` = paste0("[", .data$`95% CrI`, "]"))

  return(df_contrasts)
}
