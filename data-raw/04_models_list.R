# Code to prepare the `models_list` object
# This list is built from the `get_full_model_table()` function included in the
# package
devtools::load_all()

df_merged <- merge_clusters(
  df_raw     = study_data,
  df_red     = scale_reduce_vars(study_data),
  clustering = cluster_selected_vars(study_data)
)

df_long <- df_merged |> scale_vars() |> get_longer()

group_models      <- df_merged |> get_longer() |> get_full_model_table(Group)
cluster_models    <- df_long |> get_full_model_table(Cluster)
subcluster_models <- df_long |> get_full_model_table(Subcluster)

models_list <- list(
  group_models      = group_models,
  cluster_models    = cluster_models,
  subcluster_models = subcluster_models
)

usethis::use_data(models_list, overwrite = TRUE)
