# Get the mean and standard deviation of a variable in a clean table

The point of the function is to get the mean/SD in a clean formatted
string. It does not add much on top of `dplyr` functions, but allows to
perform the required computations in a single line of code to use them
inside other functions (e.g.,
[`get_full_model_table()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_full_model_table.md)).

## Usage

``` r
get_mean_sd(df, groups)
```

## Arguments

- df:

  A data frame containing the variable to be summarised in long format,
  with its name in a column and the associated values in a `value`
  column. This is for example the output of `get_longer(study_data)`.

- groups:

  A grouping variable (e.g. `Group` or `Cluster`) without quotes.

## Value

A data frame summarising the mean and standard deviation of the variable
for each group in a wide format with one column per group.

## Examples

``` r
df_vviq  <- study_data |> get_longer() |> dplyr::filter(Variable == "VVIQ")
vviq_mean_sd <- get_mean_sd(df_vviq, Group)
print(vviq_mean_sd)
#> # A tibble: 1 × 2
#>   Control       Aphantasic  
#>   <chr>         <chr>       
#> 1 58.08 (10.81) 18.33 (4.24)
```
