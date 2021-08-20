
#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param nodes_and_edges PARAM_DESCRIPTION
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
#'  \code{\link[dplyr]{mutate}}
#' @rdname mutate_nodes
#' @export
#' @importFrom dplyr mutate


mutate_nodes <-
  function(nodes_and_edges,
           ...) {
    nodes_and_edges@nodes@data <-
    nodes_and_edges@nodes@data %>%
      dplyr::mutate(...)

    nodes_and_edges


  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param nodes_and_edges PARAM_DESCRIPTION
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
#'  \code{\link[dplyr]{mutate}}
#' @rdname mutate_edges
#' @export
#' @importFrom dplyr mutate

mutate_edges <-
  function(nodes_and_edges,
           ...) {
    nodes_and_edges@edges@data <-
      nodes_and_edges@edges@data %>%
      dplyr::mutate(...)


    nodes_and_edges


  }
