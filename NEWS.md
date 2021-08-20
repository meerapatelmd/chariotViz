# chariotViz 0.0.2.9000  

## New Features  

* Added README  
* Added `omop.ancestors` class objects for taxonomy visualization  
* Begin developing features for ancestor visualization  
* Rename `fetch_omop` function to `fetch_omop_relationships` and `fetch_omop_ancestors` 
to accomodate new ancestors feature  
* Added `filter_for_*_relationships` and `filter_out_*_relationships` functions to 
refine omop relationships visualization  

## Bug Fixes    

* Remove printing of column names when calling `chariotViz()`  

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

* Add feature that shows deprecated concepts and their relationships  


# chariotViz 0.0.2

* Removed deprecated functions  
* Add `relationship_source` derived from `relationship_name` to omop.relationships 
class objects.  
* Add procedural logicals to nodes.and.edges class objects.  



