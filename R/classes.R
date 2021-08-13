#' @title nodes S4 class
#' @slot data nodes dataframe
#' @slot required_fields required fields for a nodes s4 class object
#' @slot attribute_fields fields denoting node attributes
#' @export

nodes <-
  setClass(
    Class = "nodes",
    slots = c(data = "data.frame",
              required_fields = "character",
              attribute_fields = "character"),
    prototype = list(data = tibble::tibble(),
                     required_fields = c("id", "type", "label"),
                     attribute_fields =   c(
                         'shape',
                         'style',
                         'penwidth',
                         'color',
                         'fillcolor',
                         'image',
                         'fontname',
                         'fontsize',
                         'fontcolor',
                         'peripheries',
                         'height',
                         'width',
                         'x',
                         'y',
                         'group',
                         'tooltip',
                         'xlabel',
                         'URL',
                         'sides',
                         'orientation',
                         'skew',
                         'distortion',
                         'gradientangle',
                         'fixedsize',
                         'labelloc',
                         'margin'
                       )
                     ))


#' @title edges S4 class
#' @slot data edges dataframe
#' @slot required_fields required fields for a edges s4 class object
#' @slot attribute_fields fields denoting edge attributes
#' @export

edges <-
setClass(
  Class = "edges",
  slots = c(data = "data.frame",
            required_fields = "character",
            attribute_fields = "character"),
  prototype = list(data = tibble::tibble(),
                   required_fields = c("from", "to", "label", "rel"),
                   attribute_fields =   c(
                     'style',
                     'penwidth',
                     'color',
                     'arrowsize',
                     'arrowhead',
                     'arrowtail',
                     'fontname',
                     'fontsize',
                     'fontcolor',
                     'len',
                     'tooltip',
                     'URL',
                     'label',
                     'labelfontname',
                     'labelfontsize',
                     'labelfontcolor',
                     'labeltooltip',
                     'labelURL',
                     'edgetooltip',
                     'edgeURL',
                     'dir',
                     'headtooltip',
                     'headURL',
                     'headclip',
                     'headlabel',
                     'headport',
                     'tailtooltip',
                     'tailURL',
                     'tailclip',
                     'taillabel',
                     'tailport',
                     'decorate'
                   ))
)

#' @title nodes.and.edges S4 class
#' @export

nodes.and.edges <-
  setClass("nodes.and.edges",
           list(nodes = "nodes",
                edges = "edges",
                overlapping_fields = "character"))


#' @title raw.omop.data S4 class
#' @export

omop.relationships <-
  setClass("omop.relationships",
           list(data = "data.frame"))


#' @title raw.omop.data S4 class
#' @export
setOldClass("dgr_graph")
omop.graph <-
  setClass("omop.graph",
           slots    = c(graph = "dgr_graph",
                        src   = "nodes.and.edges"))



validNE <-
  function(object) {

    if (all(object@required_fields %in% colnames(object@data))) {


      TRUE


    } else {

      missing_fields <-
        object@required_fields[!(object@required_fields %in% colnames(object@data))]
      glue::glue("Required fields missing from data: {glue::backtick(missing_fields)}.")


    }



  }


validNodeCount <-
  function(object) {

    if (nrow(object@data) == nrow(object@data %>% distinct(domain_id, vocabulary_id, concept_class_id, standard_concept))) {


      TRUE


    } else {

      glue::glue("There are {nrow(object@data %>% distinct(domain_id, vocabulary_id, concept_class_id, standard_concept))} unique node{?s} (defined by unique combinations of domain, vocabulary, concept_class, and standard_concept) while there are {nrow(object@data)} row{?s} in `nodes`.")


    }
  }


validNodeRows <-
  function(object) {

    if (nrow(object@data) == max(object@data$id)) {

      TRUE

    } else {


      glue::glue("There are {nrow(object@data)} row{?s} in the node dataframe, but the max `id`
                 is {max(object@data$id)}.")

    }


  }

setValidity(
  Class = "nodes",
  method = validNE
)


setValidity(
  Class = "nodes",
  method = validNodeCount
)

setValidity(
  Class = "nodes",
  method = validNodeRows
)

setValidity(
  Class = "edges",
  method = validNE
)





# setMethod("print",
#           signature(x = "nodes"),
#           function(x,...) print(x@data,...))

# setMethod("print",
#           signature(x = "edges"),
#           function(x,...) print(x@data,...))

# setMethod("print",
#           signature(x = "nodes.and.edges"),
#           function(x, ...) print(list(x@nodes@data,x@edges@data)))
