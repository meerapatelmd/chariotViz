#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param nodes_and_edges PARAM_DESCRIPTION
#' @param attr_theme PARAM_DESCRIPTION, Default: 'lr'
#' @return OUTPUT_DESCRIPTION
#' @rdname construct_graph
#' @export
#' @importFrom rlang parse_expr
#' @importFrom glue glue
#' @importFrom DiagrammeR create_graph
construct_graph <-
  function(nodes_and_edges,
           attr_theme = "lr") {


    attrs <-
      colnames(nodes_and_edges@nodes@data)[!(colnames(nodes_and_edges@nodes@data) %in%
                                               c("id"))]
    omop_ndf <-
      eval(
        rlang::parse_expr(
          c(
            "DiagrammeR::create_node_df(\n",
            "   n = nrow(nodes_and_edges@nodes@data),\n",
            paste(glue::glue("  {attrs} = nodes_and_edges@nodes@data${attrs}"),
                  collapse = ",\n"),
            "\n)") %>%
            paste(collapse = ""))
      )

    omop_ndf$id <- nodes_and_edges@nodes@data$id


    attrs <-
      colnames(nodes_and_edges@edges@data)

    omop_edf <-
      eval(
        rlang::parse_expr(
          c(
            "DiagrammeR::create_edge_df(\n",
            paste(glue::glue("  {attrs} = nodes_and_edges@edges@data${attrs}"),
                  collapse = ",\n"),
            "\n)") %>%
            paste(collapse = ""))
      )

    final_graph <-
      DiagrammeR::create_graph(
        nodes_df = omop_ndf,
        edges_df = omop_edf,
        attr_theme = attr_theme
      )


    final_data <-
    new("omop.graph",
        graph = final_graph,
        src   = nodes_and_edges
        )
    # final_data <-
    #   list(
    #     graph = final_graph,
    #     src =   nodes_and_edges
    #   )

    final_data
  }

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
           layout = NULL,
           output = NULL,
           as_svg = FALSE,
           title = NULL,
           width = NULL,
           height = NULL) {


    DiagrammeR::render_graph(
      graph = omop_graph@graph,
      layout = layout,
      output = output,
      as_svg = as_svg,
      title = title,
      width = width,
      height = height
    )


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
#' @rdname filter_graph
#' @export
#' @importFrom dplyr enquos filter
filter_graph <-
  function(omop_graph,
           ...) {

    preds <-
      dplyr::enquos(...)

    apply_filter <-
      function(data,
               ...) {

        tryCatch(
          data %>%
            dplyr::filter(...),
          error = function(e) data
        )


      }

    for (pred in preds) {
      nodes0 <-
        omop_graph@src@nodes@data %>%
        apply_filter(!!pred)

      edges0 <-
      omop_graph@src@edges@data <-
        omop_graph@src@edges@data %>%
        apply_filter(!!pred)

    }

    # If the filter is applied to a node, then
    # then filtering edges based on `from` and `to`

   edges1 <-
      dplyr::bind_rows(
        edges0 %>%
          dplyr::filter(from %in% nodes0$id),
        edges0 %>%
          dplyr::filter(to %in% nodes0$id)) %>%
      dplyr::distinct() %>%
     distinct()


   nodes1 <-
   omop_graph@src@nodes@data %>%
     dplyr::filter(id %in% unique(c(edges1$from, edges1$to))) %>%
     distinct()

   new_nodes_and_edges <-
     new(Class = "nodes.and.edges",
         list(nodes = nodes1,
              edges = edges1))



    construct_graph(
      nodes_and_edges = new_nodes_and_edges
    )
  }
