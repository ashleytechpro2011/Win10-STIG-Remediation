<#
.SYNOPSIS
    Configures Data Execution Prevention (DEP) to “OptOut” mode to comply with STIG requirement WN10-00-000145.

.DESCRIPTION
    Sets the DEP policy using `bcdedit` to enforce runtime memory protections for all processes except those explicitly exempted.
    A system reboot is required for the change to take effect.

.NOTES
    Author          : Malaya M.
    LinkedIn        : https://linkedin.com/in/malaya-m
    GitHub          : https://github.com/malaya-m
    Date Created    : 2025-07-20
    Last Modified   : 2025-07-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000145

.TESTED ON
    Date(s) Tested  : 2025-07-20
    Tested By       : Malaya M.
    Systems Tested  : Windows 10 (10.0.19045.5487)
    PowerShell Ver. : 5.1

.USAGE
    Run this script as Administrator in a PowerShell session.
    A system reboot is required for the changes to take effect.

    Example:
    PS C:\> .\Set-DEP-OptOut.ps1
#>

[CmdletBinding()]
param()

Write-Host "Configuring DEP to 'OptOut'..." -ForegroundColor Cyan

try {
    bcdedit /set '{current}' nx OptOut
    Write-Host "DEP successfully set to 'OptOut'. Please reboot your system." -ForegroundColor Green
}
catch {
    Write-Warning "Failed to set DEP: $($_.Exception.Message)"
    Write-Host "Possible causes: Secure Boot, BitLocker, or UEFI restrictions." -ForegroundColor Yellow
}
