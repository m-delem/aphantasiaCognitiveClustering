# creating this package's sticker
devtools::load_all()

sysfonts::font_add_google("Montserrat")
showtext::showtext_auto()

df_merged_long <- merge_clusters(
  df_raw     = study_data,
  df_red     = scale_reduce_vars(study_data),
  clustering = cluster_selected_vars(study_data)
  ) |>
  scale_vars() |>
  get_longer()

p_radars <-
  plot_score_radars(
    df_merged_long,
    Cluster,
    r_off = 6,
    l_off = 6,
    dot_size = 0.5,
    lw_line  = 0.2,
    lw_error = 0
  ) +
  ggplot2::theme_void() +
  ggplot2::theme(legend.position = "none")

hexSticker::sticker(
  p_radars,
  package    = "aphantasia\nCognitive\nClustering",
  p_family   = "Montserrat",
  p_fontface = "bold",
  lineheight = 0.325,
  p_x     = 1,
  p_y     = 1,
  p_size  = 15,
  p_color = "#fff",
  h_color = "#394049",
  h_size  = 1,
  h_fill  = "#0c0e10",
  s_x = 0.905,
  s_y = 0.95,
  s_width  = 2.65,
  s_height = 2.65,
  # spotlight = FALSE,
  # l_x = 1,
  # l_y = 1,
  # l_width = 4,
  # l_height = 4,
  # l_alpha  = 0.2,
  filename = "inst/figures/package_sticker.png"
  )

usethis::use_logo(here::here("inst/figures/package_sticker.png"))
