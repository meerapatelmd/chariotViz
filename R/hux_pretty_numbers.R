#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ht PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param big.mark PARAM_DESCRIPTION, Default: ','
#' @param scientific PARAM_DESCRIPTION, Default: FALSE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[huxtable]{huxtable}}
#' @rdname hux_pretty_numbers
#' @export
#' @importFrom huxtable hux number_format fmt_pretty
#' @importFrom dplyr enquos
hux_pretty_numbers <-
  function(ht,
           ...,
           big.mark = ",",
           scientific = FALSE) {

    if (!("huxtable" %in% class(ht))) {
      ht <- huxtable::hux(ht)
    }

    number_cols <- dplyr::enquos(...)
    number_cols <-
      ht %>%
      select(!!!number_cols) %>%
      colnames()
    huxtable::number_format(ht)[2:nrow(ht), number_cols] <-
      huxtable::fmt_pretty(big.mark = big.mark,
                           scientific = scientific)
    ht
  }
