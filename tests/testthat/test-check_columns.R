test_that("functions returns the correct columns", {
  correlations <- correlate_vars(study_data, partial = FALSE)
  df_scaled    <- scale_vars(study_data)
  df_reduced   <- scale_reduce_vars(study_data)
  mclust_model <- cluster_selected_vars(study_data)
  df_merged <- merge_clusters(
    df_raw     = study_data,
    df_red     = df_reduced,
    clustering = mclust_model
  )
  df_long <- get_longer(df_merged)
  expect_equal(
    colnames(as.data.frame(correlations)),
    c(
      "Parameter1", "Parameter2",
      "r", "CI", "CI_low", "CI_high",
      "t", "df_error", "p",
      "Method", "n_Obs"
  ))
  expect_equal(
    colnames(df_reduced),
    c(
      "visual_imagery",
      "auditory_imagery",
      "sensory_imagery",
      "spatial_imagery",
      "verbal_strategies",
      "fluid_intelligence",
      "verbal_reasoning",
      "span_spatial"
  ))
  expect_equal(
    colnames(df_long),
    c(
      "id", "Group", "Cluster", "Subcluster",
      "Age", "Sex", "Education",
      "Field", "field_code",
      "Occupation", "occupation_code",
      "Variable", "value"
  ))
})
