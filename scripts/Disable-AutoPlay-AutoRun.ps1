<#
.SYNOPSIS
    Disables AutoPlay and AutoRun on all drives to comply with STIG requirements WN10-CC-000180, WN10-CC-000185, and WN10-CC-000190.

.DESCRIPTION
    Configures Group Policy–based registry settings to disable AutoPlay on all drives,
    disallow AutoPlay for non-volume devices, and set AutoRun behavior to prevent
    execution of commands from removable media.

.NOTES
    Author          : Malaya M.
    LinkedIn        : https://linkedin.com/in/malaya-m
    GitHub          : https://github.com/malaya-m
    Date Created    : 2025-07-22
    Last Modified   : 2025-07-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000180, WN10-CC-000185, WN10-CC-000190

.TESTED ON
    Date(s) Tested  : 2025-07-22
    Tested By       : Malaya M.
    Systems Tested  : Windows 10 (10.0.19045.5487)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\> .\Disable-AutoPlay-AutoRun.ps1
#>

[CmdletBinding()]
param()

Write-Host "Disabling AutoPlay/AutoRun (WN10-CC-000180, -185, -190)..." -ForegroundColor Cyan

$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'

try {
    # Ensure the policy registry key exists
    if (!(Test-Path $regPath)) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' -Name 'Explorer' -Force | Out-Null
        Write-Host "Created registry path: $regPath"
    }

    # Set registry values for STIG compliance
    New-ItemProperty -Path $regPath -Name 'NoAutoplayfornonVolume' -PropertyType DWORD -Value 1 -Force | Out-Null
    New-ItemProperty -Path $regPath -Name 'NoAutorun' -PropertyType DWORD -Value 1 -Force | Out-Null
    New-ItemProperty -Path $regPath -Name 'NoDriveTypeAutoRun' -PropertyType DWORD -Value 255 -Force | Out-Null

    Write-Host "AutoPlay and AutoRun policy settings successfully applied." -ForegroundColor Green
    Write-Host "Run 'gpupdate /force' or restart the system to finalize changes." -ForegroundColor Yellow
}
catch {
    Write-Warning "Failed to configure AutoPlay/AutoRun policies: $($_.Exception.Message)"
}
