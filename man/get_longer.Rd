% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_longer.R
\name{get_longer}
\alias{get_longer}
\title{Transform the main data frame to long format}
\usage{
get_longer(df)
}
\arguments{
\item{df}{A data frame containing the main data.}
}
\value{
A data frame in long format.
}
\description{
Pivot the main data frames to long format. Any of the variables from
the study (raw/original variables) or created during the analysis (e.g.,
reduced variables) will be selected and pivoted to long format.
}
\examples{
df_raw_long <- get_longer(study_data)
head(df_raw_long[, c("id", "Variable", "value")], 18)

df_merged <- merge_clusters(
  df_raw     = study_data,
  df_red     = scale_reduce_vars(study_data),
  clustering = cluster_selected_vars(study_data)
  )
df_full_long <- get_longer(scale_vars(df_merged))
df_full_long[, c("id", "Variable", "value")] |>
  head(26) |>
  print(n = Inf)
}
