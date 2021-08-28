#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ht PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param values PARAM_DESCRIPTION
#' @param ignore_na PARAM_DESCRIPTION, Default: TRUE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname hux_bold_values
#' @export
#' @importFrom dplyr enquos select
#' @importFrom huxtable map_bold by_values

hux_bold_values <-
  function(ht,
           ...,
           values,
           ignore_na = TRUE) {

    target_cols <- dplyr::enquos(...)
    target_cols <-
      ht %>%
      dplyr::select(!!!target_cols) %>%
      colnames()

    for (target_col in target_cols) {
      ht <-
        huxtable::map_bold(ht = ht,
                 row = everywhere,
                 col = target_col,
                 fn  = huxtable::by_values(values, ignore_na = ignore_na))

    }

    ht


  }
