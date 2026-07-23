# Parameterized Term Enrollment Report

## Overview

This sanitized Oracle SQL example demonstrates a reusable enrollment report with optional term, organization, and level filters.

## Purpose

The report returns active participants for a selected reporting year and can be filtered by:

- Term
- Organization
- Minimum level
- Maximum level

## Tables Used

- participants
- enrollments
- terms
- organizations
- courses

## SQL Concepts Demonstrated

- Multi-table INNER JOIN
- Bind variables
- Optional parameter filtering
- Active-record filtering
- Reporting-year filtering
- Range filtering
- DISTINCT
- Multi-column sorting

## Parameters

- :reporting_year_id
- :term_id
- :organization_id
- :level_min
- :level_max

The reporting year is required. The other parameters are optional.

## Optional Filters

Optional filters use this pattern:

:term_id IS NULL
OR trm.term_id = :term_id

When the parameter is null, the filter is ignored.

## Level Range Logic

The minimum and maximum filters can be used separately or together.

## Business Logic

A record is included when:

1. The participant is active.
2. The enrollment belongs to the selected reporting year.
3. Any supplied optional filters are satisfied.

## Sanitization

The public version replaces organization names, identifiers, course codes, term values, participant details, and system-specific field names.

## Potential Uses

- Enrollment reports
- Employee training rosters
- Membership reporting
- Course participation
- Department assignments
- Certification tracking
