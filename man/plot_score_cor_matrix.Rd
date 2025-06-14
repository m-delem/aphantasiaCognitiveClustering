% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_score_cor_matrix.R
\name{plot_score_cor_matrix}
\alias{plot_score_cor_matrix}
\title{Plot a correlation matrix}
\usage{
plot_score_cor_matrix(correlations, size_axis = 6, matrix_text = 5)
}
\arguments{
\item{correlations}{An object produced by \code{\link[correlation:correlation]{correlation::correlation()}}, such
as the output of \code{\link[=correlate_vars]{correlate_vars()}}.}

\item{size_axis}{Size of the axis text in points. Default is 6.}

\item{matrix_text}{Size of the text in the correlation matrix. Default is 5.}
}
\value{
A ggplot2 object containing the correlation matrix plot.
}
\description{
This function is a wrapper around the \code{correlation::visualisation_recipe()}
function to plot a correlation matrix from the \code{correlation} package with
custom pre-defined options. It was designed to fit the graphical style of the
project, but it is not specific to the project and can be used with any
correlation matrix data.
}
\examples{
study_data |> correlate_vars(partial = FALSE) |> plot_score_cor_matrix()
}
