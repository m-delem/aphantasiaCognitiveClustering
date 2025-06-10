#' Study data retrieved from the OSF project
#'
#' This dataset contains the tidied data retrieved from the OSF project. The
#' data has been preprocessed from the raw data files extracted from a JATOS
#' server beforehand. The raw data is not bundled in the package to keep it
#' lightweight, but the functions to extract it are available as internal
#' functions and a code example is included in `data-raw/raw_data_extraction.R`.
#'
#' @source <https://osf.io/7vsx6/files/osfstorage>
"study_data"

#' Models for all the variables predicted by Groups, Clusters and Sub-clusters
#'
#' This list contains three data frames summarising the following:
#' - `group_models`: Models for the unstandaridsed variables predicted by Groups
#'   (aphantasia/control)
#' - `cluster_models`: Models for the standardised variables predicted by
#'   Clusters (A/B/C)
#' - `subcluster_models`: Models for the standardised variables predicted by
#'   Sub-clusters (A/B-Aphant/B-Control/C)
#'
#' These tables were obtained with the `get_full_model_table()` function
#' included in the package. This saved list exists to avoid re-running the
#' slow computations (two Bayesian models for each variable to compute the
#' contrasts).
"models_list"
