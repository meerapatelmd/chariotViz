#' @title omop.relationships Reference class
#' @export
# omop.relationships <-
#   setClass("omop.relationships",
#            list(data = "data.frame"))

omop.relationships <-
  setRefClass("omop.relationships",
              fields = list(data = "data.frame"),
              methods = list(show = print_omop))


#' @title complete.omop.relationships Reference Class
#' @export
complete.omop.relationships <-
  setRefClass("complete.omop.relationships",
              fields = list(data = "data.frame"),
              methods = list(show = print_omop))

#' @title omop.ancestors Reference class
#' @export
omop.ancestors <-
  setRefClass("omop.ancestors",
              fields = list(data = "data.frame"),
              methods = list(show = print_omop))
