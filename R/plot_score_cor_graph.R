#' Plot a correlation graph
#'
#' @description
#' This function creates a graph visualisation of a set of correlations
#' computed using [correlation::correlation()], such as the result of
#' [correlate_vars()]. It is designed to highlight nodes for specific variables
#' from the study (based on partial correlations), but it should run with any
#' set of correlations.
#'
#' @param correlations A data frame containing the correlations, typically the
#' output of [correlate_vars()].
#' @param shape Shape of the nodes in the graph. Default is 21 (circle).
#' @param stroke Stroke width of the nodes. Default is 0.1.
#' @param node_size Size of the nodes in the graph. Default is 14.
#' @param node_text_size Size of the text labels on the nodes. Default is 5.
#' @param label_text_size Size of the text labels on the edges. Default is 2.
#'
#' @returns A ggplot2 object representing the correlation graph.
#' @export
#'
#' @examples
#' study_data |> correlate_vars(partial = FALSE) |> plot_score_cor_graph()
plot_score_cor_graph <- function(
    correlations,
    shape     = 21,
    stroke    = 0.1,
    node_size = 14,
    node_text_size  = 5,
    label_text_size = 2
){
  rlang::check_installed("ggraph")

  correlation_graph <-
    correlations |>
    ggraph::ggraph(
      layout   = "linear",
      circular = TRUE
    ) +
    ggraph::geom_edge_arc(
      strength = 0.2,
      mapping  = ggplot2::aes(
        label       = round(.data$r, 2),
        filter      = (.data$p < 0.05),
        edge_colour = .data$r,
        edge_width  = .data$r
      ),
      label_size    = grid::unit(label_text_size, "pt"),
      check_overlap = TRUE
    ) +
    # Base black nodes
    ggraph::geom_node_point(
      shape  = shape,
      size   = node_size,
      stroke = 0,
      fill   = "black"
    ) +
    # Coloured nodes
    # Psi-Q's in dark blue
    ggraph::geom_node_point(
      mapping = ggplot2::aes(
        filter = (
          stringr::str_detect(.data$name, "Psi") &
            !stringr::str_detect(.data$name, "Audition"))
      ),
      shape  = shape,
      size   = node_size,
      fill   = "#0072B2",
      stroke = stroke,
      colour = "black"
    ) +
    # Visual imagery in blue
    ggraph::geom_node_point(
      mapping = ggplot2::aes(
        filter = stringr::str_detect(.data$name, "VVIQ|OSIVQ\nObject|Psi-Q\nVisual")
      ),
      shape  = shape,
      size   = node_size,
      fill   = "#56B4E9",
      stroke = stroke,
      colour = "black"
    ) +
    # Spatial imagery in light orange
    ggraph::geom_node_point(
      mapping = ggplot2::aes(
        filter = stringr::str_detect(.data$name, "SRI|OSIVQ\nSpatial")
      ),
      shape  = shape,
      size   = node_size,
      fill   = "#E69F00",
      stroke = stroke,
      colour = "black"
    ) +
    # Verbal strategies in green
    ggraph::geom_node_point(
      mapping = ggplot2::aes(
        filter = stringr::str_detect(.data$name, "OSIVQ\nVerbal")
      ),
      shape  = shape,
      size   = node_size,
      fill   = "#009E73",
      stroke = stroke,
      colour = "black"
    ) +
    # Raven + Digit in pink
    ggraph::geom_node_point(
      mapping = ggplot2::aes(
        filter = stringr::str_detect(.data$name, "Digit\nspan|Raven\nMatrices")
      ),
      shape  = shape,
      size   = node_size,
      fill   = "#CC79A7",
      stroke = stroke,
      colour = "black"
    ) +
    # Spatial span in yellow
    ggraph::geom_node_point(
      mapping = ggplot2::aes(
        filter = stringr::str_detect(.data$name, "Spatial\nspan")
      ),
      shape  = shape,
      size   = node_size,
      fill   = "#999999",
      stroke = stroke,
      colour = "black"
    ) +
    # Verbal reasoning in dark orange
    ggraph::geom_node_point(
      mapping = ggplot2::aes(
        filter = stringr::str_detect(.data$name, "Similarities")
      ),
      shape  = shape,
      size   = node_size,
      fill   = "#D55E00",
      stroke = stroke,
      colour = "black"
    ) +
    # End of coloured nodes
    ggraph::geom_node_text(
      mapping   = ggplot2::aes(label = .data$name),
      colour    = "white",
      fontface  = "bold",
      size      = node_text_size,
      size.unit = "pt"
    ) +
    ggraph::scale_edge_colour_gradient2(
      limits = c(-1, 1),
      low    = "firebrick2",
      mid    = "white",
      high   = "#009e73",
      breaks = scales::breaks_pretty(8)
    ) +
    ggraph::scale_edge_width(range = c(2, 3)) +
    ggplot2::coord_fixed(clip = "off") +
    ggplot2::guides(edge_width = "none", edge_colour = "none") +
    ggplot2::labs(title = NULL) +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = "transparent"),
      legend.position  = "none"
    )

  return(correlation_graph)
}
