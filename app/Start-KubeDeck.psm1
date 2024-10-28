# Start-KubeDeck.psm1
# This is the main entry point for the KubeDeck module

<# Deployment scripts (PowerShell) to load #>
$Path = "$PSScriptRoot\Private\"
Get-ChildItem -Path $Path -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}

Start-KubeDeckLauncher
