setOldClass("dgr_graph")
omop.graph <-
  setRefClass("omop.graph",
           fields    = list(graph = "dgr_graph",
                        src   = "nodes.and.edges",
                        has_example_concepts = "logical"),
           methods    = list(show = print_graph))


setOldClass("dgr_graph")
complete.omop.graph <-
  setClass("complete.omop.graph",
           slots    = c(graph = "dgr_graph",
                        src   = "complete.nodes.and.edges",
                        has_example_concepts = "logical"),
           prototype = list(has_example_concepts = FALSE))

setOldClass("dgr_graph")
ancestor.omop.graph <-
  setClass("ancestor.omop.graph",
           slots    = c(graph = "dgr_graph",
                        src   = "ancestor.nodes.and.edges",
                        has_example_concepts = "logical"),
           prototype = list(has_example_concepts = FALSE))

