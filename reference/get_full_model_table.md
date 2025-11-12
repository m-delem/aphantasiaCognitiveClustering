# Create a table summarising the models for each variable

This macro-function runs various computations to model the variables in
the `Variable` column of a long format data that have their values in a
`value` column with a grouping variable (e.g., `Group`, `Cluster`) and
an `Age` variable. It wraps the
[`get_mean_sd()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_mean_sd.md),
[`get_bf_inclusion()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_bf_inclusion.md),
and
[`get_contrast_bf()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_contrast_bf.md)
functions to compute the mean and standard deviation for each group, the
Bayes Factor for Inclusion of the grouping variable and the `Age`
covariate, and the contrasts between the levels of the grouping
variable, respectively. The results are then formatted in a clean table
with one row per variable and columns for the mean, standard deviation,
Bayes Factor for Inclusion, and contrasts.

## Usage

``` r
get_full_model_table(df_long, ...)
```

## Arguments

- df_long:

  A data frame in long format containing the variables to be analysed
  with a `Variable` column, a `value` column, a grouping variable (e.g.,
  `Group`, `Cluster`), and an `Age` covariate. This is for example the
  output of `get_longer(study_data)`.

- ...:

  A grouping variable (e.g. `Group` or `Cluster`) without quotes.

## Value

A data frame summarising the models for each variable.

## Examples

``` r
df_merged <- merge_clusters(
  df_raw     = study_data,
  df_red     = scale_reduce_vars(study_data),
  clustering = cluster_selected_vars(study_data)
)
df_long_example <-
 df_merged |>
 get_longer() |>
 dplyr::filter(Variable %in% c("VVIQ"))

cluster_models <- get_full_model_table(df_long_example, Cluster)
print(cluster_models)
#> # A tibble: 3 × 11
#>   Variable `A (Aphant.)` `B (Mixed)`  `C (Control)` Cluster   Age
#>   <fct>    <chr>         <chr>        <chr>           <dbl> <dbl>
#> 1 VVIQ     18.06 (4.1)   36.5 (17.56) 62.18 (8.66)     54.9 -1.11
#> 2 VVIQ     18.06 (4.1)   36.5 (17.56) 62.18 (8.66)     54.9 -1.11
#> 3 VVIQ     18.06 (4.1)   36.5 (17.56) 62.18 (8.66)     54.9 -1.11
#> # ℹ 5 more variables: `Cluster $\\times$ Age` <dbl>, Comparison <chr>,
#> #   `Difference ($\\Delta$)` <dbl>, `95% CrI` <chr>, `$log(BF_{10})$` <dbl>
```
