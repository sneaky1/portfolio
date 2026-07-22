# Rename-ImagesFromCsv.ps1

## Purpose

Reads image files from a selected folder, exports the filenames to a CSV template, and renames the files in bulk using the edited CSV.

## What the Script Does

- Reads supported image files from a selected folder
- Sorts the files by name
- Creates a CSV with CurrentName and NewName columns
- Allows the NewName column to be edited in Excel or another CSV editor
- Validates the CSV before renaming files
- Skips unchanged rows
- Warns when a source file is missing
- Prevents overwriting an existing destination file
- Supports PowerShell WhatIf previews

## Supported Image Types

- JPG and JPEG
- PNG
- GIF
- BMP
- WEBP
- TIF and TIFF

## Step 1: Create the CSV Template

```powershell
.\scripts\Rename-ImagesFromCsv.ps1 `
    -FolderPath ".\images" `
    -CsvPath ".\rename-images.csv" `
    -Mode CreateCsv
```

## Step 2: Edit the CSV

Open rename-images.csv and change only the NewName values.

Example:

```text
CurrentName,NewName
IMG_0001.png,Dashboard.png
IMG_0002.png,New-Ticket.png
```

## Step 3: Preview the Rename

```powershell
.\scripts\Rename-ImagesFromCsv.ps1 `
    -FolderPath ".\images" `
    -CsvPath ".\rename-images.csv" `
    -Mode Rename `
    -WhatIf
```

## Step 4: Perform the Rename

```powershell
.\scripts\Rename-ImagesFromCsv.ps1 `
    -FolderPath ".\images" `
    -CsvPath ".\rename-images.csv" `
    -Mode Rename
```

## CSV Columns

- CurrentName: the existing filename
- NewName: the replacement filename

## Safety Features

- Supports WhatIf before making changes
- Does not overwrite files that already exist
- Skips rows where the old and new names match
- Reports missing source files
- Validates required CSV columns

## Security and Privacy

The public example uses generic filenames and relative paths. Production folders, internal file names, user data, and organization-specific information should be removed before publication.
