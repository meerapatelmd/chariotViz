

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

    nodes_and_edges@nodes@data <-
    dplyr::left_join(
    nodes_and_edges@nodes@data,
    nodes_and_edges@nodes@data %>%
      dplyr::select(dplyr::any_of(nodes_and_edges@nodes@tooltip_fields)) %>%
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
                               collapse = "\n"),
                       .groups = "drop") %>%
      dplyr::ungroup(),
    by = "id") %>%
      dplyr::distinct()

    edges_data_w_id <-
        nodes_and_edges@edges@data %>%
          dplyr::mutate_all(as.character) # %>%
 #         tibble::rowid_to_column()

    edges_data_w_tooltip <-
    dplyr::left_join(
      edges_data_w_id,
      edges_data_w_id %>%
        dplyr::select(dplyr::any_of(nodes_and_edges@edges@tooltip_fields)) %>%
        tidyr::pivot_longer(cols = !id) %>%
        tidyr::unite(tooltip_row,
                     name,
                     value,
                     sep = ": ",
                     na.rm = FALSE) %>%
        dplyr::group_by(id) %>%
        dplyr::summarize(labeltooltip =
                           paste(tooltip_row,
                                 collapse = "\n"),
                         .groups = "drop") %>%
        dplyr::ungroup(),
      by = "id") %>%
    dplyr::distinct()

    if (nrow(edges_data_w_tooltip) != nrow(nodes_and_edges@edges@data)) {


      cli::cli_abort("Edges with tooltip has {nrow(edges_data_w_tooltip)} while input has {nrow(nodes_and_edges@edges@data)}.")

    }

  nodes_and_edges@edges@data <-
    edges_data_w_tooltip

    nodes_and_edges
  }
