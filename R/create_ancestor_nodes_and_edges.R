#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_ancestors PARAM_DESCRIPTION
#' @param type_from PARAM_DESCRIPTION, Default: concept_class_id
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname create_ancestor_nodes_and_edges
#' @export
#' @import dplyr
#' @importFrom stringr str_remove_all
#' @importFrom tibble rowid_to_column
#' @importFrom glue glue
#' @importFrom cli cli_warn
create_ancestor_nodes_and_edges <-
  function(omop_ancestors,
           type_from = concept_class_id,
           label_glue = "{vocabulary_id}\n{concept_class_id}\n({standard_concept})\n") {

    if (nrow(omop_ancestors@data) == 0) {

      cli::cli_abort("There are 0 ancestors in the omop.ancestors!")

    }


    ccr_df <- omop_ancestors@data

    type_from <- dplyr::enquo(type_from)

    omop_node <-
      dplyr::bind_rows(
        ccr_df %>%
          dplyr::select(starts_with("ancestor_")) %>%
          dplyr::rename_all(stringr::str_remove_all, "ancestor_"),
        ccr_df %>%
          dplyr::select(dplyr::starts_with("descendant_")) %>%
          dplyr::rename_all(stringr::str_remove_all, "descendant_")) %>%
      dplyr::mutate(type = !!type_from) %>%
      dplyr::mutate(label = glue::glue(label_glue)) %>%
      dplyr::select(-concept_count) %>%
      dplyr::distinct() %>%
      tibble::rowid_to_column("id")


    # Add ancestor_label and descendant_label fields
    omop_edge <-
      dplyr::bind_cols(
        ccr_df %>%
          dplyr::select(dplyr::starts_with("ancestor_")) %>%
          dplyr::rename_at(dplyr::vars(dplyr::starts_with("ancestor_")),
                           stringr::str_remove_all, "ancestor_") %>%
          dplyr::mutate(ancestor_label = glue::glue(label_glue)) %>%
          dplyr::select(ancestor_label),
        ccr_df %>%
          dplyr::select(dplyr::starts_with("descendant_")) %>%
          dplyr::rename_at(dplyr::vars(dplyr::starts_with("descendant_")),
                           stringr::str_remove_all, "descendant_") %>%
          dplyr::mutate(descendant_label = glue::glue(label_glue)) %>%
          dplyr::select(descendant_label),
        ccr_df)


    # Join by any matches to "(^.*)_[1,2]"

    omop_edge2 <-
      omop_edge %>%
      dplyr::left_join(omop_node %>%
                         dplyr::rename(from = id) %>%
                         dplyr::rename_at(dplyr::vars(!from),
                                          ~paste0("ancestor_", .)),
                       by = c("ancestor_label", "ancestor_domain_id", "ancestor_vocabulary_id", "ancestor_concept_class_id", "ancestor_standard_concept", "ancestor_total_vocabulary_ct", "ancestor_total_concept_class_ct")) %>%
      dplyr::distinct() %>%
      dplyr::left_join(omop_node %>%
                         dplyr::rename(to = id) %>%
                         dplyr::rename_at(dplyr::vars(!to),
                                          ~paste0("descendant_", .)),
                       by = c("descendant_label", "descendant_domain_id", "descendant_vocabulary_id", "descendant_concept_class_id", "descendant_standard_concept", "descendant_total_vocabulary_ct", "descendant_total_concept_class_ct")) %>%
      dplyr::distinct() %>%
      dplyr::mutate(ancestor_concept_coverage_frac = glue::glue("{ancestor_concept_count}/{ancestor_total_concept_class_ct}"),
                    descendant_concept_coverage_frac = glue::glue("{descendant_concept_count}/{descendant_total_concept_class_ct}")) %>%
      dplyr::mutate(ancestor_concept_coverage = purrr::map(ancestor_concept_coverage_frac, function(x) scales::percent(eval(rlang::parse_expr(x))))) %>%
      dplyr::mutate(descendant_concept_coverage = purrr::map(descendant_concept_coverage_frac, function(x) scales::percent(eval(rlang::parse_expr(x))))) %>%
      dplyr::mutate(ancestor_concept_coverage = unlist(ancestor_concept_coverage)) %>%
      dplyr::mutate(descendant_concept_coverage = unlist(descendant_concept_coverage)) %>%
      # Extra step with ancestors
      dplyr::mutate(rel =
                      dplyr::case_when(min_levels_of_separation == max_levels_of_separation ~ as.character(min_levels_of_separation),
                                       TRUE ~ sprintf("%s:%s", min_levels_of_separation, max_levels_of_separation))) %>%
      dplyr::mutate(label = rel) %>%
      dplyr::distinct() %>%
      tibble::rowid_to_column("id")


    if (nrow(ccr_df) != nrow(omop_edge2)) {


      cli::cli_warn("Modified edges contains different row count than provided edges.")

      return(list(edges = ccr_df,
                  modified_edges = omop_edge2))

    }

    omopNode <-
      new("ancestor.nodes",
          data = omop_node)

    omopEdge <-
      new("ancestor.edges",
          data = omop_edge2 %>%
                  dplyr::arrange(as.integer(min_levels_of_separation),
                                 as.integer(max_levels_of_separation)))

    edge_cols <-
      colnames(omopEdge@data) %>%
      grep(pattern = "^ancestor_|^descendant_",
           value   = TRUE) %>%
      stringr::str_remove_all(pattern = "^ancestor_|^descendant_") %>%
      unique()

    overlapping_fields <-
      colnames(omopNode@data)[colnames(omopNode@data) %in% edge_cols]
    overlapping_fields <-
      overlapping_fields[!(overlapping_fields %in% c("id", "label"))]

    new("ancestor.nodes.and.edges",
        nodes = omopNode,
        edges = omopEdge,
        overlapping_fields = overlapping_fields)

  }
