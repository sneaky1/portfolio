# Get-MessageSummary.ps1

## Purpose

Reads CSV files, extracts text from a selected column, groups matching messages, counts occurrences, and exports a summary report.

## What the Script Does

- Searches an input folder for matching CSV files
- Reads the selected message column
- Ignores blank values
- Trims unnecessary spaces
- Groups identical messages
- Counts how often each message appears
- Sorts the most common messages first
- Exports the results to CSV

## Requirements

- Windows PowerShell 5.1 or PowerShell 7
- CSV files with a consistent column containing messages

## Example

```powershell
.\scripts\Get-MessageSummary.ps1 `
    -InputFolder ".\sample-data" `
    -FilePattern "col_*.csv" `
    -MessageColumn "cs"
```

## Custom Output Path

```powershell
.\scripts\Get-MessageSummary.ps1 `
    -InputFolder ".\sample-data" `
    -MessageColumn "cs" `
    -OutputPath ".\sample-output\message-summary.csv"
```

## Output Fields

- Message
- Occurrences

## Use Cases

- Frequently reported error analysis
- FAQ development
- Support-ticket trend review
- Log and export cleanup
- Repeated-message reporting

## Security Notes

Public examples should use sanitized messages and sample filenames. Internal records, usernames, server names, student information, and organization-specific content should not be published.
