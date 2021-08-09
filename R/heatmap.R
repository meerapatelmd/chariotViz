# ## Add Heatmap

fetch_heatmap <-
  function(vocabulary_id_1,
           schema = "omop_vocabulary",
           verbose = FALSE,
           render_sql = FALSE,
           conn_fun = "pg13::local_connect(verbose=FALSE)") {

    require(chariot)
    require(glue)
    require(scales)

    # sql <-
    # as.character(
    #   glue::glue(
    #     "
    #   SELECT
    #     c1.vocabulary_id AS vocabulary_id_1,
    #     c1.concept_class_id AS concept_class_id_1,
    #     c1.concept_id AS concept_id_1,
    #     c2.vocabulary_id AS vocabulary_id_2,
    #     c2.concept_class_id AS concept_class_id_2,
    #     c2.concept_id AS concept_id_2,
    #     cr.relationship_id
    #   FROM {schema}.concept_relationship cr
    #   INNER JOIN (SELECT * FROM {schema}.concept WHERE invalid_reason IS NULL AND vocabulary_id IN ('{vocabulary_id_1}')) c1
    #   ON c1.concept_id = cr.concept_id_1
    #   INNER JOIN (SELECT * FROM {schema}.concept WHERE invalid_reason IS NULL) c2
    #   ON c2.concept_id = cr.concept_id_2
    #   WHERE
    #     cr.invalid_reason IS NULL;
    #   "))

    # vocabulary_id_1_relationships <-
    #   queryAthena(sql_statement = sql)

    vocabulary_id <- vocabulary_id_1
    sql <- read_sql_template("relationship_ct.sql")
    sql <- glue::glue(sql)
    Sys.sleep(0.5)
    vocabulary_id_1_relationships <-
      pg13::query(
        conn = conn,
        checks = "",
        conn_fun = conn_fun,
        sql_statement = sql,
        verbose = verbose,
        render_sql = render_sql)
    Sys.sleep(0.5)

    sql <- read_sql_template("total_concept_class_ct.sql")
    sql <- glue::glue(sql)
    Sys.sleep(0.5)
    all_vocabulary_concept_counts <-
      pg13::query(
        conn = conn,
        checks = "",
        conn_fun = conn_fun,
        sql_statement = sql,
        verbose = verbose,
        render_sql = render_sql)
    Sys.sleep(0.5)

    data_to_plot <-
    vocabulary_id_1_relationships %>%
        left_join(all_vocabulary_concept_counts,
                  by = c("vocabulary_id_1" = "vocabulary_id",
                         "concept_class_id_1" = "concept_class_id")) %>%
      left_join(all_vocabulary_concept_counts,
                by = c("vocabulary_id_2" = "vocabulary_id",
                       "concept_class_id_2" = "concept_class_id"),
                suffix = c("_1", "_2")) %>%
      distinct() %>%
      mutate(label_1_coverage = concept_count_1/total_concept_class_ct_1,
             label_2_coverage = concept_count_2/total_concept_class_ct_2) %>%
        mutate(label_2 = sprintf("%s %s", vocabulary_id_2, concept_class_id_2)) %>%
      mutate(label_1 = sprintf("%s %s", vocabulary_id_1, concept_class_id_1))

    data_to_plot <-
      data_to_plot  %>%
      split(.$label_1)

    legend <-
      data_to_plot %>%
      map(function(x) x %>% select(vocabulary_id_1, concept_class_id_1, relationship_id, vocabulary_id_2, concept_class_id_2,
                                   label_1, total_concept_class_ct_1, concept_count_1, label_1_coverage,
                                   label_2, total_concept_class_ct_2, concept_count_2, label_2_coverage))

    data_to_plot <-
      data_to_plot %>%
      map(function(x) x%>%
      select(-vocabulary_id_2,
             -concept_class_id_2) %>%
      select(-vocabulary_id_1,
             -concept_class_id_1)) %>%
      map(select, -label_1) %>%
      map(function(x) x %>% select(label_2, relationship_id, label_1_coverage, label_2_coverage))


    list(data = data_to_plot,
         legend = legend) %>%
      transpose()

  }

plot_heatmap <-
  function(data,
           x = label_2,
           y = relationship_id,
           fill = label_1_coverage,
           fontsize = 6) {

    require(ggplot2)
    fill <- enquo(fill)
    x    <- enquo(x)
    y    <- enquo(y)
    ggp <- ggplot2::ggplot(data, aes(!!x, !!y)) +
      geom_tile(aes(fill = !!fill)) +
      scale_fill_viridis_c(option = "B", direction = -1) +
      theme(text = element_text(size=fontsize),
            axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
    ggp

  }
