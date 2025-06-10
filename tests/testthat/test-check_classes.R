test_that("functions return objects with the correct classes", {
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

  expect_contains(class(correlations), c("easycorrelation", "data.frame"))
  expect_contains(class(df_scaled),    c("tbl", "data.frame"))
  expect_contains(class(df_reduced),   c("tbl", "data.frame"))
  expect_contains(class(mclust_model), "Mclust")
  expect_contains(class(df_merged),    c("tbl", "data.frame"))
  expect_contains(class(df_long),      c("tbl", "data.frame"))
  expect_null(ignore_unused_imports())
})
