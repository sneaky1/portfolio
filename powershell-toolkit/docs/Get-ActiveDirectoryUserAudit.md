# Get-ActiveDirectoryUserAudit.ps1

## Purpose

Creates a CSV audit of enabled Active Directory users, including identity details, department, title, password status, last logon information, and group membership.

## What the Script Does

- Imports the Active Directory PowerShell module
- Retrieves enabled user accounts
- Optionally limits the search to a selected organizational unit
- Collects department, title, email, and account details
- Reports password expiration settings
- Includes last logon, creation, and modification dates
- Retrieves group membership for each user
- Sorts users by display name
- Exports the audit to CSV

## Requirements

- Windows PowerShell 5.1 or PowerShell 7
- Active Directory module installed
- Network access to a domain controller
- Permission to read Active Directory user and group information

## Audit the Entire Domain

```powershell
.\scripts\Get-ActiveDirectoryUserAudit.ps1
```

## Audit a Specific Organizational Unit

```powershell
.\scripts\Get-ActiveDirectoryUserAudit.ps1 `
    -SearchBase "OU=Sample Users,DC=example,DC=com"
```

## Use a Custom Output Path

```powershell
.\scripts\Get-ActiveDirectoryUserAudit.ps1 `
    -OutputPath ".\sample-output\ad-user-audit.csv"
```

## Output Fields

- SamAccountName
- DisplayName
- UserPrincipalName
- Email
- Department
- Title
- Enabled
- PasswordNeverExpires
- PasswordExpired
- LastLogonDate
- Created
- Modified
- DistinguishedName
- GroupMembership

## Use Cases

- Account review and access auditing
- Identifying users with passwords set to never expire
- Reviewing department and title attributes
- Confirming group-based access
- Supporting onboarding and offboarding reviews
- Preparing identity-management reports

## Security Notes

Active Directory exports may contain sensitive identity and access information. Public examples must use fictional users, sample domains, and sanitized group names.
