
sort_by_edge <-
  function(omop_graph,
           ...) {

    omop_graph2 <-
      omop_graph$copy()

    omop_graph2$graph$edges_df <-
    omop_graph2$graph$edges_df %>%
      dplyr::arrange(...)

    omop_graph2

  }
