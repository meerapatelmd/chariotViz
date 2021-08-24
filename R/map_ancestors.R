#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param nodes_and_edges PARAM_DESCRIPTION
#' @param fontsize PARAM_DESCRIPTION, Default: 12
#' @param len PARAM_DESCRIPTION, Default: 1
#' @param label_from PARAM_DESCRIPTION, Default: relationship_name
#' @param style_from PARAM_DESCRIPTION, Default: NULL
#' @param style_map PARAM_DESCRIPTION, Default: NULL
#' @param penwidth_from PARAM_DESCRIPTION, Default: NULL
#' @param penwidth_map PARAM_DESCRIPTION, Default: NULL
#' @param color_from PARAM_DESCRIPTION, Default: NULL
#' @param color_map PARAM_DESCRIPTION, Default: NULL
#' @param arrowsize_from PARAM_DESCRIPTION, Default: NULL
#' @param arrowsize_map PARAM_DESCRIPTION, Default: NULL
#' @param arrowhead_from PARAM_DESCRIPTION, Default: is_hierarchical
#' @param arrowhead_map PARAM_DESCRIPTION, Default: c(`1` = "vee", `0` = "none")
#' @param arrowtail_from PARAM_DESCRIPTION, Default: NULL
#' @param arrowtail_map PARAM_DESCRIPTION, Default: NULL
#' @param fontname_from PARAM_DESCRIPTION, Default: NULL
#' @param fontname_map PARAM_DESCRIPTION, Default: NULL
#' @param fontsize_from PARAM_DESCRIPTION, Default: NULL
#' @param fontsize_map PARAM_DESCRIPTION, Default: NULL
#' @param fontcolor_from PARAM_DESCRIPTION, Default: NULL
#' @param fontcolor_map PARAM_DESCRIPTION, Default: NULL
#' @param tooltip_from PARAM_DESCRIPTION, Default: NULL
#' @param tooltip_map PARAM_DESCRIPTION, Default: NULL
#' @param URL_from PARAM_DESCRIPTION, Default: NULL
#' @param URL_map PARAM_DESCRIPTION, Default: NULL
#' @param edgetooltip_from PARAM_DESCRIPTION, Default: NULL
#' @param edgetooltip_map PARAM_DESCRIPTION, Default: NULL
#' @param edgeURL_from PARAM_DESCRIPTION, Default: NULL
#' @param edgeURL_map PARAM_DESCRIPTION, Default: NULL
#' @param dir_from PARAM_DESCRIPTION, Default: NULL
#' @param dir_map PARAM_DESCRIPTION, Default: NULL
#' @param headtooltip_from PARAM_DESCRIPTION, Default: NULL
#' @param headtooltip_map PARAM_DESCRIPTION, Default: NULL
#' @param headURL_from PARAM_DESCRIPTION, Default: NULL
#' @param headURL_map PARAM_DESCRIPTION, Default: NULL
#' @param headclip_from PARAM_DESCRIPTION, Default: NULL
#' @param headclip_map PARAM_DESCRIPTION, Default: NULL
#' @param headlabel_from PARAM_DESCRIPTION, Default: NULL
#' @param headlabel_map PARAM_DESCRIPTION, Default: NULL
#' @param headport_from PARAM_DESCRIPTION, Default: NULL
#' @param headport_map PARAM_DESCRIPTION, Default: NULL
#' @param tailtooltip_from PARAM_DESCRIPTION, Default: NULL
#' @param tailtooltip_map PARAM_DESCRIPTION, Default: NULL
#' @param tailURL_from PARAM_DESCRIPTION, Default: NULL
#' @param tailURL_map PARAM_DESCRIPTION, Default: NULL
#' @param tailclip_from PARAM_DESCRIPTION, Default: NULL
#' @param tailclip_map PARAM_DESCRIPTION, Default: NULL
#' @param taillabel_from PARAM_DESCRIPTION, Default: NULL
#' @param taillabel_map PARAM_DESCRIPTION, Default: NULL
#' @param tailport_from PARAM_DESCRIPTION, Default: NULL
#' @param tailport_map PARAM_DESCRIPTION, Default: NULL
#' @param decorate_from PARAM_DESCRIPTION, Default: NULL
#' @param decorate_map PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[dplyr]{tidyeval-compat}},\code{\link[dplyr]{mutate}},\code{\link[dplyr]{distinct}}
#' @rdname map_ancestor_edge_attributes
#' @export
#' @importFrom dplyr enquo mutate distinct
map_ancestor_edge_attributes <-
  function(nodes_and_edges,
           fontsize = 26,
           len = 5,
           color = "black",
           arrowsize = 2,
           style = "dotted",
           label_from = rel,
           penwidth_from = NULL,
           penwidth_map = NULL,
           penwidth_map_other = NULL,
           color_from = NULL,
           color_map = NULL,
           color_map_other = NULL,
           arrowtail_from = NULL,
           arrowtail_map = NULL,
           arrowtail_map_other = NULL,
           fontname_from = NULL,
           fontname_map = NULL,
           fontname_map_other = NULL,
           fontsize_from = NULL,
           fontsize_map = NULL,
           fontsize_map_other = NULL,
           fontcolor_from = NULL,
           fontcolor_map = NULL,
           fontcolor_map_other = NULL,
           tooltip_from = NULL,
           tooltip_map = NULL,
           tooltip_map_other = NULL,
           URL_from = NULL,
           URL_map = NULL,
           URL_map_other = NULL,
           edgetooltip_from = NULL,
           edgetooltip_map = NULL,
           edgetooltip_map_other = NULL,
           edgeURL_from = NULL,
           edgeURL_map = NULL,
           edgeURL_map_other = NULL,
           dir_from = NULL,
           dir_map = NULL,
           dir_map_other = NULL,
           headtooltip_from = NULL,
           headtooltip_map = NULL,
           headtooltip_map_other = NULL,
           headURL_from = NULL,
           headURL_map = NULL,
           headURL_map_other = NULL,
           headclip_from = NULL,
           headclip_map = NULL,
           headclip_map_other = NULL,
           headlabel_from = NULL,
           headlabel_map = NULL,
           headlabel_map_other = NULL,
           headport_from = NULL,
           headport_map = NULL,
           headport_map_other = NULL,
           tailtooltip_from = NULL,
           tailtooltip_map = NULL,
           tailtooltip_map_other = NULL,
           tailURL_from = NULL,
           tailURL_map = NULL,
           tailURL_map_other = NULL,
           tailclip_from = NULL,
           tailclip_map = NULL,
           tailclip_map_other = NULL,
           taillabel_from = NULL,
           taillabel_map = NULL,
           taillabel_map_other = NULL,
           tailport_from = NULL,
           tailport_map = NULL,
           tailport_map_other = NULL,
           decorate_from = NULL,
           decorate_map = NULL,
           decorate_map_other = NULL) {


    all_args <- formals()

    if (!is.null(all_args$penwidth_from)) {
      penwidth_from <- dplyr::enquo(penwidth_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(penwidth = map_to_value(!!penwidth_from,
                                              map_assignment = penwidth_map,
                                              other = penwidth_map_other))
    }

    if (!is.null(all_args$color_from)) {
      color_from <- dplyr::enquo(color_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(color = map_to_value(!!color_from,
                                           map_assignment = color_map,
                                           other = color_map_other))
    }


    if (!is.null(all_args$arrowtail_from)) {
      arrowtail_from <- dplyr::enquo(arrowtail_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(arrowtail = map_to_value(!!arrowtail_from,
                                               map_assignment = arrowtail_map,
                                               other = arrowtail_map_other))
    }

    if (!is.null(all_args$fontname_from)) {
      fontname_from <- dplyr::enquo(fontname_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(fontname = map_to_value(!!fontname_from,
                                              map_assignment = fontname_map,
                                              other = fontname_map_other))
    }

    if (!is.null(all_args$fontsize_from)) {
      fontsize_from <- dplyr::enquo(fontsize_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(fontsize = map_to_value(!!fontsize_from,
                                              map_assignment = fontsize_map,
                                              other = fontsize_map_other))
    }

    if (!is.null(all_args$fontcolor_from)) {
      fontcolor_from <- dplyr::enquo(fontcolor_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(fontcolor = map_to_value(!!fontcolor_from,
                                               map_assignment = fontcolor_map,
                                               other = fontcolor_map_other))
    }

    if (!is.null(all_args$tooltip_from)) {
      tooltip_from <- dplyr::enquo(tooltip_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(tooltip = map_to_value(!!tooltip_from,
                                             map_assignment = tooltip_map,
                                             other = tooltip_map_other))
    }

    if (!is.null(all_args$URL_from)) {
      URL_from <- dplyr::enquo(URL_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(URL = map_to_value(!!URL_from,
                                         map_assignment = URL_map,
                                         other = URL_map_other))
    }

    if (!is.null(all_args$edgetooltip_from)) {
      edgetooltip_from <- dplyr::enquo(edgetooltip_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(edgetooltip = map_to_value(!!edgetooltip_from,
                                                 map_assignment = edgetooltip_map,
                                                 other = edgetooltip_map_other))
    }

    if (!is.null(all_args$edgeURL_from)) {
      edgeURL_from <- dplyr::enquo(edgeURL_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(edgeURL = map_to_value(!!edgeURL_from,
                                             map_assignment = edgeURL_map,
                                             other = edgeURL_map_other))
    }

    if (!is.null(all_args$dir_from)) {
      dir_from <- dplyr::enquo(dir_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(dir = map_to_value(!!dir_from,
                                         map_assignment = dir_map,
                                         other = dir_map_other))
    }

    if (!is.null(all_args$headtooltip_from)) {
      headtooltip_from <- dplyr::enquo(headtooltip_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(headtooltip = map_to_value(!!headtooltip_from,
                                                 map_assignment = headtooltip_map,
                                                 other = headtooltip_map_other))
    }

    if (!is.null(all_args$headURL_from)) {
      headURL_from <- dplyr::enquo(headURL_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(headURL = map_to_value(!!headURL_from,
                                             map_assignment = headURL_map,
                                             other = headURL_map_other))
    }

    if (!is.null(all_args$headclip_from)) {
      headclip_from <- dplyr::enquo(headclip_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(headclip = map_to_value(!!headclip_from,
                                              map_assignment = headclip_map,
                                              other = headclip_map_other))
    }

    if (!is.null(all_args$headlabel_from)) {
      headlabel_from <- dplyr::enquo(headlabel_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(headlabel = map_to_value(!!headlabel_from,
                                               map_assignment = headlabel_map,
                                               other = headlabel_map_other))
    }

    if (!is.null(all_args$headport_from)) {
      headport_from <- dplyr::enquo(headport_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(headport = map_to_value(!!headport_from,
                                              map_assignment = headport_map,
                                              other = headport_map_other))
    }

    if (!is.null(all_args$tailtooltip_from)) {
      tailtooltip_from <- dplyr::enquo(tailtooltip_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(tailtooltip = map_to_value(!!tailtooltip_from,
                                                 map_assignment = tailtooltip_map,
                                                 other = tailtooltip_map_other))
    }

    if (!is.null(all_args$tailURL_from)) {
      tailURL_from <- dplyr::enquo(tailURL_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(tailURL = map_to_value(!!tailURL_from,
                                             map_assignment = tailURL_map,
                                             other = tailURL_map_other))
    }

    if (!is.null(all_args$tailclip_from)) {
      tailclip_from <- dplyr::enquo(tailclip_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(tailclip = map_to_value(!!tailclip_from,
                                              map_assignment = tailclip_map,
                                              other = tailclip_map_other))
    }

    if (!is.null(all_args$taillabel_from)) {
      taillabel_from <- dplyr::enquo(taillabel_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(taillabel = map_to_value(!!taillabel_from,
                                               map_assignment = taillabel_map,
                                               other = taillabel_map_other))
    }

    if (!is.null(all_args$tailport_from)) {
      tailport_from <- dplyr::enquo(tailport_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(tailport = map_to_value(!!tailport_from,
                                              map_assignment = tailport_map,
                                              other = tailport_map_other))
    }

    if (!is.null(all_args$decorate_from)) {
      decorate_from <- dplyr::enquo(decorate_from)
      nodes_and_edges@edges@data <-
        nodes_and_edges@edges@data %>%
        dplyr::mutate(decorate = map_to_value(!!decorate_from,
                                              map_assignment = decorate_map,
                                              other = decorate_map_other))
    }

    # Constant Attributes
    constant_attrs <-
      c("fontsize",
        "len",
        "color",
        "arrowsize",
        "style")

    constant_attrs <-
      formals()[names(formals()) %in% constant_attrs] %>%
      purrr::keep(~!is.null(.))
    constant_attrs_df <-
      tibble::as_tibble(constant_attrs)
    nodes_and_edges@edges@data <-
      cbind(nodes_and_edges@edges@data,
            constant_attrs_df)
    cli::cli_alert_info("{length(constant_attrs)} constant attribute{?s} added: {names(constant_attrs)}.")

    nodes_and_edges@has_edge_attrs <- TRUE
    nodes_and_edges

  }
