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

