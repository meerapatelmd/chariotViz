#' Read SQL from Installation Directory
#' @noRd

read_sql_template <-
  function(file) {
    readLines(
      system.file(package = "chariotViz",
                  "sql",
                  file)) %>%
      paste(collapse = "\n")
  }
