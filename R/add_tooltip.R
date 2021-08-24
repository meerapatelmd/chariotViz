#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param nodes_and_edges PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname add_tooltip
#' @export
#' @importFrom dplyr left_join select any_of group_by summarize ungroup distinct mutate_all
#' @importFrom tidyr pivot_longer unite
#' @importFrom tibble rowid_to_column
add_tooltip <-
  function(nodes_and_edges) {

    if (length(nodes_and_edges$has_tooltip)==1 & nodes_and_edges$has_tooltip %in% TRUE) {

      cli::cli_abort("Tooltip field already exists.")


    }

    nodes_and_edges$nodes@data <-
    dplyr::left_join(
    nodes_and_edges$nodes@data,
    nodes_and_edges$nodes@data %>%
      dplyr::select(dplyr::any_of(nodes_and_edges$nodes@tooltip_fields)) %>%
      dplyr::mutate(id0 = id) %>%
      dplyr::mutate_at(dplyr::vars(!id0), as.character) %>%
      tidyr::pivot_longer(cols = !id0) %>%
      tidyr::unite(col = tooltip_row,
                   name,
                   value,
                   sep = ": ",
                   na.rm = FALSE) %>%
      dplyr::group_by(id0) %>%
      dplyr::summarize(tooltip =
                         paste(tooltip_row,
                               collapse = "\n"),
                       .groups = "drop") %>%
      dplyr::ungroup() %>%
      dplyr::rename(id = id0),
    by = "id") %>%
      dplyr::distinct()

    edges_data_w_id <-
        nodes_and_edges$edges@data %>%
          dplyr::mutate(id0 = id) %>%
          dplyr::mutate_at(dplyr::vars(!id0), as.character)

    edges_data_w_tooltip <-
    dplyr::left_join(
      edges_data_w_id,
      edges_data_w_id %>%
        dplyr::select(id0, dplyr::any_of(nodes_and_edges$edges@tooltip_fields)) %>%
        tidyr::pivot_longer(cols = !id0) %>%
        tidyr::unite(tooltip_row,
                     name,
                     value,
                     sep = ": ",
                     na.rm = FALSE) %>%
        dplyr::group_by(id0) %>%
        dplyr::summarize(labeltooltip =
                           paste(tooltip_row,
                                 collapse = "\n"),
                         .groups = "drop") %>%
        dplyr::ungroup(),
      by = "id0") %>%
    dplyr::select(-id) %>%
    dplyr::rename(id = id0) %>%
    dplyr::distinct()

    if (nrow(edges_data_w_tooltip) != nrow(nodes_and_edges$edges@data)) {


      cli::cli_abort("Edges with tooltip has {nrow(edges_data_w_tooltip)} while input has {nrow(nodes_and_edges$edges@data)}.")

    }

  nodes_and_edges$edges@data <-
    edges_data_w_tooltip

    nodes_and_edges$has_tooltip <- TRUE

    nodes_and_edges
  }

