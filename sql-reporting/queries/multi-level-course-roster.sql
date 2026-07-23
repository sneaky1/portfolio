-- Multi-Level Course Roster and Scheduling Report
-- Sanitized portfolio example based on a production reporting query

SELECT DISTINCT
    s.id AS student_id,
    s.student_number AS sis_student_id,
    s.first_name,
    s.last_name,
    s.grade_level,
    sch.name AS school_name,
    c.course_number,
    c.course_name,
    sec.section_number,
    t.abbreviation AS term_name,
    tea.first_name AS instructor_first_name,
    tea.last_name AS instructor_last_name,
    NULL AS assignment_access_code

FROM cc

INNER JOIN students s
    ON s.id = cc.studentid

INNER JOIN terms t
    ON t.id = cc.termid

INNER JOIN schools sch
    ON sch.school_number = cc.schoolid

INNER JOIN sections sec
    ON sec.id = cc.sectionid

INNER JOIN courses c
    ON c.course_number = cc.course_number

INNER JOIN teachers tea
    ON tea.id = cc.teacherid

WHERE s.enroll_status = 0
  AND t.yearid = :reporting_year_id

  AND tea.teachernumber NOT IN (
      'EXCLUDED001',
      'EXCLUDED002'
  )

  AND (
      (
          s.grade_level IN (3, 4, 5)
          AND c.course_number = 'ELEMENTARY_PROGRAM'
      )

      OR

      (
          s.grade_level = 6
          AND c.course_number IN (
              'GRADE6_PROGRAM_A',
              'GRADE6_PROGRAM_B'
          )
      )

      OR

      (
          s.grade_level = 7
          AND c.course_number IN (
              'GRADE7_PROGRAM_A',
              'GRADE7_PROGRAM_B',
              'GRADE7_PROGRAM_C'
          )
      )

      OR

      (
          s.grade_level = 8
          AND c.course_number IN (
              'GRADE8_PROGRAM_A',
              'GRADE8_PROGRAM_B',
              'GRADE8_PROGRAM_C'
          )
      )

      OR

      (
          s.grade_level IN (9, 10)
          AND c.course_number IN (
              'SECONDARY_PROGRAM_A',
              'SECONDARY_PROGRAM_B',
              'SECONDARY_PROGRAM_C'
          )
      )
  )

ORDER BY
    sch.name,
    s.grade_level,
    s.last_name,
    s.first_name,
    c.course_number;
