-- Active Enrollment and Effective-Date Report
-- Sanitized portfolio example based on a real Oracle reporting workflow

SELECT
    p.person_number,
    p.last_name,
    p.first_name,
    p.eligibility_category,
    TO_CHAR(p.effective_date, 'MM/DD/YYYY') AS effective_date,
    TO_CHAR(p.entry_date, 'MM/DD/YYYY') AS entry_date,
    TO_CHAR(p.exit_date, 'MM/DD/YYYY') AS exit_date,
    CASE
        WHEN p.entry_date <= :report_date
         AND (
                p.exit_date IS NULL
                OR p.exit_date >= :report_date
             )
            THEN 'Active'
        ELSE 'Inactive'
    END AS enrollment_status
FROM program_participants p
WHERE p.entry_date <= :report_date
  AND (
        p.exit_date IS NULL
        OR p.exit_date >= :report_date
      )
ORDER BY
    p.last_name,
    p.first_name,
    p.person_number;
