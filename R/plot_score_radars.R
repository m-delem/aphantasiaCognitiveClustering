#' Plot scaled score variables as radar charts
#'
#' @description
#' This function plots the scaled score variables as radar charts using the
#' `superb` package. It can plot radars for any combination of the `Group`,
#' `Cluster`, or `Subcluster` grouping variables and selections of original or
#' reduced study variables, typically obtained through [get_longer()] and
#' [filter_study_variables()] (see examples).
#'
#' The function allows for customisation of the radar charts with various
#' options. Note that the default sizes are pretty small, this was designed to
#' render best as small dimension PDF vector figures for journals.
#'
#' @param df A data frame containing the variables to be plotted in long format,
#' with the variable names in a `Variable` column and the associated values in
#' a `value` column. This is for example the output of `get_longer(study_data)`.
#' @param groups An grouping variable among `Group`, `Cluster`, or `Subcluster`.
#' Can be quoted or unquoted. The function will plot a radars for each level of
#' this variable.
#' @param txt_big Size of the text for the x-axis labels. Default is 7.
#' @param txt_smol Size of the text for the y-axis labels. Default is 5.
#' @param dot_size Size of the dots in the radar charts. Default is 0.8.
#' @param lw Line width for the radar lines. Default is 0.2.
#' @param y_off Offset for the y-axis text to centre it. Default is 40.
#' @param r_off Right offset for the plot margin. Default is 0.
#' @param l_off Left offset for the plot margin. Default is 0.
#' @param v_off Vertical offset for the plot margin. Default is 0.
#' @param key Size of the legend key in mm. Default is 3.
#' @param ... Additional arguments passed to the `superb` function.
#'
#' @returns A ggplot object containing the radar chart.
#' @export
#'
#' @examples
#' df_merged_long <- merge_clusters(
#'   df_raw     = study_data,
#'   df_red     = scale_reduce_vars(study_data),
#'   clustering = cluster_selected_vars(study_data)
#'   ) |>
#'   scale_vars() |>
#'   get_longer()
#'
#' # Groups on the original variables
#' p1 <-
#'   df_merged_long |>
#'   filter_study_variables("original") |>
#'   plot_score_radars(Group, r_off = 6, l_off = 6)
#'
#' # Clusters on the reduced + validation variables
#' p2 <-
#'   df_merged_long |>
#'   filter_study_variables("reduced") |>
#'   plot_score_radars(Cluster, r_off = 6, l_off = 6)
#'
#' # Subclusters on the reduced variables
#' p3 <-
#'   df_merged_long |>
#'   filter_study_variables("reduced_strict") |>
#'   plot_score_radars(Subcluster, r_off = 6, l_off = 6)
#'
#' # Clusters on all the variables
#' p4 <- df_merged_long |> plot_score_radars(Cluster, r_off = 6, l_off = 6)
#'
#' if (require("patchwork", quietly = TRUE)) {
#'  print(p1 + p2)
#'  print(p3 + p4)
#' } else print(p1)
plot_score_radars <- function(
    df,
    groups,
    txt_big  = 7,
    txt_smol = 5,
    dot_size = 0.8,
    lw       = 0.2,
    y_off    = 40, # to center the y axis text
    r_off    = 0,
    l_off    = 0,
    v_off    = 0,
    key      = 3,
    ...
) {
  rlang::check_installed("superb")
  withr::local_options(list(warn = -1))

  df_to_plot <-
    df |>
    dplyr::mutate(
      Variable =
        .data$Variable |>
        stringr::str_replace("Reading\ncomprehension", "Reading") |>
        # The three lines below were ggtext attempts to put selected labels in
        # italics using markdown.
        # stringr::str_replace("Reading\ncomprehension", "*Reading*") |>
        # stringr::str_replace("Auditory imagery", "*Auditory imagery*") |>
        # stringr::str_replace("WCST", "*WCST*") |>
        stringr::str_replace("Psi-Q Sensations", "Psi-Q Sens.") |>
        stringr::str_replace("Psi-Q Feelings", "Psi-Q Feel.") |>
        stringr::str_replace("Audition", "Auditory") |>
        stringr::str_replace("Spatial span std.", "Spatial span") |>
        factor() |>
        forcats::fct_inorder() |>
        forcats::fct_relevel("Auditory imagery", after = Inf) |>
        # forcats::fct_relevel("*Auditory imagery*", after = Inf) |> # ggtext
        forcats::fct_relevel("Visual imagery", after = Inf) |>
        forcats::fct_relevel("VVIQ", after = Inf),
      Cluster = forcats::fct_recode(
        .data$Cluster, "B (Aphant. + Control)" = "B (Mixed)"
      )
    )

  # Italicise selected labels
  # The lines below were an alternative clunky attempt to italicize selected
  # labels. We create an expression() vector to be used in scale_x_discrete.
  # It worked for the italics, but the scale_x_discrete broke the radars by
  # adding space between the first and last breaks. I liked the attempt, so I
  # kept its trace here.
  # label <- df_to_plot$Variable |> levels()
  # label <- replace(label, label == "Reading", expression(~italic("Reading")))
  # label <- replace(
  #   label,
  #   label == "Auditory imagery",
  #   expression(~italic("Auditory imagery")))
  # label <- replace(label, label == "WCST", expression(~italic("WCST")))

  # Writing the formula for the "superb" plot
  # Below are various previous attempts to allow the "groups" argument to be
  # either a string or a symbol. The current version uses rlang::ensym(groups).
  # I keep a trace of these attempts because I hate this task and I still
  # don't fully understand why the current version works.
  # groups_str <- deparse(substitute(groups))
  # groups_str <- as.character(substitute(groups))
  # if (is.character(groups)) {
  #   groups_str <- groups
  #   } else {
  #   groups_str <- deparse(substitute(groups))
  #   }
  # subs <- substitute(groups)
  # groups_str <- if (is.character(subs)) subs else deparse(subs)
  # groups_str <- deparse(rlang::ensym(groups))
  # This is the version that finally worked:
  groups_str <- as.character(rlang::ensym(groups))

  if (!(groups_str %in% c("Group", "Cluster", "Subcluster"))) {
    stop("groups must be either 'Group', 'Cluster', or 'Subcluster'.")
  }
  formula    <- stats::as.formula(glue::glue("value ~ Variable + {groups_str}"))

  # Choosing the palette based on the group selection
  n_groups   <- length(unique(df |> dplyr::pull({{ groups }})))
  if (n_groups == 2) {
    palette <- see::okabeito_colors(2, 3)
  } else if (n_groups == 3) {
    palette <- see::okabeito_colors(3, 1, 2)
  } else if (n_groups == 4) {
    palette <- see::okabeito_colors(3, 9, 6, 2)
  }
  palette <- as.character(palette)

  # Plotting
  p <- (
    superb::superb(
      formula        = formula,
      data           = df_to_plot,
      plotStyle      = "circularline",
      pointParams    = list(size = dot_size),
      lineParams     = list(linewidth = lw),
      errorbarParams = list(linewidth = lw, show.legend = FALSE),
      adjustments    = list(purpose = "single"),
      ...
    ) +
      ggplot2::scale_colour_manual(values = palette) +
      ggplot2::scale_fill_manual(values   = palette) +
      # Below is the clunky attempt to italicize selected labels.
      # It worked for the italics, but broke the radars.
      # scale_x_discrete(
      #   expand = expansion(add = 0, mult = 0),
      #   limits = factor(df_to_plot$Variable |> levels()),
      #   labels = label
      # ) +
      # coord_polar(start = pi/36) +
      ggplot2::scale_y_continuous(
        limits = c(0, 1),
        breaks = scales::breaks_pretty(),
        expand = ggplot2::expansion(c(0, 0.02))
      ) +
      ggplot2::theme_minimal(base_size = txt_smol) +
      ggplot2::theme(
        # plot wise elements
        plot.title       = ggplot2::element_blank(),
        panel.grid.minor = ggplot2::element_blank(),
        panel.grid.major = ggplot2::element_line(colour = "grey92"),
        plot.margin      = ggplot2::margin(0, r_off, v_off, l_off, "mm"),
        # legend
        legend.position  = "top",
        legend.title     = ggplot2::element_blank(),
        legend.text      = ggplot2::element_text(size = txt_big),
        legend.key.size  = grid::unit(key, "mm"),
        legend.key.spacing.x = grid::unit(3, "mm"),
        # axes
        axis.line        = ggplot2::element_blank(),
        axis.title.x     = ggplot2::element_blank(),
        axis.title.y     = ggplot2::element_blank(),
        # Below is the ggtext attempt to italicize selected labels.
        # Once again, the italic worked, but this time ggtext broke the
        # patchwork layouts, creating the error:
        #   Error in grid.Call.graphics(C_setviewport, vp, TRUE)
        # From what I read in a GH issue, it seems to be a ggtext bug.
        # Sad. I was close to the solution.
        # axis.text.x      = element_markdown(
        #   size    = txt_big,
        #   margin  = unit(c(0, 0, 0, 0), "pt"),
        #   padding = unit(c(0, 0, 0, 0), "pt"),
        # ),
        axis.text.x = ggplot2::element_text(size = txt_big),
        axis.text.y = ggplot2::element_text(
          size   = txt_smol,
          margin = ggplot2::margin(0, -y_off, 0, y_off - 4, "mm"),
          hjust  = 0,
          vjust  = -0.5
        ),
      )
  ) |> suppressMessages()

  return(p)
}
