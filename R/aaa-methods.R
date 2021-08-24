#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param x PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname print_relationships
#' @import cli
#' @import glue

print_omop <-
  function(max.rows = 3) {

    cli::cat_rule("OMOP Data",
                  line = 2,
                  width = 60)
    print.data.frame(head(.self$data,max.rows),
                     row.names = FALSE)

    cli::cat_line(cli::style_italic(glue::glue("...{nrow(.self$data)-max.rows} more rows")))



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
  function(max.rows = 3) {

    cli::cat_rule("Nodes",
                  line = 2,
                  width = 60)
    print.data.frame(head(.self$nodes@data,max.rows),
                     row.names = FALSE)
    cli::cat_line(cli::style_italic(glue::glue("...{nrow(.self$nodes@data)-max.rows} more rows")))
    cat("\n")
    cli::cat_rule("Edges",
                  line = 2,
                  width = 60)
    print.data.frame(head(.self$edges@data,max.rows),
                     row.names = FALSE)
    cli::cat_line(cli::style_italic(glue::glue("...{nrow(.self$edges@data)-max.rows} more rows")))

    cat("\n")

    cli::cat_rule("Status",
                  line = 2,
                  width = 60)
    cli::cat_bullet(glue::glue("Tooltip:\t\t{.self$has_tooltip}"),
                    bullet = ifelse(.self$has_tooltip, "tick", "cross"),
                    bullet_col = ifelse(.self$has_tooltip, "green", "red")
    )
    cli::cat_bullet(glue::glue("Node Attributes:\t{.self$has_node_attrs}"),
                    bullet = ifelse(.self$has_node_attrs, "tick", "cross"),
                    bullet_col = ifelse(.self$has_node_attrs, "green", "red")
    )
    cli::cat_bullet(glue::glue("Edge Attributes:\t{.self$has_edge_attrs}"),
                    bullet = ifelse(.self$has_edge_attrs, "tick", "cross"),
                    bullet_col = ifelse(.self$has_edge_attrs, "green", "red")
    )
    cat("\n")
  }



print_graph <-
  function() {

    cli::cat_rule("Graph",
                  line = 2,
                  width = 60)
    print(.self$graph)

    cat("\n")

    cli::cat_rule("Status",
                  line = 2,
                  width = 60)
    cli::cat_bullet(glue::glue("Tooltip:\t\t{.self$src$has_tooltip}"),
                    bullet = ifelse(.self$src$has_tooltip, "tick", "cross"),
                    bullet_col = ifelse(.self$src$has_tooltip, "green", "red")
    )
    cli::cat_bullet(glue::glue("Node Attributes:\t{.self$src$has_node_attrs}"),
                    bullet = ifelse(.self$src$has_node_attrs, "tick", "cross"),
                    bullet_col = ifelse(.self$src$has_node_attrs, "green", "red")
    )
    cli::cat_bullet(glue::glue("Edge Attributes:\t{.self$src$has_edge_attrs}"),
                    bullet = ifelse(.self$src$has_edge_attrs, "tick", "cross"),
                    bullet_col = ifelse(.self$src$has_edge_attrs, "green", "red")
    )
    cli::cat_bullet(glue::glue("Example Concepts:\t{.self$has_example_concepts}"),
                    bullet = ifelse(.self$has_example_concepts, "tick", "cross"),
                    bullet_col = ifelse(.self$has_example_concepts, "green", "red")
    )
    cat("\n")

  }
