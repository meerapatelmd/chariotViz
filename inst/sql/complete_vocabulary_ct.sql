SELECT
  vocabulary_id,
  COUNT(DISTINCT concept_id) AS complete_vocabulary_ct
FROM {schema}.concept
GROUP BY vocabulary_id
ORDER BY COUNT(DISTINCT concept_id);
