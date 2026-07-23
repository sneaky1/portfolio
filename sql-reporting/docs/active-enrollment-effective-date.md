# Active Enrollment and Effective-Date Report

## Overview

This sanitized Oracle SQL example demonstrates point-in-time enrollment reporting using entry dates, exit dates, effective dates, and a selected report date.

The query is based on a real reporting workflow but removes organization-specific table names, identifiers, and program details.

## Purpose

The report identifies participants who were active on a selected reporting date.

It returns:

- Person number
- First and last name
- Eligibility category
- Effective date
- Entry date
- Exit date
- Calculated enrollment status

## Table Used

- `program_participants`

## SQL Concepts Demonstrated

- Oracle date comparisons
- Point-in-time status logic
- Null exit-date handling
- Bind variables
- `CASE` classification
- `TO_CHAR` date formatting
- Active-record filtering
- Multi-column sorting

## Business Logic

A participant is considered active when:

1. The entry date is on or before the selected report date.
2. The exit date is blank or on or after the selected report date.

The query uses the bind variable `:report_date`.

## Date Filtering Versus Formatting

The query compares original date values in the `WHERE` clause.

The `TO_CHAR` function is used only in the `SELECT` list to format dates for display.

## Null Exit Dates

A null exit date represents an open or ongoing enrollment.

The query includes both ongoing records and records that had not ended by the selected report date.

## Sanitization Notes

The public version replaces:

- Student-specific terminology
- Organization identifiers
- Program names
- Eligibility values
- System-specific table and field names
- Personally identifiable information

## Potential Uses

This pattern can be adapted for:

- Student enrollment
- Employee assignments
- Program participation
- Benefit eligibility
- Membership status
- Subscription activity
- Historical compliance reporting
