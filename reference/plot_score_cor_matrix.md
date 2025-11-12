# Plot a correlation matrix

This function is a wrapper around the
[`correlation::visualisation_recipe()`](https://easystats.github.io/datawizard/reference/visualisation_recipe.html)
function to plot a correlation matrix from the `correlation` package
with custom pre-defined options. It was designed to fit the graphical
style of the project, but it is not specific to the project and can be
used with any correlation matrix data.

## Usage

``` r
plot_score_cor_matrix(correlations, size_axis = 6, matrix_text = 5)
```

## Arguments

- correlations:

  An object produced by
  [`correlation::correlation()`](https://easystats.github.io/correlation/reference/correlation.html),
  such as the output of
  [`correlate_vars()`](https://m-delem.github.io/aphantasiaCognitiveClustering/reference/correlate_vars.md).

- size_axis:

  Size of the axis text in points. Default is 6.

- matrix_text:

  Size of the text in the correlation matrix. Default is 5.

## Value

A ggplot2 object containing the correlation matrix plot.

## Examples

``` r
study_data |> correlate_vars(partial = FALSE) |> plot_score_cor_matrix()
```
