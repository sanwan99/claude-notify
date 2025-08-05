param(
    [string]$Title = "Claude Code",
    [string]$Message = "Task completed",
    [string]$Type = "info",
    [string]$Button1Text = "",
    [string]$Button1Action = "",
    [string]$Button2Text = "",
    [string]$Button2Action = "",
    [string]$Icon = "",
    [string]$CustomSound = ""
)

# 设置PowerShell编码
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# Import BurntToast module
try {
    Import-Module BurntToast -ErrorAction Stop
} catch {
    Write-Host "ERROR: BurntToast module not available"
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show($Message, $Title, 'OK', 'Information')
    exit 1
}

# Set sound - use custom sound if provided, otherwise use type-based default
if ($CustomSound -ne "") {
    $Sound = $CustomSound
} else {
    $Sound = switch ($Type.ToLower()) {
        "success" { "Default" }
        "warning" { "Reminder" }  
        "error" { "Alarm" }
        default { "SMS" }
    }
}

# Set icon - use custom icon if provided
$AppLogo = $null
if ($Icon -ne "" -and (Test-Path $Icon)) {
    $AppLogo = $Icon
    Write-Host "  Using custom icon: $Icon"
}

# Create buttons if specified
$Buttons = @()
if ($Button1Text -ne "") {
    $Action1 = if ($Button1Action -ne "") { $Button1Action } else { "action1" }
    $Buttons += New-BTButton -Content $Button1Text -Arguments $Action1
}
if ($Button2Text -ne "") {
    $Action2 = if ($Button2Action -ne "") { $Button2Action } else { "action2" }
    $Buttons += New-BTButton -Content $Button2Text -Arguments $Action2
}

# Send notification
try {
    $TextElements = @($Title, $Message)
    
    # Build notification parameters
    $NotificationParams = @{
        Text = $TextElements
        Sound = $Sound
    }
    
    if ($AppLogo -ne $null) {
        $NotificationParams.AppLogo = $AppLogo
    }
    
    if ($Buttons.Count -gt 0) {
        $NotificationParams.Button = $Buttons
    }
    
    New-BurntToastNotification @NotificationParams
    
    Write-Host "SUCCESS: BurntToast notification sent"
    Write-Host "  Title: $Title"
    Write-Host "  Message: $Message"
    Write-Host "  Type: $Type"
    Write-Host "  Sound: $Sound"
    if ($AppLogo -ne $null) {
        Write-Host "  Icon: $AppLogo"
    }
    if ($Buttons.Count -gt 0) {
        Write-Host "  Buttons: $($Buttons.Count)"
    }
    
} catch {
    Write-Host "ERROR: Failed to send BurntToast notification"
    Write-Host "  Error: $($_.Exception.Message)"
    
    # Fallback to message box
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show($Message, $Title, 'OK', 'Information')
}