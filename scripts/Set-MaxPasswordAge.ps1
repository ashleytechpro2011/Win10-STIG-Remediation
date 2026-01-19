<#
.SYNOPSIS
    Sets the maximum password age to 60 days to comply with STIG requirement WN10-AC-000025.

.DESCRIPTION
    Exports the local security policy, updates the 'MaximumPasswordAge' setting to 60,
    and reapplies the updated policy. This enforces periodic password changes to reduce 
    the risk of compromised credentials being used long-term.

.NOTES
    Author          : Malaya M.
    LinkedIn        : https://linkedin.com/in/malaya-m
    GitHub          : https://github.com/malaya-m
    Date Created    : 2025-07-22
    Last Modified   : 2025-07-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000025

.TESTED ON
    Date(s) Tested  : 2025-07-22
    Tested By       : Malaya M.
    Systems Tested  : Windows 10 (10.0.19045.5487)
    PowerShell Ver. : 5.1

.USAGE
    Run this script as Administrator in a PowerShell session.

    Example:
    PS C:\> .\Set-MaxPasswordAge.ps1
#>

[CmdletBinding()]
param()

$exportPath  = 'C:\Temp\policy-old.ini'
$updatedPath = 'C:\Temp\policy-new.ini'
$dbPath      = 'C:\Windows\Security\Local.sdb'

Write-Host "Ensuring C:\Temp directory exists..." -ForegroundColor Cyan

try {
    if (!(Test-Path 'C:\Temp')) {
        New-Item -ItemType Directory -Path 'C:\Temp' -Force | Out-Null
        Write-Host "Created C:\Temp directory."
    }

    Write-Host "Exporting local security policy..." -ForegroundColor Cyan
    secedit /export /cfg $exportPath /areas SECURITYPOLICY | Out-Null

    if (Test-Path $exportPath) {
        Write-Host "Modifying maximum password age setting..." -ForegroundColor Cyan

        (Get-Content $exportPath) `
            -replace 'MaximumPasswordAge\s*=\s*\d+', 'MaximumPasswordAge = 60' `
            | Set-Content $updatedPath

        Write-Host "Applying updated security policy..." -ForegroundColor Cyan
        secedit /configure /db $dbPath /cfg $updatedPath /areas SECURITYPOLICY | Out-Null

        Write-Host "Maximum password age successfully updated to 60 days." -ForegroundColor Green
        Write-Host "Run 'gpupdate /force' or restart the system to ensure enforcement." -ForegroundColor Yellow
    }
    else {
        Write-Warning "Export failed. File not found: $exportPath"
    }
}
catch {
    Write-Warning "Error during maximum password age configuration: $($_.Exception.Message)"
}
