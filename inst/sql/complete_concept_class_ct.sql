SELECT
  vocabulary_id,
  concept_class_id,
  COUNT(DISTINCT concept_id) AS complete_concept_class_ct
FROM {schema}.concept
GROUP BY vocabulary_id, concept_class_id;
