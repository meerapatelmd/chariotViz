#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param vocabulary_id_1 PARAM_DESCRIPTION
#' @param schema PARAM_DESCRIPTION, Default: 'omop_vocabulary'
#' @param verbose PARAM_DESCRIPTION, Default: FALSE
#' @param render_sql PARAM_DESCRIPTION, Default: FALSE
#' @param conn_fun PARAM_DESCRIPTION, Default: 'pg13::local_connect(verbose=FALSE)'
#' @rdname fetch_heatmap
#' @export
#' @importFrom glue glue
#' @importFrom pg13 query
#' @importFrom dplyr left_join distinct mutate select
#' @importFrom purrr map select transpose
fetch_heatmap <-
  function(vocabulary_id_1,
           schema = "omop_vocabulary",
           verbose = FALSE,
           render_sql = FALSE,
           conn_fun = "pg13::local_connect(verbose=FALSE)") {

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
        dplyr::left_join(all_vocabulary_concept_counts,
                  by = c("vocabulary_id_1" = "vocabulary_id",
                         "concept_class_id_1" = "concept_class_id")) %>%
        dplyr::left_join(all_vocabulary_concept_counts,
                by = c("vocabulary_id_2" = "vocabulary_id",
                       "concept_class_id_2" = "concept_class_id"),
                suffix = c("_1", "_2")) %>%
      dplyr::distinct() %>%
      dplyr::mutate(label_1_coverage = concept_count_1/total_concept_class_ct_1,
             label_2_coverage = concept_count_2/total_concept_class_ct_2) %>%
      dplyr::mutate(label_2 = sprintf("%s %s", vocabulary_id_2, concept_class_id_2)) %>%
      dplyr::mutate(label_1 = sprintf("%s %s", vocabulary_id_1, concept_class_id_1))

    data_to_plot <-
      data_to_plot  %>%
      split(.$label_1)

    legend <-
      data_to_plot %>%
      purrr::map(
        function(x)
          x %>%
          dplyr::select(
            vocabulary_id_1,
            concept_class_id_1,
            relationship_id,
            vocabulary_id_2,
            concept_class_id_2,
            label_1,
            total_concept_class_ct_1,
            concept_count_1,
            label_1_coverage,
            label_2,
            total_concept_class_ct_2,
            concept_count_2,
            label_2_coverage))

    data_to_plot <-
      data_to_plot %>%
      purrr::map(function(x) x%>%
      purrr::select(-vocabulary_id_2,
             -concept_class_id_2) %>%
      dplyr::select(-vocabulary_id_1,
             -concept_class_id_1)) %>%
      purrr::map(select, -label_1) %>%
      purrr::map(
        function(x)
          x %>%
          select(
            label_2,
            relationship_id,
            label_1_coverage,
            label_2_coverage)
        )


    list(data = data_to_plot,
         legend = legend) %>%
      purrr::transpose()

  }

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param data PARAM_DESCRIPTION
#' @param x PARAM_DESCRIPTION, Default: label_2
#' @param y PARAM_DESCRIPTION, Default: relationship_id
#' @param fill PARAM_DESCRIPTION, Default: label_1_coverage
#' @param fontsize PARAM_DESCRIPTION, Default: 6
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[dplyr]{tidyeval-compat}}
#'  \code{\link[ggplot2]{ggplot}},\code{\link[ggplot2]{geom_raster}},\code{\link[ggplot2]{scale_colour_viridis_d}},\code{\link[ggplot2]{theme}},\code{\link[ggplot2]{margin}}
#' @rdname plot_heatmap
#' @export
#' @importFrom dplyr enquo
#' @importFrom ggplot2 ggplot geom_tile scale_fill_viridis_c theme element_text
plot_heatmap <-
  function(data,
           x = label_2,
           y = relationship_id,
           fill = label_1_coverage,
           fontsize = 6) {

    fill <- dplyr::enquo(fill)
    x    <- dplyr::enquo(x)
    y    <- dplyr::enquo(y)
    ggp <-
      ggplot2::ggplot(data, aes(!!x, !!y)) +
      ggplot2::geom_tile(aes(fill = !!fill)) +
      ggplot2::scale_fill_viridis_c(option = "B", direction = -1) +
      ggplot2::theme(
        text =
          ggplot2::element_text(size = fontsize),
        axis.text.x =
          ggplot2::element_text(angle = 45, vjust = 1, hjust=1))
    ggp

  }
