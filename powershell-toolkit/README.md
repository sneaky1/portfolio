# PowerShell Administration Toolkit

A collection of sanitized PowerShell scripts and repeatable workflows created to support systems administration, reporting, identity management, file analysis, and technical operations.

## Purpose

This toolkit demonstrates how PowerShell can reduce manual work, improve consistency, standardize support tasks, and generate useful administrative reports.

## Included Scripts

### Get-RemoteUserDiskUsage.ps1

Connects to a remote Windows computer, measures disk usage for folders under C:\Users, and exports the results to CSV.

### Get-MessageSummary.ps1

Reads CSV files, extracts messages from a selected column, groups matching messages, counts occurrences, and exports a summary.

### Rename-ImagesFromCsv.ps1

Reads image filenames from a folder, creates an editable CSV template, previews proposed changes, and renames files in bulk.

## Repository Structure

powershell-toolkit/
  scripts/
  docs/
  sample-output/
  images/
  README.md

## Safety Features

- Input validation
- Error handling
- Relative output paths
- WhatIf support for file renaming
- Duplicate-file protection
- Sanitized examples and sample output

## Security and Privacy

All public scripts and examples are sanitized. Organization names, usernames, server names, internal paths, credentials, confidential records, and identifying data are excluded or replaced with sample values.

## Author

Adam Thomas
