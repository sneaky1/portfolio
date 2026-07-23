-- Parameterized Term Enrollment Report
-- Sanitized portfolio example based on a real Oracle reporting workflow

SELECT DISTINCT
    p.person_number,
    p.last_name,
    p.first_name,
    p.level_code,
    org.organization_name,
    trm.term_name,
    crs.course_code,
    crs.course_name
FROM participants p
INNER JOIN enrollments e
    ON e.participant_id = p.participant_id
INNER JOIN terms trm
    ON trm.term_id = e.term_id
INNER JOIN organizations org
    ON org.organization_id = e.organization_id
INNER JOIN courses crs
    ON crs.course_id = e.course_id
WHERE p.status_code = 'ACTIVE'
  AND trm.reporting_year_id = :reporting_year_id
  AND (
        :term_id IS NULL
        OR trm.term_id = :term_id
      )
  AND (
        :organization_id IS NULL
        OR org.organization_id = :organization_id
      )
  AND (
        :level_min IS NULL
        OR p.level_code >= :level_min
      )
  AND (
        :level_max IS NULL
        OR p.level_code <= :level_max
      )
ORDER BY
    org.organization_name,
    p.level_code,
    p.last_name,
    p.first_name;
