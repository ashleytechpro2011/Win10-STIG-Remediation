<#
.SYNOPSIS
    Configures account lockout settings to comply with STIG requirements WN10-AC-000005, WN10-AC-000010, and WN10-AC-000015.

.DESCRIPTION
    Uses the `net accounts` command to enforce:
      - Lockout threshold: 3 invalid logon attempts
      - Lockout duration: 15 minutes
      - Reset lockout counter: 15 minutes

.NOTES
    Author          : Malaya M.
    LinkedIn        : https://linkedin.com/in/malaya-m
    GitHub          : https://github.com/malaya-m
    Date Created    : 2025-07-22
    Last Modified   : 2025-07-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005, WN10-AC-000010, WN10-AC-000015

.TESTED ON
    Date(s) Tested  : 2025-07-22
    Tested By       : Malaya M.
    Systems Tested  : Windows 10 (10.0.19045.5487)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\> .\Enforce-AccountLockout-NetAccounts.ps1
#>

[CmdletBinding()]
param()

Write-Host "Configuring Account Lockout Policy with net accounts..." -ForegroundColor Cyan

try {
    net accounts /lockoutthreshold:3
    net accounts /lockoutduration:15
    net accounts /lockoutwindow:15

    Write-Host "Account lockout policy successfully configured." -ForegroundColor Green
}
catch {
    Write-Warning "Failed to configure account lockout policy: $($_.Exception.Message)"
}
