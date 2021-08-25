#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
#' @param layout PARAM_DESCRIPTION, Default: NULL
#' @param output PARAM_DESCRIPTION, Default: NULL
#' @param as_svg PARAM_DESCRIPTION, Default: FALSE
#' @param title PARAM_DESCRIPTION, Default: NULL
#' @param width PARAM_DESCRIPTION, Default: NULL
#' @param height PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[DiagrammeR]{render_graph}}
#' @rdname chariotViz
#' @export
#' @importFrom DiagrammeR render_graph
chariotViz <-
  function(omop_graph,
           node_count_cutoff = 30,
           include_counts = TRUE,
           include_legend = TRUE,
           force = FALSE,
           layout = NULL,
           output = NULL,
           as_svg = FALSE,
           title = NULL,
           width = 1000,
           height = 1000) {


    node_count <-
      DiagrammeR::count_nodes(omop_graph$graph)

    edge_count <-
      DiagrammeR::count_edges(omop_graph$graph)


    if (include_counts) {

      legend_ht <-
        huxtable::hux(
          tibble::tibble(
            `n nodes` = node_count,
            `n edges` = edge_count)) %>%
        huxtable::theme_article()

      huxtable::print_screen(legend_ht,
                             colnames = FALSE)

    }

    if (!force & node_count > node_count_cutoff) {

      message(
        glue::glue(
          "There are {node_count} nodes and {edge_count} edges.
          To render anyways, set `force` to TRUE."))


    } else {


      DiagrammeR::render_graph(
        graph = omop_graph$graph,
        layout = layout,
        output = output,
        as_svg = as_svg,
        title = title,
        width = width,
        height = height
      )


    }

  }





graph_edge_metrics <-
  function(omop_graph) {

    edges_df <- omop_graph@graph$edges_df

    target_cols <-
    unique(c(omop_graph@src@edges@required_fields,
             omop_graph@src@edges@edge_fields))

    output <-
      vector(mode = "list",
             length = length(target_cols))

    names(output) <-
      target_cols

    for (target_col in target_cols) {

      output[[target_col]] <-
        edges_df %>%
        dplyr::group_by_at(dplyr::vars(dplyr::all_of(target_col))) %>%
        dplyr::summarise(count = n()) %>%
        dplyr::ungroup() %>%
        dplyr::arrange(desc(count))



    }


    list(size = nrow(edges_df),
         distribution = output)

  }
