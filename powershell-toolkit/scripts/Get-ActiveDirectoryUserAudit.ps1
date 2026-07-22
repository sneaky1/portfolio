[CmdletBinding()]
param(
    [string]$SearchBase,

    [string]$OutputPath = ".\sample-output\active-directory-user-audit.csv"
)

$ErrorActionPreference = "Stop"

try {
    Import-Module ActiveDirectory -ErrorAction Stop

    $properties = @(
        "Department",
        "Title",
        "Mail",
        "PasswordNeverExpires",
        "PasswordExpired",
        "LastLogonDate",
        "Created",
        "Modified"
    )

    $parameters = @{
        Filter     = "Enabled -eq `$true"
        Properties = $properties
    }

    if (-not [string]::IsNullOrWhiteSpace($SearchBase)) {
        $parameters.SearchBase = $SearchBase
    }

    $users = Get-ADUser @parameters

    if (-not $users) {
        throw "No enabled Active Directory users were found."
    }

    $report = foreach ($user in $users) {
        $groups = Get-ADPrincipalGroupMembership -Identity $user |
            Sort-Object Name |
            Select-Object -ExpandProperty Name

        [PSCustomObject]@{
            SamAccountName      = $user.SamAccountName
            DisplayName         = $user.Name
            UserPrincipalName   = $user.UserPrincipalName
            Email               = $user.Mail
            Department          = $user.Department
            Title               = $user.Title
            Enabled             = $user.Enabled
            PasswordNeverExpires = $user.PasswordNeverExpires
            PasswordExpired     = $user.PasswordExpired
            LastLogonDate       = $user.LastLogonDate
            Created             = $user.Created
            Modified            = $user.Modified
            DistinguishedName   = $user.DistinguishedName
            GroupMembership     = $groups -join "; "
        }
    }

    $outputDirectory = Split-Path $OutputPath -Parent

    if ($outputDirectory -and -not (Test-Path $outputDirectory)) {
        New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    }

    $report |
        Sort-Object DisplayName |
        Export-Csv -Path $OutputPath -NoTypeInformation

    Write-Host "Users audited: $($report.Count)"
    Write-Host "Report created: $OutputPath"
}
catch {
    Write-Error "Unable to create the Active Directory audit: $($_.Exception.Message)"
    exit 1
}
