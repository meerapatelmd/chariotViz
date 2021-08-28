#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param graph PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname construct_edge_legend
#' @export
#' @importFrom purrr set_names transpose map
#' @importFrom glue glue
#' @importFrom huxtable hux map_background_color by_rows theme_article
#' @importFrom dplyr select
construct_edge_legend <-
  function(omop_graph) {
    graph <- omop_graph$graph

    # Colorize
    edge_legend <- graph$edges_df %>%
      dplyr::select(dplyr::any_of(omop_graph$src$edges@legend_fields))

    color_cols <-
      c("color",
        "fillcolor",
        "fontcolor")

    color_names <- vector(mode = "list",
                          length = length(color_cols)) %>%
      purrr::set_names(color_cols)
    col_index <- vector(mode = "list",
                        length = length(color_cols)) %>%
      purrr::set_names(color_cols)

    for (color_col in color_cols) {
      if (!(color_col %in% colnames(edge_legend))) {
        color_names[[color_col]] <- NULL
        col_index[[color_col]] <- NULL
      } else {

        col_index[[color_col]] <-
          grep(
            pattern = glue::glue("^{color_col}$"),
            x = colnames(edge_legend))

        color_names[[color_col]] <-
          edge_legend %>%
          select(all_of(color_col)) %>%
          unlist() %>%
          unname()

      }

    }

    ht_params <-
      list(index = col_index,
           colors = color_names) %>%
      purrr::transpose()

    edge_legend_ht <-
      huxtable::hux(edge_legend)

    for (j in seq_along(ht_params)) {
      edge_legend_ht <-
        huxtable::map_background_color(edge_legend_ht,
                                       row = 2:nrow(edge_legend_ht),
                                       col = ht_params[[j]]$index,
                                       huxtable::by_rows(ht_params[[j]]$colors))

    }

    edge_legend_ht <-
      hux_pretty_numbers(ht = edge_legend_ht,
                         dplyr::any_of(omop_graph$src$edges@integer_fields))


    huxtable::theme_article(edge_legend_ht)

  }
