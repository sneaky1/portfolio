# Student Risk Indicator Summary

## Purpose

Identifies whether each active student belongs to a general at-risk category, a pre-kindergarten at-risk category, both categories, or neither category.

## What the Query Demonstrates

- Common table expressions
- Conditional logic with CASE
- Null handling with COALESCE
- Multiple indicator fields combined into one result
- Category assignment without double-counting
- Filtering for active enrollment
- Ordered reporting output

## Query Logic

The first part of the query creates two calculated flags:

- is_at_risk
- is_pre_k_at_risk

Each flag returns 1 when at least one related indicator is set to 1. Otherwise, it returns 0.

The final CASE expression assigns each student to one reporting category:

- At Risk Only
- Pre-K At Risk Only
- Both Categories
- Not At Risk

## Double-Counting Consideration

The category column makes it possible to count students once by their final classification instead of independently adding both risk flags.

## Example Count Query

```sql
SELECT
    risk_category,
    COUNT(*) AS student_count
FROM student_risk_summary
GROUP BY risk_category
ORDER BY risk_category;
```

## Sanitization Notes

The public query uses generic table names, field names, and identifiers. Production schema names, student numbers, school names, and confidential records are excluded.
