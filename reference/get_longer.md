# Transform the main data frame to long format

Pivot the main data frames to long format. Any of the variables from the
study (raw/original variables) or created during the analysis (e.g.,
reduced variables) will be selected and pivoted to long format.

## Usage

``` r
get_longer(df)
```

## Arguments

- df:

  A data frame containing the main data.

## Value

A data frame in long format.

## Examples

``` r
df_raw_long <- get_longer(study_data)
head(df_raw_long[, c("id", "Variable", "value")], 18)
#> # A tibble: 18 × 3
#>    id    Variable                 value
#>    <chr> <fct>                    <dbl>
#>  1 7210  "VVIQ"                   65   
#>  2 7210  "OSIVQ-Object"           45   
#>  3 7210  "OSIVQ-Spatial"          45   
#>  4 7210  "OSIVQ-Verbal"           54   
#>  5 7210  "Psi-Q Vision"            8   
#>  6 7210  "Psi-Q Audition"          7.67
#>  7 7210  "Psi-Q Smell"             8   
#>  8 7210  "Psi-Q Taste"             7.33
#>  9 7210  "Psi-Q Touch"             8.33
#> 10 7210  "Psi-Q Sensations"        8.67
#> 11 7210  "Psi-Q Feelings"          8   
#> 12 7210  "Raven matrices"         14   
#> 13 7210  "SRI"                    27   
#> 14 7210  "Digit span"              6.07
#> 15 7210  "Spatial span"            5.43
#> 16 7210  "Similarities test"      30   
#> 17 7210  "WCST"                   78   
#> 18 7210  "Reading\ncomprehension" 24   

df_merged <- merge_clusters(
  df_raw     = study_data,
  df_red     = scale_reduce_vars(study_data),
  clustering = cluster_selected_vars(study_data)
  )
df_full_long <- get_longer(scale_vars(df_merged))
df_full_long[, c("id", "Variable", "value")] |>
  head(26) |>
  print(n = Inf)
#> # A tibble: 26 × 3
#>    id    Variable                 value
#>    <chr> <fct>                    <dbl>
#>  1 7210  "VVIQ"                   0.766
#>  2 7210  "OSIVQ-Object"           0.5  
#>  3 7210  "OSIVQ-Spatial"          0.5  
#>  4 7210  "OSIVQ-Verbal"           0.65 
#>  5 7210  "Psi-Q Vision"           0.778
#>  6 7210  "Psi-Q Audition"         0.741
#>  7 7210  "Psi-Q Smell"            0.778
#>  8 7210  "Psi-Q Taste"            0.703
#>  9 7210  "Psi-Q Touch"            0.814
#> 10 7210  "Psi-Q Sensations"       0.852
#> 11 7210  "Psi-Q Feelings"         0.778
#> 12 7210  "Raven matrices"         0.389
#> 13 7210  "SRI"                    0.9  
#> 14 7210  "Digit span"             0.825
#> 15 7210  "Spatial span"           0.927
#> 16 7210  "Similarities test"      0.833
#> 17 7210  "Visual imagery"         0.65 
#> 18 7210  "Auditory imagery"       0.741
#> 19 7210  "Sensory imagery"        0.785
#> 20 7210  "Spatial imagery"        0.767
#> 21 7210  "Verbal strategies"      0.65 
#> 22 7210  "Raven +\nDigit Span"    0.607
#> 23 7210  "Verbal reasoning"       0.833
#> 24 7210  "Spatial span std."      0.927
#> 25 7210  "WCST"                   0.78 
#> 26 7210  "Reading\ncomprehension" 0.774
```
