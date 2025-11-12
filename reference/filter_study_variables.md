# Filter the `Variable` column of a long format data frame

This function is a simple helper to filter the `Variable` column of the
study data in long format. There are two main groups of study variables,
"original" experimental variables and "reduced" variables created in our
analyses. This functions allows to filter these two selections easily,
and optionally to filter for a specific set of variables.

## Usage

``` r
filter_study_variables(df, selection = "original", variables = NULL)
```

## Arguments

- df:

  A data frame in long format containing the `Variable` column to be
  filtered. This is for example the output of `get_longer(study_data)`.

- selection:

  A character string indicating the selection of variables to filter
  for. It can be either `"original"`, `"reduced"` (reduced variables +
  three validation variables from the original set) or
  `"reduced_strict"`. If you want to use a custom set of variables, set
  `variables` to a character vector and leave `selection` to its default
  value.

- variables:

  Optional. A character vector of variable names to filter for. If
  `NULL`, the function will use the default selection of variables based
  on the `selection` argument. If provided, it will override the default
  selection.

## Value

A data frame filtered for the specified variables in the `Variable`
column.

## Examples

``` r
df_merged_long <- merge_clusters(
  df_raw     = study_data,
  df_red     = scale_reduce_vars(study_data),
  clustering = cluster_selected_vars(study_data)
) |> get_longer()

# df_merged_long contains all study and reduced variables
original <- filter_study_variables(df_merged_long, selection = "original")
reduced  <- filter_study_variables(df_merged_long, selection = "reduced")
reduced_strict  <- filter_study_variables(
 df_merged_long,
 selection = "reduced_strict"
)
custom <- filter_study_variables(
  df_merged_long,
  variables = c("VVIQ", "WCST")
)
levels(factor(original$Variable))
#>  [1] "VVIQ"                   "OSIVQ-Object"           "OSIVQ-Spatial"         
#>  [4] "OSIVQ-Verbal"           "Psi-Q Vision"           "Psi-Q Audition"        
#>  [7] "Psi-Q Smell"            "Psi-Q Taste"            "Psi-Q Touch"           
#> [10] "Psi-Q Sensations"       "Psi-Q Feelings"         "Raven matrices"        
#> [13] "SRI"                    "Digit span"             "Spatial span"          
#> [16] "Similarities test"      "WCST"                   "Reading\ncomprehension"
levels(factor(reduced$Variable))
#>  [1] "Visual imagery"         "Auditory imagery"       "Sensory imagery"       
#>  [4] "Spatial imagery"        "Verbal strategies"      "Raven +\nDigit Span"   
#>  [7] "Verbal reasoning"       "Spatial span std."      "WCST"                  
#> [10] "Reading\ncomprehension"
levels(factor(reduced_strict$Variable))
#> [1] "Visual imagery"      "Sensory imagery"     "Spatial imagery"    
#> [4] "Verbal strategies"   "Raven +\nDigit Span" "Verbal reasoning"   
#> [7] "Spatial span std."  
levels(factor(custom$Variable))
#> [1] "VVIQ" "WCST"
```
