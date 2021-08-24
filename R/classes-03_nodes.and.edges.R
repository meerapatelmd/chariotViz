#' @title omop.concept.example S4 class
#' @export
omop.concept.example <-
  setClass("omop.concept.example",
           list(data = "data.frame"))



#' @title nodes.and.edges Reference Class
#' @export

# nodes.and.edges <-
#   setClass("nodes.and.edges",
           # list(nodes = "nodes",
           #      edges = "edges",
           #      overlapping_fields = "character",
           #      has_tooltip = "logical",
           #      has_node_attrs = "logical",
           #      has_edge_attrs = "logical"),
           # prototype = list(has_tooltip = FALSE,
           #                  has_node_attrs = FALSE,
           #                  has_edge_attrs = FALSE))
#

nodes.and.edges <-
  setRefClass("nodes.and.edges",
              fields =
              list(nodes = "nodes",
                   edges = "edges",
                   overlapping_fields = "character",
                   has_tooltip = "logical",
                   has_node_attrs = "logical",
                   has_edge_attrs = "logical"),
              methods = list(show = print_nodes_and_edges))

#' @title complete.nodes.and.edges S4 class
#' @export

complete.nodes.and.edges <-
  setClass("complete.nodes.and.edges",
           list(nodes = "complete.nodes",
                edges = "complete.edges",
                overlapping_fields = "character",
                has_tooltip = "logical",
                has_node_attrs = "logical",
                has_edge_attrs = "logical"),
           prototype = list(has_tooltip = FALSE,
                            has_node_attrs = FALSE,
                            has_edge_attrs = FALSE))


#' @title ancestor.nodes.and.edges S4 class
#' @export

ancestor.nodes.and.edges <-
  setClass("ancestor.nodes.and.edges",
           list(nodes = "ancestor.nodes",
                edges = "ancestor.edges",
                overlapping_fields = "character",
                has_tooltip = "logical",
                has_node_attrs = "logical",
                has_edge_attrs = "logical"),
           prototype = list(has_tooltip = FALSE,
                            has_node_attrs = FALSE,
                            has_edge_attrs = FALSE))



validNodeId <-
  function(object) {

    if (all(!is.na(object$nodes@data$id))) {

      TRUE

    } else {

      glue::glue("Some `id` are <NA>.")
    }




  }


validEdgeId <-
  function(object) {

    if (all(!is.na(object$edges@data$id))) {

      TRUE

    } else {

      glue::glue("Some `id` are <NA>.")
    }




  }

setValidity(
  Class = "nodes.and.edges",
  method = validNodeId
)


setValidity(
  Class = "nodes.and.edges",
  method = validEdgeId
)

setValidity(
  Class = "complete.nodes.and.edges",
  method = validNodeId
)


setValidity(
  Class = "complete.nodes.and.edges",
  method = validEdgeId
)


setValidity(
  Class = "ancestor.nodes.and.edges",
  method = validNodeId
)


setValidity(
  Class = "ancestor.nodes.and.edges",
  method = validEdgeId
)
