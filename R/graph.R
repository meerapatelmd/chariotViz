
construct_ndf <-
  function(nodes) {

    required <-
      colnames(nodes_and_edges@nodes@data)[colnames(nodes_and_edges@nodes@data) %in% nodes_and_edges@nodes@required_fields]
    required <-
      required[!(required %in% "id")]

    node_fields <-
      colnames(nodes_and_edges@nodes@data)[colnames(nodes_and_edges@nodes@data) %in% nodes_and_edges@nodes@node_fields]

    attrs <-
      colnames(nodes_and_edges@nodes@data)[colnames(nodes_and_edges@nodes@data) %in% nodes_and_edges@nodes@attribute_fields]


    all_fields <-
      c(required,
        node_fields,
        attrs)

    omop_ndf <-
      eval(
        rlang::parse_expr(
          c(
            "DiagrammeR::create_node_df(\n",
            "   n = nrow(nodes_and_edges@nodes@data),\n",
            paste(glue::glue("  {all_fields} = nodes_and_edges@nodes@data${all_fields}"),
                  collapse = ",\n"),
            "\n)") %>%
            paste(collapse = ""))
      )

    omop_ndf$id <- nodes_and_edges@nodes@data$id

    omop_ndf

  }


construct_edf <-
  function(edges) {


    required <-
      colnames(nodes_and_edges@edges@data)[colnames(nodes_and_edges@edges@data) %in% nodes_and_edges@edges@required_fields]
    required <-
      required[!(required %in% "id")]

    edge_fields <-
      colnames(nodes_and_edges@edges@data)[colnames(nodes_and_edges@edges@data) %in% nodes_and_edges@edges@edge_fields]

    attrs <-
      colnames(nodes_and_edges@edges@data)[colnames(nodes_and_edges@edges@data) %in% nodes_and_edges@edges@attribute_fields]

    all_fields <-
      c(required,
        edge_fields,
        attrs)


    omop_edf <-
      eval(
        rlang::parse_expr(
          c(
            "DiagrammeR::create_edge_df(\n",
            paste(glue::glue("  {all_fields} = nodes_and_edges@edges@data${all_fields}"),
                  collapse = ",\n"),
            "\n)") %>%
            paste(collapse = ""))
      )

    omop_edf


  }




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
