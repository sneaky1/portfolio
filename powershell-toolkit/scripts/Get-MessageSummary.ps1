[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$InputFolder,

    [string]$FilePattern = "*.csv",

    [Parameter(Mandatory)]
    [string]$MessageColumn,

    [string]$OutputPath = ".\sample-output\message-summary.csv"
)

$ErrorActionPreference = "Stop"

try {
    $files = Get-ChildItem -Path $InputFolder -Filter $FilePattern -File

    if (-not $files) {
        throw "No files matching $FilePattern were found in $InputFolder."
    }

    $messages = foreach ($file in $files) {
        $rows = Import-Csv -Path $file.FullName

        foreach ($row in $rows) {
            $message = $row.$MessageColumn

            if (-not [string]::IsNullOrWhiteSpace($message)) {
                [PSCustomObject]@{
                    SourceFile = $file.Name
                    Message    = $message.Trim()
                }
            }
        }
    }

    $summary = $messages |
        Group-Object Message |
        ForEach-Object {
            [PSCustomObject]@{
                Message     = $_.Name
                Occurrences = $_.Count
            }
        } |
        Sort-Object -Property @{Expression = "Occurrences"; Descending = $true}, Message

    $outputDirectory = Split-Path $OutputPath -Parent

    if ($outputDirectory -and -not (Test-Path $outputDirectory)) {
        New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    }

    $summary | Export-Csv -Path $OutputPath -NoTypeInformation

    Write-Host "Files processed: $($files.Count)"
    Write-Host "Unique messages: $($summary.Count)"
    Write-Host "Report created: $OutputPath"
}
catch {
    Write-Error "Unable to create the message summary: $($_.Exception.Message)"
    exit 1
}
