SELECT DISTINCT
  cr.relationship_id,
  c.vocabulary_id AS vocabulary_id_1,
  c.concept_class_id AS concept_class_id_1,
  c.invalid_reason AS invalid_reason_1,
  COUNT(DISTINCT c.concept_id) AS concept_count_1,
  c2.vocabulary_id AS vocabulary_id_2,
  c2.concept_class_id AS concept_class_id_2,
  c2.invalid_reason AS invalid_reason_2,
  COUNT(DISTINCT c2.concept_id) AS concept_count_2
FROM {schema}.concept c
INNER JOIN {schema}.concept_relationship cr
ON c.concept_id = cr.concept_id_1
INNER JOIN {schema}.concept c2
ON c2.concept_id = cr.concept_id_2
WHERE
cr.invalid_reason IS NULL AND
cr.concept_id_1 <> cr.concept_id_2 AND
c.vocabulary_id = '{vocabulary_id}'
GROUP BY
  cr.relationship_id,
  c.vocabulary_id,
  c.concept_class_id,
  c.invalid_reason,
  c2.vocabulary_id,
  c2.concept_class_id,
  c2.invalid_reason
;
