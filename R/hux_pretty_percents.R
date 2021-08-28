#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ht PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param digits PARAM_DESCRIPTION, Default: 1
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
#' @rdname hux_pretty_percents
#' @export
#' @importFrom huxtable hux number_format fmt_percent
#' @importFrom dplyr enquos select

hux_pretty_percents <-
  function(ht,
           ...,
           digits = 1) {

    if (!("huxtable" %in% class(ht))) {
      ht <- huxtable::hux(ht)
    }

    number_cols <- dplyr::enquos(...)
    number_cols <-
      ht %>%
      dplyr::select(!!!number_cols) %>%
      colnames()
    huxtable::number_format(ht)[2:nrow(ht), number_cols] <- huxtable::fmt_percent(digits = digits)
    ht
  }
