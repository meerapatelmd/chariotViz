#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param conn PARAM_DESCRIPTION
#' @param conn_fun PARAM_DESCRIPTION, Default: 'pg13::local_connect(verbose=FALSE)'
#' @param log_schema PARAM_DESCRIPTION, Default: 'public'
#' @param log_table PARAM_DESCRIPTION, Default: 'setup_athena_log'
#' @param log_timestamp_field PARAM_DESCRIPTION, Default: 'sa_datetime'
#' @param template_only PARAM_DESCRIPTION, Default: FALSE
#' @param sql_only PARAM_DESCRIPTION, Default: FALSE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[glue]{glue}}
#'  \code{\link[pg13]{query}}
#' @rdname get_version_key
#' @keywords internal
#' @importFrom glue glue
#' @importFrom pg13 query
#' @export
get_version_key <-
  function(conn,
           conn_fun = "pg13::local_connect(verbose=FALSE)",
           log_schema = "public",
           log_table = "setup_athena_log",
           log_timestamp_field = "sa_datetime",
           template_only = FALSE,
           sql_only = FALSE) {

    sql_template <-
      read_sql_template(file = "get_version_key.sql")

    if (template_only) {

      return(sql_template)

    }

    if (sql_only) {

      return(glue::glue(sql_template))

    }

    version <-
      pg13::query(conn = conn,
                  conn_fun = conn_fun,
                  checks = "",
                  sql_statement = glue::glue(sql_template),
                  verbose = FALSE,
                  render_sql = FALSE)
    as.list(version)

  }



#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param conn PARAM_DESCRIPTION
#' @param conn_fun PARAM_DESCRIPTION, Default: 'pg13::local_connect(verbose=FALSE)'
#' @param log_schema PARAM_DESCRIPTION, Default: 'public'
#' @param log_table PARAM_DESCRIPTION, Default: 'setup_athena_log'
#' @param log_timestamp_field PARAM_DESCRIPTION, Default: 'sa_datetime'
#' @param template_only PARAM_DESCRIPTION, Default: FALSE
#' @param sql_only PARAM_DESCRIPTION, Default: FALSE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[glue]{glue}}
#'  \code{\link[pg13]{query}}
#' @rdname get_logged_version_key
#' @keywords internal
#' @importFrom glue glue
#' @importFrom pg13 query
#' @export
get_logged_version_key <-
  function(conn,
           conn_fun = "pg13::local_connect(verbose=FALSE)",
           log_schema = "public",
           log_table = "setup_athena_log",
           log_timestamp_field = "sa_datetime",
           template_only = FALSE,
           sql_only = FALSE) {

    sql_template <-
      read_sql_template(file = "get_logged_version_key.sql")

    if (template_only) {

      return(sql_template)

    }

    if (sql_only) {

      return(glue::glue(sql_template))

    }

    version <-
      pg13::query(conn = conn,
                  conn_fun = conn_fun,
                  checks = "",
                  sql_statement = glue::glue(sql_template),
                  verbose = FALSE,
                  render_sql = FALSE)
    as.list(version)

  }



#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param conn PARAM_DESCRIPTION
#' @param conn_fun PARAM_DESCRIPTION, Default: 'pg13::local_connect(verbose=FALSE)'
#' @param template_only PARAM_DESCRIPTION, Default: FALSE
#' @param sql_only PARAM_DESCRIPTION, Default: FALSE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[glue]{glue}}
#'  \code{\link[pg13]{query}}
#' @rdname get_vocabulary_version_key
#' @keywords internal
#' @importFrom glue glue
#' @importFrom pg13 query
#' @importFrom purrr set_names
#' @export
get_vocabulary_version_key <-
  function(conn,
           conn_fun = "pg13::local_connect(verbose=FALSE)",
           schema = "omop_vocabulary",
           template_only = FALSE,
           sql_only = FALSE) {

    sql_template <-
      read_sql_template(file = "get_vocabulary_version_key.sql")

    if (template_only) {

      return(sql_template)

    }

    if (sql_only) {

      return(glue::glue(sql_template))

    }

    version <-
      pg13::query(conn = conn,
                  conn_fun = conn_fun,
                  checks = "",
                  sql_statement = glue::glue(sql_template),
                  verbose = FALSE,
                  render_sql = FALSE)
    as.list(version$vocabulary_version) %>%
      purrr::set_names(version$vocabulary_id)

  }
