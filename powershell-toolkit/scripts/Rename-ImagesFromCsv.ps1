[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string]$FolderPath,

    [string]$CsvPath = ".\rename-images.csv",

    [ValidateSet("CreateCsv", "Rename")]
    [string]$Mode = "CreateCsv"
)

$ErrorActionPreference = "Stop"

$supportedExtensions = @(
    ".jpg",
    ".jpeg",
    ".png",
    ".gif",
    ".bmp",
    ".webp",
    ".tif",
    ".tiff"
)

try {
    $resolvedFolder = Resolve-Path -Path $FolderPath

    if ($Mode -eq "CreateCsv") {
        $files = Get-ChildItem -Path $resolvedFolder -File |
            Where-Object {
                $supportedExtensions -contains $_.Extension.ToLowerInvariant()
            } |
            Sort-Object Name

        if (-not $files) {
            throw "No supported image files were found in $resolvedFolder."
        }

        $files |
            ForEach-Object {
                [PSCustomObject]@{
                    CurrentName = $_.Name
                    NewName     = $_.Name
                }
            } |
            Export-Csv -Path $CsvPath -NoTypeInformation

        Write-Host "CSV template created: $CsvPath"
        Write-Host "Images found: $($files.Count)"
        Write-Host "Edit the NewName column, save the CSV, and run the script in Rename mode."
        return
    }

    if (-not (Test-Path -Path $CsvPath -PathType Leaf)) {
        throw "CSV file not found: $CsvPath"
    }

    $renameList = Import-Csv -Path $CsvPath

    if (-not $renameList) {
        throw "The CSV file contains no rename records."
    }

    $requiredColumns = @("CurrentName", "NewName")
    $csvColumns = $renameList[0].PSObject.Properties.Name

    foreach ($column in $requiredColumns) {
        if ($column -notin $csvColumns) {
            throw "The CSV is missing the required column: $column"
        }
    }

    $operations = foreach ($record in $renameList) {
        $currentName = $record.CurrentName.Trim()
        $newName = $record.NewName.Trim()

        if ([string]::IsNullOrWhiteSpace($currentName) -or
            [string]::IsNullOrWhiteSpace($newName) -or
            $currentName -eq $newName) {
            continue
        }

        $sourcePath = Join-Path $resolvedFolder $currentName
        $destinationPath = Join-Path $resolvedFolder $newName

        if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
            Write-Warning "Source file not found: $currentName"
            continue
        }

        if (Test-Path -LiteralPath $destinationPath) {
            Write-Warning "Destination already exists: $newName"
            continue
        }

        [PSCustomObject]@{
            CurrentName     = $currentName
            NewName         = $newName
            SourcePath      = $sourcePath
            DestinationPath = $destinationPath
        }
    }

    if (-not $operations) {
        Write-Host "No valid rename operations were found."
        return
    }

    Write-Host ""
    Write-Host "Proposed rename operations:"
    $operations | Format-Table CurrentName, NewName -AutoSize

    foreach ($operation in $operations) {
        if ($PSCmdlet.ShouldProcess(
            $operation.SourcePath,
            "Rename to $($operation.NewName)"
        )) {
            Rename-Item `
                -LiteralPath $operation.SourcePath `
                -NewName $operation.NewName
        }
    }

    Write-Host "Rename operation completed."
}
catch {
    Write-Error "Unable to process image renaming: $($_.Exception.Message)"
    exit 1
}
