#' Filter the `Variable` column of a  long format data frame
#'
#' This function is a simple helper to filter the `Variable` column of the
#' study data in long format. There are two main groups of study variables,
#' "original" experimental variables and "reduced" variables created in our
#' analyses. This functions allows to filter these two selections easily, and
#' optionally to filter for a specific set of variables.
#'
#' @param df A data frame in long format containing the `Variable` column to be
#' filtered. This is for example the output of `get_longer(study_data)`.
#' @param selection A character string indicating the selection of variables to
#' filter for. It can be either `"original"`, `"reduced"` (reduced variables +
#' three validation variables from the original set) or `"reduced_strict"`.
#' If you want to use a custom set of variables, set `variables` to a character
#' vector and leave `selection` to its default value.
#' @param variables Optional. A character vector of variable names to filter
#' for. If `NULL`, the function will use the default selection of variables
#' based on the `selection` argument. If provided, it will override the
#' default selection.
#'
#' @returns A data frame filtered for the specified variables in the `Variable`
#' column.
#' @export
#'
#' @examples
#' df_merged_long <- merge_clusters(
#'   df_raw     = study_data,
#'   df_red     = scale_reduce_vars(study_data),
#'   clustering = cluster_selected_vars(study_data)
#' ) |> get_longer()
#'
#' # df_merged_long contains all study and reduced variables
#' original <- filter_study_variables(df_merged_long, selection = "original")
#' reduced  <- filter_study_variables(df_merged_long, selection = "reduced")
#' reduced_strict  <- filter_study_variables(
#'  df_merged_long,
#'  selection = "reduced_strict"
#' )
#' custom <- filter_study_variables(
#'   df_merged_long,
#'   variables = c("VVIQ", "WCST")
#' )
#' levels(factor(original$Variable))
#' levels(factor(reduced$Variable))
#' levels(factor(reduced_strict$Variable))
#' levels(factor(custom$Variable))
filter_study_variables <- function(
    df,
    selection = "original",
    variables = NULL
) {
  if (!is.data.frame(df)) stop("Input must be a data frame.")

  if (selection == "original") {
    var_selection <- c(
      # Original scores
      "VVIQ",
      "OSIVQ-Object",
      "OSIVQ-Spatial",
      "OSIVQ-Verbal",
      "Psi-Q Vision",
      "Psi-Q Audition",
      "Psi-Q Smell",
      "Psi-Q Taste",
      "Psi-Q Touch",
      "Psi-Q Sensations",
      "Psi-Q Feelings",
      "Raven matrices",
      "SRI",
      "Digit span",
      "Spatial span",
      "Similarities test",
      "WCST",
      "Reading\ncomprehension"
    )
  } else if (selection == "reduced") {
    var_selection <- c(
      # Reduced variables
      "Visual imagery",
      "Auditory imagery", # Kept for validation
      "Sensory imagery",
      "Spatial imagery",
      "Verbal strategies",
      "Raven +\nDigit Span",
      # "Non-verbal\nreasoning",
      "Verbal reasoning",
      "Spatial span std.",
      "WCST",                  # Validation
      "Reading\ncomprehension" # Validation
    )
  } else if (selection == "reduced_strict") {
    var_selection <- c(
      # Reduced variables only
      "Visual imagery",
      "Sensory imagery",
      "Spatial imagery",
      "Verbal strategies",
      "Raven +\nDigit Span",
      "Verbal reasoning",
      "Spatial span std."
    )
  } else stop(
    "selection must be either 'original', 'reduced' or 'reduced_strict'. If you
    want to use a custom set of variables, set 'variables' to a character
    vector."
  )

  # If variables are specified, use them instead of the default selection
  if (!is.null(variables)) {
    if (!is.character(variables)) {
      stop("'variables' must be a character vector or NULL.")
    }
    var_selection <- variables
  }

  # Filter the data frame for the specified variables
  filtered_df <- df[df$Variable %in% var_selection, ]

  return(filtered_df)
}
