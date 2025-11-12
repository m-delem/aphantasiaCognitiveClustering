# Correlate the original variables with a chosen method and correction

Correlate the original variables with a chosen method and correction

## Usage

``` r
correlate_vars(
  df,
  method = "pearson",
  partial = TRUE,
  correction = "bonferroni"
)
```

## Arguments

- df:

  A data frame containing the variables to be correlated, usually
  `study_data`.

- method:

  A string indicating the correlation method to use. Default is
  "pearson". Other options include "spearman" and "kendall". See
  `?correlation::correlation()` for more details.

- partial:

  Logical. Whether to compute partial correlations. Default is TRUE. If
  FALSE, computes simple correlations.

- correction:

  A string indicating the p-value correction method to use. Default is
  "bonferroni". Other options include "holm", "fdr", or "none". See
  `?correlation::correlation()` for more details.

## Value

A data frame containing the correlations between the variables, with the
parameters renamed for better readability.

## Examples

``` r
simple_correlations <- correlate_vars(study_data, partial = FALSE)
format(head(simple_correlations))
#>   Parameter1      Parameter2     r         95% CI t(94)         p
#> 1       VVIQ   OSIVQ\nObject  0.88 [ 0.82,  0.92] 17.55 < .001***
#> 2       VVIQ  OSIVQ\nSpatial  0.11 [-0.09,  0.30]  1.07 > .999   
#> 3       VVIQ   OSIVQ\nVerbal -0.23 [-0.41, -0.03] -2.32 > .999   
#> 4       VVIQ   Psi-Q\nVisual  0.94 [ 0.92,  0.96] 27.69 < .001***
#> 5       VVIQ Psi-Q\nAudition  0.80 [ 0.72,  0.86] 13.05 < .001***
#> 6       VVIQ    Psi-Q\nSmell  0.81 [ 0.73,  0.87] 13.30 < .001***
```
