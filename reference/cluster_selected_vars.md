# Use Gaussian Mixture Models to cluster selected variables

Use Gaussian Mixture Models to cluster selected variables

## Usage

``` r
cluster_selected_vars(df, vars = NULL)
```

## Arguments

- df:

  A data frame containing the variables to be clustered, usually
  `study_data`.

- vars:

  A character vector of variable names to be clustered. If NULL, a
  default set of variables is used:

  - `visual_imagery`

  - `sensory_imagery`

  - `spatial_imagery`

  - `verbal_strategies`

  - `fluid_intelligence`

  - `verbal_reasoning`

  - `span_spatial`

## Value

A fitted Mclust object containing the clustering results.

## Examples

``` r
clustering <- cluster_selected_vars(study_data)
clustering
#> 'Mclust' model object: (EVE,3) 
#> 
#> Available components: 
#>  [1] "call"           "data"           "modelName"      "n"             
#>  [5] "d"              "G"              "BIC"            "loglik"        
#>  [9] "df"             "bic"            "icl"            "hypvol"        
#> [13] "parameters"     "z"              "classification" "uncertainty"   

if (requireNamespace("dplyr")) {
  data.frame(cluster = clustering$classification) |>
    dplyr::reframe(n = dplyr::n(), .by = cluster)
}
#>   cluster  n
#> 1       2 34
#> 2       1 30
#> 3       3 32
```
