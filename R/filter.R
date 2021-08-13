#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
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
#'  \code{\link[dplyr]{tidyeval-compat}},\code{\link[dplyr]{filter}}
#' @rdname filter_nodes
#' @export
#' @importFrom dplyr enquos filter
filter_nodes <-
  function(omop_graph,
           set_op = "intersect",
           ...) {

    preds <-
      dplyr::enquos(...)

    apply_filter <-
      function(omop_graph,
               pred) {

        omop_graph@graph <-
          omop_graph@graph %>%
          DiagrammeR::select_nodes(conditions = !!pred) %>%
          DiagrammeR::trav_both() %>%
          DiagrammeR::transform_to_subgraph_ws()

        omop_graph

      }

    for (pred in preds) {
      omop_graph <-
        omop_graph %>%
        apply_filter(!!pred)

    }

    omop_graph

  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
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
#'  \code{\link[dplyr]{tidyeval-compat}},\code{\link[dplyr]{filter}}
#' @rdname filter_edges
#' @export
#' @importFrom dplyr enquos filter
filter_edges <-
  function(omop_graph,
           set_op = "intersect",
           ...) {

    preds <-
      dplyr::enquos(...)

    apply_filter <-
      function(omop_graph,
               pred) {


        omop_graph@graph <-
          omop_graph@graph %>%
          DiagrammeR::select_edges(conditions = !!pred) %>%
          DiagrammeR::trav_both() %>%
          DiagrammeR::transform_to_subgraph_ws()


        omop_graph

      }

    for (pred in preds) {
      omop_graph <-
        omop_graph %>%
        apply_filter(!!pred)

    }

    omop_graph

  }
