#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param graph PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname create_legend
#' @export
#' @importFrom purrr set_names transpose map
#' @importFrom glue glue
#' @importFrom huxtable hux map_background_color by_rows theme_article
#' @importFrom dplyr select
create_legend <-
  function(graph) {

    .Deprecated("include_legend")

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

    # Colorize
    node_legend <- graph$nodes_df
    edge_legend <- graph$edges_df


    for (color_col in color_cols) {
      if (!(color_col %in% colnames(node_legend))) {
        color_names[[color_col]] <- NULL
        col_index[[color_col]] <- NULL
      } else {

      col_index[[color_col]] <-
        grep(
          pattern = glue::glue("^{color_col}$"),
          x = colnames(node_legend))

      color_names[[color_col]] <-
        node_legend %>%
        select(all_of(color_col)) %>%
        unlist() %>%
        unname()

      }

    }

    ht_params <-
    list(index = col_index,
         colors = color_names) %>%
      purrr::transpose()

    node_legend_ht <-
      huxtable::hux(node_legend)

    for (j in seq_along(ht_params)) {
      node_legend_ht <-
        huxtable::map_background_color(node_legend_ht,
                                       row = 2:nrow(node_legend_ht),
                                       col = ht_params[[j]]$index,
                                       huxtable::by_rows(ht_params[[j]]$colors))

    }


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

    list(node = node_legend_ht,
         edge = edge_legend_ht %>%
                  dplyr::select(-from,
                                -to)) %>%
      purrr::map(dplyr::select,
                 -contains("label"),
                 -contains("fontsize"),
                 -contains("len"),
                 -contains("width"),
                 -contains("height"),
                 -ends_with("_1"),
                 -ends_with("_2")) %>%
      purrr::map(huxtable::theme_article)


  }
