#' @title chariotViz_Relationships S3 Class
#' @export

new_chariotVizRelationships <-
  function(x = tibble::tibble()) {

    stopifnot(is.tibble(x))

    structure(x,
              class = c("chariotVizRelationships", "tbl_df", "tbl", "data.frame"))

  }


print.chariotVizRelationships <-
  function(x,max.rows = 3) {

    cli::cat_rule(glue::glue("{class(x)[1]}"),
                  line = 2,
                  width = 60)


    print.data.frame(head(x,max.rows),
                     row.names = FALSE)

    if (nrow(x)-max.rows>0) {
    cli::cat_line(cli::style_italic(glue::glue("...{nrow(x)-max.rows} more rows")))

    }
  }


new_chariotVizValidConceptRelationships <-
  function(x = tibble::tibble()) {

    structure(x,
              class = c("chariotVizValidConceptRelationships","chariotVizRelationships", "tbl_df", "tbl", "data.frame"))



  }


new_chariotVizCompleteConceptRelationships <-
  function(x = tibble::tibble()) {


    structure(x,
              class = c("chariotVizCompleteConceptRelationships","chariotVizRelationships", "tbl_df", "tbl", "data.frame"))

  }


new_chariotVizConceptAncestors <-
  function(x = tibble::tibble()) {


    structure(x,
              class = c("chariotVizConceptAncestors","chariotVizRelationships", "tbl_df", "tbl", "data.frame"))

  }
