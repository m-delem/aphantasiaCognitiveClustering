# aphantasiaCognitiveClustering

## Overview

The main dataset used for the analyses is provided in the package as
`study_data`. It contains the data from the study in a tidy format,
ready for analysis.

``` r
library(aphantasiaCognitiveClustering)
#> Welcome to aphantasiaCognitiveClustering.
#> See https://osf.io/7vsx6/ for the associated study.

head(study_data)
#>     id age sex      group      education
#> 1 7210  25   m    Control         Master
#> 2 7213  22   f    Control         Master
#> 3 7238  52   f    Control       Bachelor
#> 4 7242  48   f    Control Post-secondary
#> 5 7254  37   f Aphantasic      Doctorate
#> 6 7257  36   m    Control       Bachelor
#>                                       field field_code
#> 1  Social sciences, journalism, information          3
#> 2  Social sciences, journalism, information          3
#> 3 Natural sciences, mathematics, statistics          5
#> 4             Business, Administration, Law          4
#> 5                        Health and Welfare          9
#> 6 Natural sciences, mathematics, statistics          5
#>                    occupation occupation_code vviq osivq_o osivq_s osivq_v
#> 1                      Health               5   65      45      45      54
#> 2                     Student               3   59      47      45      47
#> 3 Information, Communications               8   43      44      46      44
#> 4    Business, Administration               7   73      46      35      23
#> 5                      Health               5   16      32      30      50
#> 6    Business, Administration               7   55      64      48      47
#>   psiq_vis psiq_aud psiq_od psiq_gout psiq_tou psiq_sens psiq_feel score_raven
#> 1     8.00     7.67       8      7.33     8.33      8.67      8.00          14
#> 2     7.67     9.00       6      8.67     9.00      9.00      7.00          17
#> 3     7.00     7.33       7      6.67     7.00      6.00      7.00          11
#> 4     7.67     8.33       9      7.00     8.67      7.33      8.00           7
#> 5     1.00     1.00       1      1.00     1.00      1.00      1.00          12
#> 6     6.67     8.00       7      3.33     5.00      7.00      8.67          12
#>   score_sri span_spatial span_digit wcst_accuracy score_similarities
#> 1        27         5.43       6.07            78                 30
#> 2        26         3.79       6.14            72                 27
#> 3        22         2.79       3.93            67                 26
#> 4        15         2.14       3.50            25                 20
#> 5        16         3.36       3.07            45                 22
#> 6        26         4.00       3.57            23                 29
#>   score_comprehension
#> 1                  24
#> 2                  23
#> 3                  24
#> 4                  16
#> 5                  20
#> 6                   9
```

The main analyses can be roughly divided into three steps: modelling
observed scores with two groups, clustering the sample based on a
selection of variables, and exploring these clusters in the light of
their scores. These core steps are taken care of by the following
functions:

- [`get_association_models()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_association_models.md):
  This function computes Bayes Factors for association between the
  groups (aphantasia/control) and the `education`, `field`, and
  `occupation` variables in the dataset.

- [`get_full_model_table()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_full_model_table.md):
  This function fits Bayesian models to the observed variables,
  predicting them with the two groups (aphantasia/control) and the age
  as a covariate. It returns a data frame summarising the model results
  for each variable.

- [`correlate_vars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/correlate_vars.md):
  This function computes the correlation matrix of the observed
  variables, returning a data frame with the correlations and their
  significance levels. It allowed to identify the variables that were
  most relevant for clustering.

- [`cluster_selected_vars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/cluster_selected_vars.md):
  This function performs clustering on a selection of variables,
  returning a data frame with the cluster assignments for each
  participant. We can then reuse
  [`get_association_models()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_association_models.md)
  and
  [`get_full_model_table()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_full_model_table.md)
  to fit new models with these clusters.

Some transformations of the shape of the data are also required to
prepare them for certain steps, which are handled by other functions in
the package. Finally, a suite of functions is provided to visualise the
results of the analyses, such as
[`plot_score_violins()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/plot_score_violins.md),
[`plot_score_radars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/plot_score_radars.md),
[`plot_score_cor_matrix()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/plot_score_cor_matrix.md),
etc.

See the [complete data analysis
report](https://m-delem.github.io/aphantasiaCognitiveClustering/articles/analysis_report.html)
this package was built for or the [reproducible
manuscript](https://m-delem.github.io/aphantasiaCognitiveClustering/articles/manuscript.html)
it led to.
