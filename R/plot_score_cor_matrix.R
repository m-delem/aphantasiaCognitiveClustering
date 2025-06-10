#' Plot a correlation matrix
#'
#' @description
#' This function is a wrapper around the `correlation::visualisation_recipe()`
#' function to plot a correlation matrix from the `correlation` package with
#' custom pre-defined options. It was designed to fit the graphical style of the
#' project, but it is not specific to the project and can be used with any
#' correlation matrix data.
#'
#' @param correlations An object produced by [correlation::correlation()], such
#' as the output of [correlate_vars()].
#' @param size_axis Size of the axis text in points. Default is 6.
#' @param matrix_text Size of the text in the correlation matrix. Default is 5.
#'
#' @returns A ggplot2 object containing the correlation matrix plot.
#' @export
#'
#' @examples
#' study_data |> correlate_vars(partial = FALSE) |> plot_score_cor_matrix()
plot_score_cor_matrix <- function(correlations, size_axis = 6, matrix_text = 5){
  rlang::check_installed("correlation")

  p <-
    (correlations |>
    dplyr::mutate(r = ifelse(abs(.data$r) < 0.01, 0, .data$r)) |>
    summary(digits = 2) |>
    correlation::visualisation_recipe(
      show_data  = "tiles",
      tile       = list(colour = "black", linewidth = 0.05),
      text       = list(size = matrix_text, size.unit = "pt"),
      scale_fill = list(
        high = "#009e73",
        low  = "firebrick2",
        name = "r"
      )
    ) |>
    plot() +
    ggplot2::scale_x_discrete(position = "top") +
    ggplot2::scale_y_discrete(position = "left") +
    ggplot2::labs(title = NULL) +
    see::theme_modern() +
    ggplot2::theme(
      legend.position = "none",
      axis.text.x     = ggplot2::element_text(
        size = size_axis,
        angle = 45,
        hjust = 0
      ),
      axis.text.y = ggplot2::element_text(size = size_axis),
      axis.line   = ggplot2::element_blank()
    )) |> suppressMessages() |> suppressWarnings()
  return(p)
}
