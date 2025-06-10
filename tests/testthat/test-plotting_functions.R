test_that("ggplot2 wrappers work properly", {
  group_effects <-
    tibble::tibble(
      Variable = factor(c(
        "VVIQ","Psi-Q Vision",
        "Psi-Q Audition", "Psi-Q Smell", "Psi-Q Taste",
        "Psi-Q Touch", "Psi-Q Sensations", "Psi-Q Feelings",
        "OSIVQ-Object")) |> forcats::fct_inorder(),
      x_star = 1.5,
      y_star = 1.08,
      stars  = "***",
      x_line = x_star - 0.5,
      x_line_end = x_star + 0.5,
      y_line = 1.05
    )

  group_effect_verbal <-
    tibble::tibble(
      Variable   = factor("OSIVQ-Verbal"),
      x_star     = 1.5,
      y_star     = 1.08,
      stars      = "**",
      x_line     = x_star - 0.5,
      x_line_end = x_star + 0.5,
      y_line     = 1.05
    )

  expect_contains(
    class(add_significance_geoms(group_effect_verbal)[[1]]),
    c("gg", "ggproto")
  )

  clusters_bic <- study_data |> cluster_selected_vars() |> plot_clusters_bic()
  expect_contains(class(clusters_bic), c("gg", "ggplot"))

  expect_error(save_ggplot(clusters_bic, ncol = 3)) # 1 or 2 max
  expect_error(save_ggplot(clusters_bic)) # path missing

  save_path <- withr::local_tempfile(fileext = ".pdf")
  expect_invisible(
    save_ggplot(clusters_bic, path = save_path, ncol = 1, verbose = TRUE)
  )
  expect_contains(
    class(
      save_ggplot(clusters_bic, save_path, 2, show = TRUE, verbose = FALSE)
    ),
    c("gg", "ggplot")
  )
})

test_that("Violin plotting works properly", {
  p_violins_original <-
    study_data |>
    scale_vars() |>
    get_longer() |>
    filter_study_variables("original") |>
    plot_score_violins(add_signif = TRUE, nrow = 2)
  p_violins_reduced <-
    merge_clusters(
      df_raw     = study_data,
      df_red     = scale_reduce_vars(study_data),
      clustering = cluster_selected_vars(study_data)
    ) |>
    scale_vars() |>
    get_longer() |>
    filter_study_variables("reduced") |>
    plot_score_violins(add_signif = FALSE, nrow = 2)

  expect_contains(class(p_violins_original), c("gg", "ggplot"))
  expect_contains(class(p_violins_reduced), c("gg", "ggplot"))
})

test_that("Radar plotting works properly", {
  df_merged_long <- merge_clusters(
    df_raw     = study_data,
    df_red     = scale_reduce_vars(study_data),
    clustering = cluster_selected_vars(study_data)
    ) |>
    scale_vars() |>
    get_longer()

  p_group <-
    df_merged_long |>
    filter_study_variables("original") |>
    plot_score_radars(Group)
  p_cluster <-
    df_merged_long |>
    filter_study_variables("reduced") |>
    plot_score_radars("Cluster") # with quotes also works
  p_subcluster <-
    df_merged_long |>
    filter_study_variables("reduced_strict") |>
    plot_score_radars(Subcluster)

  expect_contains(class(p_group),      c("gg", "ggplot"))
  expect_contains(class(p_cluster),    c("gg", "ggplot"))
  expect_contains(class(p_subcluster), c("gg", "ggplot"))

  expect_error(
    plot_score_radars(df_merged_long, Groups),
    "groups must be either 'Group', 'Cluster', or 'Subcluster'."
  )
  expect_error(
    plot_score_radars(df_merged_long, "Groups"),
    "groups must be either 'Group', 'Cluster', or 'Subcluster'."
  )
})

test_that("Correlation plotting works properly", {
  correlations <- correlate_vars(study_data, partial = FALSE)

  expect_contains(class(plot_score_cor_matrix(correlations)), c("gg", "ggplot"))
  expect_contains(class(plot_score_cor_graph(correlations)), c("gg", "ggplot"))
  expect_contains(class(plot_score_cor_joint(correlations)), c("gg", "ggplot"))
})
