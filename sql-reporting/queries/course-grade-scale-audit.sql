-- Course Configuration and Grade-Scale Audit
-- Sanitized portfolio example based on a real reporting workflow

SELECT DISTINCT
    c.course_number,
    c.course_name,
    c.grade_scale_id,
    cc.term_id,
    cc.school_id,
    CASE
        WHEN c.grade_scale_id IS NULL THEN 'Missing Grade Scale'
        WHEN c.grade_scale_id = :expected_grade_scale_id THEN 'Expected Grade Scale'
        ELSE 'Different Grade Scale'
    END AS audit_status
FROM courses c
LEFT JOIN course_enrollments cc
    ON cc.course_number = c.course_number
WHERE (
        :school_id IS NULL
        OR cc.school_id = :school_id
      )
  AND (
        :term_id IS NULL
        OR cc.term_id = :term_id
      )
ORDER BY
    audit_status,
    c.course_number;
