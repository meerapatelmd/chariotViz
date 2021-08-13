#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
#' @param layout PARAM_DESCRIPTION, Default: NULL
#' @param output PARAM_DESCRIPTION, Default: NULL
#' @param as_svg PARAM_DESCRIPTION, Default: FALSE
#' @param title PARAM_DESCRIPTION, Default: NULL
#' @param width PARAM_DESCRIPTION, Default: NULL
#' @param height PARAM_DESCRIPTION, Default: NULL
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[DiagrammeR]{render_graph}}
#' @rdname chariotViz
#' @export
#' @importFrom DiagrammeR render_graph
chariotViz <-
  function(omop_graph,
           force = FALSE,
           layout = NULL,
           output = NULL,
           as_svg = FALSE,
           title = NULL,
           width = 1000,
           height = 1000) {


    if (!force) {

    node_count <-
      DiagrammeR::count_nodes(omop_graph@graph)

    if (node_count > 20) {

      readline(glue::glue("There are {node_code} nodes. To render anyways, set `force` to TRUE."))

    }


    DiagrammeR::render_graph(
      graph = omop_graph@graph,
      layout = layout,
      output = output,
      as_svg = as_svg,
      title = title,
      width = width,
      height = height
    )


    } else {



      DiagrammeR::render_graph(
        graph = omop_graph@graph,
        layout = layout,
        output = output,
        as_svg = as_svg,
        title = title,
        width = width,
        height = height
      )

    }


  }
