# install.packages("osfr")
library(osfr)

# Creating an OSF Personal Access Token (PAT) is recommended for faster
# downloads, although not strictly necessary.
# See: https://docs.ropensci.org/osfr/articles/auth
# osf_auth("ThIsIsNoTaReAlPATbUtYoUgEtIt")

# Downloading the extracted and tidied data from the OSF project
osf_retrieve_node("7vsx6") |>
  osf_ls_files() |>
  dplyr::filter(name == "Data") |>
  osf_ls_files() |>
  dplyr::filter(name == "extracted-data") |>
  osf_ls_files() |>
  dplyr::filter(name == "data_tidied.rds") |>
  osf_download(path = here::here("data-raw"))

# Saving it as package data
study_data <- readRDS(here::here("data-raw/data_tidied.rds"))
usethis::use_data(study_data)

unlink(here::here("data-raw/data_tidied.rds"))
