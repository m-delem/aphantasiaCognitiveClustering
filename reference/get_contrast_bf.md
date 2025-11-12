# Get contrasts between groups in a Bayesian model

This function wraps the machinery needed to compute the contrasts
between the levels of a grouping variable in our data (e.g., `Group`,
`Cluster`) for a given variable. It fits Bayesian models using the
[`fit_stan_glm()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/fit_stan_glm.md)
function for the prior and posterior distributions, computes the
contrasts using
[`emmeans::emmeans()`](https://rvlenth.github.io/emmeans/reference/emmeans.html)
and [`pairs()`](https://rdrr.io/r/graphics/pairs.html), and then
computes the Bayes Factor for the contrasts using
[`bayestestR::bf_parameters()`](https://easystats.github.io/bayestestR/reference/bayesfactor_parameters.html).
The results are then formatted in a clean table.

## Usage

``` r
get_contrast_bf(df, groups)
```

## Arguments

- df:

  A data frame in long format containing the variable to be analysed and
  the required columns. This is for example the output of
  `get_longer(study_data)`.

- groups:

  A grouping variable (e.g. `Group` or `Cluster`) without quotes.

## Value

A data frame summarising the contrasts between the levels of the
grouping variable, with the variable name in a `Variable` column, the
comparison in a `Comparison` column, the difference in a
`Difference ($\Delta$)` column, the 95% credible interval in a `95% CrI`
column, and the log Bayes Factor in a `$log(BF_{10})$` column.

## Examples

``` r
df_vviq <- study_data |> get_longer() |> dplyr::filter(Variable == "VVIQ")
vviq_contrast <- get_contrast_bf(df_vviq, Group)
print(vviq_contrast)
#> # A tibble: 1 × 4
#>   Comparison           `Difference ($\\Delta$)` `95% CrI`      `$log(BF_{10})$`
#>   <chr>                                   <dbl> <chr>                     <dbl>
#> 1 Control - Aphantasic                     39.7 [36.22, 43.17]             56.6
```
