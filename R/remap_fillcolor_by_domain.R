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
#' @rdname remap_fillcolor_by_domain
#' @importFrom dplyr mutate
#' @export

remap_fillcolor_by_domain <-
  function(omop_graph) {

    omop_graph@graph$nodes_df <-
      omop_graph@graph$nodes_df %>%
        dplyr::mutate(fillcolor = map_to_value(domain_id,
                                        map_assignment = domain_colors,
                                        other = "gray20"))


    omop_graph

  }
