# Edge Attributes
defines_ancestry_styles <-
  c(`1` = "bold",
    `0` = "solid")



# Edge Colors
relationship_source_colors <-
  c(`OMOP`    = "black",
    `SNOMED`  = "cadetblue4",
    `NA`      = "black",
    `RxNorm`  = "violetred4",
    `NDF-RT`  = "orange3",
    `NLM`     = "saddlebrown",
    `DM+D`    = "royalblue4",
    `HemOnc`  = "mediumpurple4",
    `LOINC`   = "yellow4",
    `NAACCR`  = "orangered4",
    `PPI`     = "yellowgreen",
    `Question-Answer/Variable-Value` = "gray20",
    `dictionary of medicines and devices` = "gray20",
    `SNOMED Vet` = "darkviolet",
    `NDF` = "darkgreen",
    `CMS` = "steelblue4",
    `Hemonc` = "saddlebrown"
    )


# Node Attributes
rxnorm_class_colors <-
  c(
    `Branded Drug` = 'springgreen3',
    `Clinical Drug` = 'springgreen3',
    `Branded Pack` = 'orange2',
    `Clinical Pack` = 'orange2',
    `Quant Branded Drug` = 'royalblue2',
    `Quant Clinical Drug` = 'royalblue2',
    `Brand Name` = 'violetred2',
    `Branded Drug Comp` = 'peachpuff2',
    `Clinical Drug Comp` = 'peachpuff2',
    `Ingredient` = 'violetred2',
    `Multiple Ingredients` = 'violetred2',
    `Clinical Dose Group` = 'lightpink2',
    `Dose Form Group` = 'lightpink2',
    `Branded Dose Group` = 'lightpink2',
    `Precise Ingredient` = 'violetred2',
    `Clinical Drug Form` = 'purple2',
    `Dose Form` = 'purple2',
    `Branded Drug Form` = 'purple2',
    `Branded Drug Box` = 'lightgoldenrod2',
    `Clinical Drug Box` = 'lightgoldenrod2',
    `Branded Pack Box` = 'lightgoldenrod2',
    `Clinical Pack Box` = 'lightgoldenrod2',
    `Quant Branded Box` = 'lightgoldenrod2',
    `Quant Clinical Box` = 'lightgoldenrod2',
    `Marketed Product` = 'lightgoldenrod2')


omop_ext_class_colors <-
  c(`Transcript Variant` = "cadetblue",
    `Protein Variant` = "indianred",
    `Genomic Variant` = "mediumpurple")

hemonc_class_colors <-
  c(`Brand Name` = "darkorange",
    `Component` = "maroon2",
    `Component Class` = "maroon4",
    `Condition` = "thistle",
    `Context`   = "lightcyan",
    `Modality` = 'lightseagreen',
    `Procedure` = "cyan",
    `Regimen`   = "dodgerblue2",
    `Regimen Class` = "dodgerblue4",
    `Route` = "red")

rxnorm_concept_class_color_groups <-
  c(
  'Branded Drug' = 'Green colors',
    'Clinical Drug' = 'Green colors',
    'Branded Pack' = 'Orange colors',
    'Clinical Pack' = 'Orange colors',
    'Quant Branded Drug' = 'Blue colors',
    'Quant Clinical Drug' = 'Blue colors',
    'Brand Name' = 'Red colors',
    'Branded Drug Comp' = 'Yellow colors',
    'Clinical Drug Comp' = 'Yellow colors',
    'Ingredient' = 'Red colors',
    'Multiple Ingredients' = 'Red colors',
    'Clinical Dose Group' = "Pink colors",
    'Branded Dose Group' = "Pink colors",
    'Dose Form Group' = "Pink colors",
    'Precise Ingredient' = 'Red colors',
    'Clinical Drug Form' = 'Purple, violet, and magenta colors',
    'Dose Form' = 'Purple, violet, and magenta colors',
    'Branded Drug Form' = 'Purple, violet, and magenta colors',
    'Branded Drug Box' = 'Brown colors',
    'Clinical Drug Box' = 'Brown colors',
    'Branded Pack Box' = 'Brown colors',
    'Clinical Pack Box' = 'Brown colors',
    'Quant Branded Box' = 'Brown colors',
    'Quant Clinical Box' = 'Brown colors',
    'Marketed Product' = 'Brown colors')


domain_color_groups <-
  c(
    'Condition'           = "Cyan colors",
    'Condition Status'    = "Cyan colors",
    'Condition/Device'    = "Cyan colors",
    'Condition/Meas'      = "Cyan colors",
    'Condition/Obs'       = "Cyan colors",
    'Condition/Procedure' = "Cyan colors",
    'Cost'                = "White colors",
    'Currency'            = "White colors",
    'Device'              = "Purple, violet, and magenta colors",
    'Device/Procedure'    = "Purple, violet, and magenta colors",
    'Drug'                = "Red colors",
    'Drug/Procedure'      = "Red colors",
    'Episode'             = "Blue colors",
    'Ethnicity'           = "White colors",
    'Gender'              = "White colors",
    'Geography'           = "White colors",
    'Meas Value'          = "Orange colors",
    'Meas Value Operator' = "Orange colors",
    'Measurement'         = "Orange colors",
    'Metadata'            = "Pink colors",
    'Obs/Procedure'       = "Blue colors",
    'Observation'         = "Blue colors",
    'Payer'               = "White colors",
    'Place of Service' = "White colors",
    'Plan' = "White colors",
    'Plan Stop Reason' = "White colors",
    'Procedure' = "Yellow colors",
    'Provider' = "Green colors",
    'Race'  = "White colors",
    'Regimen' = "Red colors",
    'Relationship' = "Pink colors",
    'Revenue Code' = "Pink colors",
    'Route' = "Red colors",
    'Spec Anatomic Site' = "Blue colors",
    'Spec Disease Status' = "Blue colors",
    'Specimen' = "Brown colors",
    'Sponsor' = "Pink colors",
    'Type Concept' = "Pink colors",
    'Unit' = "Yellow colors",
    'Visit' = "Blue colors"
  )

domain_colors <-
  c(
    `Condition` = 'aquamarine',
    `Condition Status` = 'aquamarine',
    `Condition/Device` = 'aquamarine',
    `Condition/Meas` = 'aquamarine',
    `Condition/Obs` = 'aquamarine',
    `Condition/Procedure` = 'aquamarine',
    `Cost` = 'honeydew',
    `Currency` = 'honeydew',
    `Device` = 'lightslateblue',
    `Device/Procedure` = 'lightslateblue',
    `Drug` = 'firebrick1',
    `Drug/Procedure` = 'firebrick1',
    `Episode` = 'dodgerblue',
    `Ethnicity` = 'honeydew',
    `Gender` = 'honeydew',
    `Geography` = 'honeydew',
    `Meas Value` = 'darkorange',
    `Meas Value Operator` = 'darkorange',
    `Measurement` = 'darkorange',
    `Metadata` = 'tomato',
    `Obs/Procedure` = 'dodgerblue',
    `Observation` = 'dodgerblue',
    `Payer` = 'honeydew',
    `Place of Service` = 'honeydew',
    `Plan` = 'honeydew',
    `Plan Stop Reason` = 'honeydew',
    `Procedure` = 'gold',
    `Provider` = 'palegreen',
    `Race` = 'honeydew',
    `Regimen` = 'firebrick1',
    `Relationship` = 'tomato',
    `Revenue Code` = 'tomato',
    `Route` = 'firebrick1',
    `Spec Anatomic Site` = 'dodgerblue',
    `Spec Disease Status` = 'dodgerblue',
    `Specimen` = 'tan',
    `Sponsor` = 'tomato',
    `Type Concept` = 'tomato',
    `Unit` = 'gold',
    `Visit` = 'dodgerblue')


vocabulary_id_standard_colors <-
  c(
    `ATC` = 'goldenrod2',
    `CIViC` = 'wheat2',
    `CPT4` = 'blue2',
    `Cancer Modifier` = 'royalblue2',
    `ClinVar` = 'chartreuse2',
    `Cohort` = 'chocolate2',
    `Concept Class` = 'seashell2',
    `Condition Status` = 'orchid2',
    `Condition Type` = 'slateblue2',
    `Cost` = 'firebrick2',
    `Cost Type` = 'violetred2',
    `Currency` = 'darkorange2',
    `DRG` = 'mediumorchid2',
    `Death Type` = 'sienna2',
    `Device Type` = 'cornsilk2',
    `Domain` = 'honeydew2',
    `Drug Type` = 'lightgoldenrod2',
    `EphMRA ATC` = 'azure2',
    `Episode` = 'thistle2',
    `Episode Type` = 'burlywood2',
    `Ethnicity` = 'cadetblue2',
    `GCN_SEQNO` = 'tan2',
    `HCPCS` = 'orange2',
    `HGNC` = 'lightcyan2',
    `HemOnc` = 'cadetblue2',
    `ICD10` = 'rosybrown2',
    `ICD10CM` = 'indianred2',
    `ICD10CN` = 'deepskyblue2',
    `ICD10GM` = 'bisque2',
    `ICD10PCS` = 'darkolivegreen2',
    `ICD9CM` = 'palevioletred2',
    `ICD9Proc` = 'pink2',
    `ICD9ProcCN` = 'plum2',
    `ICDO3` = 'peachpuff2',
    `JAX` = 'mediumpurple2',
    `LOINC` = 'seagreen2',
    `MeSH` = 'steelblue2',
    `Meas Type` = 'skyblue2',
    `MedDRA` = 'red2',
    `Metadata` = 'purple2',
    `NAACCR` = 'paleturquoise2',
    `NCIt` = 'yellow2',
    `NDC` = 'magenta2',
    `NDFRT` = 'dodgerblue2',
    `Nebraska Lexicon` = 'gold2',
    `None` = 'green2',
    `OMOP Extension` = 'palegreen2',
    `OMOP Genomic` = "slategray",
    `Observation Type` = 'tomato2',
    `OncoKB` = 'lavenderblush2',
    `PCORNet` = 'darkseagreen2',
    `Race` = 'aquamarine2',
    `Relationship` = 'lemonchiffon2',
    `RxNorm` = 'deeppink2',
    `RxNorm Extension` = 'mistyrose2',
    `SNOMED` = 'lightskyblue2',
    `Specimen Type` = 'olivedrab2',
    `Type Concept` = 'salmon2',
    `UCUM` = 'lightblue2',
    `Vocabulary` = 'cyan2')

vocabulary_id_class_colors <-
  vocabulary_id_standard_colors

vocabulary_id_nonstandard_colors <-
  c(
    `ATC` = 'goldenrod4',
    `CIViC` = 'wheat4',
    `CPT4` = 'blue4',
    `Cancer Modifier` = 'royalblue4',
    `ClinVar` = 'chartreuse4',
    `Cohort` = 'chocolate4',
    `Concept Class` = 'seashell4',
    `Condition Status` = 'orchid4',
    `Condition Type` = 'slateblue4',
    `Cost` = 'firebrick4',
    `Cost Type` = 'violetred4',
    `Currency` = 'darkorange4',
    `DRG` = 'mediumorchid4',
    `Death Type` = 'sienna4',
    `Device Type` = 'cornsilk4',
    `Domain` = 'honeydew4',
    `Drug Type` = 'lightgoldenrod4',
    `EphMRA ATC` = 'azure4',
    `Episode` = 'thistle4',
    `Episode Type` = 'burlywood4',
    `Ethnicity` = 'cadetblue4',
    `GCN_SEQNO` = 'tan4',
    `HCPCS` = 'orange4',
    `HGNC` = 'lightcyan4',
    `HemOnc` = 'maroon4',
    `ICD10` = 'rosybrown4',
    `ICD10CM` = 'indianred4',
    `ICD10CN` = 'deepskyblue4',
    `ICD10GM` = 'bisque4',
    `ICD10PCS` = 'darkolivegreen4',
    `ICD9CM` = 'palevioletred4',
    `ICD9Proc` = 'pink4',
    `ICD9ProcCN` = 'plum4',
    `ICDO3` = 'peachpuff4',
    `JAX` = 'mediumpurple4',
    `LOINC` = 'seagreen4',
    `MeSH` = 'steelblue4',
    `Meas Type` = 'skyblue4',
    `MedDRA` = 'red4',
    `Metadata` = 'purple4',
    `NAACCR` = 'paleturquoise4',
    `NCIt` = 'yellow4',
    `NDC` = 'magenta4',
    `NDFRT` = 'dodgerblue4',
    `Nebraska Lexicon` = 'gold4',
    `None` = 'green4',
    `OMOP Extension` = 'palegreen4',
    `Observation Type` = 'tomato4',
    `OncoKB` = 'lavenderblush4',
    `PCORNet` = 'darkseagreen4',
    `Race` = 'aquamarine4',
    `Relationship` = 'lemonchiffon4',
    `RxNorm` = 'deeppink4',
    `RxNorm Extension` = 'mistyrose4',
    `SNOMED` = 'lightskyblue4',
    `Specimen Type` = 'olivedrab4',
    `Type Concept` = 'salmon4',
    `UCUM` = 'lightblue4',
    `Vocabulary` = 'cyan4')





node.map <-
  setClass(Class = "node.map",
           list(domain_id = "list",
                vocabulary_id = "list",
                concept_class_id = "list",
                standard_concept = "list",
                invalid_reason = "list"))

#' @export

node_color_map <-
  new(Class = "node.map",
      domain_id        = list(Base = domain_colors),
      vocabulary_id    = list(Base = vocabulary_id_standard_colors),
      concept_class_id = list(RxNorm = rxnorm_class_colors,
                              HemOnc = hemonc_class_colors,
                              `OMOP Extension` = omop_ext_class_colors),
      invalid_reason   = list(`NA` = "orangered",
                              `U`  = "orangered4",
                              `D`  = "midnightblue"))


edge.map <-
  setClass(Class = "edge.map",
           list(relationship_id = "list",
                relationship_name = "list",
                relationship_source = "list",
                defines_ancestry = "list",
                is_hierarchical = "list"))

#' @export

edge_style_map <-
  new(Class = "edge.map",
      defines_ancestry = list(Base = defines_ancestry_styles))

#' @export
edge_color_map <-
  new(Class = "edge.map",
      relationship_source = list(Base = relationship_source_colors))
