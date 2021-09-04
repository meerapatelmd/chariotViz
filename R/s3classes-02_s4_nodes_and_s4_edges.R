#' @title nodes S3 class
#' @slot data nodes dataframe
#' @slot required_fields required fields for a nodes s4 class object
#' @slot attribute_fields fields denoting node attributes
#' @export

new_chariotVizNodes <-
  function(x = tibble::tibble(),
           required_fields = NULL,
           attribute_fields = NULL,
           tooltip_fields = NULL,
           node_fields = NULL,
           integer_fields = NULL,
           legend_fields = NULL) {


    structure(x,
              required_fields = required_fields,
              attribute_fields = attribute_fields,
              tooltip_fields = tooltip_fields,
              node_fields = node_fields,
              integer_fields = integer_fields,
              legend_fields = legend_fields,
              class = c("chariotVizNodes", "tbl_df", "tbl", "data.frame"))

  }


print.chariotVizNodes <-
  function(x,max.rows = 3) {

    cli::cli_h1(glue::glue("{class(x)[1]}"))
    cli::cli_h3("Summary")
    summarize_data <-
    function (data,
              names_to = "Variable",
              values_to = "Value") {

      char_funs <- list(COUNT = ~length(.),
                        DISTINCT_COUNT = ~length(unique(.)),
                        NA_COUNT = ~length(.[is.na(.)]),
                        NA_STR_COUNT = ~length(.[. %in% c("NA", "#N/A", "NaN", "NAN")]),
                        BLANK_COUNT = ~length(.[. %in% c("")]),
                        SPACE_COUNT = ~length(grep(pattern = "^[ ]{1,}$", x = .)))

        main_output <-
          data %>%
          dplyr::mutate_all(as.character) %>%
          tidyr::pivot_longer(
            cols = dplyr::everything(),
            names_to = names_to,
            values_to = values_to,
            values_drop_na = FALSE) %>%
          dplyr::group_by_at(dplyr::vars(dplyr::all_of(names_to))) %>%
          dplyr::summarize_at(dplyr::vars(dplyr::all_of(values_to)),
                              char_funs)

      DISTINCT_VALUES <- list()
      variables <- unlist(main_output[, names_to])
      for (i in seq_along(variables)) {
        DISTINCT_VALUES[[i]] <- data %>% select_at(vars(all_of(variables[i]))) %>%
          mutate_at(vars(all_of(variables[i])), factor) %>%
          unlist() %>% unname() %>% forcats::fct_count(sort = TRUE,
                                                       prop = TRUE)
      }
      names(DISTINCT_VALUES) <- variables
      main_output$DISTINCT_VALUES <- DISTINCT_VALUES
      main_output_b <-
        lapply(data, class) %>%
        purrr::map(
          ~tibble::as_tibble_col(
            x = .,
            column_name = "DTYPE")) %>%
        bind_rows(.id = names_to)

      main_output <-
        main_output_b %>%
        left_join(main_output, by = names_to) %>%
        distinct()

      main_output
    }

    group_by_cols <-
      attributes(x)$node_fields[!(attributes(x)$node_fields %in% attributes(x)$integer_fields)]
    summary_data <-
    x %>%
      dplyr::select(dplyr::all_of(group_by_cols)) %>%
      summarize_data()

    print.data.frame(summary_data,
                     row.names = FALSE)

    cli::cli_h3("Data")
    print.data.frame(head(x,max.rows),
                     row.names = FALSE)

    if (nrow(x)-max.rows>0) {
      cli::cat_line(cli::style_italic(glue::glue("...{nrow(x)-max.rows} more rows")))

    }
  }



new_chariotVizNodes(x = tibble(A = 1:3))


new_chariotVizValidNodes <-
  function(x = tibble::tibble(),
           required_fields = c("id", "type", "label"),
           attribute_fields =
            c(
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
             'margin'),
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
               'total_vocabulary_ct'),
           integer_fields =
             c("total_concept_class_ct",
               "total_vocabulary_ct"),
           legend_fields =
             c("id",
               "domain_id",
               "vocabulary_id",
               "concept_class_id",
               "standard_concept",
               "total_concept_class_ct",
               "total_vocabulary_ct",
               'shape',
               'style',
               'penwidth',
               'color',
               'fillcolor',
               'fontcolor')) {


    structure(x,
              required_fields = required_fields,
              attribute_fields = attribute_fields,
              tooltip_fields = tooltip_fields,
              node_fields = node_fields,
              integer_fields = integer_fields,
              legend_fields = legend_fields,
              class = c("chariotVizValidNodes",
                        "chariotVizNodes",
                        "tbl_df", "tbl", "data.frame"))



  }


new_chariotVizCompleteNodes <-
  function(x = tibble::tibble(),
           required_fields = c("id", "type", "label"),
           attribute_fields =
             c(
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
               'concept_class_invalid_reason_ct',
               'valid_concept_ct',
               'updated_concept_ct',
               'deprecated_concept_ct',
               'complete_concept_class_ct',
               'complete_vocabulary_ct'),
           node_fields =
             c('domain_id',
               'vocabulary_id',
               'concept_class_id',
               'standard_concept',
               'invalid_reason',
               'concept_class_invalid_reason_ct',
               'valid_concept_ct',
               'updated_concept_ct',
               'deprecated_concept_ct',
               'complete_concept_class_ct',
               'complete_vocabulary_ct'),
           integer_fields =
             c('concept_class_invalid_reason_ct',
               'valid_concept_ct',
               'updated_concept_ct',
               'deprecated_concept_ct',
               'complete_concept_class_ct',
               'complete_vocabulary_ct'),
           legend_fields =
             c('id',
               'domain_id',
               'vocabulary_id',
               'concept_class_id',
               'standard_concept',
               'invalid_reason',
               'concept_class_invalid_reason_ct',
               'valid_concept_ct',
               'updated_concept_ct',
               'deprecated_concept_ct',
               'complete_concept_class_ct',
               'complete_vocabulary_ct',
               'shape',
               'style',
               'penwidth',
               'color',
               'fillcolor',
               'fontcolor')) {


    structure(x,
              required_fields = required_fields,
              attribute_fields = attribute_fields,
              tooltip_fields = tooltip_fields,
              node_fields = node_fields,
              integer_fields = integer_fields,
              legend_fields = legend_fields,
              class = c("chariotVizValidNodes",
                        "chariotVizNodes",
                        "tbl_df", "tbl", "data.frame"))



  }


test_cVvN <- new_chariotVizValidNodes(x = tibble(A = 1:3))

test_hemOnc <- new_chariotVizValidNodes(x = test_chariotRels$data %>%
                                              select(ends_with("_1")) %>%
                                              rename_all(str_remove_all,
                                                         "_1$"))
test_hemOnc


nodes <-
  setClass(
    Class = "nodes",
    slots = c(data = "data.frame",
              required_fields = "character",
              attribute_fields = "character",
              tooltip_fields = "character",
              node_fields = "character",
              integer_fields = "character",
              legend_fields = "character"),
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
                         'total_vocabulary_ct'),
                     integer_fields =
                       c("total_concept_class_ct",
                         "total_vocabulary_ct"),
                     legend_fields =
                       c("id",
                         "domain_id",
                         "vocabulary_id",
                         "concept_class_id",
                         "standard_concept",
                         "total_concept_class_ct",
                         "total_vocabulary_ct",
                         'shape',
                         'style',
                         'penwidth',
                         'color',
                         'fillcolor',
                         'fontcolor')

                     )
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
              node_fields = "character",
              integer_fields = "character",
              legend_fields = "character"),
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
                         'concept_class_invalid_reason_ct',
                         'valid_concept_ct',
                         'updated_concept_ct',
                         'deprecated_concept_ct',
                         'complete_concept_class_ct',
                         'complete_vocabulary_ct'),
                     node_fields =
                       c('domain_id',
                         'vocabulary_id',
                         'concept_class_id',
                         'standard_concept',
                         'invalid_reason',
                         'concept_class_invalid_reason_ct',
                         'valid_concept_ct',
                         'updated_concept_ct',
                         'deprecated_concept_ct',
                         'complete_concept_class_ct',
                         'complete_vocabulary_ct'),
                     integer_fields =
                       c('concept_class_invalid_reason_ct',
                         'valid_concept_ct',
                         'updated_concept_ct',
                         'deprecated_concept_ct',
                         'complete_concept_class_ct',
                         'complete_vocabulary_ct'),
                     legend_fields =
                       c('id',
                         'domain_id',
                         'vocabulary_id',
                         'concept_class_id',
                         'standard_concept',
                         'invalid_reason',
                         'concept_class_invalid_reason_ct',
                         'valid_concept_ct',
                         'updated_concept_ct',
                         'deprecated_concept_ct',
                         'complete_concept_class_ct',
                         'complete_vocabulary_ct',
                         'shape',
                         'style',
                         'penwidth',
                         'color',
                         'fillcolor',
                         'fontcolor')


                     )
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
              node_fields = "character",
              integer_fields = "character"),
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
                         'concept_count',
                         'total_concept_class_ct',
                         'total_vocabulary_ct'),
                     node_fields =
                       c('domain_id',
                         'vocabulary_id',
                         'concept_class_id',
                         'standard_concept',
                         'concept_count',
                         'total_concept_class_ct',
                         'total_vocabulary_ct'),
                     integer_fields =
                       c(
                         'total_concept_class_ct',
                         'total_vocabulary_ct')
                       )
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
              edge_fields = "character",
              integer_fields = "character",
              legend_fields = "character"),
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
                         'total_vocabulary_ct_2'),
                     integer_fields =
                       c('concept_count_1',
                         'total_concept_class_ct_1',
                         'total_vocabulary_ct_1',
                         'concept_count_2',
                         'total_concept_class_ct_2',
                         'total_vocabulary_ct_2'),
                     legend_fields =
                       c(
                         'id',
                         'relationship_id',
                         'relationship_name',
                         'is_hierarchical',
                         'defines_ancestry',
                         'concept_1_coverage',
                         'concept_1_coverage_frac',
                         'concept_2_coverage',
                         'concept_2_coverage_frac',
                         'style',
                         'penwidth',
                         'color',
                         'arrowsize',
                         'arrowhead',
                         'arrowtail',
                         'fontcolor',
                         'labelfontcolor')
                       )
    )

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
              edge_fields = "character",
              integer_fields = "character"),
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
                         'ancestor_concept_coverage',
                         'descendant_concept_coverage',
                         'ancestor_domain_id',
                         'ancestor_vocabulary_id',
                         'ancestor_concept_class_id',
                         'ancestor_standard_concept',
                         'ancestor_concept_count',
                         'ancestor_total_concept_class_ct',
                         'ancestor_total_vocabulary_ct',
                         'descendant_domain_id',
                         'descendant_vocabulary_id',
                         'descendant_concept_class_id',
                         'descendant_standard_concept',
                         'descendant_concept_count',
                         'descendant_total_concept_class_ct',
                         'descendant_total_vocabulary_ct'),
                     edge_fields =
                       c(
                         'min_levels_of_separation',
                         'max_levels_of_separation',
                         'ancestor_concept_coverage',
                         'descendant_concept_coverage',
                         'ancestor_domain_id',
                         'ancestor_vocabulary_id',
                         'ancestor_concept_class_id',
                         'ancestor_standard_concept',
                         'ancestor_concept_count',
                         'ancestor_total_concept_class_ct',
                         'ancestor_total_vocabulary_ct',
                         'descendant_domain_id',
                         'descendant_vocabulary_id',
                         'descendant_concept_class_id',
                         'descendant_standard_concept',
                         'descendant_concept_count',
                         'descendant_total_concept_class_ct',
                         'descendant_total_vocabulary_ct'),
                     integer_fields =
                       c(
                         'ancestor_concept_count',
                         'ancestor_total_concept_class_ct',
                         'ancestor_total_vocabulary_ct',
                         'descendant_concept_count',
                         'descendant_total_concept_class_ct',
                         'descendant_total_vocabulary_ct'))
    )


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
              edge_fields = "character",
              integer_fields = "character",
              legend_fields = "character"),
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
                         'concept_class_invalid_reason_ct_1',
                         'valid_concept_ct_1',
                         'updated_concept_ct_1',
                         'deprecated_concept_ct_1',
                         'concept_count_1',
                         'complete_concept_class_ct_1',
                         'complete_vocabulary_ct_1',
                         'domain_id_2',
                         'vocabulary_id_2',
                         'concept_class_id_2',
                         'standard_concept_2',
                         'invalid_reason_2',
                         'concept_class_invalid_reason_ct_2',
                         'valid_concept_ct_2',
                         'updated_concept_ct_2',
                         'deprecated_concept_ct_2',
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
                         'concept_class_invalid_reason_ct_1',
                         'valid_concept_ct_1',
                         'updated_concept_ct_1',
                         'deprecated_concept_ct_1',
                         'concept_count_1',
                         'complete_concept_class_ct_1',
                         'complete_vocabulary_ct_1',
                         'domain_id_2',
                         'vocabulary_id_2',
                         'concept_class_id_2',
                         'standard_concept_2',
                         'invalid_reason_2',
                         'concept_class_invalid_reason_ct_2',
                         'valid_concept_ct_2',
                         'updated_concept_ct_2',
                         'deprecated_concept_ct_2',
                         'concept_count_2',
                         'complete_concept_class_ct_2',
                         'complete_vocabulary_ct_2'),
                     integer_fields =
                       c('concept_class_invalid_reason_ct_1',
                         'valid_concept_ct_1',
                         'updated_concept_ct_1',
                         'deprecated_concept_ct_1',
                         'concept_count_1',
                         'complete_concept_class_ct_1',
                         'complete_vocabulary_ct_1',
                         'concept_class_invalid_reason_ct_2',
                         'valid_concept_ct_2',
                         'updated_concept_ct_2',
                         'deprecated_concept_ct_2',
                         'concept_count_2',
                         'complete_concept_class_ct_2',
                         'complete_vocabulary_ct_2'),
                     legend_fields =
                       c('id',
                         'relationship_id',
                         'relationship_name',
                         'is_hierarchical',
                         'defines_ancestry',
                         'concept_1_coverage',
                         'concept_1_coverage_frac',
                         'concept_2_coverage',
                         'concept_2_coverage_frac',
                         'style',
                         'penwidth',
                         'color',
                         'arrowsize',
                         'arrowhead',
                         'arrowtail',
                         'fontcolor',
                         'labelfontcolor')
    ))


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


validEdgeCountAncestors <-
  function(object) {

    if (nrow(object@data) == nrow(object@data %>% dplyr::distinct(ancestor_label, descendant_label, min_levels_of_separation, max_levels_of_separation))) {


      TRUE


    } else {

      glue::glue("There are {nrow(object@data %>% dplyr::distinct(label_1, label_2, rel))} unique edge{?s} (defined by unique combinations of ancestor_label, descendant_label, min_levels_of_separation, and max_levels_of_separation) while there are {nrow(object@data)} row{?s} in `edges`.")


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
  method = validEdgeCountAncestors
)
