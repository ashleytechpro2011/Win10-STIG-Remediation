<#
.SYNOPSIS
    Disables WDigest authentication to comply with STIG requirement WN10-CC-000038.

.DESCRIPTION
    Sets the 'UseLogonCredential' registry value to 0 under the WDigest provider. 
    This prevents LSASS from storing plaintext credentials in memory, mitigating credential theft risk.

.NOTES
    Author          : Malaya M.
    LinkedIn        : https://linkedin.com/in/malaya-m
    GitHub          : https://github.com/malaya-m
    Date Created    : 2025-07-22
    Last Modified   : 2025-07-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000038

.TESTED ON
    Date(s) Tested  : 2025-07-22
    Tested By       : Malaya M.
    Systems Tested  : Windows 10 (10.0.19045.5487)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\> .\Disable-WDigestAuth.ps1
#>

[CmdletBinding()]
param()

Write-Host "Disabling WDigest authentication (WN10-CC-000038)..." -ForegroundColor Cyan

$wdigestPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest'
$dwordName   = 'UseLogonCredential'
$dwordValue  = 0

try {
    # Create WDigest key if it does not exist
    if (!(Test-Path $wdigestPath)) {
        New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders' -Name 'WDigest' -Force | Out-Null
        Write-Host "Created the WDigest registry key."
    }

    # Set UseLogonCredential to 0 (disabled)
    New-ItemProperty -Path $wdigestPath -Name $dwordName -PropertyType DWord -Value $dwordValue -Force | Out-Null
    Write-Host "'$dwordName' set to $dwordValue under WDigest." -ForegroundColor Green
}
catch {
    Write-Warning "Failed to configure WDigest setting: $($_.Exception.Message)"
}

Write-Host "Done. A system restart is recommended to apply the change." -ForegroundColor Yellow
