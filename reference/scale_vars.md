# Scale original quantitative variables to a defined range

The function does not require any of the variables to be present in the
dataframe, so any dataframe can be used. The function simply modifies
the columns of interest if they

## Usage

``` r
scale_vars(df, min = 0, max = 1)
```

## Arguments

- df:

  A data frame containing the variables to be scaled, usually
  `study_data`.

- min:

  Numeric. The minimum value of the scaled range. Default is 0.

- max:

  Numeric. The maximum value of the scaled range. Default is 1.

## Value

A data frame with the original variables scaled to the specified range.

## Examples

``` r
df_scaled <- scale_vars(study_data, min = 0, max = 1)
head(df_scaled)
#> # A tibble: 6 × 27
#>   id      age sex   group  education field field_code occupation occupation_code
#>   <chr> <dbl> <fct> <fct>  <fct>     <fct> <fct>      <fct>      <fct>          
#> 1 7210  0.13  m     Contr… Master    Soci… 3          Health     5              
#> 2 7213  0.065 f     Contr… Master    Soci… 3          Student    3              
#> 3 7238  0.717 f     Contr… Bachelor  Natu… 5          Informati… 8              
#> 4 7242  0.63  f     Contr… Post-sec… Busi… 4          Business,… 7              
#> 5 7254  0.391 f     Aphan… Doctorate Heal… 9          Health     5              
#> 6 7257  0.37  m     Contr… Bachelor  Natu… 5          Business,… 7              
#> # ℹ 18 more variables: vviq <dbl>, osivq_o <dbl>, osivq_s <dbl>, osivq_v <dbl>,
#> #   psiq_vis <dbl>, psiq_aud <dbl>, psiq_od <dbl>, psiq_gout <dbl>,
#> #   psiq_tou <dbl>, psiq_sens <dbl>, psiq_feel <dbl>, score_raven <dbl>,
#> #   score_sri <dbl>, span_spatial <dbl>, span_digit <dbl>, wcst_accuracy <dbl>,
#> #   score_similarities <dbl>, score_comprehension <dbl>
colnames(df_scaled)
#>  [1] "id"                  "age"                 "sex"                
#>  [4] "group"               "education"           "field"              
#>  [7] "field_code"          "occupation"          "occupation_code"    
#> [10] "vviq"                "osivq_o"             "osivq_s"            
#> [13] "osivq_v"             "psiq_vis"            "psiq_aud"           
#> [16] "psiq_od"             "psiq_gout"           "psiq_tou"           
#> [19] "psiq_sens"           "psiq_feel"           "score_raven"        
#> [22] "score_sri"           "span_spatial"        "span_digit"         
#> [25] "wcst_accuracy"       "score_similarities"  "score_comprehension"
```
