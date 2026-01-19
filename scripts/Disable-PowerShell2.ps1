<#
.SYNOPSIS
    Disables Windows PowerShell 2.0 to comply with STIG requirement WN10-00-000155.

.DESCRIPTION
    Uses 'Disable-WindowsOptionalFeature' to remove legacy PowerShell 2.0, which is deprecated and insecure.

.NOTES
    Author          : Malaya M.
    LinkedIn        : https://linkedin.com/in/malaya-m
    GitHub          : https://github.com/malaya-m
    Date Created    : 2025-07-21
    Last Modified   : 2025-07-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000155

.TESTED ON
    Date(s) Tested  : 2025-07-22
    Tested By       : Malaya M.
    Systems Tested  : Windows 10 (10.0.19045.5487)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\> .\Disable-PowerShell2.ps1
#>

Write-Host "Disabling Windows PowerShell 2.0 (WN10-00-000155)..."

try {
    Disable-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2Root" -NoRestart -ErrorAction Stop
    Disable-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2" -NoRestart -ErrorAction Stop
    Write-Host "Successfully disabled Windows PowerShell 2.0."
}
catch {
    Write-Error "Error disabling PowerShell 2.0: $_"
}

Write-Host "Done. A system restart may be required to fully remove PowerShell 2.0 components."
