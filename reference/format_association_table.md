# Display the association table for a specific variable in a clean format

This function was built specifically to provide an easy way to display
the tables nested in the output of
[`get_association_models()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_association_models.md)
in a clean format. It is *really* not meant to be used outside of this
context and it requires specific columns, so it is not likely to work
with many other data frames.

## Usage

``` r
format_association_table(df, variable)
```

## Arguments

- df:

  A tibble containing the association table in a nested `table` column,
  typically the result of
  [`get_association_models()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_association_models.md).

- variable:

  A character string specifying the variable for which to format the
  table. For the output of
  [`get_association_models()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_association_models.md),
  this should be one of `"Education"`, `"Field"`, or `"Occupation"`.

## Value

A table formatted with
[`knitr::kable()`](https://rdrr.io/pkg/knitr/man/kable.html), ready to
be displayed.

## Examples

``` r
df_associations <- get_association_models(study_data, group)
format_association_table(df_associations, "Education")
#> # A tibble: 6 × 3
#>   Education       Control Aphantasic
#>   <fct>             <int>      <int>
#> 1 Other                 5          4
#> 2 Upper secondary       1          0
#> 3 Post-secondary        9          5
#> 4 Bachelor             17         17
#> 5 Master               17         16
#> 6 Doctorate             2          3
format_association_table(df_associations, "Field")
#> # A tibble: 11 × 3
#>    Field                                        Control Aphantasic
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
format_association_table(df_associations, "Occupation")
#> # A tibble: 9 × 3
#>   Occupation                  Control Aphantasic
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
```
