#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname print_omop_relationships
#' @import cli
#' @import glue

print_omop_relationships <-
  function(x,
           max.rows = 3) {

    print.data.frame(head(x@data,max.rows),
                     row.names = FALSE)
    cli::cat_line(cli::style_italic(glue::glue("...{nrow(x@data)-max.rows} more rows")))



  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname print_nodes_and_edges
#' @import cli
#' @import glue

print_nodes_and_edges <-
  function(x,
           max.rows = 3) {

    cli::cat_rule("Nodes",
                  line = 2,
                  width = 60)
    print.data.frame(head(x@nodes@data,max.rows),
                     row.names = FALSE)
    cli::cat_line(cli::style_italic(glue::glue("...{nrow(x@nodes@data)-max.rows} more rows")))
    cat("\n")
    cli::cat_rule("Edges",
                  line = 2,
                  width = 60)
    print.data.frame(head(x@edges@data,max.rows),
                     row.names = FALSE)
    cli::cat_line(cli::style_italic(glue::glue("...{nrow(x@edges@data)-max.rows} more rows")))

    cat("\n")

    cli::cat_rule("Status",
                  line = 2,
                  width = 60)
    cli::cat_bullet(glue::glue("Tooltip:\t\t{x@has_tooltip}"),
                    bullet = ifelse(x@has_tooltip, "tick", "cross"),
                    bullet_col = ifelse(x@has_tooltip, "green", "red")
    )
    cli::cat_bullet(glue::glue("Node Attributes:\t{x@has_node_attrs}"),
                    bullet = ifelse(x@has_node_attrs, "tick", "cross"),
                    bullet_col = ifelse(x@has_node_attrs, "green", "red")
    )
    cli::cat_bullet(glue::glue("Edge Attributes:\t{x@has_edge_attrs}"),
                    bullet = ifelse(x@has_edge_attrs, "tick", "cross"),
                    bullet_col = ifelse(x@has_edge_attrs, "green", "red")
    )
    cat("\n")
  }


# setMethod("print",
#           signature(x = "omop.relationships"),
#           function(x) print_omop_relationships(x))
#
# setMethod("print",
#           signature(x = "nodes.and.edges"),
#           function(x) print_nodes_and_edges(x))
#
#
# setMethod("print",
#           signature(x = "omop.graph"),
#           function(x) x@graph)
