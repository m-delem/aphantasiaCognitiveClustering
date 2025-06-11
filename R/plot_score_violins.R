#' Plot the study variables' distributions as half-violins with point
#' averages and error bars.
#'
#' @description
#' This function contains the machinery to produce the main figure for group
#' comparisons in the article. By default, it adds significance labels at
#' pre-defined locations for the group effects (based on the analysis results).
#' It sets various defaults such as a palette for the groups and various
#' geom options. Note that the default sizes are pretty small, this was
#' designed to render best as small dimension PDF vector figures for journals.
#'
#' The function is not very flexible (mostly because it was designed for a
#' single plot initially). As it is, it is best suited to plot all the
#' original variable with their significance labels, or a selection of
#' ***scaled*** variables without significance labels (see examples).
#'
#' @param df A data frame in long format containing the variables to be plotted.
#' @param palette A character vector of colours to use for the groups. Default
#' is `c("#56B4E9", "#009E73")`, which are the colours used in the article.
#' @param txt_big The size of the text for the main plot axis and legend.
#' Default is `7`.
#' @param txt_mid The size of the text for the facet labels. Default is `6`.
#' @param txt_smol The size of the text for the y axis labels. Default is `5`.
#' @param dot_big The size of the points in the plot. Default is `0.35`.
#' @param lw_big The line width for the main plot lines. Default is `0.1`.
#' @param lw_smol The line width for the minor plot lines. Default is `0.1`.
#' @param jit_w The width of the jitter for the points in the plot. Default is
#' `0.3`.
#' @param jit_h The height of the jitter for the points in the plot. Default is
#' `0`.
#' @param alpha The alpha transparency for the points and the half-violins.
#' @param add_signif A logical indicating whether to add significance labels
#' and lines to the plot at pre-defined locations. Default is `TRUE`. If set to
#' `FALSE`, the plot will not include any significance labels or lines.
#' @param nrow The number of rows in the facet grid. Default is `2`.
#'
#' @returns A ggplot2 object.
#' @export
#'
#' @examples
#' # The figure from the article
#' study_data |>
#'   scale_vars() |>
#'   get_longer() |>
#'   filter_study_variables("original") |>
#'   plot_score_violins(add_signif = TRUE, nrow = 2)
#'
#' # Alternative use with reduced scaled variables only
#' merge_clusters(
#'   df_raw     = study_data,
#'   df_red     = scale_reduce_vars(study_data),
#'   clustering = cluster_selected_vars(study_data)
#'   ) |>
#'   scale_vars() |>
#'   get_longer() |>
#'   filter_study_variables("reduced_strict") |>
#'   plot_score_violins(add_signif = FALSE, nrow = 2)
plot_score_violins <- function(
    df,
    add_signif = TRUE,
    palette  = c("#56B4E9", "#009E73"),
    txt_big  = 7,
    txt_mid  = 6,
    txt_smol = 5,
    dot_big  = 0.35,
    lw_big   = 0.1,
    lw_smol  = 0.1,
    jit_w    = 0.3,
    jit_h    = 0,
    alpha    = 0.3,
    nrow     = 2
) {
  rlang::check_installed("see")
  withr::local_options(list(warn = -1))

  # Defining the effects to label with stars
  group_effects <-
    tibble::tibble(
      Variable = factor(c(
        "VVIQ","Psi-Q Vision",
        "Psi-Q Audition", "Psi-Q Smell", "Psi-Q Taste",
        "Psi-Q Touch", "Psi-Q Sensations", "Psi-Q Feelings",
        "OSIVQ-Object")) |> forcats::fct_inorder(),
      x_star = 1.5,
      y_star = 1.08,
      stars  = "***",
      x_line = .data$x_star - 0.5,
      x_line_end = .data$x_star + 0.5,
      y_line = 1.05
    )
  group_effect_verbal <-
    tibble::tibble(
      Variable   = factor("OSIVQ-Verbal"),
      x_star     = 1.5,
      y_star     = 1.08,
      stars      = "**",
      x_line     = .data$x_star - 0.5,
      x_line_end = .data$x_star + 0.5,
      y_line     = 1.05
    )

  p <-
    df |>
    dplyr::group_by(.data$Group, .data$Variable) |>
    dplyr::reframe(
      value = .data$value,
      mean  = mean(.data$value),
      sd    = sd(.data$value)
    ) |>
    ggplot2::ggplot(
    ggplot2::aes(
      x     = .data$Group,
      y     = .data$value,
      color = .data$Group,
      fill  = .data$Group
    )) +
    see::geom_violinhalf(
      flip  = c(1),
      alpha = alpha,
      scale = "width",
      color = "transparent"
    ) +
    see::geom_point2(
      position = ggplot2::position_jitterdodge(
        jitter.width  = jit_w,
        jitter.height = jit_h
      ),
      size  = dot_big,
      alpha = alpha,
      na.rm = TRUE
    ) +
    ggplot2::geom_line(
      mapping   = ggplot2::aes(x = .data$Group, y = .data$mean, group = 1),
      color     = "grey80",
      linewidth = lw_big
    ) +
    see::geom_pointrange2(
      ggplot2::aes(
        x     = .data$Group,
        y     = .data$mean,
        ymin  = ifelse(.data$mean - .data$sd <= 0, 0, .data$mean - .data$sd),
        ymax  = ifelse(.data$mean + .data$sd >= 1, 1, .data$mean + .data$sd),
        group = .data$Group
      ),
      size      = dot_big,
      linewidth = lw_big,
      na.rm     = TRUE
    ) +
    ggplot2::facet_wrap(~.data$Variable, nrow = nrow) +
    ggplot2::scale_y_continuous(
      expand = ggplot2::expansion(c(0.05, 0)),
      limits = c(0, 1.15),
      breaks = seq(0, 1, .2)
    ) +
    ggplot2::scale_color_manual(values = palette) +
    ggplot2::scale_fill_manual(values  = palette) +
    ggplot2::labs(y = "Standardised scores") +
    see::theme_modern() +
    ggplot2::theme(
      # whole plot
      plot.margin        = ggplot2::margin(0, 1, 0, 1, "mm"),
      # legend
      legend.position    = "top",
      legend.title       = ggplot2::element_blank(),
      legend.text        = ggplot2::element_text(size = txt_big),
      legend.margin      = ggplot2::margin(0, 0, 0, 0, "mm"),
      legend.box.margin  = ggplot2::margin(1, 0, 0, 0, "mm"),
      legend.box.spacing = grid::unit(1, "mm"),
      legend.key.size    = grid::unit(4, "mm"),
      # y axis
      axis.title.y       = ggplot2::element_text(
        size   = txt_big,
        margin = ggplot2::margin(0, 1.5, 0, 0, "mm")
      ),
      axis.text.y        = ggplot2::element_text(size = txt_smol),
      axis.ticks.y       = ggplot2::element_line(
        colour = "grey92", linewidth = lw_smol
      ),
      # x axis
      axis.title.x       = ggplot2::element_blank(),
      axis.text.x        = ggplot2::element_blank(),
      axis.ticks.x       = ggplot2::element_blank(),
      axis.line          = ggplot2::element_blank(),
      # panel lines
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_line(linewidth = lw_smol),
      panel.grid.minor.y = ggplot2::element_line(linewidth = lw_smol),
      # facets
      panel.border       = ggplot2::element_rect(
        color     = "grey92",
        fill      = NA,
        linewidth = lw_smol
      ),
      panel.spacing.x    = grid::unit(0, "mm"),
      panel.spacing.y    = grid::unit(3, "mm"),
      strip.text         = ggplot2::element_text(
        size = txt_mid, face = "plain"
      ),
      strip.background   = ggplot2::element_rect(
        color     = "grey92",
        fill      = "grey98",
        linewidth = lw_smol
      )
    )

  if (add_signif) {
    p <- p +
      add_significance_geoms(group_effects) +
      add_significance_geoms(group_effect_verbal)
  }
  return(p)
}
