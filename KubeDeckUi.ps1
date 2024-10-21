Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Xaml

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
        return "Light"
    }
}

# Determine color scheme based on mode
$isDarkMode = Get-SystemTheme
$formBackColor = if ($isDarkMode -eq "Dark") { "#202f3d" } else { "#f0f0f0" }
$headerBackColor = "Black"
$headerForeColor = "White"
$labelForeColor = if ($isDarkMode -eq "Dark") { "White" } else { "Black" }
$btnBackColor = "#11A9BB"
$cardBackground = if ($isDarkMode -eq "Dark") { "#2c3e50" } else { "#ffffff" }
$cardShadowColor = if ($isDarkMode -eq "Dark") { "#000000" } else { "#999999" }

# Function to create the KubeDeck launcher using WPF
function Create-KubeDeckLauncher {
    [xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="KubeDeck Launcher" Width="900" Background="$formBackColor" WindowStartupLocation="CenterScreen" ResizeMode="CanResizeWithGrip" FontFamily="Roboto" FontSize="14" SizeToContent="Height">
    <DockPanel>

        <!-- Header Section -->
        <Grid DockPanel.Dock="Top" Background="$headerBackColor" Height="60">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="Auto" /> <!-- Column for the logo image -->
                <ColumnDefinition Width="*" />    <!-- Column for spacing -->
                <ColumnDefinition Width="Auto" /> <!-- Column for the About button -->
            </Grid.ColumnDefinitions>

            <!-- Align the logo to the left -->
            <Image Grid.Column="0" x:Name="logoImage" Height="40" VerticalAlignment="Center" HorizontalAlignment="Left" />

            <!-- About Button on the Header with same style as other buttons -->
            <Button x:Name="btnAbout" Grid.Column="2" Content="About" Width="80" Height="30" HorizontalAlignment="Right" Margin="10"
                    Background="$btnBackColor" Foreground="$headerForeColor" FontFamily="Roboto" FontSize="14" />
        </Grid>

        <!-- Main content using Grid to position material design cards -->
        <Grid Margin="20,10,20,20" DockPanel.Dock="Top">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto" />
                <RowDefinition Height="Auto" />
            </Grid.RowDefinitions>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*" />
                <ColumnDefinition Width="*" />
            </Grid.ColumnDefinitions>

            <!-- First Material Design Card for KubeTidy (Using Image for Header) -->
            <Border Grid.Row="0" Grid.Column="0" Background="$cardBackground" Padding="0" Margin="10" BorderBrush="#ddd" BorderThickness="1">
                <Border.Effect>
                    <DropShadowEffect Color="$cardShadowColor" BlurRadius="10" ShadowDepth="4" />
                </Border.Effect>
                <StackPanel>
                    <!-- Image for KubeTidy Header, filling the card's width -->
                    <Image x:Name="imgKubeTidyHeader" Stretch="UniformToFill" />

                    <TextBlock Text="Launch the KubeTidy application" Foreground="$labelForeColor" Margin="10,10,10,10" TextWrapping="Wrap" />
                    <Button x:Name="btnKubeTidy" Content="Launch KubeTidy" Background="$btnBackColor" Foreground="$headerForeColor" Padding="10" Margin="10,10,10,10" />
                </StackPanel>
            </Border>

            <!-- Second Material Design Card for KubeSnapIt -->
            <Border Grid.Row="0" Grid.Column="1" Background="$cardBackground" Padding="0" Margin="10" BorderBrush="#ddd" BorderThickness="1">
                <Border.Effect>
                    <DropShadowEffect Color="$cardShadowColor" BlurRadius="10" ShadowDepth="4" />
                </Border.Effect>
                <StackPanel>
                    <TextBlock Text="KubeSnapIt" FontSize="18" FontWeight="Bold" Foreground="$headerForeColor" Margin="10,0,10,10" />
                    <TextBlock Text="Launch the KubeSnapIt application" Foreground="$labelForeColor" Margin="10,0,10,10" TextWrapping="Wrap" />
                    <Button x:Name="btnKubeSnapIt" Content="Launch KubeSnapIt" Background="$btnBackColor" Foreground="$headerForeColor" Padding="10" Margin="10,10,10,10" />
                </StackPanel>
            </Border>
        </Grid>
    </DockPanel>
</Window>
"@

    # Parse the XAML
    $reader = (New-Object System.Xml.XmlNodeReader $xaml)
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # Set the logo image source using $PSScriptRoot
    $logoImage = $window.FindName("logoImage")
    $imagePath = Join-Path $PSScriptRoot "assets/images/logo/KubeDeckLogo.png"
    $logoImage.Source = [Windows.Media.Imaging.BitmapImage]::new([uri]::new($imagePath, [UriKind]::Absolute))

    # Set the KubeTidy header image to fill the card's width
    $imgKubeTidyHeader = $window.FindName("imgKubeTidyHeader")
    $kubeTidyHeaderPath = Join-Path $PSScriptRoot "assets/images/gen/projects/KubeTidyHeader.png"
    $imgKubeTidyHeader.Source = [Windows.Media.Imaging.BitmapImage]::new([uri]::new($kubeTidyHeaderPath, [UriKind]::Absolute))

    # Get the About button from the header
    $aboutButton = $window.FindName("btnAbout")

    # Event Handlers
    $btnKubeTidy = $window.FindName("btnKubeTidy")
    $btnKubeTidy.Add_Click({ Start-Process "KubeTidy.exe" })

    $btnKubeSnapIt = $window.FindName("btnKubeSnapIt")
    $btnKubeSnapIt.Add_Click({ Start-Process "KubeSnapIt.exe" })

    # About Button Click Event
    $aboutButton.Add_Click({
        # About window setup
        $aboutWindow = New-Object Windows.Window
        $aboutWindow.Title = "About KubeDeck"
        $aboutWindow.Width = 400
        $aboutWindow.Height = 400
        $aboutWindow.Background = [System.Windows.Media.BrushConverter]::new().ConvertFromString($formBackColor)
        $aboutWindow.WindowStartupLocation = 'CenterScreen'
        $aboutWindow.ResizeMode = 'NoResize'
        $aboutWindow.WindowStyle = 'SingleBorderWindow'
        $aboutWindow.FontFamily = "Roboto"
        $aboutWindow.FontSize = 14

        $stackPanel = New-Object Windows.Controls.StackPanel
        $stackPanel.Margin = "20"

        $aboutText = New-Object Windows.Controls.TextBlock
        $aboutText.Text = "KubeDeck is a suite of open-source tools designed to simplify Kubernetes management.`n `nKubeDeck automates tasks such as cleaning up your KubeConfig file with KubeTidy and managing Kubernetes snapshots with KubeSnapIt, helping you keep your clusters organized and efficient.`n`n"
        $aboutText.Foreground = [System.Windows.Media.Brushes]::White
        $aboutText.Margin = "0,0,0,10"
        $aboutText.TextWrapping = 'Wrap'
        $stackPanel.Children.Add($aboutText)

        # Fetch KubeTidy and KubeSnapIt versions
        $kubeTidyVersion = (Get-Module -Name KubeTidy -ListAvailable | Select-Object -First 1).Version.ToString()
        $kubeSnapItVersion = (Get-Module -Name KubeSnapIt -ListAvailable | Select-Object -First 1).Version.ToString()

        # Create version labels
        $versionText = New-Object Windows.Controls.TextBlock
        $versionText.Text = "KubeTidy Version: $kubeTidyVersion`nKubeSnapIt Version: $kubeSnapItVersion"
        $versionText.Foreground = [System.Windows.Media.Brushes]::White
        $versionText.Margin = "0,0,0,10"
        $versionText.TextWrapping = 'Wrap'
        $stackPanel.Children.Add($versionText)

        # Add update button
        $updateButton = New-Object Windows.Controls.Button
        $updateButton.Content = "Check for Updates"
        $updateButton.Margin = "10"
        $updateButton.Padding = "10"
        $updateButton.Background = "$btnBackColor"
        $updateButton.Foreground = "$headerForeColor"
        $updateButton.FontFamily = "Roboto"
        $updateButton.FontSize = 14

        $updateButton.Add_Click({
            # Show a new window for progress
            $script:progressWindow = New-Object Windows.Window
            $script:progressWindow.Title = "Checking for Updates"
            $script:progressWindow.Width = 400
            $script:progressWindow.Height = 200
            $script:progressWindow.WindowStartupLocation = 'CenterScreen'
            $script:progressWindow.ResizeMode = 'NoResize'
            $script:progressWindow.Background = [System.Windows.Media.BrushConverter]::new().ConvertFromString($formBackColor)

            # Create a stack panel for the progress window
            $progressPanel = New-Object Windows.Controls.StackPanel
            $progressPanel.Margin = "20"

            # Add a label to indicate checking
            $progressLabel = New-Object Windows.Controls.TextBlock
            $progressLabel.Text = "Checking for updates, please wait..."
            $progressLabel.Margin = "0,0,0,10"
            $progressLabel.TextWrapping = 'Wrap'
            $progressLabel.Foreground = [System.Windows.Media.Brushes]::White
            $progressPanel.Children.Add($progressLabel)

            # Add a progress bar
            $progressBar = New-Object Windows.Controls.ProgressBar
            $progressBar.Height = 20
            $progressBar.Minimum = 0
            $progressBar.Maximum = 100
            $progressPanel.Children.Add($progressBar)

            # Show the progress window
            $script:progressWindow.Content = $progressPanel
            $script:progressWindow.Show()

            # Check for updates on PowerShell Gallery
            $modulesToCheck = @("KubeTidy", "KubeSnapIt")
            foreach ($moduleName in $modulesToCheck) {
                $installedModule = Get-Module -Name $moduleName -ListAvailable | Select-Object -First 1
                $newVersion = Find-Module -Name $moduleName | Select-Object -ExpandProperty Version
                if ($newVersion -gt $installedModule.Version) {
                    # Update module and show progress
                    Update-Module -Name $moduleName -Force
                    $progressBar.Value = ($progressBar.Value + 50)
                }
            }

            # Update the message and add an OK button
            $progressLabel.Text = "Check complete. Modules updated if needed."
            $progressBar.Value = 100

            # Add OK button after update check completes
            $okButton = New-Object Windows.Controls.Button
            $okButton.Content = "OK"
            $okButton.Margin = "10"
            $okButton.Padding = "10"
            $okButton.Background = "$btnBackColor"
            $okButton.Foreground = "$headerForeColor"
            $okButton.Add_Click({
                $script:progressWindow.Close()
            })
            $progressPanel.Children.Add($okButton)
        })
        $stackPanel.Children.Add($updateButton)

        # Add the URL under the "Check for Updates" button
        $urlTextBlock = New-Object Windows.Controls.TextBlock
        $urlTextBlock.Foreground = [System.Windows.Media.Brushes]::White
        $urlTextBlock.Margin = "0,10,0,0"
        $urlTextBlock.TextWrapping = 'Wrap'

        $hyperlink = New-Object Windows.Documents.Hyperlink
        $hyperlink.Inlines.Add("Visit us at: KubeDeck.io")
        $hyperlink.NavigateUri = [Uri]::new("https://kubedeck.io")
        $hyperlink.Foreground = [System.Windows.Media.Brushes]::White
        $urlTextBlock.Inlines.Add($hyperlink)

        $hyperlink.add_RequestNavigate({
            param($sender, $e)
            Start-Process $e.Uri.AbsoluteUri
            $e.Handled = $true
        })

        $stackPanel.Children.Add($urlTextBlock)

        $aboutWindow.Content = $stackPanel
        $aboutWindow.ShowDialog()
    })

    # Show the main window
    $window.ShowDialog()
}

# Import KubeTidy and KubeSnapIt modules
try {
    Import-Module KubeTidy -ErrorAction Stop
    Import-Module KubeSnapIt -ErrorAction Stop
}
catch {
    [System.Windows.MessageBox]::Show("Error importing modules. Please ensure KubeTidy and KubeSnapIt are installed.", "Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
}

# Launch the KubeDeck launcher
Create-KubeDeckLauncher
