source(here::here("data-raw/data_processing_functions.R"))

# Extracting and tidying raw data
df <- extract_raw_jatos()

df_similarities    <- process_similarities(df) # To export and score manually
df_comprehension   <- process_reading(df)      # To export and score manually

df_spans <- process_span_tasks(df)               # Unfolding span data
df_wcst  <- process_wcst(df)                     # Unfolding WCST data
df_questionnaires  <- process_questionnaires(df) # Raw questionnaire responses
df_scored_manually <- readxl::read_xlsx(         # Fetching manually scored data
  here::here("inst/extdata/data_scored_manually.xlsx")
)

df_final <-
  merge_all_tasks(                     # Merging all scores and classifications
    df_questionnaires,
    df_wcst,
    df_spans,
    df_scored_manually
  ) |>
  compute_questionnaire_scores() |>    # Computing questionnaire scores
  factor_and_arrange_variables() |>    # Factoring, reordering variables, etc.

# Retrieving metadata
df_meta  <- extract_metadata()

# Exporting in various formats ------------------------------

# Excel, all clean data
openxlsx::write.xlsx(
  list(
    "data_final"  = df_final,
    "similarities" = df_similarities,
    "comprehension" = df_comprehension,
    "metadata" = df_meta
  ),
  here::here("inst/extdata/data_tidied.xlsx"),
  asTable = TRUE,
  colNames = TRUE,
  colWidths = "auto",
  borders = "all",
  tableStyle = "TableStyleMedium16"
)

# CSV, main data only
readr::write_csv(df_final, here::here("inst/extdata/data_tidied.csv"))

# RDS, main data with correct variable types
saveRDS(df_final, here::here("inst/extdata/data_tidied.rds"))

# These three files have been uploaded to the OSF project
# (https://osf.io/7vsx6/files/osfstorage) in the `Data/extracted-data` folder.
# The last one, `data_tidied.rds`, is thereafter used in `03_study_data.R` to
# create the final `study_data` dataset included in the package.
