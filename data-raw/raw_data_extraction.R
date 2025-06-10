# install.packages("osfr")
library(osfr)

# Creating an OSF Personal Access Token (PAT) is recommended for faster
# downloads, although not strictly necessary.
# See: https://docs.ropensci.org/osfr/articles/auth
# osf_auth("ThIsIsNoTaReAlPATbUtYoUgEtIt")

# Download the raw data from the OSF project
osf_retrieve_node("7vsx6") |>
  osf_ls_files() |>
  dplyr::filter(name == "Data") |>
  osf_ls_files() |>
  dplyr::filter(name == "raw-data.zip") |>
  osf_download(path = here::here("data-raw"))

# The raw data is in an archive that needs to be unzipped before processing.
# Once all the study folders (study_result_XXXX) are unzipped in the current
# data-raw/ directory, we can use the internal functions in the project
# dedicated to the initial extraction of raw JATOS files (text files containing
# JSON, nested in a lot of folders). This is not built in the "frontend" of the
# package because the raw files were too large, and it felt like keeping raw
# study files in a scientific repository was not a good idea. Instead, I decided
# to save the most relevant tidy data in the package as a lightweight .rda file,
# and the rest as an optional set of files + functions for the (*very*)
# interested researcher. Yes, I'm talking about you!
# Thank you for your interest, it means a lot to me.
