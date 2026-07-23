# Course Configuration and Grade-Scale Audit

## Overview

This sanitized SQL example demonstrates how to audit course configuration data and identify missing, expected, or unexpected grade-scale assignments.

The query is based on a real troubleshooting and reporting workflow but removes organization-specific names, identifiers, and configuration values.

## Purpose

The report helps identify courses that:

- Have no grade scale assigned
- Use the expected grade scale
- Use a different grade scale
- Appear in a selected school or term

## Tables Used

- `courses`
- `course_enrollments`

## SQL Concepts Demonstrated

- `LEFT JOIN`
- `CASE` classification
- Null detection
- Optional parameters
- Configuration auditing
- Distinct result filtering
- Multi-column sorting

## Business Logic

Each course is assigned one of three audit statuses:

1. `Missing Grade Scale`
2. `Expected Grade Scale`
3. `Different Grade Scale`

The school and term filters are optional. When a parameter is null, that filter is ignored.

## Why a LEFT JOIN Is Used

A `LEFT JOIN` keeps courses in the result even when no matching enrollment record exists.

This is important during audits because a missing related record may be the issue that needs investigation.

## Sanitization Notes

The public version replaces:

- Course numbers
- School identifiers
- Term identifiers
- Grade-scale identifiers
- Organization-specific table details

The audit structure and troubleshooting logic were retained.

## Potential Uses

This pattern can be adapted for:

- Course configuration audits
- Employee policy assignments
- Product category validation
- Security-role reviews
- Missing configuration detection
- Application setup verification
