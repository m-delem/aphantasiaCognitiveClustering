#' Custom ggsave wrapper set with Nature's formatting guidelines (width-locked)
#'
#' @description
#' See:
#' https://www.nature.com/documents/NRJs-guide-to-preparing-final-artwork.pdf
#' It's pretty strict. A one column figure is 88 mm wide and a two column figure
#' is 180 mm wide. Depending on the length of the figure caption, there are
#' different maximum heights (see the PDF). Most figures types must be in vector
#' format to prevent quality loss when zooming in. Ever since I found these
#' guidelines, I use them for all figures, even if they are not for Nature...
#' Because it looks nice and I like it.
#'
#' @param plot     The ggplot object to save.
#' @param path     A character string with the path to save the plot.
#' @param ncol     The number of columns for the plot. Either 1 (default) or 2.
#' @param height   The height of the plot in mm. Default is 90 mm.
#' @param show     Logical. Whether to return the plot visibly or not. Default
#' is FALSE, the plot is returned invisibly.
#' @param verbose  Logical. Whether to print a message in the console when the
#' saving is done. Default is TRUE.
#' @param ...      Additional arguments passed to `ggsave()`.
#'
#' @returns Nothing. The function saves the ggplot to the specified path.
#' @export
save_ggplot <- function(
    plot,
    path,
    ncol     = 1,
    height   = 90,
    show     = FALSE,
    verbose  = TRUE,
    ...
) {
  rlang::check_installed("here")

  if (ncol == 1) {
    # Standard width for single column figures
    width  <- 88
    colour <- "green"
    shape  <- "One-column"
  } else if (ncol == 2) {
    # Standard width for double column figures
    width  <- 180
    colour <- "cyan"
    shape  <- "Two-column"
  } else stop(glue::glue_col("ncol must be {cyan 1} or {green 2}."))

  ggplot2::ggsave(
    filename = here::here(path),
    plot     = plot,
    width    = width,
    height   = height,
    units    = "mm",
    dpi      = 600,
    ...
  )
  if (verbose) {
    print(glue::glue_col(
      "{magenta |-> {", colour, " {shape}} figure saved in {yellow {path}}.}"
    ))
  }
  if (show) return(plot)
  invisible(plot)
}
