#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_relationships PARAM_DESCRIPTION
#' @param type_from PARAM_DESCRIPTION, Default: concept_class_id
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname create_complete_nodes_and_edges
#' @export
#' @import dplyr
#' @importFrom stringr str_remove_all
#' @importFrom tibble rowid_to_column
#' @importFrom glue glue
#' @importFrom cli cli_warn
create_complete_nodes_and_edges <-
  function(complete_omop_relationships,
           type_from = invalid_reason,
           label_glue = "{ifelse(is.na(invalid_reason), 'V', invalid_reason)}\n{vocabulary_id}\n{concept_class_id}\n({standard_concept})\n") {

    if (nrow(complete_omop_relationships$data) == 0) {

      cli::cli_abort("There are 0 relationships in the complete.omop.relationship!")

    }

    omop_relationships <- complete_omop_relationships
    ccr_df <- omop_relationships$data

    type_from <- dplyr::enquo(type_from)

    omop_node <-
      dplyr::bind_rows(
        ccr_df %>%
          dplyr::select(ends_with("_1")) %>%
          dplyr::rename_all(stringr::str_remove_all, "_1"),
        ccr_df %>%
          dplyr::select(ends_with("_2")) %>%
          dplyr::rename_all(stringr::str_remove_all, "_2")) %>%
      dplyr::mutate(type = !!type_from) %>%
      dplyr::mutate(label = glue::glue(label_glue)) %>%
      dplyr::select(-concept_count) %>%
      dplyr::distinct() %>%
      tibble::rowid_to_column("id")


    # Add label_1 and label_2 fields
    omop_edge <-
      dplyr::bind_cols(
        ccr_df %>%
          dplyr::select(dplyr::ends_with("_1")) %>%
          dplyr::rename_at(dplyr::vars(dplyr::ends_with("_1")),
                           stringr::str_remove_all, "_1") %>%
          dplyr::mutate(label_1 = glue::glue(label_glue)) %>%
          dplyr::select(label_1),
        ccr_df %>%
          dplyr::select(dplyr::ends_with("_2")) %>%
          dplyr::rename_at(dplyr::vars(dplyr::ends_with("_2")),
                           stringr::str_remove_all, "_2") %>%
          dplyr::mutate(label_2 = glue::glue(label_glue)) %>%
          dplyr::select(label_2),
        ccr_df)


    # Join by any matches to "(^.*)_[1,2]"

    omop_edge2 <-
      omop_edge %>%
      dplyr::left_join(omop_node %>%
                         dplyr::rename(from = id) %>%
                         dplyr::rename_at(dplyr::vars(!from),
                                          ~paste0(., "_1")),
                       by = c("label_1",
                              "domain_id_1",
                              "vocabulary_id_1",
                              "concept_class_id_1",
                              "standard_concept_1",
                              "invalid_reason_1",
                              "complete_concept_class_ct_1",
                              "complete_vocabulary_ct_1")) %>%
      dplyr::distinct() %>%
      dplyr::left_join(omop_node %>%
                         dplyr::rename(to = id) %>%
                         dplyr::rename_at(dplyr::vars(!to),
                                          ~paste0(., "_2")),
                       by = c("label_2",
                              "domain_id_2",
                              "vocabulary_id_2",
                              "concept_class_id_2",
                              "standard_concept_2",
                              "invalid_reason_2",
                              "complete_concept_class_ct_2",
                              "complete_vocabulary_ct_2")) %>%
      dplyr::distinct() %>%
      dplyr::mutate(concept_1_coverage_frac = glue::glue("{concept_count_1}/{complete_concept_class_ct_1}"),
                    concept_2_coverage_frac = glue::glue("{concept_count_2}/{complete_concept_class_ct_2}")) %>%
      dplyr::mutate(concept_1_coverage = purrr::map(concept_1_coverage_frac, function(x) scales::percent(eval(rlang::parse_expr(x))))) %>%
      dplyr::mutate(concept_2_coverage = purrr::map(concept_2_coverage_frac, function(x) scales::percent(eval(rlang::parse_expr(x))))) %>%
      dplyr::mutate(concept_1_coverage = unlist(concept_1_coverage)) %>%
      dplyr::mutate(concept_2_coverage = unlist(concept_2_coverage)) %>%
      dplyr::mutate(rel = relationship_id,
                    label = relationship_name) %>%
      tibble::rowid_to_column("id")


    if (nrow(ccr_df) != nrow(omop_edge2)) {


      cli::cli_warn("Modified edges contains different row count than provided edges.")

      return(list(edges = ccr_df,
                  modified_edges = omop_edge2))

    }

    omopNode <-
      new("complete.nodes",
          data = omop_node)

    omopEdge <-
      new("complete.edges",
          data = omop_edge2)

    edge_cols <-
      colnames(omopEdge@data) %>%
      grep(pattern = "_1$|_2$",
           value   = TRUE) %>%
      stringr::str_remove_all(pattern = "_1$|_2$") %>%
      unique()

    overlapping_fields <-
      colnames(omopNode@data)[colnames(omopNode@data) %in% edge_cols]
    overlapping_fields <-
      overlapping_fields[!(overlapping_fields %in% c("id", "label"))]

    new("complete.nodes.and.edges",
        nodes = omopNode,
        edges = omopEdge,
        overlapping_fields = overlapping_fields,
        has_tooltip = FALSE,
        has_node_attrs = FALSE,
        has_edge_attrs = FALSE)

  }
