# Fit and report Bayes Factors for associations with education, fields and occupations

This function computes the Bayes Factors for associations between a
grouping variable (e.g., `Group`, `Cluster`) and the variables
`education`, `field`, and `occupation` in a data frame. It uses the
[`BayesFactor::contingencyTableBF()`](https://rdrr.io/pkg/BayesFactor/man/contingencyTableBF.html)
function to compute the Bayes Factor for each variable and returns a
tidy data frame with the results.

## Usage

``` r
get_association_models(df, groups, type = "indepMulti")
```

## Arguments

- df:

  A data frame containing the variables `education`, `field`, and
  `occupation`, along with the grouping variable.

- groups:

  A grouping variable (e.g. `Group` or `Cluster`) without quotes.

- type:

  A character string specifying the type of contingency table model to
  use. Default is `"indepMulti"`, which indicates an independent
  multinomial model. See
  [`?BayesFactor::contingencyTableBF`](https://rdrr.io/pkg/BayesFactor/man/contingencyTableBF.html)
  for more details and options.

## Value

A data frame summarising the Bayes Factors for associations between the
grouping variable and the variables `education`, `field`, and
`occupation`, with the variable name in a `Variable` column, the
contingency table in a `table` column, and the log Bayes Factor in a
`log_bf10` column. The variable names are capitalised for better
readability.

## Examples

``` r
df_merged <- merge_clusters(
  df_raw     = study_data,
  df_red     = scale_reduce_vars(study_data),
  clustering = cluster_selected_vars(study_data)
)
get_association_models(df_merged, group)
#> # A tibble: 3 × 4
#> # Rowwise:  Variable
#>   Variable   data              table             log_bf10
#>   <chr>      <list>            <list>               <dbl>
#> 1 Education  <tibble [96 × 2]> <tibble [6 × 3]>     -4.88
#> 2 Field      <tibble [96 × 2]> <tibble [11 × 3]>    -5.41
#> 3 Occupation <tibble [96 × 2]> <tibble [9 × 3]>     -4.37
get_association_models(df_merged, cluster)
#> # A tibble: 3 × 4
#> # Rowwise:  Variable
#>   Variable   data              table             log_bf10
#>   <chr>      <list>            <list>               <dbl>
#> 1 Education  <tibble [96 × 2]> <tibble [6 × 4]>     -7.44
#> 2 Field      <tibble [96 × 2]> <tibble [11 × 4]>    -6.06
#> 3 Occupation <tibble [96 × 2]> <tibble [9 × 4]>     -3.88
get_association_models(df_merged, subcluster)
#> # A tibble: 3 × 4
#> # Rowwise:  Variable
#>   Variable   data              table             log_bf10
#>   <chr>      <list>            <list>               <dbl>
#> 1 Education  <tibble [96 × 2]> <tibble [6 × 5]>     -9.84
#> 2 Field      <tibble [96 × 2]> <tibble [11 × 5]>    -7.7 
#> 3 Occupation <tibble [96 × 2]> <tibble [9 × 5]>     -7.06
get_association_models(df_merged, group)$table
#> [[1]]
#> # A tibble: 6 × 3
#>   value           Control Aphantasic
#>   <fct>             <int>      <int>
#> 1 Other                 5          4
#> 2 Upper secondary       1          0
#> 3 Post-secondary        9          5
#> 4 Bachelor             17         17
#> 5 Master               17         16
#> 6 Doctorate             2          3
#> 
#> [[2]]
#> # A tibble: 11 × 3
#>    value                                        Control Aphantasic
#>    <fct>                                          <int>      <int>
#>  1 Generic programmes                                 4          4
#>  2 Education                                          1          1
#>  3 Arts, humanities                                   9         12
#>  4 Social sciences, journalism, information          11          4
#>  5 Business, Administration, Law                     10          8
#>  6 Natural sciences, mathematics, statistics          6          4
#>  7 Information, communication technologies            4          4
#>  8 Engineering, manufacturing, construction           3          3
#>  9 Agriculture, forestry, fisheries, veterinary       1          1
#> 10 Health and Welfare                                 2          3
#> 11 Services                                           0          1
#> 
#> [[3]]
#> # A tibble: 9 × 3
#>   value                       Control Aphantasic
#>   <fct>                         <int>      <int>
#> 1 No answer                         1          1
#> 2 Unemployed                        1          1
#> 3 Student                          20         12
#> 4 Science and Engineering           2          4
#> 5 Health                            2          6
#> 6 Teaching                          4          3
#> 7 Business, Administration          9         10
#> 8 Information, Communications       8          6
#> 9 Social, Cultural, Legal           4          2
#> 
```
