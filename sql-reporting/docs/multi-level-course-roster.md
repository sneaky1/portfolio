# Multi-Level Course Roster and Scheduling Report

## Overview

This sanitized SQL example demonstrates how a multi-table operational report can combine enrollment, scheduling, course, term, school, and instructor data.

The query is based on a real reporting workflow but removes organization-specific names, identifiers, course codes, and personnel information.

## Purpose

The report identifies actively enrolled records that meet grade-level and course-specific participation rules for a selected reporting year.

It produces a detailed roster containing:

- Student identifier
- SIS identifier
- First and last name
- Grade level
- School
- Course number
- Course name
- Section number
- Term
- Instructor

## Tables Used

- `students`
- `cc`
- `terms`
- `schools`
- `sections`
- `courses`
- `teachers`

## SQL Concepts Demonstrated

- Multi-table `INNER JOIN` operations
- Parameterized filtering
- Active-record filtering
- Grouped `AND` and `OR` logic
- Grade-specific business rules
- Inclusion lists with `IN`
- Exclusion lists with `NOT IN`
- Duplicate prevention with `DISTINCT`
- Multi-column sorting

## Business Logic

The query includes records only when:

1. The student is actively enrolled.
2. The course is associated with the selected reporting year.
3. The instructor is not part of the exclusion list.
4. The student's grade level matches an approved set of course codes.

The grouped conditions allow each grade band to have different course-selection rules without repeating the entire query through multiple `UNION` statements.

## Sanitization Notes

The following values were replaced for public portfolio use:

- School names
- Organization identifiers
- Course numbers
- Instructor identifiers
- Reporting-year values
- Assignment access values
- Personally identifiable information

The query structure and reporting logic were retained to demonstrate the original technical approach.

## Potential Uses

This pattern can be adapted for:

- Course rosters
- Program participation reports
- Employee training assignments
- Membership eligibility reports
- Certification tracking
- Department scheduling
- Access-provisioning audits
