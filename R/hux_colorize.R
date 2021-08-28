#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ht PARAM_DESCRIPTION
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
#'  \code{\link[huxtable]{huxtable}},\code{\link[huxtable]{background_color}}
#' @rdname hux_colorize
#' @export
#' @importFrom huxtable hux map_background_color
hux_colorize <-
  function(ht,
           ...) {

    require(huxtable)
    require(plotrix)

    if ("huxtable" %in% class(ht)) {

      data <-
        as_tibble(ht)

      colnames(data) <-
        unlist(data[1,])

      data <-
        data[-1,]
    } else {

      data <- ht

    }

    fillcolor_cols <- enquos(...)

    legend <- data
    fillcolors <- vector(mode = "list",
                         length = length(fillcolor_cols))
    col_index <- vector(mode = "list",
                        length = length(fillcolor_cols))
    i <- 0
    for (fillcolor_col in fillcolor_cols) {
      i <- i+1
      legend <-
        legend %>%
        mutate(!!fillcolor_col := map(!!fillcolor_col, function(x) color.id(x)[1])) %>%
        mutate(!!fillcolor_col := unlist(!!fillcolor_col))

      col_index[[i]] <-
        grep(
          legend %>%
            select(!!fillcolor_col) %>%
            colnames(),
          colnames(data))

      fillcolors[[i]] <-
        legend %>%
        select(!!fillcolor_col) %>%
        unlist() %>%
        unname()

    }

    legend_ht <-
      huxtable::hux(legend)

    for (j in 1:i) {
      legend_ht <-
        huxtable::map_background_color(legend_ht,
                                       row = 2:nrow(legend_ht),
                                       col = col_index[[j]],
                                       by_rows(fillcolors[[j]]))

    }
    legend_ht
  }
