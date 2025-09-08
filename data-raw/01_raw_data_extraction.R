# install.packages("osfr")
library(osfr)

# Creating an OSF Personal Access Token (PAT) is recommended for faster
# downloads, although not strictly necessary.
# See: https://docs.ropensci.org/osfr/articles/auth
# osf_auth("ThIsIsNoTaReAlPATbUtYoUgEtIt")

# Get the paths to the raw data from the OSF project
data_files <-
  osf_retrieve_node("7vsx6") |>
  osf_ls_files() |>
  dplyr::filter(name == "Data") |>
  osf_ls_files()

# Download the zipped JATOS data files
data_files |>
  dplyr::filter(name == "raw-data.zip") |>
  osf_download(path = here::here("inst/extdata"))

# Download the data scored manually
data_files |>
  dplyr::filter(name == "extracted-data") |>
  osf_ls_files() |>
  dplyr::filter(name == "data_scored_manually.xlsx")  |>
  osf_download(path = here::here("inst/extdata"))

# The raw JATOS data is in an archive that needs to be unzipped in inst/extdata.
# Once all the study folders (study_result_XXXX) are unzipped, we can use the
# functions in `data_processing_functions.R` to extract the JATOS files (text
# files containing JSON, nested in a lot of folders) and merge it with manually
# scored data from two tasks (Reading comprehension and Similarities test).
# This is done in `02_creating_data_files.R`, which creates the final tidy data.
#
# This is not built in the "frontend" of the package because the raw files took
# a bit of time to process, and it felt like keeping raw study files in a GitHub
# repository was not a great idea. Instead, I decided to save the most relevant
# tidy data in the package as a lightweight .rda file, and the rest as an
# optional set of code and functions for the (*very*) interested researcher.
# Yes, I'm talking about you!
#
# Thank you for your interest, it means a lot to me.
