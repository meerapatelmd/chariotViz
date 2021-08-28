#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param nodes_and_edges PARAM_DESCRIPTION
#' @param fontsize PARAM_DESCRIPTION, Default: 12
#' @param fontname PARAM_DESCRIPTION, Default: NULL
#' @param width PARAM_DESCRIPTION, Default: 1.5
#' @param height PARAM_DESCRIPTION, Default: 1.5
#' @param shape_from PARAM_DESCRIPTION, Default: standard_concept
#' @param shape_map PARAM_DESCRIPTION, Default: c(C = "square", S = "circle", `NA` = "circle")
#' @param shape_map_other PARAM_DESCRIPTION, Default: 'circle'
#' @param style_from PARAM_DESCRIPTION, Default: standard_concept
#' @param style_map PARAM_DESCRIPTION, Default: c(C = "filled", S = "filled", `NA` = "filled")
#' @param style_map_other PARAM_DESCRIPTION, Default: NULL
#' @param penwidth_from PARAM_DESCRIPTION, Default: NULL
#' @param penwidth_map PARAM_DESCRIPTION, Default: NULL
#' @param color_from PARAM_DESCRIPTION, Default: vocabulary_id
#' @param color_map PARAM_DESCRIPTION, Default: vocabulary_id_standard_colors
#' @param color_map_other PARAM_DESCRIPTION, Default: 'gray20'
#' @param fillcolor_from PARAM_DESCRIPTION, Default: vocabulary_id
#' @param fillcolor_map PARAM_DESCRIPTION, Default: vocabulary_id_standard_colors
#' @param fillcolor_map_other PARAM_DESCRIPTION, Default: 'gray20'
#' @param image_from PARAM_DESCRIPTION, Default: NULL
#' @param image_map PARAM_DESCRIPTION, Default: NULL
#' @param fontname_from PARAM_DESCRIPTION, Default: NULL
#' @param fontname_map PARAM_DESCRIPTION, Default: NULL
#' @param fontcolor_from PARAM_DESCRIPTION, Default: standard_concept
#' @param fontcolor_map PARAM_DESCRIPTION, Default: c(C = "black", S = "black", `NA` = "gray40")
#' @param fontcolor_map_other PARAM_DESCRIPTION, Default: NULL
#' @param peripheries_from PARAM_DESCRIPTION, Default: NULL
#' @param peripheries_map PARAM_DESCRIPTION, Default: NULL
#' @param x_from PARAM_DESCRIPTION, Default: NULL
#' @param x_map PARAM_DESCRIPTION, Default: NULL
#' @param y_from PARAM_DESCRIPTION, Default: NULL
#' @param y_map PARAM_DESCRIPTION, Default: NULL
#' @param group_from PARAM_DESCRIPTION, Default: NULL
#' @param group_map PARAM_DESCRIPTION, Default: NULL
#' @param tooltip_from PARAM_DESCRIPTION, Default: NULL
#' @param tooltip_map PARAM_DESCRIPTION, Default: NULL
#' @param xlabel_from PARAM_DESCRIPTION, Default: NULL
#' @param xlabel_map PARAM_DESCRIPTION, Default: NULL
#' @param URL_from PARAM_DESCRIPTION, Default: NULL
#' @param URL_map PARAM_DESCRIPTION, Default: NULL
#' @param sides_from PARAM_DESCRIPTION, Default: NULL
#' @param sides_map PARAM_DESCRIPTION, Default: NULL
#' @param orientation_from PARAM_DESCRIPTION, Default: NULL
#' @param orientation_map PARAM_DESCRIPTION, Default: NULL
#' @param skew_from PARAM_DESCRIPTION, Default: NULL
#' @param skew_map PARAM_DESCRIPTION, Default: NULL
#' @param distortion_from PARAM_DESCRIPTION, Default: NULL
#' @param distortion_map PARAM_DESCRIPTION, Default: NULL
#' @param gradientangle_from PARAM_DESCRIPTION, Default: NULL
#' @param gradientangle_map PARAM_DESCRIPTION, Default: NULL
#' @param fixedsize_from PARAM_DESCRIPTION, Default: NULL
#' @param fixedsize_map PARAM_DESCRIPTION, Default: NULL
#' @param labelloc_from PARAM_DESCRIPTION, Default: NULL
#' @param labelloc_map PARAM_DESCRIPTION, Default: NULL
#' @param margin_from PARAM_DESCRIPTION, Default: NULL
#' @param margin_map PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[cli]{cli_alert}}
#'  \code{\link[dplyr]{tidyeval-compat}},\code{\link[dplyr]{mutate}}
#'  \code{\link[purrr]{keep}}
#'  \code{\link[tibble]{as_tibble}}
#' @rdname map_node_attributes
#' @export
#' @importFrom cli cat_rule cli_alert_info
#' @importFrom dplyr enquo mutate
#' @importFrom purrr keep
#' @importFrom tibble as_tibble
map_node_attributes <-
  function(nodes_and_edges,
           fontsize = 26,
           fontname = NULL,
           width    = 4,
           height   = 4,
           shape_from = standard_concept,
           shape_map =   c(C = "square",
                           S = "circle",
                           `NA` = "circle"),
           shape_map_other = "circle",
           style_from = standard_concept,
           style_map = c(C = "filled",
                           S = "filled",
                           `NA` = "filled"),
           style_map_other = NULL,
           penwidth_from = NULL,
           penwidth_map = NULL,
           color_from = standard_concept,
           color_map =   c(C = "black",
                           S = "black",
                           `NA` = "white"),
           color_map_other = "white",
           fillcolor_from = vocabulary_id,
           fillcolor_map = node_color_map$vocabulary_id$Base,
           fillcolor_map_other = "gray20",
           image_from = NULL,
           image_map = NULL,
           fontname_from = NULL,
           fontname_map = NULL,
           fontcolor_from = standard_concept,
           fontcolor_map = c(C = "black",
                             S = "black",
                             `NA` = "gray40"),
           fontcolor_map_other = "gray40",
           peripheries_from = NULL,
           peripheries_map = NULL,
           x_from = NULL,
           x_map = NULL,
           y_from = NULL,
           y_map = NULL,
           group_from = NULL,
           group_map = NULL,
           xlabel_from = NULL,
           xlabel_map = NULL,
           URL_from = NULL,
           URL_map = NULL,
           sides_from = NULL,
           sides_map = NULL,
           orientation_from = NULL,
           orientation_map = NULL,
           skew_from = NULL,
           skew_map = NULL,
           distortion_from = NULL,
           distortion_map = NULL,
           gradientangle_from = NULL,
           gradientangle_map = NULL,
           fixedsize_from = NULL,
           fixedsize_map = NULL,
           labelloc_from = NULL,
           labelloc_map = NULL,
           margin_from = NULL,
           margin_map = NULL) {


    cli::cat_rule(
      "\nNode Attributes",
      line = 2,
      width = 60)

    all_args <- formals()

    if (!is.null(all_args$shape_from)) {
      cli::cli_alert_info("Shape from: {all_args$shape_from}")
      shape_from <- dplyr::enquo(shape_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(shape = map_to_value(!!shape_from,
                                    map_assignment = shape_map,
                                    other = shape_map_other))
    }

    if (!is.null(all_args$style_from)) {
      cli::cli_alert_info("Style from: {all_args$style_from}")
      style_from <- dplyr::enquo(style_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(style = map_to_value(!!style_from,
                                    map_assignment = style_map,
                                    other = style_map_other))
    }

    if (!is.null(all_args$penwidth_from)) {
      cli::cli_alert_info("Penwidth from: {all_args$penwidth_from}")
      penwidth_from <- dplyr::enquo(penwidth_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(penwidth = map_to_value(!!penwidth_from,
                                       map_assignment = penwidth_map,
                                       other = penwidth_map_other))
    }

    if (!is.null(all_args$color_from)) {
      cli::cli_alert_info("Color from: {all_args$color_from}")
      color_from <- dplyr::enquo(color_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(color = map_to_value(!!color_from,
                                    map_assignment = color_map,
                                    other = color_map_other))
    }

    if (!is.null(all_args$fillcolor_from)) {
      cli::cli_alert_info("Fillcolor from: {all_args$fillcolor_from}")
      fillcolor_from <- dplyr::enquo(fillcolor_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(fillcolor = map_to_value(!!fillcolor_from,
                                        map_assignment = fillcolor_map,
                                        other = fillcolor_map_other))
    }

    if (!is.null(all_args$image_from)) {
      cli::cli_alert_info("Image from: {all_args$image_from}")
      image_from <- dplyr::enquo(image_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(image = map_to_value(!!image_from,
                                    map_assignment = image_map,
                                    other = image_map_other))
    }

    if (!is.null(all_args$fontcolor_from)) {
      cli::cli_alert_info("Fontcolor from: {all_args$fontcolor_from}")
      fontcolor_from <- dplyr::enquo(fontcolor_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(fontcolor = map_to_value(!!fontcolor_from,
                                        map_assignment = fontcolor_map,
                                        other = fontcolor_map_other))
    }

    if (!is.null(all_args$peripheries_from)) {
      peripheries_from <- dplyr::enquo(peripheries_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(peripheries = map_to_value(!!peripheries_from,
                                          map_assignment = peripheries_map,
                                          other = peripheries_map_other))
    }

    if (!is.null(all_args$x_from)) {
      x_from <- dplyr::enquo(x_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(x = map_to_value(!!x_from,
                                map_assignment = x_map,
                                other = x_map_other))
    }

    if (!is.null(all_args$y_from)) {
      y_from <- dplyr::enquo(y_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(y = map_to_value(!!y_from,
                                map_assignment = y_map,
                                other = y_map_other))
    }

    if (!is.null(all_args$group_from)) {
      group_from <- dplyr::enquo(group_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(group = map_to_value(!!group_from,
                                    map_assignment = group_map,
                                    other = group_map_other))
    }

    if (!is.null(all_args$xlabel_from)) {
      xlabel_from <- dplyr::enquo(xlabel_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(xlabel = map_to_value(!!xlabel_from,
                                     map_assignment = xlabel_map,
                                     other = xlabel_map_other))
    }

    if (!is.null(all_args$URL_from)) {
      URL_from <- dplyr::enquo(URL_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(URL = map_to_value(!!URL_from,
                                  map_assignment = URL_map,
                                  other = URL_map_other))
    }

    if (!is.null(all_args$sides_from)) {
      sides_from <- dplyr::enquo(sides_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(sides = map_to_value(!!sides_from,
                                    map_assignment = sides_map,
                                    other = sides_map_other))
    }

    if (!is.null(all_args$orientation_from)) {
      orientation_from <- dplyr::enquo(orientation_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(orientation = map_to_value(!!orientation_from,
                                          map_assignment = orientation_map,
                                          other = orientation_map_other))
    }

    if (!is.null(all_args$skew_from)) {
      skew_from <- dplyr::enquo(skew_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(skew = map_to_value(!!skew_from,
                                   map_assignment = skew_map,
                                   other = skew_map_other))
    }

    if (!is.null(all_args$distortion_from)) {
      distortion_from <- dplyr::enquo(distortion_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(distortion = map_to_value(!!distortion_from,
                                         map_assignment = distortion_map,
                                         other = distortion_map_other))
    }

    if (!is.null(all_args$gradientangle_from)) {
      gradientangle_from <- dplyr::enquo(gradientangle_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(gradientangle = map_to_value(!!gradientangle_from,
                                            map_assignment = gradientangle_map,
                                            other = gradientangle_map_other))
    }

    if (!is.null(all_args$fixedsize_from)) {
      fixedsize_from <- dplyr::enquo(fixedsize_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(fixedsize = map_to_value(!!fixedsize_from,
                                        map_assignment = fixedsize_map,
                                        other = fixedsize_map_other))
    }

    if (!is.null(all_args$labelloc_from)) {
      labelloc_from <- dplyr::enquo(labelloc_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(labelloc = map_to_value(!!labelloc_from,
                                       map_assignment = labelloc_map,
                                       other = labelloc_map_other))
    }

    if (!is.null(all_args$margin_from)) {
      margin_from <- dplyr::enquo(margin_from)
      nodes_and_edges$nodes@data <-
        nodes_and_edges$nodes@data %>%
        dplyr::mutate(margin = map_to_value(!!margin_from,
                                     map_assignment = margin_map,
                                     other = margin_map_other))
    }

    # Constant Attributes
    constant_attrs <-
      c("fontsize",
        "fontname",
        "width",
        "height")

    constant_attrs <-
      formals()[names(formals()) %in% constant_attrs] %>%
      purrr::keep(~!is.null(.))
    constant_attrs_df <-
      tibble::as_tibble(constant_attrs)
    nodes_and_edges$nodes@data <-
      cbind(nodes_and_edges$nodes@data,
            constant_attrs_df)
    cli::cli_alert_info("{length(constant_attrs)} constant attribute{?s} added: {names(constant_attrs)}.")
    nodes_and_edges$has_node_attrs <- TRUE
    nodes_and_edges

  }




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
#' @rdname map_edge_attributes
#' @export
#' @importFrom cli cat_rule cli_alert_info
#' @importFrom dplyr enquo mutate
#' @importFrom purrr keep
#' @importFrom tibble as_tibble
map_edge_attributes <-
  function(nodes_and_edges,
           fontsize = 26,
           len = 5,
           label_from = relationship_name,
           style_from = defines_ancestry,
           style_map = defines_ancestry_styles,
           style_map_other = "dotted",
           penwidth_from = NULL,
           penwidth_map = NULL,
           penwidth_map_other = NULL,
           color_from = relationship_source,
           color_map = relationship_source_colors,
           color_map_other = "black",
           arrowsize_from = defines_ancestry,
           arrowsize_map = c(`0` = 2, `1` = 2),
           arrowsize_map_other = 2,
           arrowhead_from = is_hierarchical,
           arrowhead_map = c(`1` = "vee",
                             `0` = "vee"),
           arrowhead_map_other = NULL,
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
    if (!is.null(all_args$style_from)) {
      style_from <- dplyr::enquo(style_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(style = map_to_value(!!style_from,
                                           map_assignment = style_map,
                                           other = style_map_other))
    }

    if (!is.null(all_args$penwidth_from)) {
      penwidth_from <- dplyr::enquo(penwidth_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(penwidth = map_to_value(!!penwidth_from,
                                              map_assignment = penwidth_map,
                                              other = penwidth_map_other))
    }

    if (!is.null(all_args$color_from)) {
      color_from <- dplyr::enquo(color_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(color = map_to_value(!!color_from,
                                           map_assignment = color_map,
                                           other = color_map_other))
    }

    if (!is.null(all_args$arrowsize_from)) {
      arrowsize_from <- dplyr::enquo(arrowsize_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(arrowsize = map_to_value(!!arrowsize_from,
                                               map_assignment = arrowsize_map,
                                               other = arrowsize_map_other))
    }

    if (!is.null(all_args$arrowhead_from)) {
      arrowhead_from <- dplyr::enquo(arrowhead_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(arrowhead = map_to_value(!!arrowhead_from,
                                               map_assignment = arrowhead_map,
                                               other = arrowhead_map_other))
    }

    if (!is.null(all_args$arrowtail_from)) {
      arrowtail_from <- dplyr::enquo(arrowtail_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(arrowtail = map_to_value(!!arrowtail_from,
                                               map_assignment = arrowtail_map,
                                               other = arrowtail_map_other))
    }

    if (!is.null(all_args$fontname_from)) {
      fontname_from <- dplyr::enquo(fontname_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(fontname = map_to_value(!!fontname_from,
                                              map_assignment = fontname_map,
                                              other = fontname_map_other))
    }

    if (!is.null(all_args$fontsize_from)) {
      fontsize_from <- dplyr::enquo(fontsize_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(fontsize = map_to_value(!!fontsize_from,
                                              map_assignment = fontsize_map,
                                              other = fontsize_map_other))
    }

    if (!is.null(all_args$fontcolor_from)) {
      fontcolor_from <- dplyr::enquo(fontcolor_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(fontcolor = map_to_value(!!fontcolor_from,
                                               map_assignment = fontcolor_map,
                                               other = fontcolor_map_other))
    }

    if (!is.null(all_args$tooltip_from)) {
      tooltip_from <- dplyr::enquo(tooltip_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(tooltip = map_to_value(!!tooltip_from,
                                             map_assignment = tooltip_map,
                                             other = tooltip_map_other))
    }

    if (!is.null(all_args$URL_from)) {
      URL_from <- dplyr::enquo(URL_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(URL = map_to_value(!!URL_from,
                                         map_assignment = URL_map,
                                         other = URL_map_other))
    }

    if (!is.null(all_args$edgetooltip_from)) {
      edgetooltip_from <- dplyr::enquo(edgetooltip_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(edgetooltip = map_to_value(!!edgetooltip_from,
                                                 map_assignment = edgetooltip_map,
                                                 other = edgetooltip_map_other))
    }

    if (!is.null(all_args$edgeURL_from)) {
      edgeURL_from <- dplyr::enquo(edgeURL_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(edgeURL = map_to_value(!!edgeURL_from,
                                             map_assignment = edgeURL_map,
                                             other = edgeURL_map_other))
    }

    if (!is.null(all_args$dir_from)) {
      dir_from <- dplyr::enquo(dir_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(dir = map_to_value(!!dir_from,
                                         map_assignment = dir_map,
                                         other = dir_map_other))
    }

    if (!is.null(all_args$headtooltip_from)) {
      headtooltip_from <- dplyr::enquo(headtooltip_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(headtooltip = map_to_value(!!headtooltip_from,
                                                 map_assignment = headtooltip_map,
                                                 other = headtooltip_map_other))
    }

    if (!is.null(all_args$headURL_from)) {
      headURL_from <- dplyr::enquo(headURL_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(headURL = map_to_value(!!headURL_from,
                                             map_assignment = headURL_map,
                                             other = headURL_map_other))
    }

    if (!is.null(all_args$headclip_from)) {
      headclip_from <- dplyr::enquo(headclip_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(headclip = map_to_value(!!headclip_from,
                                              map_assignment = headclip_map,
                                              other = headclip_map_other))
    }

    if (!is.null(all_args$headlabel_from)) {
      headlabel_from <- dplyr::enquo(headlabel_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(headlabel = map_to_value(!!headlabel_from,
                                               map_assignment = headlabel_map,
                                               other = headlabel_map_other))
    }

    if (!is.null(all_args$headport_from)) {
      headport_from <- dplyr::enquo(headport_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(headport = map_to_value(!!headport_from,
                                              map_assignment = headport_map,
                                              other = headport_map_other))
    }

    if (!is.null(all_args$tailtooltip_from)) {
      tailtooltip_from <- dplyr::enquo(tailtooltip_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(tailtooltip = map_to_value(!!tailtooltip_from,
                                                 map_assignment = tailtooltip_map,
                                                 other = tailtooltip_map_other))
    }

    if (!is.null(all_args$tailURL_from)) {
      tailURL_from <- dplyr::enquo(tailURL_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(tailURL = map_to_value(!!tailURL_from,
                                             map_assignment = tailURL_map,
                                             other = tailURL_map_other))
    }

    if (!is.null(all_args$tailclip_from)) {
      tailclip_from <- dplyr::enquo(tailclip_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(tailclip = map_to_value(!!tailclip_from,
                                              map_assignment = tailclip_map,
                                              other = tailclip_map_other))
    }

    if (!is.null(all_args$taillabel_from)) {
      taillabel_from <- dplyr::enquo(taillabel_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(taillabel = map_to_value(!!taillabel_from,
                                               map_assignment = taillabel_map,
                                               other = taillabel_map_other))
    }

    if (!is.null(all_args$tailport_from)) {
      tailport_from <- dplyr::enquo(tailport_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(tailport = map_to_value(!!tailport_from,
                                              map_assignment = tailport_map,
                                              other = tailport_map_other))
    }

    if (!is.null(all_args$decorate_from)) {
      decorate_from <- dplyr::enquo(decorate_from)
      nodes_and_edges$edges@data <-
        nodes_and_edges$edges@data %>%
        dplyr::mutate(decorate = map_to_value(!!decorate_from,
                                              map_assignment = decorate_map,
                                              other = decorate_map_other))
    }

    # Constant Attributes
    constant_attrs <-
      c("fontsize",
        "len")

    constant_attrs <-
      formals()[names(formals()) %in% constant_attrs] %>%
      purrr::keep(~!is.null(.))
    constant_attrs_df <-
      tibble::as_tibble(constant_attrs)
    nodes_and_edges$edges@data <-
      cbind(nodes_and_edges$edges@data,
            constant_attrs_df)
    cli::cli_alert_info("{length(constant_attrs)} constant attribute{?s} added: {names(constant_attrs)}.")

    nodes_and_edges$has_edge_attrs <- TRUE
    nodes_and_edges

  }
