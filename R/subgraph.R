#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[DiagrammeR]{transform_to_subgraph_ws}}
#' @rdname subgraph
#' @export
#' @importFrom DiagrammeR transform_to_subgraph_ws

subgraph <-
  function(graph,
           src) {

    new(Class = "omop.graph",
        graph = DiagrammeR::transform_to_subgraph_ws(graph = graph),
        src   = src)



  }
