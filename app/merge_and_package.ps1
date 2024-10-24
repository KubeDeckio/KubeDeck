param (
    [string]$KubeDeckPath = ".\app\KubeDeckUI.ps1",
    [string]$KubeTidyPath = ".\app\KubeTidyUI.ps1",
    [string]$KubeSnapItPath = ".\app\KubeSnapItUI.ps1",    
    [string]$IconPath = "..\assets\images\gen\home\KubeDeck.ico",
    [string]$version = "0.0.1"
)

# Read KubeTidyUi.ps1 content
Write-Output "Reading KubeTidyUi.ps1 content..."
$kubeTidyContent = Get-Content -Path $KubeTidyPath -Raw

# Read KubeDeckUi.ps1 content
Write-Output "Reading KubeDeckUi.ps1 content..."
$kubeDeckContent = Get-Content -Path $KubeDeckPath -Raw

# Read KubeSnapIt.ps1 content
Write-Output "Reading KubeSnapItUi.ps1 content..."
$kubeSnapItContent = Get-Content -Path $KubeSnapItPath -Raw

# Merged Content Creation
Write-Output "Merging KubeTidyUi.ps1, KubeDeckUi.ps1, and KubeSnapIt.ps1..."

$mergedContent = @"
# Combined KubeTidyUi, KubeSnapIt, and KubeDeckUi script

# Original KubeTidyUi.ps1 content
$kubeTidyContent

# Original KubeSnapIt.ps1 content
$kubeSnapItContent

# Original KubeDeckUi.ps1 content
$kubeDeckContent

# Version: $version
"@

# Create the output file name with the version number
$mergedFilePath = Join-Path -Path .\app\ -ChildPath "LaunchKubeDeck_$version.ps1"
Write-Output "Writing merged content to temporary file: $mergedFilePath..."
$mergedContent | Out-File -FilePath $mergedFilePath -Encoding UTF8 -Force
