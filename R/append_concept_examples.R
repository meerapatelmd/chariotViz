#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
#' @param sample_size PARAM_DESCRIPTION, Default: 5
#' @param schema PARAM_DESCRIPTION, Default: 'omop_vocabulary'
#' @param conn PARAM_DESCRIPTION
#' @param conn_fun PARAM_DESCRIPTION, Default: 'pg13::local_connect(verbose=FALSE)'
#' @param verbose PARAM_DESCRIPTION, Default: FALSE
#' @param render_sql PARAM_DESCRIPTION, Default: FALSE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname append_concept_examples
#' @export
#' @import dplyr
#' @importFrom glue glue
#' @importFrom pg13 query
#' @importFrom tidyr pivot_longer unite


append_concept_examples <-
  function(omop_graph,
           sample_size = 5,
           schema = "omop_vocabulary",
           conn,
           conn_fun = "pg13::local_connect(verbose=FALSE)",
           verbose = FALSE,
           render_sql = FALSE) {

    # Deriving domain, vocabulary, concept_class, and standard_concept from
    # nodes
    node_groups <-
    omop_graph@graph$nodes_df %>%
      dplyr::distinct(id,
                    domain_id,
                    vocabulary_id,
                    concept_class_id,
                    standard_concept)

    output <-
      vector(mode = "list",
             length = nrow(node_groups))
    names(output) <- node_groups$id


    for (i in 1:nrow(node_groups)) {

      id <- node_groups$id[i]
      domain_id <- node_groups$domain_id[i]
      vocabulary_id <- node_groups$vocabulary_id[i]
      concept_class_id <- node_groups$concept_class_id[i]
      standard_concept <- node_groups$standard_concept[i]

      sqls <-
        vector(mode = "list",
               length = 2L)
      names(sqls) <-
        c("node_group_count",
          "data")

      resultsets <- sqls

      if (is.na(standard_concept)) {

        sqls$node_group_count <-
        paste(
        as.character(
        glue::glue(
          "SELECT COUNT(*) AS count",
          "FROM {schema}.CONCEPT ",
          "WHERE ",
          "  domain_id = '{domain_id}' AND",
          "  vocabulary_id = '{vocabulary_id}' AND",
          "  concept_class_id = '{concept_class_id}' AND",
          "  standard_concept IS NULL AND",
          "  invalid_reason IS NULL ;",
         .sep = "\n"
        )),
        collapse = " ")

        resultsets$node_group_count <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sqls$node_group_count,
            verbose = verbose,
            render_sql = render_sql) %>%
          unlist() %>%
          unname()

        if (resultsets$node_group_count > sample_size) {


          sqls$data <-
            paste(
              as.character(
                glue::glue(
                  "SELECT *",
                  "FROM {schema}.CONCEPT ",
                  "WHERE ",
                  "  domain_id = '{domain_id}' AND",
                  "  vocabulary_id = '{vocabulary_id}' AND",
                  "  concept_class_id = '{concept_class_id}' AND",
                  "  standard_concept IS NULL AND",
                  "  invalid_reason IS NULL ",
                  "ORDER BY RANDOM() ",
                  "LIMIT {sample_size} ;",
                  .sep = "\n"
                )),
              collapse = " ")

        } else {

          sqls$data <-
            paste(
              as.character(
                glue::glue(
                  "SELECT *",
                  "FROM {schema}.CONCEPT ",
                  "WHERE ",
                  "  domain_id = '{domain_id}' AND",
                  "  vocabulary_id = '{vocabulary_id}' AND",
                  "  concept_class_id = '{concept_class_id}' AND",
                  "  standard_concept NOT IN ('S', 'C') AND",
                  "  invalid_reason IS NULL ",
                  .sep = "\n"
                )),
              collapse = " ")


        }

        resultsets$data <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sqls$data,
            verbose = verbose,
            render_sql = render_sql)

      } else {


        sqls$node_group_count <-
          paste(
            as.character(
              glue::glue(
                "SELECT COUNT(*) AS count",
                "FROM {schema}.CONCEPT ",
                "WHERE ",
                "  domain_id = '{domain_id}' AND",
                "  vocabulary_id = '{vocabulary_id}' AND",
                "  concept_class_id = '{concept_class_id}' AND",
                "  standard_concept = '{standard_concept}' AND",
                "  invalid_reason IS NULL ;",
                .sep = "\n"
              )),
            collapse = " ")

        resultsets$node_group_count <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sqls$node_group_count,
            verbose = verbose,
            render_sql = render_sql) %>%
          unlist() %>%
          unname()

        if (resultsets$node_group_count > sample_size) {


          sqls$data <-
            paste(
              as.character(
                glue::glue(
                  "SELECT *",
                  "FROM {schema}.CONCEPT ",
                  "WHERE ",
                  "  domain_id = '{domain_id}' AND",
                  "  vocabulary_id = '{vocabulary_id}' AND",
                  "  concept_class_id = '{concept_class_id}' AND",
                  "  standard_concept = '{standard_concept}' AND",
                  "  invalid_reason IS NULL ",
                  "ORDER BY RANDOM() ",
                  "LIMIT {sample_size} ;",
                  .sep = "\n"
                )),
              collapse = " ")

        } else {

          sqls$data <-
            paste(
              as.character(
                glue::glue(
                  "SELECT *",
                  "FROM {schema}.CONCEPT ",
                  "WHERE ",
                  "  domain_id = '{domain_id}' AND",
                  "  vocabulary_id = '{vocabulary_id}' AND",
                  "  concept_class_id = '{concept_class_id}' AND",
                  "  standard_concept = '{standard_concept}' AND",
                  "  invalid_reason IS NULL ",
                  .sep = "\n"
                )),
              collapse = " ")


        }

        resultsets$data <-
          pg13::query(
            conn = conn,
            checks = "",
            conn_fun = conn_fun,
            sql_statement = sqls$data,
            verbose = verbose,
            render_sql = render_sql)




      }


      output[[id]] <-
        resultsets$data %>%
        dplyr::mutate(total_concept_class_count = resultsets$node_group_count)

    }


    output <-
    output %>%
      dplyr::bind_rows(.id = "from")

    nodes <-
      output %>%
      dplyr::mutate(id = concept_id,
                    label = concept_name)

    nodes_tooltip <-
      nodes %>%
      dplyr::select(-from,
                    -label) %>%
      dplyr::mutate_at(dplyr::vars(!id), as.character) %>%
      tidyr::pivot_longer(cols = !id) %>%
      tidyr::unite(col = tooltip_row,
                   name,
                   value,
                   sep = ": ",
                   na.rm = FALSE) %>%
      dplyr::group_by(id) %>%
      dplyr::summarize(tooltip =
                         paste(tooltip_row,
                               collapse = "\n")) %>%
      dplyr::ungroup()

    ne <-
    nodes %>%
      dplyr::left_join(nodes_tooltip,
                       by = "id") %>%
      dplyr::transmute(
        id,
        type = "Concept",
        label,
        tooltip,
        from,
        to = id) %>%
      dplyr::distinct()

    nodes <-
      ne %>%
      dplyr::distinct(id,
                      type,
                      label,
                      tooltip,
                      fontsize = 18) %>%
      dplyr::mutate(
        fixedsize = FALSE,
        shape = "plaintext") %>%
      dplyr::mutate_at(dplyr::vars(id,fontsize), as.integer)

    edges <-
      ne %>%
      dplyr::distinct(from,
                      to,
                      rel = "example",
                      style = "dotted",
                      color = "gray",
                      arrowhead = "none",
                      penwidth = 3,
                      len = 0) %>%
      dplyr::mutate_at(dplyr::vars(c(from,to,len,penwidth)),
                       as.integer)


    omop_graph@graph$nodes_df <-
      dplyr::bind_rows(
        omop_graph@graph$nodes_df,
        nodes) %>%
      dplyr::arrange(domain_id,
                     vocabulary_id,
                     concept_class_id,
                     standard_concept)

    omop_graph@graph$edges_df <-
      dplyr::bind_rows(
        omop_graph@graph$edges_df,
        edges
      )


    omop_graph

  }
