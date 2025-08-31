
<!-- README.md is generated from README.Rmd. Please edit that file -->

# aphantasiaCognitiveClustering <a href="https://m-delem.github.io/aphantasiaCognitiveClustering/"><img src="man/figures/logo.png" align="right" height="139" alt="aphantasiaCognitiveClustering website" /></a>

<!-- badges: start -->

[<img alt="alt_text" src="https://img.shields.io/badge/OSF-https://osf.io/7vsx6/-337AB7?logo=osf"/>](https://osf.io/7vsx6/)
[![R-CMD-check](https://github.com/m-delem/aphantasiaCognitiveClustering/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/m-delem/aphantasiaCognitiveClustering/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/m-delem/aphantasiaCognitiveClustering/graph/badge.svg)](https://app.codecov.io/gh/m-delem/aphantasiaCognitiveClustering)
<!-- badges: end -->

aphantasiaCognitiveClustering is a data analysis project disguised as an
R package. It contains the code and data to reproduce the analyses
presented in the paper “*Unsupervised clustering reveals spatial and
verbal cognitive profiles in aphantasia and typical imagery*” by Delem
et al. (2025, *in review*). You can read the preprint
[here](https://doi.org/10.31219/osf.io/ucyb5_v2). All study materials
are available in [this OSF project](https://osf.io/7vsx6/), while the
reproducible manuscript and complete analyses can be found in [the
package
documentation](https://m-delem.github.io/aphantasiaCognitiveClustering/)
online.

The R package structure was chosen to facilitate the sharing of the code
and data with the scientific community, and to make it easy to reproduce
the analyses. It is not intended to be a general-purpose package, but
rather a collection of functions and data specific to this study
(although many functions are reusable in their own right). The package
development workflow (see [this reference book](https://r-pkgs.org/)) is
also a good way to ensure that the code is well-documented and tested,
which is important for reproducibility in scientific research.

## Installation

You can install the development version of aphantasiaCognitiveClustering
from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("m-delem/aphantasiaCognitiveClustering")
```

Alternatively, you can clone the repository, launch the R project in
RStudio by opening the `aphantasiaCognitiveClustering.Rproj` file and
run the following command:

``` r
devtools::load_all()
#> ℹ Loading aphantasiaCognitiveClustering
#> Welcome to aphantasiaCognitiveClustering.
#> This is actually a data analysis project 'disguised' as a package.
#> It contains the code and data to reproduce the analyses presented
#> in an article.
#> See https://osf.io/7vsx6/ for the complete study materials.
```

… Which will load the package and make all its functions and data
available in your R session.
