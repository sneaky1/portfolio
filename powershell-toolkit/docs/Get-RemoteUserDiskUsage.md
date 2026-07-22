# Get-RemoteUserDiskUsage.ps1

## Purpose

Reports the amount of disk space used by each user profile folder on a remote Windows computer.

## What the Script Does

- Connects to a remote computer with PowerShell Remoting
- Scans folders under C:\Users
- Calculates the total size of each user folder
- Sorts results from largest to smallest
- Exports the results to a CSV file
- Provides basic error handling

## Requirements

- Windows PowerShell 5.1 or PowerShell 7
- PowerShell Remoting enabled on the target computer
- Administrative access to the target computer
- Network connectivity to the target computer

## Example

```powershell
.\scripts\Get-RemoteUserDiskUsage.ps1 -ComputerName "TEST-PC01"
```

## Custom Output Path

```powershell
.\scripts\Get-RemoteUserDiskUsage.ps1 `
    -ComputerName "TEST-PC01" `
    -OutputPath ".\sample-output\TEST-PC01-disk-usage.csv"
```

## Sample Output Fields

- ComputerName
- UserFolder
- Path
- SizeGB

## Security Notes

The public version uses sample computer names and relative output paths. Internal server names, usernames, network paths, and organization-specific information are not included.
