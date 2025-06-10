#' Fit a stan_glm model with predefined parameters
#'
#' @description
#' This function is a simple wrapper around the [rstanarm::stan_glm()] function
#' to fit a Bayesian linear model using Stan. It is mostly designed to set the
#' defaults we needed for our package, notably the number of iterations and the
#' seed for reproducibility. It provides a shorter syntax to fit many models,
#' allowing to reuse it in other functions (e.g., [get_full_model_table()]).
#'
#' @param df A data frame.
#' @param formula A formula specifying the model to be fitted, e.g.
#' `value ~ Group * Age`.
#' @param chains  Number of Markov chains to run. Default is 4.
#' @param iter    Number of iterations per chain. Default is 10000.
#' @param refresh Refresh rate for the progress bar. Default is 0 (no progress
#' bar).
#' @param seed    Seed for random number generation to ensure reproducibility.
#' The default, 14051998, was used to produce the results presented in the
#' scientific article associated with this package.
#' @param prior_PD Logical. If `TRUE`, the model will be fitted with a prior
#' predictive check. Default is `FALSE`.
#' @param ... Additional arguments passed to [rstanarm::stan_glm()].
#'
#' @returns A fitted `stanreg` object containing the results of the Bayesian
#' linear model.
#'
#' @export
#' @examples
#' df_vviq  <- study_data |> get_longer() |> dplyr::filter(Variable == "VVIQ")
#' vviq_fit <- fit_stan_glm(df_vviq, value ~ Group * Age)
#' summary(vviq_fit)
fit_stan_glm <- function(
    df, formula,
    chains = 4, iter = 10000, refresh = 0, seed = 14051998, prior_PD = FALSE,
    ...
) {
  rlang::check_installed("rstanarm")

  fit <-
    rstanarm::stan_glm(
      formula  = formula,
      data     = df,
      chains   = chains,
      iter     = iter,
      refresh  = refresh,
      seed     = seed,
      prior_PD = prior_PD,
      ...
    )
  return(fit)
}
