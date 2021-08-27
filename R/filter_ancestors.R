#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_ancestors PARAM_DESCRIPTION
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
#' @rdname filter_omop_ancestors
#' @export
#' @importFrom dplyr filter
filter_omop_ancestors <-
  function(omop_ancestors,
           ...) {

    if (class(omop_ancestors) != "omop.ancestors") {

      stop("Not omop.ancestors class.")

    }

    output <-
      omop_ancestors$copy()


    output@data <-
      output@data %>%
      dplyr::filter(...)


    output

  }
