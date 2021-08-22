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


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param version_key PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @rdname rmd_print_version
#' @keywords internal
#' @importFrom rlang list2
#' @importFrom stringr str_replace_all
#' @importFrom easyBakeOven print_list

rmd_print_version <-
  function(version_key,
           ...) {

    version_key <-
    version_key[names(version_key) %in%
                   c("sa_datetime",
                     "sa_release_version")]

    output <- list()
    if ("sa_datetime" %in% names(version_key)) {

      output[[length(output)+1]] <-
        as.character(version_key$sa_datetime)

      names(output)[length(output)] <-
        "OMOP Vocabulary Loaded At"

    }

    if ("sa_release_version" %in% names(version_key)) {


      output[[length(output)+1]] <-
        version_key$sa_release_version

      names(output)[length(output)] <-
        "OMOP Vocabulary Release Version"


    }

    if (!missing(...)) {

      vocabularies <-
        unlist(rlang::list2(...))

      vocabularies_fn <-
        stringr::str_replace_all(string = vocabularies,
                                 pattern = "[+]{1}|[ ]{1}",
                                 replacement = "_")
      vocabularies_fn <-
        tolower(vocabularies_fn)


      vocabularies_fn <-
        sprintf("%s_version",
                vocabularies_fn)


      output2 <- list()

      for (i in seq_along(vocabularies)) {


        vocabulary_id <- vocabularies[i]
        vocabulary_field <- vocabularies_fn[i]


        vocabulary_version <-
        version_key[[vocabulary_field]]

        output2[[i]] <-
          ifelse(is.null(vocabulary_version), NA, vocabulary_version)

        names(output2)[i] <- vocabulary_id


      }

      output <-
        c(output,
          output2)

    }

    easyBakeOven::print_list(output)


  }

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param version_key PARAM_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname console_print_version
#' @keywords internal
#' @importFrom rlang list2
#' @importFrom stringr str_replace_all
#' @importFrom tibble tibble
#' @import huxtable

console_print_version <-
  function(version_key,
           ...) {


    version_key <-
      version_key[names(version_key) %in%
                    c("sa_datetime",
                      "sa_release_version")]

    output <- list()
    if ("sa_datetime" %in% names(version_key)) {

      output[[length(output)+1]] <-
        as.character(version_key$sa_datetime)

      names(output)[length(output)] <-
        "OMOP Vocabulary Loaded At"

    }

    if ("sa_release_version" %in% names(version_key)) {


      output[[length(output)+1]] <-
        version_key$sa_release_version

      names(output)[length(output)] <-
        "OMOP Vocabulary Release Version"


    }

    if (!missing(...)) {

      vocabularies <-
        unlist(rlang::list2(...))

      vocabularies_fn <-
        stringr::str_replace_all(string = vocabularies,
                                 pattern = "[+]{1}|[ ]{1}",
                                 replacement = "_")
      vocabularies_fn <-
        tolower(vocabularies_fn)


      vocabularies_fn <-
        sprintf("%s_version",
                vocabularies_fn)


      output2 <- list()

      for (i in seq_along(vocabularies)) {


        vocabulary_id <- vocabularies[i]
        vocabulary_field <- vocabularies_fn[i]


        vocabulary_version <-
          version_key[[vocabulary_field]]

        output2[[i]] <-
          ifelse(is.null(vocabulary_version), NA, vocabulary_version)

        names(output2)[i] <- vocabulary_id


      }
    }

      output <-
        c(output,
          output2)

      tibble_output <-
        tibble::tibble(
          attribute = names(output),
          value     = unlist(unname(output))
        )


      ht_output <-
        huxtable::hux(tibble_output,
                      add_colnames = FALSE)


      ht_output <-
        huxtable::set_na_string(ht_output,
                                "Not Available")

      ht_output <-
        ht_output %>%
        huxtable::theme_compact()

      ht_output <-
        huxtable::set_all_borders(ht_output)

      ht_output <-
        huxtable::set_all_border_colors(ht_output, "black")


      huxtable::print_screen(ht_output,
                             colnames = FALSE)




  }
