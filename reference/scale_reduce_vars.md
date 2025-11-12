# Reduce the number of variables to prepare for clustering

Reduce the number of variables to prepare for clustering

## Usage

``` r
scale_reduce_vars(df, min = 0, max = 1)
```

## Arguments

- df:

  A data frame containing the variables to be reduced. It should contain
  the following columns:

  - `vviq`: VVIQ scores

  - `osivq_o`: OSIVQ Object scores

  - `osivq_s`: OSIVQ Spatial scores

  - `osivq_v`: OSIVQ Verbal scores

  - `psiq_vis`: Psi-Q Visual scores

  - `psiq_aud`: Psi-Q Auditory scores

  - `psiq_od`: Psi-Q Olfactory scores

  - `psiq_gout`: Psi-Q Gustatory scores

  - `psiq_tou`: Psi-Q Tactile scores

  - `psiq_sens`: Psi-Q Sensory scores

  - `psiq_feel`: Psi-Q Feelings scores

  - `score_raven`: Raven Matrices scores

  - `score_sri`: SRI scores

  - `span_spatial`: Spatial Span scores

  - `span_digit`: Digit Span scores

  - `wcst_accuracy`: WCST accuracy scores

  - `score_similarities`: Similarities scores

  - `score_comprehension`: Comprehension scores

- min:

  Numeric. The minimum value of the scaled range. Default is 0.

- max:

  Numeric. The maximum value of the scaled range. Default is 1.

## Value

A data frame with reduced variables, including:

- `visual_imagery`: Merged VVIQ, OSIVQ Object, and Psi-Q Visual scores

- `auditory_imagery`: Psi-Q Auditory scores

- `sensory_imagery`: Merged Psi-Q scores on other modalities

- `spatial_imagery`: Merged SRI and OSIVQ Spatial scores

- `verbal_strategies`: OSIVQ Verbal scores

- `fluid_intelligence`: Merged Raven and Digit Span scores

- `verbal_reasoning`: Similarities scores

- `span_spatial`: Spatial Span scores

## Examples

``` r
df_reduced <- scale_reduce_vars(study_data)
head(df_reduced)
#> # A tibble: 6 × 8
#>   visual_imagery auditory_imagery sensory_imagery spatial_imagery
#>            <dbl>            <dbl>           <dbl>           <dbl>
#> 1          0.65             0.741           0.785           0.767
#> 2          0.617            0.889           0.771           0.745
#> 3          0.471            0.703           0.637           0.661
#> 4          0.713            0.814           0.778           0.444
#> 5          0.125            0               0               0.439
#> 6          0.703            0.778           0.578           0.761
#> # ℹ 4 more variables: verbal_strategies <dbl>, fluid_intelligence <dbl>,
#> #   verbal_reasoning <dbl>, span_spatial <dbl>
colnames(df_reduced)
#> [1] "visual_imagery"     "auditory_imagery"   "sensory_imagery"   
#> [4] "spatial_imagery"    "verbal_strategies"  "fluid_intelligence"
#> [7] "verbal_reasoning"   "span_spatial"      
```
