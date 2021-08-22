#' @title omop.relationships S4 class
#' @export
omop.relationships <-
  setClass("omop.relationships",
           list(data = "data.frame"))


#' @title complete.omop.relationships S4 class
#' @export
complete.omop.relationships <-
  setClass("complete.omop.relationships",
           list(data = "data.frame"))

#' @title omop.ancestors S4 class
#' @export
omop.ancestors <-
  setClass("omop.ancestors",
           list(data = "data.frame"))


#' @title omop.concept.example S4 class
#' @export
omop.concept.example <-
  setClass("omop.concept.example",
           list(data = "data.frame"))


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
              attribute_fields = "character",
              tooltip_fields = "character",
              node_fields = "character"),
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
                       ),
                     tooltip_fields =
                       c('id',
                         'domain_id',
                         'vocabulary_id',
                         'concept_class_id',
                         'standard_concept',
                         'total_concept_class_ct',
                         'total_vocabulary_ct'),
                     node_fields =
                       c('domain_id',
                         'vocabulary_id',
                         'concept_class_id',
                         'standard_concept',
                         'total_concept_class_ct',
                         'total_vocabulary_ct'))
    )



#' @title complete.nodes S4 class
#' @slot data nodes dataframe
#' @slot required_fields required fields for a nodes s4 class object
#' @slot attribute_fields fields denoting node attributes
#' @export

complete.nodes <-
  setClass(
    Class = "complete.nodes",
    slots = c(data = "data.frame",
              required_fields = "character",
              attribute_fields = "character",
              tooltip_fields = "character",
              node_fields = "character"),
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
                     ),
                     tooltip_fields =
                       c('id',
                         'domain_id',
                         'vocabulary_id',
                         'concept_class_id',
                         'standard_concept',
                         'invalid_reason',
                         'complete_concept_class_ct',
                         'complete_vocabulary_ct'),
                     node_fields =
                       c('domain_id',
                         'vocabulary_id',
                         'concept_class_id',
                         'standard_concept',
                         'invalid_reason',
                         'complete_concept_class_ct',
                         'complete_vocabulary_ct'))
  )

#' @title ancestor.nodes S4 class
#' @slot data nodes dataframe
#' @slot required_fields required fields for a nodes s4 class object
#' @slot attribute_fields fields denoting node attributes
#' @export

ancestor.nodes <-
  setClass(
    Class = "ancestor.nodes",
    slots = c(data = "data.frame",
              required_fields = "character",
              attribute_fields = "character",
              tooltip_fields = "character",
              node_fields = "character"),
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
                     ),
                     tooltip_fields =
                       c('id',
                         'domain_id',
                         'vocabulary_id',
                         'concept_class_id',
                         'standard_concept',
                         'to_descendant_count',
                         'total_concept_class_ct',
                         'total_vocabulary_ct'),
                     node_fields =
                       c('domain_id',
                         'vocabulary_id',
                         'concept_class_id',
                         'standard_concept',
                         'to_descendant_count',
                         'total_concept_class_ct',
                         'total_vocabulary_ct'))
  )


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
            attribute_fields = "character",
            tooltip_fields = "character",
            edge_fields = "character"),
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
                     'decorate'),
                   tooltip_fields =
                     c('id',
                       'from',
                       'to',
                       'relationship_id',
                       'relationship_name',
                       'relationship_source',
                       'is_hierarchical',
                       'defines_ancestry',
                       'concept_1_coverage',
                       'concept_2_coverage',
                       'domain_id_1',
                       'vocabulary_id_1',
                       'concept_class_id_1',
                       'standard_concept_1',
                       'concept_count_1',
                       'total_concept_class_ct_1',
                       'total_vocabulary_ct_1',
                       'domain_id_2',
                       'vocabulary_id_2',
                       'concept_class_id_2',
                       'standard_concept_2',
                       'concept_count_2',
                       'total_concept_class_ct_2',
                       'total_vocabulary_ct_2'),
                  edge_fields =
                     c('relationship_id',
                       'relationship_name',
                       'relationship_source',
                       'is_hierarchical',
                       'defines_ancestry',
                       'domain_id_1',
                       'vocabulary_id_1',
                       'concept_class_id_1',
                       'standard_concept_1',
                       'concept_count_1',
                       'total_concept_class_ct_1',
                       'total_vocabulary_ct_1',
                       'domain_id_2',
                       'vocabulary_id_2',
                       'concept_class_id_2',
                       'standard_concept_2',
                       'concept_count_2',
                       'total_concept_class_ct_2',
                       'total_vocabulary_ct_2')
))

#' @title ancestor.edges S4 class
#' @slot data edges dataframe
#' @slot required_fields required fields for a edges s4 class object
#' @slot attribute_fields fields denoting edge attributes
#' @export

ancestor.edges <-
  setClass(
    Class = "ancestor.edges",
    slots = c(data = "data.frame",
              required_fields = "character",
              attribute_fields = "character",
              tooltip_fields = "character",
              edge_fields = "character"),
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
                       'decorate'),
                     tooltip_fields =
                       c('id',
                         'from',
                         'to',
                         'min_levels_of_separation',
                         'max_levels_of_separation',
                         'ancestor_to_descendant_count',
                         'concept_1_coverage',
                         'concept_2_coverage',
                         'ancestor_domain_id',
                         'ancestor_vocabulary_id',
                         'ancestor_concept_class_id',
                         'ancestor_standard_concept',
                         #'concept_count_1',
                         'ancestor_total_concept_class_ct',
                         'ancestor_total_vocabulary_ct',
                         'descendant_domain_id',
                         'descendant_vocabulary_id',
                         'descendant_concept_class_id',
                         'descendant_standard_concept',
                         #'concept_count_2',
                         'descendant_total_concept_class_ct',
                         'descendant_total_vocabulary_ct'),
                     edge_fields =
                       c(
                         'min_levels_of_separation',
                         'max_levels_of_separation',
                         'ancestor_to_descendant_count',
                         'ancestor_domain_id',
                         'ancestor_vocabulary_id',
                         'ancestor_concept_class_id',
                         'ancestor_standard_concept',
                         #'concept_count_1',
                         'ancestor_total_concept_class_ct',
                         'ancestor_total_vocabulary_ct',
                         'descendant_domain_id',
                         'descendant_vocabulary_id',
                         'descendant_concept_class_id',
                         'descendant_standard_concept',
                         #'concept_count_2',
                         'descendant_total_concept_class_ct',
                         'descendant_total_vocabulary_ct')
    ))


#' @title edges S4 class
#' @slot data edges dataframe
#' @slot required_fields required fields for a edges s4 class object
#' @slot attribute_fields fields denoting edge attributes
#' @export

complete.edges <-
  setClass(
    Class = "complete.edges",
    slots = c(data = "data.frame",
              required_fields = "character",
              attribute_fields = "character",
              tooltip_fields = "character",
              edge_fields = "character"),
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
                       'decorate'),
                     tooltip_fields =
                       c('id',
                         'from',
                         'to',
                         'relationship_id',
                         'relationship_name',
                         'relationship_source',
                         'is_hierarchical',
                         'defines_ancestry',
                         'concept_1_coverage',
                         'concept_2_coverage',
                         'domain_id_1',
                         'vocabulary_id_1',
                         'concept_class_id_1',
                         'standard_concept_1',
                         'invalid_reason_1',
                         'concept_count_1',
                         'complete_concept_class_ct_1',
                         'complete_vocabulary_ct_1',
                         'domain_id_2',
                         'vocabulary_id_2',
                         'concept_class_id_2',
                         'standard_concept_2',
                         'invalid_reason_2',
                         'concept_count_2',
                         'complete_concept_class_ct_2',
                         'complete_vocabulary_ct_2'),
                     edge_fields =
                       c('relationship_id',
                         'relationship_name',
                         'relationship_source',
                         'is_hierarchical',
                         'defines_ancestry',
                         'domain_id_1',
                         'vocabulary_id_1',
                         'concept_class_id_1',
                         'standard_concept_1',
                         'invalid_reason_1',
                         'concept_count_1',
                         'complete_concept_class_ct_1',
                         'complete_vocabulary_ct_1',
                         'domain_id_2',
                         'vocabulary_id_2',
                         'concept_class_id_2',
                         'standard_concept_2',
                         'invalid_reason_2',
                         'concept_count_2',
                         'complete_concept_class_ct_2',
                         'complete_vocabulary_ct_2')
    ))



#' @title nodes.and.edges S4 class
#' @export

nodes.and.edges <-
  setClass("nodes.and.edges",
           list(nodes = "nodes",
                edges = "edges",
                overlapping_fields = "character",
                has_tooltip = "logical",
                has_node_attrs = "logical",
                has_edge_attrs = "logical"),
           prototype = list(has_tooltip = FALSE,
                            has_node_attrs = FALSE,
                            has_edge_attrs = FALSE))

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


setOldClass("dgr_graph")
omop.graph <-
  setClass("omop.graph",
           slots    = c(graph = "dgr_graph",
                        src   = "nodes.and.edges",
                        has_example_concepts = "logical"),
           prototype = list(has_example_concepts = FALSE))


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


validEdgeRows <-
  function(object) {

    if (nrow(object@data) == max(object@data$id)) {

      TRUE

    } else {


      glue::glue("There are {nrow(object@data)} row{?s} in the edge dataframe, but the max `id`
                 is {max(object@data$id)}.")

    }


  }

validEdgeCount <-
  function(object) {

    if (nrow(object@data) == nrow(object@data %>% dplyr::distinct(label_1, label_2, relationship_id))) {


      TRUE


    } else {

      glue::glue("There are {nrow(object@data %>% dplyr::distinct(label_1, label_2, relationship_id))} unique edge{?s} (defined by unique combinations of label_1, label_2, and relationship_id) while there are {nrow(object@data)} row{?s} in `edges`.")


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

setValidity(
  Class = "edges",
  method = validEdgeRows
)

setValidity(
  Class = "edges",
  method = validEdgeCount
)


setValidity(
  Class = "complete.nodes",
  method = validNE
)


setValidity(
  Class = "complete.nodes",
  method = validNodeCount
)

setValidity(
  Class = "complete.nodes",
  method = validNodeRows
)

setValidity(
  Class = "complete.edges",
  method = validNE
)

setValidity(
  Class = "complete.edges",
  method = validEdgeRows
)

setValidity(
  Class = "complete.edges",
  method = validEdgeCount
)

setValidity(
  Class = "ancestor.nodes",
  method = validNE
)


setValidity(
  Class = "ancestor.nodes",
  method = validNodeCount
)

setValidity(
  Class = "ancestor.nodes",
  method = validNodeRows
)

setValidity(
  Class = "ancestor.edges",
  method = validNE
)

setValidity(
  Class = "ancestor.edges",
  method = validEdgeRows
)

setValidity(
  Class = "ancestor.edges",
  method = validEdgeCount
)

validNodeId <-
  function(object) {

    if (all(!is.na(object@nodes@data$id))) {

      TRUE

    } else {

      glue::glue("Some `id` are <NA>.")
    }




  }


validEdgeId <-
  function(object) {

    if (all(!is.na(object@edges@data$id))) {

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
