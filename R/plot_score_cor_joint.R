#' Create a joint matrix + graph correlation figure
#'
#' @description
#' This function combines a correlation matrix and a graph visualisation of
#' correlations into a single plot using the `patchwork` package. While the
#' two underlying functions ([plot_score_cor_matrix()] and
#' [plot_score_cor_graph()]) are fairly generic, this function is tailored for
#' the study data from the article. It is recommended to use it together with
#' the other package functions (see examples).
#'
#' @param correlations A data frame containing the correlations, typically the
#' output of [correlate_vars()].
#'
#' @returns A ggplot2 object representing the joint plot of the correlation
#' matrix and the graph.
#' @export
#'
#' @examples
#' study_data |> correlate_vars(partial = FALSE) |> plot_score_cor_joint()
plot_score_cor_joint <- function(correlations) {
  rlang::check_installed("patchwork")

  # Manual patchwork layout to overlay the matrix and the graph
  layout <- c(
    patchwork::area(t = 1, l = 1, b = 5, r = 3),
    patchwork::area(t = 2, l = 3, b = 5, r = 4)
  )

  matrix <- plot_score_cor_matrix(correlations)
  graph  <- plot_score_cor_graph(correlations)

  joint_plot <-
    (matrix + graph) +
    patchwork::plot_layout(design = layout) &
    ggplot2::theme(
      plot.margin = ggplot2::margin(0, 1, 0, 0, "mm")
    )

  return(joint_plot)
}
