
if (!is.null(all_args$style_from)) {
  style_from <- dplyr::enquo(style_from)
  nodes_and_edges@edges@data <-
    nodes_and_edges@edges@data %>%
    dplyr::mutate(style = map_to_value(!!style_from,
                                          map_assignment = style_map,
                                          other = style_map_other))
}

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

if (!is.null(all_args$arrowsize_from)) {
  arrowsize_from <- dplyr::enquo(arrowsize_from)
  nodes_and_edges@edges@data <-
    nodes_and_edges@edges@data %>%
    dplyr::mutate(arrowsize = map_to_value(!!arrowsize_from,
                                          map_assignment = arrowsize_map,
                                          other = arrowsize_map_other))
}

if (!is.null(all_args$arrowhead_from)) {
  arrowhead_from <- dplyr::enquo(arrowhead_from)
  nodes_and_edges@edges@data <-
    nodes_and_edges@edges@data %>%
    dplyr::mutate(arrowhead = map_to_value(!!arrowhead_from,
                                          map_assignment = arrowhead_map,
                                          other = arrowhead_map_other))
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

if (!is.null(all_args$style_from)) {
  style_from <- dplyr::enquo(style_from)
  nodes_and_edges@edges@data <-
    nodes_and_edges@edges@data %>%
    dplyr::mutate(style = map_to_value(!!style_from,
                                          map_assignment = style_map,
                                          other = style_map_other))
}

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

if (!is.null(all_args$arrowsize_from)) {
  arrowsize_from <- dplyr::enquo(arrowsize_from)
  nodes_and_edges@edges@data <-
    nodes_and_edges@edges@data %>%
    dplyr::mutate(arrowsize = map_to_value(!!arrowsize_from,
                                          map_assignment = arrowsize_map,
                                          other = arrowsize_map_other))
}

if (!is.null(all_args$arrowhead_from)) {
  arrowhead_from <- dplyr::enquo(arrowhead_from)
  nodes_and_edges@edges@data <-
    nodes_and_edges@edges@data %>%
    dplyr::mutate(arrowhead = map_to_value(!!arrowhead_from,
                                          map_assignment = arrowhead_map,
                                          other = arrowhead_map_other))
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
