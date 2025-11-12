#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom graphics pairs
#' @importFrom mclust mclustBIC
#' @importFrom rlang .data
#' @importFrom rlang :=
#' @importFrom stats as.formula
#' @importFrom stats sd
#' @importFrom utils data
## usethis namespace: end
NULL

.onAttach <- function(libname, pkgname) {
  packageStartupMessage(glue::glue_col("{blue
  Welcome to {cyan aphantasiaCognitiveClustering}.
  See {magenta https://osf.io/7vsx6/} for the associated study.
  }",
  .literal = TRUE
  ))
}

# To avoid check NOTE on package sub-dependencies not called
ignore_unused_imports <- function() {
  BiocManager::valid        # for factoextra
  crayon::underline         # for glue_col
  logspline::dlogspline     # for emmeans
  sessioninfo::session_info # for RMD check
  quarto::quarto_render     # for RMD check
  return(NULL)
}
