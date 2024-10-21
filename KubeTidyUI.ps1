Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to get system theme (light or dark mode)
function Get-SystemTheme {
    try {
        $key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        $appsUseLightTheme = Get-ItemPropertyValue -Path $key -Name "AppsUseLightTheme"
        if ($appsUseLightTheme -eq 0) {
            return "Dark"
        }
        return "Light"
    } catch {
        # Default to Light theme if anything goes wrong
        return "Light"
    }
}

# Determine color scheme based on dark mode setting
$isDarkMode = Get-SystemTheme

# Set colors based on mode
if ($isDarkMode) {
    $formBackColor = [System.Drawing.Color]::FromArgb(255, 32, 47, 61)
    $headerBackColor = [System.Drawing.Color]::Black
    $headerForeColor = [System.Drawing.Color]::White
    $labelForeColor = [System.Drawing.Color]::White
    $btnBackColor = [System.Drawing.Color]::FromArgb(17, 169, 187)  # Brand color
    $txtBackColor = [System.Drawing.Color]::FromArgb(50, 50, 50)  # Dark text box
    $txtForeColor = [System.Drawing.Color]::White
} else {
    $formBackColor = [System.Drawing.Color]::FromArgb(32, 47, 61)  # Custom color #202f3d
    $headerBackColor = [System.Drawing.Color]::Black  # Light header
    $headerForeColor = [System.Drawing.Color]::White
    $labelForeColor = [System.Drawing.Color]::Black
    $btnBackColor = [System.Drawing.Color]::FromArgb(17, 169, 187)  # Brand color
    $txtBackColor = [System.Drawing.Color]::White  # Light text box
    $txtForeColor = [System.Drawing.Color]::Black
}

# Create the form
$form = New-Object system.Windows.Forms.Form
$form.Text = "KubeTidy"
$form.Size = New-Object System.Drawing.Size(920, 750)  # Initial form size
$form.StartPosition = "CenterScreen"
$form.AutoSize = $true  # Enable auto-resizing
$form.AutoSizeMode = 'GrowAndShrink'  # Grow based on content
$form.MinimumSize = New-Object System.Drawing.Size(920, 450)  # Minimum size of the form
$form.BackColor = $formBackColor  # Set background color based on mode

# Prevent maximizing and resizing
$form.MaximizeBox = $false  # Disable the maximize button
$form.FormBorderStyle = 'FixedDialog'  # Prevent resizing

# Set the font for Roboto
$robotoFont = New-Object System.Drawing.Font("Roboto", 10)

# Create a FlowLayoutPanel for dynamic layout
$flowPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$flowPanel.Dock = 'Top'
$flowPanel.FlowDirection = 'TopDown'
$flowPanel.AutoSize = $true
$flowPanel.WrapContents = $false
$flowPanel.BackColor = [System.Drawing.Color]::Transparent
$form.Controls.Add($flowPanel)

# Header panel
$headerPanel = New-Object System.Windows.Forms.Panel
$headerPanel.Size = New-Object System.Drawing.Size(880, 60)
$headerPanel.BackColor = $headerBackColor
$headerPanel.Padding = New-Object System.Windows.Forms.Padding(10)
$headerPanel.Dock = 'Top'
$form.Controls.Add($headerPanel)

# Label for Title
$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "KubeTidy"
$lblTitle.ForeColor = $headerForeColor
$lblTitle.Font = New-Object System.Drawing.Font("Roboto", 18, [System.Drawing.FontStyle]::Bold)
$lblTitle.AutoSize = $true
$headerPanel.Controls.Add($lblTitle)

# Center the label vertically within the header panel
$lblTitleHeight = $lblTitle.Height
$headerPanelHeight = $headerPanel.Height
$verticalCenter = ($headerPanelHeight - $lblTitleHeight) / 2
$lblTitle.Location = New-Object System.Drawing.Point(10, $verticalCenter)  # 10 is the X-position (horizontal)

# Panel to hold both the checkboxes and the "Run" button
$headerFlowPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$headerFlowPanel.FlowDirection = 'RightToLeft'  # Align items from right to left
$headerFlowPanel.Dock = 'Fill'
$headerFlowPanel.AutoSize = $true
$headerFlowPanel.WrapContents = $false  # Prevent wrapping
$headerPanel.Controls.Add($headerFlowPanel)

# Add the "Run" button first so it stays on the right (right-to-left flow)
$btnExecute = New-Object System.Windows.Forms.Button
$btnExecute.Text = "Run"
$btnExecute.Size = New-Object System.Drawing.Size(150, 40)
$btnExecute.Font = New-Object System.Drawing.Font("Roboto", 12, [System.Drawing.FontStyle]::Bold)
$btnExecute.BackColor = $btnBackColor  # Brand color
$btnExecute.ForeColor = $headerForeColor
$btnExecute.FlatStyle = 'Flat'
$btnExecute.FlatAppearance.BorderSize = 0
$headerFlowPanel.Controls.Add($btnExecute)

# KubeConfig Path Section
$kubeConfigPanel = New-Object System.Windows.Forms.Panel
$kubeConfigPanel.Size = New-Object System.Drawing.Size(880, 60)
$flowPanel.Controls.Add($kubeConfigPanel)

$lblKubeConfig = New-Object System.Windows.Forms.Label
$lblKubeConfig.Text = "KubeConfig Path:"
$lblKubeConfig.AutoSize = $true
$lblKubeConfig.Location = New-Object System.Drawing.Point(10, 20)
$lblKubeConfig.Font = $robotoFont
$lblKubeConfig.ForeColor = $labelForeColor
$kubeConfigPanel.Controls.Add($lblKubeConfig)

$txtKubeConfig = New-Object System.Windows.Forms.TextBox
$txtKubeConfig.Size = New-Object System.Drawing.Size(600, 25)
$txtKubeConfig.Font = $robotoFont
$txtKubeConfig.Location = New-Object System.Drawing.Point(150, 18)
$txtKubeConfig.BackColor = $txtBackColor
$txtKubeConfig.ForeColor = $txtForeColor
$kubeConfigPanel.Controls.Add($txtKubeConfig)

$btnBrowseKubeConfig = New-Object System.Windows.Forms.Button
$btnBrowseKubeConfig.Text = "Browse"
$btnBrowseKubeConfig.Size = New-Object System.Drawing.Size(100, 30)
$btnBrowseKubeConfig.Font = $robotoFont
$btnBrowseKubeConfig.Location = New-Object System.Drawing.Point(760, 18)
$btnBrowseKubeConfig.BackColor = $btnBackColor  # Brand color
$btnBrowseKubeConfig.ForeColor = $headerForeColor
$btnBrowseKubeConfig.FlatStyle = 'Flat'
$kubeConfigPanel.Controls.Add($btnBrowseKubeConfig)

# Radio buttons for List Clusters and List Contexts
$radioPanel = New-Object System.Windows.Forms.Panel
$radioPanel.Size = New-Object System.Drawing.Size(880, 60)
$flowPanel.Controls.Add($radioPanel)

$radListClusters = New-Object System.Windows.Forms.RadioButton
$radListClusters.Text = "List Clusters"
$radListClusters.Location = New-Object System.Drawing.Point(10, 20)
$radListClusters.Font = $robotoFont
$radListClusters.ForeColor = $labelForeColor
$radioPanel.Controls.Add($radListClusters)

$radListContexts = New-Object System.Windows.Forms.RadioButton
$radListContexts.Text = "List Contexts"
$radListContexts.Location = New-Object System.Drawing.Point(150, 20)
$radListContexts.Font = $robotoFont
$radListContexts.ForeColor = $labelForeColor
$radioPanel.Controls.Add($radListContexts)

$radNone = New-Object System.Windows.Forms.RadioButton
$radNone.Text = "None"
$radNone.Checked = $true
$radNone.Location = New-Object System.Drawing.Point(290, 20)
$radNone.Font = $robotoFont
$radNone.ForeColor = $labelForeColor
$radioPanel.Controls.Add($radNone)

# Checkboxes for "Exclude a Cluster", "Merge Config Files", and "Destination Config" - Horizontal Flow
$chkPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$chkPanel.FlowDirection = 'LeftToRight'
$chkPanel.AutoSize = $true
$chkPanel.Padding = New-Object System.Windows.Forms.Padding(10)
$flowPanel.Controls.Add($chkPanel)

$chkExcludeCluster = New-Object System.Windows.Forms.CheckBox
$chkExcludeCluster.Text = "Exclude a Cluster"
$chkExcludeCluster.Font = $robotoFont
$chkExcludeCluster.ForeColor = $labelForeColor
$chkExcludeCluster.AutoSize = $true
$chkPanel.Controls.Add($chkExcludeCluster)

$chkMergeConfig = New-Object System.Windows.Forms.CheckBox
$chkMergeConfig.Text = "Merge Config Files"
$chkMergeConfig.Font = $robotoFont
$chkMergeConfig.ForeColor = $labelForeColor
$chkMergeConfig.AutoSize = $true
$chkPanel.Controls.Add($chkMergeConfig)

$chkDestinationConfig = New-Object System.Windows.Forms.CheckBox
$chkDestinationConfig.Text = "Destination Config"
$chkDestinationConfig.Font = $robotoFont
$chkDestinationConfig.ForeColor = $labelForeColor
$chkDestinationConfig.AutoSize = $true
$chkPanel.Controls.Add($chkDestinationConfig)

# Create a TableLayoutPanel to align the labels and text boxes
$tablePanel = New-Object System.Windows.Forms.TableLayoutPanel
$tablePanel.ColumnCount = 3  # Increase column count to accommodate button
$tablePanel.RowCount = 0  # Start with 0 rows
$tablePanel.AutoSize = $true
$tablePanel.Dock = 'Top'
$tablePanel.Margin = New-Object System.Windows.Forms.Padding(10)
$flowPanel.Controls.Add($tablePanel)

# Function to add label and textbox to the table
function AddLabelTextBoxRow($labelText) {
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $labelText
    $label.AutoSize = $true
    $label.Location = New-Object System.Drawing.Point(10, 20)
    $label.Font = $robotoFont
    $label.ForeColor = $labelForeColor

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Size = New-Object System.Drawing.Size(600, 30)  # Fixed width for all text boxes
    $textBox.Font = $robotoFont
    $textBox.BackColor = $txtBackColor  # Set background color for text box
    $textBox.ForeColor = $txtForeColor  # Set foreground color for text box

    # Add the label and text box to the next row
    $tablePanel.Controls.Add($label, 0, $tablePanel.RowCount)
    $tablePanel.Controls.Add($textBox, 1, $tablePanel.RowCount)
    $tablePanel.RowCount++  # Increment row count

    # Initially hide the label and text box
    $label.Visible = $false
    $textBox.Visible = $false

    # Return the text box and label for later reference
    return @($textBox, $label)
}

# Add text boxes and labels for Exclusion List, Merge Config Files, and Destination Config
$exclusionRow = AddLabelTextBoxRow "Exclusion List:"
$mergeConfigRow = AddLabelTextBoxRow "Merge Config Files:"
$destinationRow = AddLabelTextBoxRow "Destination Config:"

$exclusionTextBox = $exclusionRow[0]
$lblExclusion = $exclusionRow[1]

$mergeConfigTextBox = $mergeConfigRow[0]
$lblMergeConfig = $mergeConfigRow[1]

$destinationConfigTextBox = $destinationRow[0]
$lblDestinationConfig = $destinationRow[1]

# Create Browse button for Destination Config (Hidden by default)
$btnBrowseDestinationConfig = New-Object System.Windows.Forms.Button
$btnBrowseDestinationConfig.Text = "Browse"
$btnBrowseDestinationConfig.Size = New-Object System.Drawing.Size(100, 30)
$btnBrowseDestinationConfig.Font = $robotoFont
$btnBrowseDestinationConfig.BackColor = $btnBackColor  # Brand color
$btnBrowseDestinationConfig.ForeColor = $headerForeColor
$btnBrowseDestinationConfig.FlatStyle = 'Flat'

# Add the button to the table panel in the same row as the text box
$tablePanel.Controls.Add($btnBrowseDestinationConfig, 2, $tablePanel.RowCount - 1)  # Add to the next column of the last row

# Initially hide the button and text boxes
$exclusionTextBox.Visible = $false
$lblExclusion.Visible = $false
$mergeConfigTextBox.Visible = $false
$lblMergeConfig.Visible = $false
$destinationConfigTextBox.Visible = $false
$lblDestinationConfig.Visible = $false
$btnBrowseDestinationConfig.Visible = $false

# Dynamically adjust visibility based on checkbox selections
$chkExcludeCluster.Add_CheckedChanged({
    $exclusionTextBox.Visible = $chkExcludeCluster.Checked
    $lblExclusion.Visible = $chkExcludeCluster.Checked  # Show/hide label
})

$chkMergeConfig.Add_CheckedChanged({
    $mergeConfigTextBox.Visible = $chkMergeConfig.Checked
    $lblMergeConfig.Visible = $chkMergeConfig.Checked  # Show/hide label
})

$chkDestinationConfig.Add_CheckedChanged({
    $destinationConfigTextBox.Visible = $chkDestinationConfig.Checked
    $lblDestinationConfig.Visible = $chkDestinationConfig.Checked  # Show/hide label
    $btnBrowseDestinationConfig.Visible = $chkDestinationConfig.Checked  # Show/hide browse button
})

# Output RichTextBox
$txtOutput = New-Object System.Windows.Forms.RichTextBox
$txtOutput.Multiline = $true
$txtOutput.ScrollBars = 'Vertical'
$txtOutput.Size = New-Object System.Drawing.Size(880, 150)  # Adjusted width and height
$txtOutput.ReadOnly = $true
$txtOutput.Font = New-Object System.Drawing.Font("Courier New", 10)
$txtOutput.BackColor = [System.Drawing.Color]::Black
$txtOutput.ForeColor = [System.Drawing.Color]::Cyan
$flowPanel.Controls.Add($txtOutput)

# Create the StatusStrip
$statusStrip = New-Object System.Windows.Forms.StatusStrip
$statusStrip.Dock = 'Bottom'
$form.Controls.Add($statusStrip)

# Create "Visit Us" button on the left
$visitButton = New-Object System.Windows.Forms.ToolStripStatusLabel
$visitButton.Text = "Visit Us"
$visitButton.IsLink = $true
$visitButton.ForeColor = $labelForeColor
$visitButton.Font = New-Object System.Drawing.Font("Roboto", 10, [System.Drawing.FontStyle]::Bold)
$visitButton.BackColor = $headerBackColor
$statusStrip.Items.Add($visitButton)

# Create "About" button on the right
$aboutButton = New-Object System.Windows.Forms.ToolStripStatusLabel
$aboutButton.Text = "About"
$aboutButton.ForeColor = $labelForeColor
$aboutButton.Font = New-Object System.Drawing.Font("Roboto", 10, [System.Drawing.FontStyle]::Bold)
$aboutButton.BackColor = $headerBackColor
$statusStrip.Items.Add($aboutButton)

# Right-align the "About" button by adding a spring item (fills space between Visit Us and About)
$spring = New-Object System.Windows.Forms.ToolStripStatusLabel
$spring.Spring = $true
$statusStrip.Items.Insert(1, $spring)

# Add event handler for the "Visit Us" button click to open the website
$visitButton.Click += {
    Start-Process "https://kubetidy.io"
}

# Add event handler for the "About" button to show a new window
$aboutButton.Click += {
    # Create a new form for the About window
    $aboutForm = New-Object system.Windows.Forms.Form
    $aboutForm.Text = "About KubeTidy"
    $aboutForm.Size = New-Object System.Drawing.Size(400, 300)
    $aboutForm.StartPosition = "CenterParent"
    $aboutForm.FormBorderStyle = 'FixedDialog'
    $aboutForm.MaximizeBox = $false
    $aboutForm.BackColor = $formBackColor
    $aboutForm.Font = $robotoFont

    # Add a label with information about the application
    $aboutLabel = New-Object System.Windows.Forms.Label
    $aboutLabel.Text = "KubeTidy Version 1.0`nA tool to tidy your Kubernetes configurations."
    $aboutLabel.ForeColor = $labelForeColor
    $aboutLabel.Location = New-Object System.Drawing.Point(20, 50)
    $aboutLabel.AutoSize = $true
    $aboutForm.Controls.Add($aboutLabel)

    # Show the About form as a modal dialog
    $aboutForm.ShowDialog()
}


# Show Save File Dialog Function
function Show-SaveFileDialog {
    param (
        [string]$Filter,
        [string]$InitialDirectory
    )

    $FileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $FileDialog.Filter = $Filter
    $FileDialog.InitialDirectory = $InitialDirectory

    if ($FileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $FileDialog.FileName
    } else {
        return $null
    }
}

# Open Save File Dialog for Destination Config
$btnBrowseDestinationConfig.Add_Click({
    $filePath = Show-SaveFileDialog -Filter "Config Files (*.yaml, *.yml, *.config)|*.yaml;*.yml;*.config|All Files (*.*)|*.*" -InitialDirectory [System.Environment]::GetFolderPath('MyDocuments')
    if ($filePath) {
        $destinationConfigTextBox.Text = $filePath
    }
})

# Show File Dialog Function
function Show-FileDialog {
    param (
        [string]$DialogType,  # 'Open' or 'Save'
        [string]$Filter,
        [string]$InitialDirectory
    )

    if ($DialogType -eq 'Open') {
        $FileDialog = New-Object System.Windows.Forms.OpenFileDialog
    } elseif ($DialogType -eq 'Save') {
        $FileDialog = New-Object System.Windows.Forms.SaveFileDialog
    }

    $FileDialog.Filter = $Filter
    $FileDialog.InitialDirectory = $InitialDirectory

    if ($FileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $FileDialog.FileName
    } else {
        return $null
    }
}

# Open File Dialog for KubeConfig
$btnBrowseKubeConfig.Add_Click({
    $filePath = Show-FileDialog -DialogType 'Open' `
                                -Filter "KubeConfig Files (*.yaml, *.yml, *.config)|*.yaml;*.yml;*.config|All Files (*.*)|*.*" `
                                -InitialDirectory [System.Environment]::GetFolderPath('MyDocuments')
    if ($filePath) {
        $txtKubeConfig.Text = $filePath
    }
})

# Capture Output Function
function Write-ColoredOutput {
    param (
        [string]$message,
        [string]$color = 'Cyan'
    )
    $txtOutput.SelectionColor = [System.Drawing.Color]::$color
    $txtOutput.AppendText("$message`r`n")
    $txtOutput.ScrollToCaret()
}

# Action for the Run button
$btnExecute.Add_Click({
    $txtOutput.Clear()
    # Get values from inputs
    $KubeConfigPath = $txtKubeConfig.Text
    $ExclusionList = $exclusionTextBox.Text  # Update to get text from exclusionTextBox
    $MergeConfigs = $mergeConfigTextBox.Text  # Update to get text from mergeConfigTextBox
    $DestinationConfig = $destinationConfigTextBox.Text

    # Prepare the parameters for Invoke-KubeTidy
    $invokeParams = @{
        KubeConfigPath  = $KubeConfigPath
        ExclusionList   = $ExclusionList
        MergeConfigs    = $MergeConfigs
        DestinationConfig = $DestinationConfig
    }

    # Add parameters based on selected radio button
if ($radListClusters.Checked) {
    $invokeParams['ListClusters'] = $true  # Add ListClusters flag
} elseif ($radListContexts.Checked) {
    $invokeParams['ListContexts'] = $true   # Add ListContexts flag
}

    # Script execution
    $psOutput = {
        try {
            # Try running the command
            Invoke-KubeTidy @invokeParams
        } catch {
            Write-ColoredOutput "An error occurred while running KubeTidy: $($_.Exception.Message)" 'Red'
        }
    }
    try {
        . {
            & $psOutput 4>&1 5>&1 6>&1 |
            ForEach-Object {
                if ($_ -match "ERROR") {
                    Write-ColoredOutput $_ 'Red'
                }
                elseif ($_ -match "WARNING") {
                    Write-ColoredOutput $_ 'Orange'
                } else {
                    Write-ColoredOutput $_ 'Cyan'
                }
            }
        }
    }
    catch {
        Write-ColoredOutput "An error occurred: $_" 'Red'
    }
})

# Show the form
$form.Topmost = $true
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()