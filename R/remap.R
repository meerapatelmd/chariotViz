#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname remap_fillcolor_by_domain
#' @importFrom dplyr mutate
#' @export

remap_fillcolor_by_domain <-
  function(omop_graph,
           fillcolor_from = domain_id,
           fillcolor_map = node_color_map$domain_id$Base,
           fillcolor_map_other = "gray20") {

    omop_graph2 <-
      omop_graph$copy()

    fillcolor_from <- dplyr::enquo(fillcolor_from)
    omop_graph2$graph$nodes_df <-
      omop_graph2$graph$nodes_df %>%
        dplyr::mutate(fillcolor = map_to_value(!!fillcolor_from,
                                        map_assignment = fillcolor_map,
                                        other = fillcolor_map_other))


    omop_graph2

  }



#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname remap_fillcolor_by_concept_class
#' @importFrom dplyr mutate
#' @export

remap_fillcolor_by_concept_class <-
  function(omop_graph,
           fillcolor_from = concept_class_id,
           fillcolor_map = node_color_map$concept_class_id %>% purrr::set_names(NULL) %>% unlist(),
           fillcolor_map_other = "gray20") {

    omop_graph2 <-
      omop_graph$copy()

    fillcolor_from <- dplyr::enquo(fillcolor_from)
    omop_graph2$graph$nodes_df <-
      omop_graph2$graph$nodes_df %>%
      dplyr::mutate(fillcolor = map_to_value(!!fillcolor_from,
                                             map_assignment = fillcolor_map,
                                             other = fillcolor_map_other))


    omop_graph2

  }




#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param complete_omop_graph PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname remap_fillcolor_by_concept_class
#' @importFrom dplyr mutate
#' @export

remap_fillcolor_by_invalid_reason <-
  function(complete_omop_graph,
           fillcolor_from = invalid_reason,
           fillcolor_map = unlist(node_color_map$invalid_reason),
           fillcolor_map_other = "gray20") {


    if (class(complete_omop_graph) != "complete.omop.graph") {


      cli::cli_abort("Not complete.omop.graph class!")


    }

    complete_omop_graph2 <-
      complete_omop_graph$copy()


    fillcolor_from <- dplyr::enquo(fillcolor_from)
    complete_omop_graph2$graph$nodes_df <-
      complete_omop_graph2$graph$nodes_df %>%
      dplyr::mutate(invalid_reason = as.character(invalid_reason)) %>%
      dplyr::mutate(fillcolor = map_to_value(!!fillcolor_from,
                                             map_assignment = fillcolor_map,
                                             other = fillcolor_map_other))


    complete_omop_graph2

  }
