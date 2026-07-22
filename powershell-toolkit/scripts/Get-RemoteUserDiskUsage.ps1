[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$ComputerName,

    [string]$OutputPath = ".\sample-output\disk-usage-report.csv"
)

$ErrorActionPreference = "Stop"

try {
    $results = Invoke-Command -ComputerName $ComputerName -ScriptBlock {
        Get-ChildItem "C:\Users" -Directory -ErrorAction SilentlyContinue |
            ForEach-Object {
                $size = Get-ChildItem $_.FullName -File -Recurse -ErrorAction SilentlyContinue |
                    Measure-Object -Property Length -Sum

                [PSCustomObject]@{
                    ComputerName = $env:COMPUTERNAME
                    UserFolder   = $_.Name
                    Path         = $_.FullName
                    SizeGB       = [math]::Round(($size.Sum / 1GB), 2)
                }
            }
    }

    $outputDirectory = Split-Path $OutputPath -Parent

    if ($outputDirectory -and -not (Test-Path $outputDirectory)) {
        New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    }

    $results |
        Sort-Object SizeGB -Descending |
        Export-Csv -Path $OutputPath -NoTypeInformation

    Write-Host "Report created: $OutputPath"
}
catch {
    Write-Error "Unable to create the disk-usage report: $($_.Exception.Message)"
    exit 1
}
