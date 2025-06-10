test_that("modelling functions work properly", {
  df_vviq  <- study_data |> get_longer() |> dplyr::filter(Variable == "VVIQ")
  df_merged <- merge_clusters(
    df_raw     = study_data,
    df_red     = scale_reduce_vars(study_data),
    clustering = cluster_selected_vars(study_data)
  )

  # check get_mean_sd
  expect_contains(
    colnames(get_mean_sd(df_vviq, Group)),
    c("Control", "Aphantasic")
  )
  expect_error(get_mean_sd(df_vviq))
  expect_error(get_mean_sd(df_vviq, "test"))
  expect_error(get_mean_sd(df_vviq, "Group"))

  # check get_bf_inclusion
  expect_contains(
    colnames(get_bf_inclusion(df_vviq, Group)),
    c("Variable", "p_prior", "p_posterior", "log_BF")
  )
  expect_error(get_bf_inclusion(df_vviq))
  expect_error(get_bf_inclusion(df_vviq, "test"))
  expect_error(get_bf_inclusion(df_vviq, "Group"))

  # check get_full_model_table (and get_contrast_bf/fit_stan_glm indirectly)
  vviq_models <- get_full_model_table(df_vviq, Group)
  expect_contains(class(vviq_models), c("tbl", "data.frame"))
  expect_equal(
    colnames(vviq_models),
    c(
      "Variable",
      "Control", "Aphantasic",
      "Group", "Age", "Group $\\times$ Age",
      "Comparison", "Difference ($\\Delta$)",
      "95% CrI", "$log(BF_{10})$"
    )
  )
  expect_error(get_full_model_table(df_merged, "Group"))

  # check get_association_models
  expect_equal(
    colnames(get_association_models(df_merged, group)),
    c("Variable", "data", "table", "log_bf10")
  )
  expect_error(get_association_models(df_merged, Group))
  expect_error(get_association_models(df_merged, "group"))
})


