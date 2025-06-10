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
  This is actually a data analysis project 'disguised' as a package.
  It contains the code and data to reproduce the analyses presented
  in an article.
  See {magenta https://osf.io/7vsx6/} for the complete study materials.
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
  return(NULL)
}
