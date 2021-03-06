#' @title
#' Fetch OMOP Ancestors
#'
#' @description
#' Fetch concept class ancestry in a
#' Postgres instance of the OMOP vocabularies.
#'
#' @param conn PARAM_DESCRIPTION
#' @param conn_fun PARAM_DESCRIPTION, Default: 'pg13::local_connect(verbose=FALSE)'
#' @param type_from PARAM_DESCRIPTION, Default: concept_class_id
#' @param schema PARAM_DESCRIPTION, Default: 'omop_vocabulary'
#' @param verbose PARAM_DESCRIPTION, Default: FALSE
#' @param render_sql PARAM_DESCRIPTION, Default: FALSE
#' @param version_key A list object that serves
#' as the hash for caching. Set to NULL to cache under a generic hash.
#' @return OUTPUT_DESCRIPTION
#'
#' @rdname fetch_omop_ancestors
#' @export
#' @importFrom glue glue
#' @import cli
#' @importFrom pg13 query
#' @importFrom rlang list2
#' @importFrom dplyr arrange distinct select any_of left_join bind_rows rename mutate mutate_at vars
#' @importFrom purrr transpose map reduce
#' @importFrom tidyr extract pivot_wider
fetch_omop_ancestors <-
  function(...,
           conn,
           conn_fun = "pg13::local_connect(verbose=FALSE)",
           schema = "omop_vocabulary",
           verbose = FALSE,
           render_sql = FALSE,
           version_key) {

    stopifnot(!missing(version_key))
    # Converted to list for consumption by R.cache
    if (is.null(version_key)) {
      version_key <- list(NULL)
    }
    stopifnot(is.list(version_key))

    sql <- read_sql_template(file = "total_concept_class_ct.sql")
    sql <- glue::glue(sql)

    cli::cli_progress_step("Getting total concept class counts")
    total_concept_class_ct <-
      load_from_cache(sql = sql,
                      version_key = version_key)

    if (is.null(total_concept_class_ct)) {

      total_concept_class_ct <-
        pg13::query(
          conn = conn,
          checks = "",
          conn_fun = conn_fun,
          sql_statement = sql,
          verbose = verbose,
          render_sql = render_sql)

      save_to_cache(resultset = total_concept_class_ct,
                    sql       = sql,
                    version_key = version_key)

    }
    Sys.sleep(0.5)

    sql <- read_sql_template(file = "total_vocabulary_ct.sql")
    sql <- glue::glue(sql)

    cli::cli_progress_step("Getting total vocabulary counts")
    total_vocabulary_ct <-
      load_from_cache(sql = sql,
                      version_key = version_key)

    if (is.null(total_vocabulary_ct)) {

      total_vocabulary_ct <-
        pg13::query(
          conn = conn,
          checks = "",
          conn_fun = conn_fun,
          sql_statement = sql,
          verbose = verbose,
          render_sql = render_sql)

      save_to_cache(resultset = total_vocabulary_ct,
                    sql       = sql,
                    version_key = version_key)

    }
    Sys.sleep(0.5)


    if (!missing(...)) {


      vocabulary_ids <- unlist(rlang::list2(...))

    } else {

      vocabulary_ids <-
        total_vocabulary_ct %>%
        dplyr::arrange(total_vocabulary_ct) %>%
        dplyr::distinct(vocabulary_id) %>%
        unlist() %>%
        unname()


    }

    ancestor_output <-
      vector(mode = "list",
             length =
               length(vocabulary_ids))
    names(ancestor_output) <- vocabulary_ids

    cli::cli_progress_bar(
      format = "\n{activity} {vocabulary_id} Relationships | {pb_bar} {pb_current}/{pb_total} {pb_percent} ({pb_elapsed})\n",
      clear = FALSE,
      total = length(vocabulary_ids))
    Sys.sleep(0.1)

    activity <- "Querying"
    for (vocabulary_id in vocabulary_ids) {

      sql <- read_sql_template(file = "ancestor.sql")
      sql <- glue::glue(sql)

      ancestor <-
        load_from_cache(sql = sql,
                        version_key = version_key)

      if (is.null(ancestor)) {
        Sys.sleep(0.5)
        ancestor <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sql,
            verbose = verbose,
            render_sql = render_sql)
        Sys.sleep(0.5)

        save_to_cache(resultset = ancestor,
                      sql       = sql,
                      version_key = version_key)

      } else {

        Sys.sleep(0.05)

      }

      ancestor_output[[vocabulary_id]] <-
        ancestor
      cli::cli_progress_update()

    }
    cli::cli_progress_done()

    ancestor_ct_output <-
      vector(mode = "list",
             length =
               length(vocabulary_ids))
    names(ancestor_ct_output) <- vocabulary_ids

    cli::cli_progress_bar(
      format = "\n{activity} {vocabulary_id} Concept Class Counts | {pb_bar} {pb_current}/{pb_total} {pb_percent} ({pb_elapsed})\n",
      clear = FALSE,
      total = length(vocabulary_ids))
    Sys.sleep(0.1)

    activity <- "Calculating"
    for (vocabulary_id in vocabulary_ids) {

      sql <- read_sql_template(file = "ancestor_ct.sql")
      sql <- glue::glue(sql)

      ancestor_ct <-
        load_from_cache(sql = sql,
                        version_key = version_key)

      if (is.null(ancestor_ct)) {

        Sys.sleep(0.5)
        ancestor_ct <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sql,
            verbose = verbose,
            render_sql = render_sql)
        Sys.sleep(0.5)

        save_to_cache(resultset = ancestor_ct,
                      sql       = sql,
                      version_key = version_key)

      } else {

        Sys.sleep(0.05)

      }
      ancestor_ct_output[[vocabulary_id]] <-
        ancestor_ct
      cli::cli_progress_update()

    }

    cli::cli_progress_done()

    omop_ancestors <-
      list(ancestors = ancestor_output,
           ancestor_counts = ancestor_ct_output) %>%
      purrr::transpose()


    omop_ancestor_errors <-
      list()

    # Check to make sure a join will not lead to duplicates
    for (vocabulary_id in vocabulary_ids) {

      ancestor_rows <-
        omop_ancestors[[vocabulary_id]]$ancestors %>%
        dplyr::select(dplyr::any_of(colnames(omop_ancestors[[vocabulary_id]]$ancestor_counts))) %>%
        dplyr::distinct() %>%
        nrow()

      ancestor_count_rows <-
        nrow(omop_ancestors[[vocabulary_id]]$ancestor_counts)

      if (ancestor_rows != ancestor_count_rows) {

        omop_ancestor_errors[[length(omop_ancestor_errors)+1]] <-
          list(ancestor_rows = ancestor_rows,
               ancestor_count_rows = ancestor_count_rows)
        names(omop_ancestor_errors)[length(omop_ancestor_errors)] <-
          vocabulary_id


      }


    }

    if (length(omop_ancestor_errors)>0) {

      cli::cli_warn("{length(omop_ancestor_errors)} error{?s} in ancestor counts found: {names(omop_ancestor_errors)}!")
      return(omop_ancestor_errors)


    }


    omop_ancestors1 <-
      omop_ancestors %>%
      purrr::map(
        purrr::reduce,
        dplyr::left_join,
        by =
          c("ancestor_domain_id",
            "ancestor_vocabulary_id",
            "ancestor_concept_class_id",
            "ancestor_standard_concept",
            "descendant_domain_id",
            "descendant_vocabulary_id",
            "descendant_concept_class_id",
            "descendant_standard_concept",
            "min_levels_of_separation",
            "max_levels_of_separation")) %>%
      purrr::map(dplyr::distinct) %>%
      dplyr::bind_rows()


    omop_ancestors2 <-
      omop_ancestors1 %>%
      dplyr::left_join(
        total_vocabulary_ct,
        by = c("ancestor_vocabulary_id" = "vocabulary_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(
        total_vocabulary_ct_1 = total_vocabulary_ct) %>%
      dplyr::left_join(
        total_vocabulary_ct,
        by = c("descendant_vocabulary_id" = "vocabulary_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(total_vocabulary_ct_2 = total_vocabulary_ct) %>%
      dplyr::distinct()

    if (nrow(omop_ancestors2) != nrow(omop_ancestors1)) {

      cli::cli_warn("Duplicates introduced when joining `total_vocabulary_ct` with `omop_ancestors`!")
      return(list(total_vocabulary_ct = total_vocabulary_ct,
                  omop_ancestors = omop_ancestors1,
                  omop_ancestors2 = omop_ancestors2))

    }

    omop_ancestors3 <-
      omop_ancestors2


    omop_ancestors4 <-
      omop_ancestors3 %>%
      dplyr::left_join(total_concept_class_ct,
                       by = c("ancestor_vocabulary_id" = "vocabulary_id",
                              "ancestor_concept_class_id" = "concept_class_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(ancestor_total_concept_class_ct = total_concept_class_ct) %>%
      dplyr::left_join(total_concept_class_ct,
                       by = c("descendant_vocabulary_id" = "vocabulary_id",
                              "descendant_concept_class_id" = "concept_class_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(descendant_total_concept_class_ct = total_concept_class_ct) %>%
      dplyr::distinct()

    if (nrow(omop_ancestors4) != nrow(omop_ancestors3)) {

      cli::cli_warn("Duplicates introduced when joining `total_vocabulary_ct` with `omop_ancestors`!")
      return(list(total_concept_class_ct = total_concept_class_ct,
                  omop_ancestors = omop_ancestors3,
                  omop_ancestors2 = omop_ancestors4))

    }

    new("omop.ancestors",
        data =
          omop_ancestors4 %>%
          dplyr::select(
            ancestor_domain_id,
            ancestor_vocabulary_id,
            ancestor_concept_class_id,
            ancestor_standard_concept,
            ancestor_concept_count,
            ancestor_total_concept_class_ct,
            ancestor_total_vocabulary_ct = total_vocabulary_ct_1,
            descendant_domain_id,
            descendant_vocabulary_id,
            descendant_concept_class_id,
            descendant_standard_concept,
            descendant_concept_count,
            descendant_total_concept_class_ct,
            descendant_total_vocabulary_ct = total_vocabulary_ct_2,
            min_levels_of_separation,
            max_levels_of_separation
            ))

  }


#' @title
#' Fetch OMOP Relationships
#'
#' @description
#' Fetch concept class relationships in a
#' Postgres instance of the OMOP vocabularies.
#'
#' @param conn PARAM_DESCRIPTION
#' @param conn_fun PARAM_DESCRIPTION, Default: 'pg13::local_connect(verbose=FALSE)'
#' @param type_from PARAM_DESCRIPTION, Default: concept_class_id
#' @param schema PARAM_DESCRIPTION, Default: 'omop_vocabulary'
#' @param verbose PARAM_DESCRIPTION, Default: FALSE
#' @param render_sql PARAM_DESCRIPTION, Default: FALSE
#' @param version_key A list object that serves
#' as the hash for caching. Set to NULL to cache under a generic hash.
#' @return OUTPUT_DESCRIPTION
#' @details
#' The OMOP vocabularies are transformed into nodes
#' and edges by first normalizing
#' OMOP concepts to their associated concept classes.
#' The distinct `concept_id` count
#' is preserved to determine the extent of coverage
#' between concept classes across
#' relationships.
#'
#' This function queries excludes invalid concepts
#' and concept relationships as well
#' as relationships to self.
#'
#' @rdname fetch_omop_relationships
#' @export
#' @importFrom glue glue
#' @import cli
#' @importFrom pg13 query
#' @importFrom rlang list2
#' @importFrom dplyr arrange distinct select any_of left_join bind_rows rename mutate mutate_at vars
#' @importFrom purrr transpose map reduce
#' @importFrom tidyr extract pivot_wider
fetch_omop_relationships <-
  function(...,
           conn,
           conn_fun = "pg13::local_connect(verbose=FALSE)",
           schema = "omop_vocabulary",
           verbose = FALSE,
           render_sql = FALSE,
           version_key) {

    stopifnot(!missing(version_key))
    # Converted to list for consumption by R.cache
    if (is.null(version_key)) {
      version_key <- list(NULL)
    }
    stopifnot(is.list(version_key))

    sql <- read_sql_template(file = "total_concept_class_ct.sql")
    sql <- glue::glue(sql)

    cli::cli_progress_step("Getting total concept class counts")
    total_concept_class_ct <-
      load_from_cache(sql = sql,
                      version_key = version_key)

    if (is.null(total_concept_class_ct)) {

      total_concept_class_ct <-
        pg13::query(
          conn = conn,
          checks = "",
          conn_fun = conn_fun,
          sql_statement = sql,
          verbose = verbose,
          render_sql = render_sql)

      save_to_cache(resultset = total_concept_class_ct,
                    sql       = sql,
                    version_key = version_key)

    }
    Sys.sleep(0.5)

    sql <- read_sql_template(file = "total_vocabulary_ct.sql")
    sql <- glue::glue(sql)

    cli::cli_progress_step("Getting total vocabulary counts")
    total_vocabulary_ct <-
      load_from_cache(sql = sql,
                      version_key = version_key)

    if (is.null(total_vocabulary_ct)) {

      total_vocabulary_ct <-
        pg13::query(
          conn = conn,
          checks = "",
          conn_fun = conn_fun,
          sql_statement = sql,
          verbose = verbose,
          render_sql = render_sql)

      save_to_cache(resultset = total_vocabulary_ct,
                    sql       = sql,
                    version_key = version_key)

    }
    Sys.sleep(0.5)


    if (!missing(...)) {


      vocabulary_ids <- unlist(rlang::list2(...))

    } else {

      vocabulary_ids <-
        total_vocabulary_ct %>%
        dplyr::arrange(total_vocabulary_ct) %>%
        dplyr::distinct(vocabulary_id) %>%
        unlist() %>%
        unname()


    }

    relationship_output <-
      vector(mode = "list",
             length =
               length(vocabulary_ids))
    names(relationship_output) <- vocabulary_ids

    cli::cli_progress_bar(
      format = "\n{activity} {vocabulary_id} Relationships | {pb_bar} {pb_current}/{pb_total} {pb_percent} ({pb_elapsed})\n",
      clear = FALSE,
      total = length(vocabulary_ids))
    Sys.sleep(0.1)

    activity <- "Querying"
    for (vocabulary_id in vocabulary_ids) {

      sql <- read_sql_template(file = "relationship.sql")
      sql <- glue::glue(sql)

      relationship <-
        load_from_cache(sql = sql,
                        version_key = version_key)

      if (is.null(relationship)) {
        Sys.sleep(0.5)
        relationship <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sql,
            verbose = verbose,
            render_sql = render_sql)
        Sys.sleep(0.5)

        save_to_cache(resultset = relationship,
                      sql       = sql,
                      version_key = version_key)

      } else {

        Sys.sleep(0.05)

      }

      relationship_output[[vocabulary_id]] <-
        relationship
      cli::cli_progress_update()

    }
    cli::cli_progress_done()

    relationship_ct_output <-
      vector(mode = "list",
             length =
               length(vocabulary_ids))
    names(relationship_ct_output) <- vocabulary_ids

    cli::cli_progress_bar(
      format = "\n{activity} {vocabulary_id} Concept Class Counts | {pb_bar} {pb_current}/{pb_total} {pb_percent} ({pb_elapsed})\n",
      clear = FALSE,
      total = length(vocabulary_ids))
    Sys.sleep(0.1)

    activity <- "Calculating"
    for (vocabulary_id in vocabulary_ids) {

      sql <- read_sql_template(file = "relationship_ct.sql")
      sql <- glue::glue(sql)

      relationship_ct <-
        load_from_cache(sql = sql,
                        version_key = version_key)

      if (is.null(relationship_ct)) {

        Sys.sleep(0.5)
        relationship_ct <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sql,
            verbose = verbose,
            render_sql = render_sql)
        Sys.sleep(0.5)

        save_to_cache(resultset = relationship_ct,
                      sql       = sql,
                      version_key = version_key)

      } else {

        Sys.sleep(0.05)

      }
      relationship_ct_output[[vocabulary_id]] <-
        relationship_ct
      cli::cli_progress_update()

    }

    cli::cli_progress_done()

    omop_relationships <-
      list(relationships = relationship_output,
           relationship_counts = relationship_ct_output) %>%
      purrr::transpose()


    omop_relationship_errors <-
      list()

    # Check to make sure a join will not lead to duplicates
    for (vocabulary_id in vocabulary_ids) {

      relationship_rows <-
        omop_relationships[[vocabulary_id]]$relationships %>%
        dplyr::select(dplyr::any_of(colnames(omop_relationships[[vocabulary_id]]$relationship_counts))) %>%
        dplyr::distinct() %>%
        nrow()

      relationship_count_rows <-
        nrow(omop_relationships[[vocabulary_id]]$relationship_counts)

      if (relationship_rows != relationship_count_rows) {

        omop_relationship_errors[[length(omop_relationship_errors)+1]] <-
          list(relationship_rows = relationship_rows,
               relationship_count_rows = relationship_count_rows)
        names(omop_relationship_errors)[length(omop_relationship_errors)] <-
          vocabulary_id

      }


    }

    if (length(omop_relationship_errors)>0) {

      cli::cli_warn("{length(omop_relationship_errors)} error{?s} in relationship counts found: {names(omop_relationship_errors)}!")
      return(omop_relationship_errors)


    }


    omop_relationships1 <-
      omop_relationships %>%
      purrr::map(
        purrr::reduce,
        dplyr::left_join,
        by =
          c("relationship_id",
            "vocabulary_id_1",
            "concept_class_id_1",
            "vocabulary_id_2",
            "concept_class_id_2")) %>%
      purrr::map(dplyr::distinct) %>%
      dplyr::bind_rows()


    omop_relationships2 <-
      omop_relationships1 %>%
      dplyr::left_join(
        total_vocabulary_ct,
        by = c("vocabulary_id_1" = "vocabulary_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(
        total_vocabulary_ct_1 = total_vocabulary_ct) %>%
      dplyr::left_join(
        total_vocabulary_ct,
        by = c("vocabulary_id_2" = "vocabulary_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(total_vocabulary_ct_2 = total_vocabulary_ct) %>%
      dplyr::distinct()

    if (nrow(omop_relationships2) != nrow(omop_relationships1)) {

      cli::cli_warn("Duplicates introduced when joining `total_vocabulary_ct` with `omop_relationships`!")
      return(list(total_vocabulary_ct = total_vocabulary_ct,
                  omop_relationships = omop_relationships1,
                  omop_relationships2 = omop_relationships2))

    }

    omop_relationships3 <-
      omop_relationships2


    omop_relationships4 <-
      omop_relationships3 %>%
      dplyr::left_join(total_concept_class_ct,
                       by = c("vocabulary_id_1" = "vocabulary_id",
                              "concept_class_id_1" = "concept_class_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(total_concept_class_ct_1 = total_concept_class_ct) %>%
      dplyr::left_join(total_concept_class_ct,
                       by = c("vocabulary_id_2" = "vocabulary_id",
                              "concept_class_id_2" = "concept_class_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(total_concept_class_ct_2 = total_concept_class_ct) %>%
      dplyr::distinct()

    if (nrow(omop_relationships4) != nrow(omop_relationships3)) {

      cli::cli_warn("Duplicates introduced when joining `total_vocabulary_ct` with `omop_relationships`!")
      return(list(total_concept_class_ct = total_concept_class_ct,
                  omop_relationships = omop_relationships3,
                  omop_relationships2 = omop_relationships4))

    }

    new("omop.relationships",
        data =
          omop_relationships4 %>%
          tidyr::extract(col = relationship_name,
                         into = "relationship_source",
                         regex = "^.*?[(]{1}(.*?)[)]{1}",
                         remove = FALSE) %>%
          dplyr::select(
            relationship_id,
            relationship_name,
            relationship_source,
            is_hierarchical,
            defines_ancestry,
            domain_id_1,
            vocabulary_id_1,
            concept_class_id_1,
            standard_concept_1,
            concept_count_1,
            total_concept_class_ct_1,
            total_vocabulary_ct_1,
            domain_id_2,
            vocabulary_id_2,
            concept_class_id_2,
            standard_concept_2,
            concept_count_2,
            total_concept_class_ct_2,
            total_vocabulary_ct_2))

  }



#' @title
#' Fetch Relationships with Deprecated Concepts
#'
#' @description
#' The difference between
#' this function and `fetch_omop_relationships` is that all
#' concepts belonging to a vocabulary are retrieved, including
#' deprecated concepts. In `fetch_omop_relationships`, `concept_class_id` matches
#' on both sides are filtered out, but here, a deprecated concept may map to a valid
#' concept within the concept concept class. For this reason, the filtering is adjusted
#' by removing relationships where concept_ids are equal instead. Invalid relationships
#' in the Concept Relationship table continue to be filtered out.
#'
#' A new field `validity_status` is introduced here, which is `invalid_reason` with
#' the NULL value recorded to 'V'.
#'
#' @param conn PARAM_DESCRIPTION
#' @param conn_fun PARAM_DESCRIPTION, Default: 'pg13::local_connect(verbose=FALSE)'
#' @param type_from PARAM_DESCRIPTION, Default: concept_class_id
#' @param schema PARAM_DESCRIPTION, Default: 'omop_vocabulary'
#' @param verbose PARAM_DESCRIPTION, Default: FALSE
#' @param render_sql PARAM_DESCRIPTION, Default: FALSE
#' @param version_key A list object that serves
#' as the hash for caching. Set to NULL to cache under a generic hash.
#' @return OUTPUT_DESCRIPTION
#' @details
#' The OMOP vocabularies are transformed into nodes
#' and edges by first normalizing
#' OMOP concepts to their associated concept classes.
#' The distinct `concept_id` count
#' is preserved to determine the extent of coverage
#' between concept classes across
#' relationships.
#'
#' This function queries excludes invalid concepts
#' and concept relationships as well
#' as relationships to self.
#'
#' @rdname fetch_complete_omop_relationships
#' @export
#' @importFrom glue glue
#' @import cli
#' @importFrom pg13 query
#' @importFrom rlang list2
#' @importFrom dplyr arrange distinct select any_of left_join bind_rows rename mutate mutate_at vars
#' @importFrom purrr transpose map reduce
#' @importFrom tidyr extract pivot_wider
fetch_complete_omop_relationships <-
  function(...,
           conn,
           conn_fun = "pg13::local_connect(verbose=FALSE)",
           schema = "omop_vocabulary",
           verbose = FALSE,
           render_sql = FALSE,
           version_key) {

    stopifnot(!missing(version_key))
    # Converted to list for consumption by R.cache
    if (is.null(version_key)) {
      version_key <- list(NULL)
    }
    stopifnot(is.list(version_key))

    sql <- read_sql_template(file = "complete_concept_class_ct.sql")
    sql <- glue::glue(sql)

    cli::cli_progress_step("Getting complete concept class counts")
    complete_concept_class_ct <-
      load_from_cache(sql = sql,
                      version_key = version_key)

    if (is.null(complete_concept_class_ct)) {

      complete_concept_class_ct <-
        pg13::query(
          conn = conn,
          checks = "",
          conn_fun = conn_fun,
          sql_statement = sql,
          verbose = verbose,
          render_sql = render_sql)

      save_to_cache(resultset = complete_concept_class_ct,
                    sql       = sql,
                    version_key = version_key)

    }
    Sys.sleep(0.5)

    sql <- read_sql_template(file = "complete_concept_class_ct_by_invalid_reason.sql")
    sql <- glue::glue(sql)

    cli::cli_progress_step("Getting complete concept class counts by invalid reason")
    complete_concept_class_ct_by_invalid_reason <-
      load_from_cache(sql = sql,
                      version_key = version_key)

    if (is.null(complete_concept_class_ct_by_invalid_reason)) {

      complete_concept_class_ct_by_invalid_reason <-
        pg13::query(
          conn = conn,
          checks = "",
          conn_fun = conn_fun,
          sql_statement = sql,
          verbose = verbose,
          render_sql = render_sql)

      save_to_cache(resultset = complete_concept_class_ct_by_invalid_reason,
                    sql       = sql,
                    version_key = version_key)

    }
    complete_concept_class_ct_by_invalid_reason2 <-
      complete_concept_class_ct_by_invalid_reason %>%
      dplyr::mutate(invalid_reason =
                      map_to_value(invalid_reason,
                                   map_assignment = c("U" = "updated_concept_ct",
                                                      `NA` = "valid_concept_ct",
                                                      "D"  = "deprecated_concept_ct"))) %>%
      tidyr::pivot_wider(id_cols = c(vocabulary_id,
                                     concept_class_id),
                         names_from = invalid_reason,
                         values_from = concept_class_invalid_reason_ct) %>%
      dplyr::mutate_at(dplyr::vars(c(updated_concept_ct,
                                     valid_concept_ct,
                                     deprecated_concept_ct)),
                       ~ifelse(is.na(.),0,.))
    Sys.sleep(0.5)

    sql <- read_sql_template(file = "complete_vocabulary_ct.sql")
    sql <- glue::glue(sql)

    cli::cli_progress_step("Getting complete vocabulary counts")
    complete_vocabulary_ct <-
      load_from_cache(sql = sql,
                      version_key = version_key)

    if (is.null(complete_vocabulary_ct)) {

      complete_vocabulary_ct <-
        pg13::query(
          conn = conn,
          checks = "",
          conn_fun = conn_fun,
          sql_statement = sql,
          verbose = verbose,
          render_sql = render_sql)

      save_to_cache(resultset = complete_vocabulary_ct,
                    sql       = sql,
                    version_key = version_key)

    }
    Sys.sleep(0.5)


    if (!missing(...)) {


      vocabulary_ids <- unlist(rlang::list2(...))

    } else {

      vocabulary_ids <-
        complete_vocabulary_ct %>%
        dplyr::arrange(complete_vocabulary_ct) %>%
        dplyr::distinct(vocabulary_id) %>%
        unlist() %>%
        unname()


    }

    relationship_output <-
      vector(mode = "list",
             length =
               length(vocabulary_ids))
    names(relationship_output) <- vocabulary_ids

    cli::cli_progress_bar(
      format = "\n{activity} {vocabulary_id} Relationships | {pb_bar} {pb_current}/{pb_total} {pb_percent} ({pb_elapsed})\n",
      clear = FALSE,
      total = length(vocabulary_ids))
    Sys.sleep(0.1)

    activity <- "Querying"
    for (vocabulary_id in vocabulary_ids) {

      sql <- read_sql_template(file = "deprecated_relationship.sql")
      sql <- glue::glue(sql)

      deprecated_relationship <-
        load_from_cache(sql = sql,
                        version_key = version_key)

      if (is.null(deprecated_relationship)) {
        Sys.sleep(0.5)
        deprecated_relationship <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sql,
            verbose = verbose,
            render_sql = render_sql)
        Sys.sleep(0.5)

        save_to_cache(resultset = deprecated_relationship,
                      sql       = sql,
                      version_key = version_key)

      } else {

        Sys.sleep(0.05)

      }

      relationship_output[[vocabulary_id]] <-
        deprecated_relationship
      cli::cli_progress_update()

    }
    cli::cli_progress_done()

    relationship_ct_output <-
      vector(mode = "list",
             length =
               length(vocabulary_ids))
    names(relationship_ct_output) <- vocabulary_ids

    cli::cli_progress_bar(
      format = "\n{activity} {vocabulary_id} Concept Class Counts | {pb_bar} {pb_current}/{pb_total} {pb_percent} ({pb_elapsed})\n",
      clear = FALSE,
      total = length(vocabulary_ids))
    Sys.sleep(0.1)

    activity <- "Calculating"
    for (vocabulary_id in vocabulary_ids) {

      sql <- read_sql_template(file = "deprecated_relationship_ct.sql")
      sql <- glue::glue(sql)

      deprecated_relationship_ct <-
        load_from_cache(sql = sql,
                        version_key = version_key)

      if (is.null(deprecated_relationship_ct)) {

        Sys.sleep(0.5)
        deprecated_relationship_ct <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sql,
            verbose = verbose,
            render_sql = render_sql)
        Sys.sleep(0.5)

        save_to_cache(resultset = deprecated_relationship_ct,
                      sql       = sql,
                      version_key = version_key)

      } else {

        Sys.sleep(0.05)

      }
      relationship_ct_output[[vocabulary_id]] <-
        deprecated_relationship_ct
      cli::cli_progress_update()

    }

    cli::cli_progress_done()

    deprecated_omop_relationships <-
      list(relationships = relationship_output,
           relationship_counts = relationship_ct_output) %>%
      purrr::transpose()


    omop_relationship_errors <-
      list()

    # Check to make sure a join will not lead to duplicates
    for (vocabulary_id in vocabulary_ids) {

      relationship_rows <-
        deprecated_omop_relationships[[vocabulary_id]]$relationships %>%
        dplyr::select(dplyr::any_of(colnames(deprecated_omop_relationships[[vocabulary_id]]$relationship_counts))) %>%
        dplyr::distinct() %>%
        nrow()

      relationship_count_rows <-
        nrow(deprecated_omop_relationships[[vocabulary_id]]$relationship_counts)

      if (relationship_rows != relationship_count_rows) {

        omop_relationship_errors[[length(omop_relationship_errors)+1]] <-
          list(relationship_rows = relationship_rows,
               relationship_count_rows = relationship_count_rows,
               relationship_df = deprecated_omop_relationships[[vocabulary_id]]$relationships,
               relationship_ct_df = deprecated_omop_relationships[[vocabulary_id]]$relationship_counts)
        names(omop_relationship_errors)[length(omop_relationship_errors)] <-
          vocabulary_id


      }


    }

    if (length(omop_relationship_errors)>0) {

      cli::cli_warn("{length(omop_relationship_errors)} error{?s} in relationship counts found: {names(omop_relationship_errors)}!")
      return(omop_relationship_errors)


    }


    deprecated_omop_relationships1 <-
      deprecated_omop_relationships %>%
      purrr::map(
        purrr::reduce,
        dplyr::left_join,
        by =
          c("relationship_id",
            "vocabulary_id_1",
            "concept_class_id_1",
            "invalid_reason_1",
            "vocabulary_id_2",
            "concept_class_id_2",
            "invalid_reason_2")) %>%
      purrr::map(dplyr::distinct) %>%
      dplyr::bind_rows()


    deprecated_omop_relationships2 <-
      deprecated_omop_relationships1 %>%
      dplyr::left_join(
        complete_vocabulary_ct,
        by = c("vocabulary_id_1" = "vocabulary_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(
        complete_vocabulary_ct_1 = complete_vocabulary_ct) %>%
      dplyr::left_join(
        complete_vocabulary_ct,
        by = c("vocabulary_id_2" = "vocabulary_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(complete_vocabulary_ct_2 = complete_vocabulary_ct) %>%
      dplyr::left_join(
        complete_concept_class_ct_by_invalid_reason2,
        by = c("vocabulary_id_1" = "vocabulary_id",
               "concept_class_id_1" = "concept_class_id")) %>%
      dplyr::rename(
        updated_concept_ct_1 = updated_concept_ct,
        valid_concept_ct_1 = valid_concept_ct,
        deprecated_concept_ct_1 = deprecated_concept_ct) %>%
      dplyr::left_join(
        complete_concept_class_ct_by_invalid_reason2,
        by = c("vocabulary_id_2" = "vocabulary_id",
               "concept_class_id_2" = "concept_class_id")) %>%
      dplyr::rename(
        updated_concept_ct_2 = updated_concept_ct,
        valid_concept_ct_2 = valid_concept_ct,
        deprecated_concept_ct_2 = deprecated_concept_ct) %>%
      dplyr::mutate(join_key_invalid_reason_1 = str_replace_na(invalid_reason_1)) %>%
      dplyr::left_join(
        complete_concept_class_ct_by_invalid_reason %>%
          dplyr::mutate(invalid_reason = str_replace_na(invalid_reason)),
        by = c("vocabulary_id_1" = "vocabulary_id",
               "concept_class_id_1" = "concept_class_id",
               "join_key_invalid_reason_1" = "invalid_reason")) %>%
      dplyr::rename(concept_class_invalid_reason_ct_1 = concept_class_invalid_reason_ct)  %>%
      dplyr::mutate(join_key_invalid_reason_2 = str_replace_na(invalid_reason_2)) %>%
      dplyr::left_join(
        complete_concept_class_ct_by_invalid_reason %>%
          dplyr::mutate(invalid_reason = str_replace_na(invalid_reason)),
        by = c("vocabulary_id_2" = "vocabulary_id",
               "concept_class_id_2" = "concept_class_id",
               "join_key_invalid_reason_2" = "invalid_reason")) %>%
      dplyr::rename(concept_class_invalid_reason_ct_2 = concept_class_invalid_reason_ct) %>%
      dplyr::select(-join_key_invalid_reason_1,
                    -join_key_invalid_reason_2) %>%
      dplyr::distinct()

    if (nrow(deprecated_omop_relationships2) != nrow(deprecated_omop_relationships1)) {

      cli::cli_warn("Duplicates introduced when joining `complete_vocabulary_ct` with `omop_relationships`!")
      return(list(complete_vocabulary_ct = complete_vocabulary_ct,
                  deprecated_omop_relationships = deprecated_omop_relationships1,
                  deprecated_omop_relationships2 = deprecated_omop_relationships2))

    }

    deprecated_omop_relationships3 <-
      deprecated_omop_relationships2


    deprecated_omop_relationships4 <-
      deprecated_omop_relationships3 %>%
      dplyr::left_join(complete_concept_class_ct,
                       by = c("vocabulary_id_1" = "vocabulary_id",
                              "concept_class_id_1" = "concept_class_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(complete_concept_class_ct_1 = complete_concept_class_ct) %>%
      dplyr::left_join(complete_concept_class_ct,
                       by = c("vocabulary_id_2" = "vocabulary_id",
                              "concept_class_id_2" = "concept_class_id")) %>%
      dplyr::distinct() %>%
      dplyr::rename(complete_concept_class_ct_2 = complete_concept_class_ct) %>%
      dplyr::distinct()

    if (nrow(deprecated_omop_relationships4) != nrow(deprecated_omop_relationships3)) {

      cli::cli_warn("Duplicates introduced when joining `complete_vocabulary_ct` with `omop_relationships`!")
      return(list(complete_concept_class_ct = complete_concept_class_ct,
                  omop_relationships = deprecated_omop_relationships3,
                  omop_relationships2 = deprecated_omop_relationships4))

    }


    new("complete.omop.relationships",
        data =
          deprecated_omop_relationships4 %>%
          tidyr::extract(col = relationship_name,
                         into = "relationship_source",
                         regex = "^.*?[(]{1}(.*?)[)]{1}",
                         remove = FALSE) %>%
          dplyr::select(
            relationship_id,
            relationship_name,
            relationship_source,
            is_hierarchical,
            defines_ancestry,
            domain_id_1,
            vocabulary_id_1,
            concept_class_id_1,
            standard_concept_1,
            invalid_reason_1,
            concept_count_1,
            concept_class_invalid_reason_ct_1,
            valid_concept_ct_1,
            updated_concept_ct_1,
            deprecated_concept_ct_1,
            complete_concept_class_ct_1,
            complete_vocabulary_ct_1,
            domain_id_2,
            vocabulary_id_2,
            concept_class_id_2,
            standard_concept_2,
            invalid_reason_2,
            concept_count_2,
            concept_class_invalid_reason_ct_2,
            valid_concept_ct_2,
            updated_concept_ct_2,
            deprecated_concept_ct_2,
            complete_concept_class_ct_2,
            complete_vocabulary_ct_2))

  }


