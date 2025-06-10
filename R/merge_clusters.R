#' Add the clustering and reduced variables to the main data frame
#'
#' @param df_raw A data frame containing the raw data, usually `study_data`.
#' @param df_red A data frame containing the reduced variables, usually from
#' `scale_reduce_vars()`.
#' @param clustering A fitted Mclust object containing the clustering results,
#' usually from `cluster_selected_vars()`.
#' @param names A character vector of cluster names. Default is
#' `c("B", "C", "A")`. The default is based on the last iteration of the
#' clustering to date (which the article is based on).
#'
#' @returns A data frame with the columns from the raw data, the reduced
#' variables, a cluster column with the cluster names and a subcluster column
#' with the cluster and group names.
#' @export
#'
#' @examples
#' df_merged <- merge_clusters(
#'   df_raw     = study_data,
#'   df_red     = scale_reduce_vars(study_data),
#'   clustering = cluster_selected_vars(study_data)
#' )
#' head(df_merged)
#' colnames(df_merged)
#' if (requireNamespace("dplyr")) {
#'   df_merged |>
#'     dplyr::reframe(
#'       .by = cluster,
#'       n = dplyr::n(),
#'       vviq    = mean(vviq),
#'       object  = mean(osivq_o),
#'       spatial = mean(osivq_s),
#'       verbal  = mean(osivq_v)
#'     ) |>
#'     dplyr::arrange(cluster) |>
#'     print()
#' }
merge_clusters <- function(
    df_raw,
    df_red,
    clustering,
    names = c("B", "C", "A")
) {
  withr::local_options(list(warn = -1))

  new_cols <-
    df_red |>
    dplyr::mutate(
      id = df_raw$id,
      cluster =
        clustering$classification |>
        dplyr::case_match(1 ~ names[1], 2 ~ names[2], 3 ~ names[3])
    ) |>
    dplyr::rename("spatial_span" = "span_spatial")

  df_new <-
    dplyr::left_join(df_raw, new_cols, by = "id") |>
    tidyr::unite("subcluster", "cluster", "group", remove = FALSE) |>
    dplyr::mutate(
      cluster = factor(
        .data$cluster,
        levels = c("A", "B", "C"),
        labels = c("A (Aphant.)", "B (Mixed)", "C (Control)")
      ),
      subcluster = factor(
        .data$subcluster,
        levels = c("A_Aphantasic", "B_Aphantasic", "B_Control", "C_Control"),
        labels = c("A (Aphant.)", "B-Aphant.", "B-Control", "C (Control)")
      )
    ) |>
    dplyr::select(
      "id", "group", "cluster", "subcluster", "age",
      tidyselect::everything()
    )

  return(df_new)
}
