#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[dplyr]{filter}},\code{\link[dplyr]{select}}
#' @rdname filter_node_id_1
#' @export
#' @importFrom dplyr filter select
filter_node_id_1 <-
  function(omop_graph,
           ...) {

    .Deprecated()
      dplyr::filter(omop_graph@graph$edges_df,
                    ...)  %>%
      dplyr::select(from) %>%
      unlist() %>%
      unname() %>%
      unique()
  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[dplyr]{filter}},\code{\link[dplyr]{select}}
#' @rdname filter_node_id_2
#' @export
#' @importFrom dplyr filter select
filter_node_id_2 <-
  function(omop_graph,
           ...) {
    .Deprecated()
    omop_graph@graph$edges_df %>%
      dplyr::filter(...) %>%
      dplyr::select(from) %>%
      unlist() %>%
      unname() %>%
      unique()
  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_graph PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[dplyr]{filter}},\code{\link[dplyr]{select}}
#' @rdname filter_edge_id
#' @export
#' @importFrom dplyr filter select
filter_edge_id <-
  function(omop_graph,
           ...) {
    .Deprecated()
    omop_graph@graph$edges_df %>%
      dplyr::filter(...) %>%
      dplyr::select(id) %>%
      unlist() %>%
      unname() %>%
      unique()
  }
