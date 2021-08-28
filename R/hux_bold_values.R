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
hux_bold_values <-
  function(ht,
           ...,
           values,
           ignore_na = TRUE) {

    target_cols <- enquos(...)
    target_cols <-
      ht %>%
      select(!!!target_cols) %>%
      colnames()

    for (target_col in target_cols) {
      ht <-
        map_bold(ht = ht,
                 row = everywhere,
                 col = target_col,
                 fn  = by_values(values, ignore_na = ignore_na))

    }

    ht


  }
