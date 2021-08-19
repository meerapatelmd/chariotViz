#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_relationships PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[dplyr]{filter}}
#' @rdname filter_omop_relationships
#' @export
#' @import dplyr

filter_omop_relationships <-
  function(omop_relationships,
           ...) {

    if (class(omop_relationships) != "omop.relationships") {

      stop("Not omop.relationships class.")

    }

    output <-
      omop_relationships


    output@data <-
      output@data %>%
      dplyr::filter(...)


    output

  }
