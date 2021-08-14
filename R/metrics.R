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
#'  \code{\link[dplyr]{group_by}},\code{\link[dplyr]{summarise}},\code{\link[dplyr]{context}},\code{\link[dplyr]{arrange}},\code{\link[dplyr]{desc}},\code{\link[dplyr]{tidyeval-compat}}
#' @rdname view_to_counts
#' @export
#' @importFrom dplyr group_by summarize n ungroup arrange desc enquos


view_to_counts <-
  function(omop_graph,
           ...) {

  to_counts_df <-
  omop_graph@graph$edges_df %>%
    dplyr::group_by(domain_id_2,
             vocabulary_id_2,
             concept_class_id_2,
             standard_concept_2) %>%
    dplyr::summarize(n = dplyr::n(),
                     .groups = "drop") %>%
    dplyr::ungroup() %>%
    dplyr::arrange(dplyr::desc(n))

  if (!missing(...)) {

    aggregate_by_cols <- dplyr::enquos(...)

    to_counts_df %>%
      dplyr::group_by(!!!aggregate_by_cols) %>%
      dplyr::summarize(n = sum(n, na.rm = TRUE),
                       .groups = "drop") %>%
      dplyr::ungroup() %>%
      dplyr::arrange(dplyr::desc(n))




  } else {

    to_counts_df


  }

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
#'  \code{\link[dplyr]{group_by}},\code{\link[dplyr]{summarise}},\code{\link[dplyr]{context}},\code{\link[dplyr]{arrange}},\code{\link[dplyr]{desc}},\code{\link[dplyr]{tidyeval-compat}}
#' @rdname view_from_counts
#' @export
#' @importFrom dplyr group_by summarize n ungroup arrange desc enquos
view_from_counts <-
  function(omop_graph,
           ...) {

    from_counts_df <-
      omop_graph@graph$edges_df %>%
      dplyr::group_by(domain_id_1,
                      vocabulary_id_1,
                      concept_class_id_1,
                      standard_concept_1) %>%
      dplyr::summarize(n = dplyr::n(),
                       .groups = "drop") %>%
      dplyr::ungroup() %>%
      dplyr::arrange(dplyr::desc(n))

    if (!missing(...)) {

      aggregate_by_cols <- dplyr::enquos(...)

      from_counts_df %>%
        dplyr::group_by(!!!aggregate_by_cols) %>%
        dplyr::summarize(n = sum(n, na.rm = TRUE),
                         .groups = "drop") %>%
        dplyr::ungroup() %>%
        dplyr::arrange(dplyr::desc(n))




    } else {

      from_counts_df


    }

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
#'  \code{\link[dplyr]{group_by}},\code{\link[dplyr]{summarise}},\code{\link[dplyr]{context}},\code{\link[dplyr]{arrange}},\code{\link[dplyr]{desc}},\code{\link[dplyr]{tidyeval-compat}}
#' @rdname view_all_counts
#' @export
#' @importFrom dplyr group_by summarize n ungroup arrange desc enquos

view_all_counts <-
  function(omop_graph,
           ...) {

  counts_df <-
  omop_graph@graph$edges_df %>%
  dplyr::group_by(domain_id_1,
                  vocabulary_id_1,
                  concept_class_id_1,
                  standard_concept_1,
                  domain_id_2,
                  vocabulary_id_2,
                  concept_class_id_2,
                  standard_concept_2) %>%
  dplyr::summarize(n = dplyr::n(),
                   .groups = "drop") %>%
  dplyr::ungroup() %>%
  dplyr::arrange(dplyr::desc(n))

if (!missing(...)) {

  aggregate_by_cols <- dplyr::enquos(...)

  counts_df %>%
    dplyr::group_by(!!!aggregate_by_cols) %>%
    dplyr::summarize(n = sum(n, na.rm = TRUE),
                     .groups = "drop") %>%
    dplyr::ungroup() %>%
    dplyr::arrange(dplyr::desc(n))




} else {

  counts_df


}
  }
