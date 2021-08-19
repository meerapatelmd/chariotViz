SELECT DISTINCT
  c.domain_id AS ancestor_domain_id,
  c.vocabulary_id AS ancestor_vocabulary_id,
  c.concept_class_id AS ancestor_concept_class_id,
  c.standard_concept AS ancestor_standard_concept,
  c2.domain_id AS descendant_domain_id,
  c2.vocabulary_id AS descendant_vocabulary_id,
  c2.concept_class_id AS descendant_concept_class_id,
  c2.standard_concept AS descendant_standard_concept
FROM {schema}.concept c
INNER JOIN {schema}.concept_ancestor ca
ON c.concept_id = ca.ancestor_concept_id
INNER JOIN {schema}.concept c2
ON c2.concept_id = ca.descendant_concept_id
WHERE
c.invalid_reason IS NULL AND
c2.invalid_reason IS NULL AND
c.vocabulary_id = '{vocabulary_id}' AND
c.concept_class_id <> c2.concept_class_id
;
