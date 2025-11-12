# Compute Bayes Factor for Inclusion for the groups and age covariate

This function computes the Bayes Factor for Inclusion (BFI) for a given
grouping variable (e.g., `Group`, `Cluster`) and the `Age` covariate
when predicting a variable (e.g., `VVIQ`, `OSIVQ-Spatial`, etc.) from
the `value` column. As such, it requires a data frame with a `value`
column, a `Variable` column, the grouping variable, and the `Age`
covariate.

## Usage

``` r
get_bf_inclusion(df, groups, progress = FALSE)
```

## Arguments

- df:

  A data frame in long format containing the variable to be analysed and
  the required columns.

- groups:

  A grouping variable (e.g. `Group` or `Cluster`) without quotes.

- progress:

  Logical. If `TRUE`, the function will show a progress bar while
  computing the Bayes Factor. Default is `FALSE`.

## Value

A data frame summarising the Bayes Factor for Inclusion for the
specified grouping variable and the `Age` covariate, with the variable
name in a `Variable` column and the Bayes Factor in a `log_BF` column.

## Examples

``` r
df_vviq  <- study_data |> get_longer() |> dplyr::filter(Variable == "VVIQ")
vviq_bfi <- get_bf_inclusion(df_vviq, Group, progress = FALSE)
print(vviq_bfi)
#>    Variable p_prior p_posterior log_BF
#> 1     Group     0.6        1.00  84.58
#> 2       Age     0.6        0.22  -1.65
#> 3 Age:Group     0.2        0.06  -1.36
```
