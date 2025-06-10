#' Use Gaussian Mixture Models to cluster selected variables
#'
#' @param df A data frame containing the variables to be clustered, usually
#' `study_data`.
#' @param vars A character vector of variable names to be clustered. If NULL, a
#' default set of variables is used:
#' - `visual_imagery`
#' - `sensory_imagery`
#' - `spatial_imagery`
#' - `verbal_strategies`
#' - `fluid_intelligence`
#' - `verbal_reasoning`
#' - `span_spatial`
#'
#' @returns A fitted Mclust object containing the clustering results.
#' @export
#'
#' @examples
#' clustering <- cluster_selected_vars(study_data)
#' clustering
#'
#' if (requireNamespace("dplyr")) {
#'   data.frame(cluster = clustering$classification) |>
#'     dplyr::reframe(n = dplyr::n(), .by = cluster)
#' }
cluster_selected_vars <- function(df, vars = NULL) {
  if (is.null(vars)) {
    vars <- c(
      "visual_imagery", "sensory_imagery",
      "spatial_imagery", "verbal_strategies",
      "fluid_intelligence", "verbal_reasoning",
      "span_spatial"
    )
  }
  clustering <-
    df |>
    scale_reduce_vars() |>
    dplyr::select(tidyselect::any_of(vars)) |>
    mclust::Mclust(verbose = FALSE)
  return(clustering)
}
