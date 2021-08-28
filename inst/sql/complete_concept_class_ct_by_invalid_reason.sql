SELECT
  vocabulary_id,
  concept_class_id,
  invalid_reason,
  COUNT(DISTINCT concept_id) AS concept_class_invalid_reason_ct
FROM {schema}.concept
GROUP BY vocabulary_id, concept_class_id, invalid_reason;
