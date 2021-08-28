#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param conn PARAM_DESCRIPTION
#' @param conn_fun PARAM_DESCRIPTION, Default: 'pg13::local_connect(verbose=FALSE)'
#' @param schema PARAM_DESCRIPTION, Default: 'omop_vocabulary'
#' @param verbose PARAM_DESCRIPTION, Default: FALSE
#' @param render_sql PARAM_DESCRIPTION, Default: FALSE
#' @param version_key PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname setup_chariotViz
#' @export


setup_chariotViz <-
  function(conn,
           conn_fun = "pg13::local_connect(verbose=FALSE)",
           schema = "omop_vocabulary",
           verbose = FALSE,
           render_sql = FALSE,
           version_key) {


    cli::cli_h1("omop.relationships")
    invisible(fetch_omop_relationships(conn = conn,
                             conn_fun = conn_fun,
                             schema = schema,
                             verbose = verbose,
                             render_sql = render_sql,
                             version_key = version_key))

    cli::cli_h1("complete.omop.relationships")
    invisible(fetch_complete_omop_relationships(conn = conn,
                                      conn_fun = conn_fun,
                                      schema = schema,
                                      verbose = verbose,
                                      render_sql = render_sql,
                                      version_key = version_key))

    cli::cli_h1("omop.ancestors")
    invisible(
    fetch_omop_ancestors(conn = conn,
                         conn_fun = conn_fun,
                         schema = schema,
                         verbose = verbose,
                         render_sql = render_sql,
                         version_key = version_key))

  }
