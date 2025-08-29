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
#' @param size_axis Size of the axis text in points. Default is 6.
#' @param matrix_text Size of the text in the correlation matrix. Default is 5.
#' @param shape Shape of the nodes in the graph. Default is 21 (circle).
#' @param stroke Stroke width of the nodes. Default is 0.1.
#' @param node_size Size of the nodes in the graph. Default is 14.
#' @param node_text_size Size of the text labels on the nodes. Default is 5.
#' @param label_text_size Size of the text labels on the edges. Default is 2.
#'
#' @returns A ggplot2 object representing the joint plot of the correlation
#' matrix and the graph.
#' @export
#'
#' @examples
#' study_data |> correlate_vars(partial = FALSE) |> plot_score_cor_joint()
plot_score_cor_joint <- function(
    correlations,
    size_axis = 6,
    matrix_text = 5,
    shape     = 21,
    stroke    = 0.1,
    node_size = 14,
    node_text_size  = 5,
    label_text_size = 2
) {
  rlang::check_installed("patchwork")

  # Manual patchwork layout to overlay the matrix and the graph
  layout <- c(
    patchwork::area(t = 1, l = 1, b = 5, r = 3),
    patchwork::area(t = 2, l = 3, b = 5, r = 4)
  )

  matrix <- plot_score_cor_matrix(correlations, size_axis, matrix_text)
  graph  <-
    plot_score_cor_graph(
      correlations,
      shape,
      stroke,
      node_size,
      node_text_size,
      label_text_size
    )

  joint_plot <-
    (matrix + graph) +
    patchwork::plot_layout(design = layout) &
    ggplot2::theme(
      plot.margin = ggplot2::margin(0, 1, 0, 0, "mm")
    )

  return(joint_plot)
}
