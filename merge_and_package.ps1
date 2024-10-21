param (
    [string]$KubeDeckPath = "KubeDeckUi.ps1",
    [string]$KubeTidyPath = "KubeTidyUi.ps1",
    [string]$OutputFilePath = "KubeDeck.exe",
    [string]$IconPath = "KubeDeck.ico"
)

# Convert KubeTidyUi.ps1 to Base64
$bytes = [System.IO.File]::ReadAllBytes($KubeTidyPath)
$base64KubeTidy = [Convert]::ToBase64String($bytes)

# Read KubeDeckUi.ps1 content
$kubeDeckContent = Get-Content -Path $KubeDeckPath -Raw

# Add the Base64 content for KubeTidy to KubeDeck script
$mergedContent = @"
# Base64-encoded KubeTidyUi.ps1 script
\$base64KubeTidy = @"
$base64KubeTidy
"@

# Original KubeDeck script content
$kubeDeckContent

# Modify Launch KubeTidy Button Click Event to Execute Embedded KubeTidy
\$btnLaunchKubeTidy = \$window.FindName("btnLaunchKubeTidy")
if (\$btnLaunchKubeTidy) {
    \$btnLaunchKubeTidy.Add_Click({
        # Decode and execute the embedded KubeTidy script
        \$decodedBytes = [Convert]::FromBase64String(\$base64KubeTidy)
        \$scriptText = [System.Text.Encoding]::UTF8.GetString(\$decodedBytes)

        try {
            # Run the KubeTidy script
            Invoke-Expression \$scriptText
        } catch {
            [System.Windows.MessageBox]::Show("Error launching KubeTidy: \$_.Exception.Message", "Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
        }
    })
}
"@

# Write the merged script to a temporary file
$mergedFilePath = Join-Path -Path $env:TEMP -ChildPath "MergedKubeDeck.ps1"
Set-Content -Path $mergedFilePath -Value $mergedContent

# Package the merged script as an exe using PS2EXE
Write-Output "Packaging the merged script as an exe..."
Invoke-PS2EXE -InputFile $mergedFilePath -OutputFile $OutputFilePath -IconPath $IconPath -NoConsole -Force
Write-Output "Packaging complete: $OutputFilePath"
