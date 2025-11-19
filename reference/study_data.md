# Study data retrieved from the OSF project

This dataset contains the tidied data retrieved from the OSF project.
The data has been preprocessed from the raw data files extracted from a
JATOS server beforehand. The raw data is not bundled in the package to
keep it lightweight, but the functions to extract it are available as
internal functions and a code example is included in
`data-raw/raw_data_extraction.R`.

## Usage

``` r
study_data
```

## Format

An object of class `tbl_df` (inherits from `tbl`, `data.frame`) with 96
rows and 27 columns.

## Source

Data collected in the online experiment. See
<https://osf.io/7vsx6/files/osfstorage>.

## Details

The dataset contains the following columns:

- `id`: Participant ID

- `age`: Participant age

- `sex`: Participant sex

- `group`: Participant VVIQ group (Aphantasic/Control)

- `education`: Participant education level (ISCED classification)

- `field`: Participant field of study/work (ISCED-F classification)

- `field_code`: Participant field of study/work code (ISCED-F
  classification)

- `occupation`: Participant occupation field (ISCO classification)

- `occupation_code`: Participant occupation field code (ISCO
  classification)

- `vviq`: Vividness of Visual Imagery Questionnaire score

- `osivq_o`: Object imagery score from the OSIVQ questionnaire

- `osivq_s`: Spatial imagery score from the OSIVQ questionnaire

- `osivq_v`: Verbal score from the OSIVQ questionnaire

- `psiq_vis`: Psi-Q Visual imagery score

- `psiq_aud`: Psi-Q Auditory imagery score

- `psiq_od`: Psi-Q Olfactory imagery score

- `psiq_gout`: Psi-Q Gustatory imagery score

- `psiq_tou`: Psi-Q Tactile imagery score

- `psiq_sens`: Psi-Q Sensory imagery score

- `psiq_feel`: Psi-Q Feelings imagery score

- `score_raven`: Raven Matrices score

- `score_sri`: SRI score

- `span_digit`: Digit Span score

- `span_spatial`: Spatial Span score

- `score_similarities`: Similarities test score

- `wcst_accuracy`: Wisconsin Card Sorting Test accuracy score

- `score_comprehension`: Reading comprehension score
