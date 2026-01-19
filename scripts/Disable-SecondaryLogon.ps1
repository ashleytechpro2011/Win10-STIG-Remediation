<#
.SYNOPSIS
    Disables the Secondary Logon service (seclogon) to comply with STIG requirement WN10-00-000175.

.DESCRIPTION
    Stops and disables the Secondary Logon service to prevent privilege escalation. 
    Also sets the registry 'Start' value to 4 to ensure full STIG/Nessus compliance.

.NOTES
    Author          : Ashley U. 
    LinkedIn        : https://linkedin.com/in/ashleytechpro2011
    GitHub          : https://github.com/ashleytechpro2011
    Date Created    : 2025-07-16
    Last Modified   : 2025-07-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000175

.TESTED ON
    Date(s) Tested  : 2025-07-16
    Tested By       : Ashley U.
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
