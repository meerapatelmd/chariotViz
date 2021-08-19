#
#
# test_concept_id <- 35803361
#
#
# output <- list()
# output[[1]] <-
#   pg13::query(
#     conn_fun = "pg13::local_connect()",
#     sql_statement = "SELECT cr.* FROM omop_vocabulary.concept_relationship cr INNER JOIN omop_vocabulary.relationship r ON r.relationship_id = cr.relationship_id WHERE concept_id_2 = 35803361 AND concept_id_1 <> concept_id_2 AND r.defines_ancestry = '1'"
#   )
# for (i in 2:20) {
#
#   cat(i, sep = "\n")
#   cat(nrow(output[[i-1]]))
#   staging_table <-
#     pg13::write_staging_table(
#       conn_fun = "pg13::local_connect()",
#       schema = "public",
#       data   = output[[i-1]],
#       drop_existing = TRUE
#     )
#
#   output[[i]] <-
#     pg13::query(
#       conn_fun = "pg13::local_connect()",
#       sql_statement =
#         glue::glue("SELECT cr.* FROM public.{staging_table} t INNER JOIN omop_vocabulary.concept_relationship cr ON cr.concept_id_2 = t.concept_id_1 inner join omop_vocabulary.relationship r ON r.relationship_id = cr.relationship_id WHERE r.defines_ancestry = '1' AND cr.concept_id_1 <> cr.concept_id_2 AND cr.invalid_reason IS NULL")
#     )
#
#   if (nrow(output[[i]]) == 0) {
#     break
#   }
# }
#
# output <- list()
# output[[1]] <-
#   pg13::query(
#     conn_fun = "pg13::local_connect()",
#     sql_statement = "SELECT cr.* FROM omop_vocabulary.concept_relationship cr INNER JOIN omop_vocabulary.relationship r ON r.relationship_id = cr.relationship_id WHERE concept_id_2 = 35803361 AND concept_id_1 <> concept_id_2 AND r.is_hierarchical = '1'"
#   )
# for (i in 2:20) {
#
#   cat(i, sep = "\n")
#   cat(nrow(output[[i-1]]))
#   staging_table <-
#     pg13::write_staging_table(
#       conn_fun = "pg13::local_connect()",
#       schema = "public",
#       data   = output[[i-1]],
#       drop_existing = TRUE
#     )
#
#   output[[i]] <-
#     pg13::query(
#       conn_fun = "pg13::local_connect()",
#       sql_statement =
#         glue::glue("SELECT cr.* FROM public.{staging_table} t INNER JOIN omop_vocabulary.concept_relationship cr ON cr.concept_id_2 = t.concept_id_1 inner join omop_vocabulary.relationship r ON r.relationship_id = cr.relationship_id WHERE r.is_hierarchical = '1' AND cr.concept_id_1 <> cr.concept_id_2 AND cr.invalid_reason IS NULL")
#     )
#
#   if (nrow(output[[i]]) == 0) {
#     break
#   }
# }
#
# trace_concept_relationship <-
#   function(concept_id,
#            schema = "omop_vocabulary",
#            conn,
#            conn_fun = "pg13::local_connect(verbose=FALSE)",
#            verbose = FALSE,
#            render_sql = FALSE,
#            version_key,
#            force = FALSE) {
#
#
#
#
#     concept_row <-
#       pg13::query(
#         conn = conn,
#         conn_fun = conn_fun,
#         checks = "",
#         sql_statement =
#           glue::glue("SELECT * FROM {schema}.concept WHERE concept_id = {concept_id} AND invalid_reason IS NULL;"),
#         verbose = verbose,
#         render_sql = render_sql
#       )
#
#
#     if (nrow(concept_row) != 1) {
#
#       cli::cli_abort("Query returned {nrow(concept_row)} row{?s}")
#
#     }
#
#
#     input_vocabulary_id <- concept_row$vocabulary_id
#     input_concept_class_id <- concept_row$concept_class_id
#
#     fetch_omop_relationships(!!!input_vocabulary_id,
#                              conn = conn,
#                              conn_fun = conn_fun,
#                              version_key = version_key) %>%
#       create_nodes_and_edges() %>%
#       add_tooltip() %>%
#       map_node_attributes() %>%
#       map_edge_attributes() %>%
#       construct_graph() %>%
#       append_concept_examples(sample_size = 3) %>%
#       chariotViz(force = force)
#
#   }
