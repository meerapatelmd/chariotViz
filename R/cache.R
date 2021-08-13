#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param resultset PARAM_DESCRIPTION
#' @param sql PARAM_DESCRIPTION
#' @param version_key PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @seealso
#'  \code{\link[R.cache]{saveCache}}
#' @rdname save_to_cache
#' @export
#' @importFrom R.cache saveCache
save_to_cache <-
  function(
    resultset,
    sql,
    version_key) {

    R.cache::saveCache(
      object = resultset,
      key    = c(sql, version_key),
      dirs   = "chariotViz"
    )
  }

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param sql PARAM_DESCRIPTION
#' @param version_key PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[R.cache]{loadCache}}
#' @rdname load_from_cache
#' @importFrom R.cache loadCache
load_from_cache <-
  function(sql,
           version_key) {

    R.cache::loadCache(
      key = c(sql, version_key),
      dirs = "chariotViz")

  }


#' @title FUNCTION_TITLE
#' @rdname delete_cache
#' @export
#' @importFrom R.cache clearCache
delete_cache <-
  function() {


    R.cache::clearCache(dirs = "chariotViz")

  }
