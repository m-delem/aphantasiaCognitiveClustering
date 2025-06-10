test_that("filter_study_variables works properly", {
  df_study_long   <- get_longer(study_data)
  df_merged_long  <-
    merge_clusters(
      df_raw     = study_data,
      df_red     = scale_reduce_vars(study_data),
      clustering = cluster_selected_vars(study_data)
    ) |>
    get_longer()

  n_id <- nrow(df_study_long |> dplyr::distinct(id))

  expect_error(filter_study_variables("df_long"), "Input must be a data frame")
  expect_error(
    filter_study_variables(df_study_long, selection = "reduc"),
    "selection must be either 'original', 'reduced' or 'reduced_strict'"
  )
  expect_error(
    filter_study_variables(df_study_long, variables = 3),
    "'variables' must be a character vector or NULL."
  )
  expect_equal(
    nrow(filter_study_variables(df_study_long, selection = "original")),
    n_id * 18 # 18 original study variables
  )
  expect_equal(
    nrow(filter_study_variables(df_merged_long, selection = "original")),
    n_id * 18
  )
  expect_equal(
    nrow(filter_study_variables(df_merged_long, selection = "reduced")),
    n_id * 10 # 7 reduced variables + 3 original kept for validation
  )
  expect_equal(
    nrow(filter_study_variables(df_merged_long, selection = "reduced_strict")),
    n_id * 7 # 7 reduced variables
  )
  expect_equal(
    nrow(filter_study_variables(df_study_long, selection = "reduced_strict")),
    0 # no original variables when keeping reduced variables only
  )
  expect_equal(
    nrow(filter_study_variables(df_merged_long, variables = c("VVIQ", "WCST"))),
    n_id * 2 # custom selection
  )
})
