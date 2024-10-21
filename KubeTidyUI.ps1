Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

# Ensure the KubeTidy module is installed and loaded
if (-not (Get-Module -ListAvailable -Name 'KubeTidy')) {
    try {
        Install-Module -Name 'KubeTidy' -Scope CurrentUser -Force -ErrorAction Stop
    }
    catch {
        Write-Error "Error: Unable to install the KubeTidy module from the PowerShell Gallery. Please check your internet connection and permissions."
        return
    }
}

# Load the KubeTidy module
try {
    Import-Module KubeTidy -ErrorAction Stop
}
catch {
    Write-Error "Error: Unable to load the KubeTidy module. Please make sure it is installed and accessible."
    return
}

# Function to get system theme (light or dark mode)
function Get-SystemTheme {
    try {
        $key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        $appsUseLightTheme = Get-ItemPropertyValue -Path $key -Name "AppsUseLightTheme"
        if ($appsUseLightTheme -eq 0) {
            return "Dark"
        }
        return "Light"
    }
    catch {
        # Default to Light theme if anything goes wrong
        return "Light"
    }
}

# Determine color scheme based on dark mode setting
$isDarkMode = Get-SystemTheme

# Set colors based on mode
$formBackColor = if ($isDarkMode -eq "Dark") { "#202f3d" } else { "#f0f0f0" }
$headerBackColor = "Black"
$headerForeColor = "White"
$labelForeColor = if ($isDarkMode -eq "Dark") { "White" } else { "Black" }
$btnBackColor = "#11A9BB"
$txtBackColor = if ($isDarkMode -eq "Dark") { "#323232" } else { "White" }
$txtForeColor = if ($isDarkMode -eq "Dark") { "White" } else { "Black" }

# Function to create the KubeTidy UI using WPF
function Create-KubeTidyLauncher {
    [xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="KubeTidy" 
        SizeToContent="WidthAndHeight"
        MinHeight="450" MinWidth="920"
        Background="$formBackColor" 
        WindowStartupLocation="CenterScreen" 
        ResizeMode="CanMinimize" 
        FontFamily="Roboto" 
        FontSize="12">

    <DockPanel>
        <!-- Header Section -->
        <Grid DockPanel.Dock="Top" Background="$headerBackColor" Height="60">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="Auto" /> <!-- Title Column -->
                <ColumnDefinition Width="*" /> <!-- Filler Column -->
                <ColumnDefinition Width="Auto" /> <!-- Checkboxes Column -->
                <ColumnDefinition Width="Auto" /> <!-- Run Button Column -->
            </Grid.ColumnDefinitions>

            <TextBlock Grid.Column="0" Text="KubeTidy" FontSize="24" Foreground="$headerForeColor" Padding="0" VerticalAlignment="Center" FontWeight="Bold"/>
            
            <!-- Checkboxes for Dry Run and Backup Options -->
            <StackPanel Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center" Margin="10,0">
                <CheckBox x:Name="chkBackup" Content="Backup Config" Foreground="$headerForeColor" Margin="10,0" IsChecked="True"/>
                <CheckBox x:Name="chkDryRun" Content="Dry Run" Foreground="$headerForeColor" Margin="10,0"/>
                <CheckBox x:Name="chkForce" Content="Force" Foreground="$headerForeColor" Margin="10,0"/>
                
            </StackPanel>

            <!-- Run Button -->
            <Button x:Name="btnRun" Grid.Column="3" Content="Run" Width="150" Height="30" HorizontalAlignment="Right" Margin="10"
                    Background="$btnBackColor" Foreground="$headerForeColor" FontWeight="Bold"/>
        </Grid>

        <!-- Main Content -->
        <ScrollViewer DockPanel.Dock="Top" VerticalScrollBarVisibility="Auto">
            <StackPanel Margin="10" VerticalAlignment="Top">

                <!-- KubeConfig Path Section -->
                <Grid Margin="10,20,10,20">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="150" /> <!-- Label Column -->
                        <ColumnDefinition Width="*" /> <!-- Input Box Column -->
                        <ColumnDefinition Width="Auto" /> <!-- Browse Button Column -->
                    </Grid.ColumnDefinitions>

                    <TextBlock Text="KubeConfig Path:" VerticalAlignment="Center" Foreground="$labelForeColor" Grid.Column="0"/>
                    <TextBox x:Name="txtKubeConfig" Height="30" Width="600" Background="$txtBackColor" Foreground="$txtForeColor" Margin="10,10,10,10" Grid.Column="1" VerticalContentAlignment="Center"/>
                    <Button x:Name="btnBrowseKubeConfig" Content="Browse" Width="100" Height="30" Background="$btnBackColor" Foreground="$headerForeColor" Grid.Column="2"/>
                </Grid>

                <!-- Radio Buttons Section for List Clusters and Contexts -->
                <StackPanel Orientation="Horizontal" Margin="10,15">
                    <RadioButton x:Name="radListClusters" Content="List Clusters" GroupName="RadioGroup" Foreground="$labelForeColor" Margin="10,0"/>
                    <RadioButton x:Name="radListContexts" Content="List Contexts" GroupName="RadioGroup" Foreground="$labelForeColor" Margin="10,0"/>
                    <RadioButton x:Name="radNone" Content="None" GroupName="RadioGroup" Foreground="$labelForeColor" IsChecked="True" Margin="10,0"/>
                </StackPanel>

                <!-- Checkboxes Section for Exclude Cluster, Merge Config, Destination Config -->
                <StackPanel Orientation="Horizontal" Margin="10,15">
                    <CheckBox x:Name="chkExcludeCluster" Content="Exclude Cluster" Foreground="$labelForeColor" Margin="10,0"/>
                    <CheckBox x:Name="chkMergeConfig" Content="Merge Config Files" Foreground="$labelForeColor" Margin="10,0"/>
                    <CheckBox x:Name="chkDestinationConfig" Content="Destination Config" Foreground="$labelForeColor" Margin="10,0"/>
                </StackPanel>

                <Grid Margin="10,20,10,20">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="150" /> <!-- Label Column -->
                        <ColumnDefinition Width="*" /> <!-- Input Box Column -->
                        <ColumnDefinition Width="Auto" /> <!-- Browse Button Column, if applicable -->
                    </Grid.ColumnDefinitions>

                    <!-- Exclusion List Section -->
                    <TextBlock x:Name="lblExclusion" Text="Exclusion List:" VerticalAlignment="Center" Foreground="$labelForeColor" Visibility="Collapsed" Grid.Row="0" Grid.Column="0"/>
                    <TextBox x:Name="txtExclusion" Height="30" Background="$txtBackColor" Foreground="$txtForeColor" Margin="10,10,10,10" Visibility="Collapsed" Grid.Row="0" Grid.Column="1" VerticalContentAlignment="Center"/>

                    <!-- Merge Config Section -->
                    <TextBlock x:Name="lblMergeConfig" Text="Merge Config Files:" VerticalAlignment="Center" Foreground="$labelForeColor" Visibility="Collapsed" Grid.Row="1" Grid.Column="0"/>
                    <TextBox x:Name="txtMergeConfig" Height="30" Background="$txtBackColor" Foreground="$txtForeColor" Margin="10,10,10,10" Visibility="Collapsed" Grid.Row="1" Grid.Column="1" VerticalContentAlignment="Center"/>

                    <!-- Destination Config Section -->
                    <TextBlock x:Name="lblDestinationConfig" Text="Destination Config:" VerticalAlignment="Center" Foreground="$labelForeColor" Visibility="Collapsed" Grid.Row="2" Grid.Column="0"/>
                    <TextBox x:Name="txtDestinationConfig" Height="30" Background="$txtBackColor" Foreground="$txtForeColor" Margin="10,10,10,10" Visibility="Collapsed" Grid.Row="2" Grid.Column="1" VerticalContentAlignment="Center"/>
                    <Button x:Name="btnBrowseDestinationConfig" Content="Browse" Width="100" Height="30" Background="$btnBackColor" Foreground="$headerForeColor" Visibility="Collapsed" Grid.Row="2" Grid.Column="2" Margin="10,10,10,10"/>
                </Grid>

                <!-- Output Section -->
                <TextBox x:Name="txtOutput" Height="150" Margin="10" VerticalScrollBarVisibility="Auto" IsReadOnly="True" TextWrapping="Wrap" FontFamily="Courier New" Background="Black" Foreground="Cyan"/>
            </StackPanel>
        </ScrollViewer>

    </DockPanel>
</Window>
"@

    # Load XAML
    $reader = (New-Object System.Xml.XmlNodeReader $xaml)
    $window = [Windows.Markup.XamlReader]::Load($reader)

    if (-not $window) {
        Write-Error "Failed to load the WPF window."
        return
    }

    # Set Button Event Handlers
    $btnRun = $window.FindName("btnRun")
    if ($btnRun) {
        $btnRun.Add_Click({
                $txtOutput = [System.Windows.Controls.TextBox]$window.FindName("txtOutput")
                
                # Display "Working..." message while the task is running
                $txtOutput.Clear()
                $txtOutput.AppendText("Working...`n")
                $window.Cursor = [System.Windows.Input.Cursors]::Wait
                
                # Gather inputs from UI elements
                $txtKubeConfig = [System.Windows.Controls.TextBox]$window.FindName("txtKubeConfig")
                $kubeConfigPath = $txtKubeConfig.Text
                $backup = ($window.FindName("chkBackup")).IsChecked
                $dryRun = ($window.FindName("chkDryRun")).IsChecked
                $force = ($window.FindName("chkForce")).IsChecked
                $listClusters = ($window.FindName("radListClusters")).IsChecked
                $listContexts = ($window.FindName("radListContexts")).IsChecked
                $excludeCluster = ($window.FindName("chkExcludeCluster")).IsChecked
                $exclusionList = if ($excludeCluster) { ($window.FindName("txtExclusion")).Text } else { $null }
                $mergeConfig = ($window.FindName("chkMergeConfig")).IsChecked
                $mergeConfigs = if ($mergeConfig) { ($window.FindName("txtMergeConfig")).Text } else { $null }
                $destinationConfigChecked = ($window.FindName("chkDestinationConfig")).IsChecked
                $destinationConfig = if ($destinationConfigChecked) { ($window.FindName("txtDestinationConfig")).Text } else { $null }

                # Construct and run the Invoke-KubeTidy command directly in the current session
                try {
                    # Construct command arguments
                    $arguments = @{
                        KubeConfigPath    = $kubeConfigPath
                        Backup            = $backup
                        Force             = $force
                        ListClusters      = $listClusters
                        ListContexts      = $listContexts
                        DryRun            = $dryRun
                        ExclusionList     = if ($excludeCluster) { $exclusionList } else { $null }
                        MergeConfigs      = if ($mergeConfig) { $mergeConfigs } else { $null }
                        DestinationConfig = if ($destinationConfigChecked) { $destinationConfig } else { $null }
                    }
                
                    # Use transcript to capture Write-Host output
                    $transcriptPath = [System.IO.Path]::GetTempFileName()
                    Start-Transcript -Path $transcriptPath -Force
                
                    # Run Invoke-KubeTidy
                    Invoke-KubeTidy @arguments
                
                    Stop-Transcript

                    # Clear "Working..." message and display actual output
                    $txtOutput.Clear()

                    # Read the transcript file, filter out unnecessary transcript metadata, and append to UI output
                    $inTranscriptBody = $false
                    Get-Content -Path $transcriptPath | ForEach-Object {
                        if ($_ -match 'PowerShell transcript start|PowerShell transcript end|^\*{22}|^End time:') {
                            # Skip transcript metadata, section dividers, and end time
                            $inTranscriptBody = -not $inTranscriptBody
                        } elseif ($inTranscriptBody -eq $true) {
                            # Append only the actual output to the text box
                            $txtOutput.AppendText("$_`n")
                        }
                    }
                    Remove-Item -Path $transcriptPath -Force

                }
                catch {
                    # Clear "Working..." message and display error
                    $txtOutput.Clear()
                    $txtOutput.AppendText("Error: $_`n")
                }
                finally {
                    # Reset cursor to default
                    $window.Cursor = [System.Windows.Input.Cursors]::Arrow
                }
            })
    }

    $btnBrowseKubeConfig = $window.FindName("btnBrowseKubeConfig")
    if ($btnBrowseKubeConfig) {
        $btnBrowseKubeConfig.Add_Click({
                $fileDialog = New-Object -TypeName Microsoft.Win32.OpenFileDialog
                $fileDialog.Filter = "KubeConfig Files (*.yaml, *.yml, *.config)|*.yaml;*.yml;*.config|All Files (*.*)|*.*"
                if ($fileDialog.ShowDialog() -eq $true) {
                    $txtKubeConfig = [System.Windows.Controls.TextBox]$window.FindName("txtKubeConfig")
                    $txtKubeConfig.Text = $fileDialog.FileName
                }
            })
    }

    $btnBrowseDestinationConfig = $window.FindName("btnBrowseDestinationConfig")
    if ($btnBrowseDestinationConfig) {
        $btnBrowseDestinationConfig.Add_Click({
                $fileDialog = New-Object -TypeName Microsoft.Win32.SaveFileDialog
                $fileDialog.Filter = "Config Files (*.yaml, *.yml, *.config)|*.yaml;*.yml;*.config|All Files (*.*)|*.*"
                if ($fileDialog.ShowDialog() -eq $true) {
                    $txtDestinationConfig = [System.Windows.Controls.TextBox]$window.FindName("txtDestinationConfig")
                    $txtDestinationConfig.Text = $fileDialog.FileName
                }
            })
    }

    # CheckBox Visibility Handling
    $chkExcludeCluster = $window.FindName("chkExcludeCluster")
    $txtExclusion = [System.Windows.Controls.TextBox]$window.FindName("txtExclusion")
    $lblExclusion = $window.FindName("lblExclusion")
    if ($chkExcludeCluster) {
        $chkExcludeCluster.Add_Checked({
                $txtExclusion.Visibility = [System.Windows.Visibility]::Visible
                $lblExclusion.Visibility = [System.Windows.Visibility]::Visible
            })
        $chkExcludeCluster.Add_Unchecked({
                $txtExclusion.Visibility = [System.Windows.Visibility]::Collapsed
                $lblExclusion.Visibility = [System.Windows.Visibility]::Collapsed
            })
    }

    $chkMergeConfig = $window.FindName("chkMergeConfig")
    $txtMergeConfig = [System.Windows.Controls.TextBox]$window.FindName("txtMergeConfig")
    $lblMergeConfig = $window.FindName("lblMergeConfig")
    if ($chkMergeConfig) {
        $chkMergeConfig.Add_Checked({
                $txtMergeConfig.Visibility = [System.Windows.Visibility]::Visible
                $lblMergeConfig.Visibility = [System.Windows.Visibility]::Visible
            })
        $chkMergeConfig.Add_Unchecked({
                $txtMergeConfig.Visibility = [System.Windows.Visibility]::Collapsed
                $lblMergeConfig.Visibility = [System.Windows.Visibility]::Collapsed
            })
    }

    $chkDestinationConfig = $window.FindName("chkDestinationConfig")
    $txtDestinationConfig = [System.Windows.Controls.TextBox]$window.FindName("txtDestinationConfig")
    $lblDestinationConfig = $window.FindName("lblDestinationConfig")
    $btnBrowseDestinationConfig = $window.FindName("btnBrowseDestinationConfig")

    if ($chkDestinationConfig) {
        $chkDestinationConfig.Add_Checked({
                $txtDestinationConfig.Visibility = [System.Windows.Visibility]::Visible
                $lblDestinationConfig.Visibility = [System.Windows.Visibility]::Visible
                $btnBrowseDestinationConfig.Visibility = [System.Windows.Visibility]::Visible
            })
        $chkDestinationConfig.Add_Unchecked({
                $txtDestinationConfig.Visibility = [System.Windows.Visibility]::Collapsed
                $lblDestinationConfig.Visibility = [System.Windows.Visibility]::Collapsed
                $btnBrowseDestinationConfig.Visibility = [System.Windows.Visibility]::Collapsed
            })
    }

    # Show the main window
    $window.ShowDialog()
}

# Launch the KubeTidy Launcher
Create-KubeTidyLauncher
