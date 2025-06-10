
<!-- README.md is generated from README.Rmd. Please edit that file -->

# aphantasiaCognitiveClustering

<!-- badges: start -->

[<img alt="alt_text" src="https://img.shields.io/badge/OSF-https://osf.io/7vsx6/-337AB7"/>](https://osf.io/7vsx6/)
[![Codecov test
coverage](https://codecov.io/gh/m-delem/aphantasiaCognitiveClustering/graph/badge.svg)](https://app.codecov.io/gh/m-delem/aphantasiaCognitiveClustering)
<!-- badges: end -->

aphantasiaCognitiveClustering is actually a data analysis project
disguised as an R package. It contains the code and data to reproduce
the analyses presented in the paper “*Uncovering spatial and verbal
cognitive profiles in aphantasia through unsupervised clustering*” by
Delem et al. (2025, *in review*). The complete study materials are
available in [this OSF project](https://osf.io/7vsx6/).

The R package structure was chosen to facilitate the sharing of the code
and data with the scientific community, and to allow for easy
reproduction of the analyses. It is not intended to be a general-purpose
package, but rather a collection of functions and data specific to this
study (although many functions are reusable in their own right). The
package development workflow (see [this reference
book](https://r-pkgs.org/)) is also a good way to ensure that the code
is well-documented and tested, which is important for reproducibility in
scientific research.

## Installation

You can install the development version of aphantasiaCognitiveClustering
from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("m-delem/aphantasiaCognitiveClustering")
```

Alternatively, you can clone the repository, launch the R project in
RStudio by opening the `aphantasiaCognitiveClustering.Rproj` file,
follow the instructions that appear in the console, and run the
following command:

``` r
devtools::load_all()
#> ℹ Loading aphantasiaCognitiveClustering
#> Welcome to aphantasiaCognitiveClustering.
#> This is actually a data analysis project 'desguised' as a package.
#> It contains the code and data to reproduce the analyses presented
#> in an article.
#> See https://osf.io/7vsx6/ for the complete study materials.
```

… Which will load the package and make all its functions and data
available in your R session.

## Overview

The main dataset used for the analyses is provided in the package as
`study_data`. It contains the data from the study in a tidy format,
ready for analysis.

``` r
library(aphantasiaCognitiveClustering)

head(study_data)
#> # A tibble: 6 × 27
#>   id      age sex   group  education field field_code occupation occupation_code
#>   <chr> <dbl> <fct> <fct>  <fct>     <fct> <fct>      <fct>      <fct>          
#> 1 7210     25 m     Contr… Master    Soci… 3          Health     5              
#> 2 7213     22 f     Contr… Master    Soci… 3          Student    3              
#> 3 7238     52 f     Contr… Bachelor  Natu… 5          Informati… 8              
#> 4 7242     48 f     Contr… Post-sec… Busi… 4          Business,… 7              
#> 5 7254     37 f     Aphan… Doctorate Heal… 9          Health     5              
#> 6 7257     36 m     Contr… Bachelor  Natu… 5          Business,… 7              
#> # ℹ 18 more variables: vviq <dbl>, osivq_o <dbl>, osivq_s <dbl>, osivq_v <dbl>,
#> #   psiq_vis <dbl>, psiq_aud <dbl>, psiq_od <dbl>, psiq_gout <dbl>,
#> #   psiq_tou <dbl>, psiq_sens <dbl>, psiq_feel <dbl>, score_raven <dbl>,
#> #   score_sri <dbl>, span_spatial <dbl>, span_digit <dbl>, wcst_accuracy <dbl>,
#> #   score_similarities <dbl>, score_comprehension <dbl>
```

The main analyses can be roughly divided into three steps: modelling
observed scores with two groups, clustering the sample based on a
selection of variables, and exploring these clusters in the light of
their scores. These core steps are taken care of by the following
functions:

- `get_association_models()`: This function computes Bayes Factors for
  association between the groups (aphantasia/control) and the
  `education`, `field`, and `occupation` variables in the dataset.

- `get_full_model_table()`: This function fits Bayesian models to the
  observed variables, predicting them with the two groups
  (aphantasia/control) and the age as a covariate. It returns a data
  frame summarising the model results for each variable.

- `correlate_vars()`: This function computes the correlation matrix of
  the observed variables, returning a data frame with the correlations
  and their significance levels. It allowed us to identify the variables
  that were most relevant for clustering.

- `cluster_selected_vars()`: This function performs clustering on a
  selection of variables, returning a data frame with the cluster
  assignments for each participant. We can then reuse
  `get_association_models()` and `get_full_model_table()` to fit new
  models with these clusters.

Some transformations of the shape of the data are also required to
prepare them for certain steps, which are handled by other functions in
the package. Finally, a suite of functions is provided to visualise the
results of the analyses, such as `plot_score_violins()`,
`plot_score_radars()`, or `plot_score_cor_matrix()`, etc.

See the main vignette for a complete report of the analyses.
