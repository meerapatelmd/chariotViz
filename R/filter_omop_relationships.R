#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_relationships PARAM_DESCRIPTION
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
#'  \code{\link[dplyr]{filter}}
#' @rdname filter_omop_relationships
#' @export
#' @importFrom dplyr filter
filter_omop_relationships <-
  function(omop_relationships,
           ...) {

    if (class(omop_relationships) != "omop.relationships") {

      stop("Not omop.relationships class.")

    }

    output <-
      omop_relationships


    output@data <-
      output@data %>%
      dplyr::filter(...)


    output

  }

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param complete_omop_relationships PARAM_DESCRIPTION
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
#'  \code{\link[dplyr]{filter}}
#' @rdname filter_complete_omop_relationships
#' @export
#' @importFrom dplyr filter
filter_complete_omop_relationships <-
  function(complete_omop_relationships,
           ...) {

    if (class(complete_omop_relationships) != "complete.omop.relationships") {

      stop("Not complete.omop.relationships class.")

    }

    output <-
      complete_omop_relationships


    output@data <-
      output@data %>%
      dplyr::filter(...)


    output

  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_relationships PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname filter_for_mapping_relationships
#' @export
filter_for_mapping_relationships <-
  function(omop_relationships) {

    filter_omop_relationships(
      omop_relationships = omop_relationships,
      relationship_id %in% omop_relationship_id_classification$Mapping
    )

  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_relationships PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname filter_for_taxonomy_relationships
#' @export
filter_for_taxonomy_relationships <-
  function(omop_relationships) {

    filter_omop_relationships(
      omop_relationships = omop_relationships,
      relationship_id %in% omop_relationship_id_classification$Taxonomy
    )

  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_relationships PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname filter_out_mapping_relationships
#' @export
filter_out_mapping_relationships <-
  function(omop_relationships) {

    filter_omop_relationships(
      omop_relationships = omop_relationships,
      !(relationship_id %in% omop_relationship_id_classification$Mapping)
    )

  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_relationships PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname filter_out_taxonomy_relationships
#' @export
filter_out_taxonomy_relationships <-
  function(omop_relationships) {

    filter_omop_relationships(
      omop_relationships = omop_relationships,
      !(relationship_id %in% omop_relationship_id_classification$Taxonomy)
    )

  }

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_relationships PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname filter_for_lateral_relationships
#' @export
filter_for_lateral_relationships <-
  function(omop_relationships) {

    output <-
    filter_out_mapping_relationships(omop_relationships =
                                       omop_relationships)

    filter_out_taxonomy_relationships(omop_relationships = output)

  }


#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param omop_relationships PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @rdname filter_out_lateral_relationships
#' @export
filter_out_lateral_relationships <-
  function(omop_relationships) {

    output <-
      filter_for_mapping_relationships(omop_relationships =
                                         omop_relationships)

    filter_for_taxonomy_relationships(omop_relationships = output)

  }
