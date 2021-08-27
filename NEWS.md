# chariotViz 0.0.2.9000   

## New Documentation  

* Added README  
* Converted some S4 classes to Reference Classes to customize `show` method 
in console.  

## New Features  

### OMOP Relationship Class  

* Added `mutate_nodes()` and `mutate_edges()` to apply to dataframes in `nodes.and.edges` 
objects.  
* Added slot that logs when `append_concept_examples()` is called on an `omop.graph` class object. This 
ensures that `append_concept_examples()` is not called on more than once, resulting in duplicate entries 
in the dataframes used to render the graph.  
* Added `filter_for_*_relationships` and `filter_out_*_relationships` functions to 
refine visualization capabilities  

## OMOP Ancestor Class 

* Introduced `omop.ancestors` class for taxonomy visualization  
* Begin developing features for ancestor visualization   
* Rename `fetch_omop` function to `fetch_omop_relationships` and `fetch_omop_ancestors` 
to accommodate new ancestors feature  


## OMOP Complete Relationship Class  

* Introduced `complete.omop.relationships` class for visualization that includes invalid concepts.  



## Bug Fixes    

* Remove printing of column names when calling `chariotViz()`  
* Converted `omop.relationships`, `complete.omop.relationships`, `omop.ancestors`, 
and all types of `nodes.and.edges` to Reference Classes to default `show` method.  
* Replaced object assignment of Reference Classes to `copy` method  



## Existing Issues  

* Write documentation for functions  
* Improve the scale of rendered graphs  
* Tracing concepts in such a manner that in lieu of `append_example_concepts()` where 
each node is annotated with random examples, the node would be annotated with the actual 
related concept for the input concept.  In terms of relationship filtering, ascending 
the Concept Relationship table with no filters applied leads to an exponential increase in 
related concepts. For example, trastuzumab can map to regimens in HemOnc which subsequently 
can map back to all the antineoplastics that regimen is associated with. For this reason, 
a filter must be applied. Using `is_hierarchical` filters leads to the same issue, but 
`defines_ancestry` does not. Also chariotViz `mapping`, `taxonomy`, and `lateral` filters 
need to be tested.   
* When calling `append_example_concepts()`, errors can sometimes be thrown when the `concept_name` 
has an unusual character (likely single quote).  

* Need the ability to adjust node and edge attributes of the example concepts. 

* The counts used to calculate percent coverage on both sides of the relationship get 
filtered out at some point and should be returned in the legend and tooltip.  

* Improve counts for `complete.omop.relationships`. Counts should include how many are `D`, `U`, 
or `NULL`.  


# chariotViz 0.0.2

* Removed deprecated functions  
* Add `relationship_source` derived from `relationship_name` to omop.relationships 
class objects.  
* Add procedural logicals to nodes.and.edges class objects.  



