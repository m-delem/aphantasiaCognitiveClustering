#' Plot the comparison of Gaussian Mixture Models (GMM) BIC scores
#'
#' @description
#' This function is a wrapper around the `factoextra::fviz_mclust_bic()`
#' function to plot the Bayesian Information Criterion (BIC) scores of
#' Gaussian Mixture Models (GMM) fitted to a dataset. It is mainly designed to
#' facilitate the setting of various default options that fit the graphical
#' style of the project.
#'
#' @param mclust_object A fitted Mclust object containing the clustering
#' results, usually from `cluster_selected_vars()`.
#' @param txt_big Size of the plot, x-axis and legend titles. Default is 7.
#' @param txt_mid Size of the legend text. Default is 6.
#' @param txt_smol Size of the axis text. Default is 5.
#' @param size Size of the points in the plot. Default is 0.2.
#'
#' @returns A ggplot2 object containing the BIC plot.
#' @export
#'
#' @examples
#' study_data |> cluster_selected_vars() |> plot_clusters_bic()
plot_clusters_bic <- function(
    mclust_object,
    txt_big  = 7,
    txt_mid  = 6,
    txt_smol = 5,
    size = 0.2
) {
  rlang::check_installed("factoextra")
  rlang::check_installed("see")
  withr::local_options(list(warn = -1))

  p <-
    factoextra::fviz_mclust_bic(
      mclust_object,
      shape   = "model",
      size    = size,
      palette = grDevices::colorRampPalette(see::okabeito_colors())(14)
    ) +
    ggplot2::labs(
      title  = NULL,
      colour = "Model type",
      shape  = "Model type"
    ) +
    ggplot2::theme(
      plot.subtitle         = ggplot2::element_text(size = txt_big),
      plot.margin           = ggplot2::margin(1, 1, 0, 1, "mm"),
      legend.position       = "bottom",
      legend.margin         = ggplot2::margin(0, 0, 1, 0, "mm"),
      legend.box.spacing    = grid::unit(0, "mm"),
      legend.title.position = "top",
      legend.title          = ggplot2::element_text(size = txt_big),
      legend.text           = ggplot2::element_text(size = txt_mid),
      axis.title            = ggplot2::element_text(size = txt_big),
      axis.text             = ggplot2::element_text(size = txt_smol),
      axis.line             = ggplot2::element_line(linewidth = size),
      axis.ticks            = ggplot2::element_line(linewidth = size),
    )

  # reorder the layers to put the red line in the background
  p$layers <- p$layers[c(3, 1, 2)]

  return(p)
}
