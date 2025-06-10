#' Add significance label and line to a plot
#'
#' @param df A dataframe containing one column per variable in the
#' desired aesthetics (x, y, colour, etc.) and the following columns:
#' - `x_star`: x position of the star label
#' - `y_star`: y position of the star label
#' - `stars`: the star label (e.g., "*", "**", "***")
#' - `x_line`: x position of the start of the line
#' - `x_line_end`: x position of the end of the line
#' - `y_line`: y position of the line
#' @param size_star Size of the star label. Default is 2.5.
#' @param lw Line width of the significance line. Default is 0.2.
#'
#' @returns A list of ggplot2 layers that can be added to a ggplot object.
#' @export
#'
#' @examples
#' group_effect_verbal <-
#'  tibble::tibble(
#'    Variable   = factor("OSIVQ-Verbal"),
#'     x_star     = 1.5,
#'     y_star     = 1.08,
#'     stars      = "**",
#'     x_line     = x_star - 0.5,
#'     x_line_end = x_star + 0.5,
#'     y_line     = 1.05
#'   )
#'
#' ggplot2::ggplot() +
#'   ggplot2::scale_x_discrete(limits = factor(c(1, 2))) +
#'   ggplot2::scale_y_continuous(limits = c(0, 1.1)) +
#'   ggplot2::labs(x = NULL, y = NULL) +
#'   ggplot2::facet_wrap(~ Variable, scales = "free_x") +
#'   add_significance_geoms(group_effect_verbal, size_star = 4)
add_significance_geoms <- function(
    df,
    size_star = 2.5,
    lw = 0.2
){
  significance_geoms <-
    list(
      ggplot2::geom_text(
        data = df,
        ggplot2::aes(
          x     = .data$x_star,
          y     = .data$y_star,
          label = .data$stars
        ),
        size        = size_star,
        color       = "black",
        inherit.aes = FALSE
      ),
      ggplot2::geom_segment(
        data = df,
        ggplot2::aes(
          x    = .data$x_line,
          xend = .data$x_line_end,
          y    = .data$y_line,
          yend = .data$y_line,
        ),
        color       = "black",
        linewidth   = lw,
        inherit.aes = FALSE
      )
    )
  return(significance_geoms)
}
