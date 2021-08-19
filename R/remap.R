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
  function(omop_graph,
           fillcolor_from = domain_id,
           fillcolor_map = domain_colors,
           fillcolor_map_other = "gray20") {

    fillcolor_from <- dplyr::enquo(fillcolor_from)
    omop_graph@graph$nodes_df <-
      omop_graph@graph$nodes_df %>%
        dplyr::mutate(fillcolor = map_to_value(!!fillcolor_from,
                                        map_assignment = fillcolor_map,
                                        other = fillcolor_map_other))


    omop_graph

  }



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
#' @rdname remap_fillcolor_by_concept_class
#' @importFrom dplyr mutate
#' @export

remap_fillcolor_by_concept_class <-
  function(omop_graph,
           fillcolor_from = concept_class_id,
           fillcolor_map = domain_colors,
           fillcolor_map_other = "gray20") {

    fillcolor_from <- dplyr::enquo(fillcolor_from)
    omop_graph@graph$nodes_df <-
      omop_graph@graph$nodes_df %>%
      dplyr::mutate(fillcolor = map_to_value(!!fillcolor_from,
                                             map_assignment = fillcolor_map,
                                             other = fillcolor_map_other))


    omop_graph

  }
