<#
.SYNOPSIS
    Disables the Secondary Logon service (seclogon) to comply with STIG requirement WN10-00-000175.

.DESCRIPTION
    Stops and disables the Secondary Logon service to prevent privilege escalation. 
    Also sets the registry 'Start' value to 4 to ensure full STIG/Nessus compliance.

.NOTES
    Author          : Malaya M.
    LinkedIn        : https://linkedin.com/in/malaya-m
    GitHub          : https://github.com/malaya-m
    Date Created    : 2025-07-20
    Last Modified   : 2025-07-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000175

.TESTED ON
    Date(s) Tested  : 2025-07-22
    Tested By       : Malaya M.
    Systems Tested  : Windows 10 (10.0.19045.5487)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\> .\Disable-SecondaryLogon.ps1
#>

[CmdletBinding()]
param()

Write-Host "Disabling Secondary Logon service (seclogon)..." -ForegroundColor Cyan

try {
    # Stop the service if running
    Stop-Service -Name 'seclogon' -Force -ErrorAction SilentlyContinue

    # Set service to Disabled
    Set-Service -Name 'seclogon' -StartupType Disabled

    # Set registry key to Start=4 (fully disabled)
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\seclogon' -Name 'Start' -Value 4

    Write-Host "Secondary Logon service disabled and registry set to Start=4." -ForegroundColor Green
}
catch {
    Write-Warning "Failed to disable Secondary Logon service: $($_.Exception.Message)"
}
