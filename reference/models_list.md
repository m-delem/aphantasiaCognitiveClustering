# Models for all the variables predicted by Groups, Clusters and Sub-clusters

This list contains three data frames summarising the following:

- `group_models`: Models for the unstandaridsed variables predicted by
  Groups (aphantasia/control)

- `cluster_models`: Models for the standardised variables predicted by
  Clusters (A/B/C)

- `subcluster_models`: Models for the standardised variables predicted
  by Sub-clusters (A/B-Aphant/B-Control/C)

## Usage

``` r
models_list
```

## Format

An object of class `list` of length 3.

## Details

These tables were obtained with the
[`get_full_model_table()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/get_full_model_table.md)
function included in the package. This saved list exists to avoid
re-running the slow computations (two Bayesian models for each variable
to compute the contrasts).
