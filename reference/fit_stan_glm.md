# Fit a stan_glm model with predefined parameters

This function is a simple wrapper around the
[`rstanarm::stan_glm()`](https://mc-stan.org/rstanarm/reference/stan_glm.html)
function to fit a Bayesian linear model using Stan. It is mostly
designed to set the defaults we needed for our package, notably the
number of iterations and the seed for reproducibility. It provides a
shorter syntax to fit many models, allowing to reuse it in other
functions (e.g.,
[`get_full_model_table()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_full_model_table.md)).

## Usage

``` r
fit_stan_glm(
  df,
  formula,
  chains = 4,
  iter = 10000,
  refresh = 0,
  seed = 14051998,
  prior_PD = FALSE,
  ...
)
```

## Arguments

- df:

  A data frame.

- formula:

  A formula specifying the model to be fitted, e.g.
  `value ~ Group * Age`.

- chains:

  Number of Markov chains to run. Default is 4.

- iter:

  Number of iterations per chain. Default is 10000.

- refresh:

  Refresh rate for the progress bar. Default is 0 (no progress bar).

- seed:

  Seed for random number generation to ensure reproducibility. The
  default, 14051998, was used to produce the results presented in the
  scientific article associated with this package.

- prior_PD:

  Logical. If `TRUE`, the model will be fitted with a prior predictive
  check. Default is `FALSE`.

- ...:

  Additional arguments passed to
  [`rstanarm::stan_glm()`](https://mc-stan.org/rstanarm/reference/stan_glm.html).

## Value

A fitted `stanreg` object containing the results of the Bayesian linear
model.

## Examples

``` r
df_vviq  <- study_data |> get_longer() |> dplyr::filter(Variable == "VVIQ")
vviq_fit <- fit_stan_glm(df_vviq, value ~ Group * Age)
summary(vviq_fit)
#> 
#> Model Info:
#>  function:     stan_glm
#>  family:       gaussian [identity]
#>  formula:      value ~ Group * Age
#>  algorithm:    sampling
#>  sample:       20000 (posterior sample size)
#>  priors:       see help('prior_summary')
#>  observations: 96
#>  predictors:   4
#> 
#> Estimates:
#>                       mean   sd    10%   50%   90%
#> (Intercept)          57.6    3.4  53.2  57.6  61.9
#> GroupAphantasic     -37.2    5.5 -44.3 -37.3 -30.2
#> Age                   0.0    0.1  -0.1   0.0   0.1
#> GroupAphantasic:Age  -0.1    0.2  -0.3  -0.1   0.1
#> sigma                 8.6    0.6   7.8   8.5   9.4
#> 
#> Fit Diagnostics:
#>            mean   sd   10%   50%   90%
#> mean_PPD 39.5    1.2 37.9  39.5  41.0 
#> 
#> The mean_ppd is the sample average posterior predictive distribution of the outcome variable (for details see help('summary.stanreg')).
#> 
#> MCMC diagnostics
#>                     mcse Rhat n_eff
#> (Intercept)         0.0  1.0   9010
#> GroupAphantasic     0.1  1.0   7208
#> Age                 0.0  1.0   8917
#> GroupAphantasic:Age 0.0  1.0   6894
#> sigma               0.0  1.0  13234
#> mean_PPD            0.0  1.0  16897
#> log-posterior       0.0  1.0   6816
#> 
#> For each parameter, mcse is Monte Carlo standard error, n_eff is a crude measure of effective sample size, and Rhat is the potential scale reduction factor on split chains (at convergence Rhat=1).
```
