-- Student Risk Indicator Summary
-- Sanitized portfolio example

WITH risk_flags AS (
    SELECT
        s.student_id,

        CASE
            WHEN
                COALESCE(r.general_flag_01, 0) = 1 OR
                COALESCE(r.general_flag_02, 0) = 1 OR
                COALESCE(r.general_flag_03, 0) = 1 OR
                COALESCE(r.general_flag_04, 0) = 1
            THEN 1
            ELSE 0
        END AS is_at_risk,

        CASE
            WHEN
                COALESCE(r.prekindergarten_flag_01, 0) = 1 OR
                COALESCE(r.prekindergarten_flag_02, 0) = 1 OR
                COALESCE(r.prekindergarten_flag_03, 0) = 1
            THEN 1
            ELSE 0
        END AS is_pre_k_at_risk

    FROM students s

    INNER JOIN student_risk_indicators r
        ON r.student_id = s.student_id

    WHERE s.enrollment_status = 0
)

SELECT
    student_id,
    is_at_risk,
    is_pre_k_at_risk,

    CASE
        WHEN is_at_risk = 1 AND is_pre_k_at_risk = 0
            THEN 'At Risk Only'

        WHEN is_at_risk = 0 AND is_pre_k_at_risk = 1
            THEN 'Pre-K At Risk Only'

        WHEN is_at_risk = 1 AND is_pre_k_at_risk = 1
            THEN 'Both Categories'

        ELSE 'Not At Risk'
    END AS risk_category

FROM risk_flags

ORDER BY student_id;
