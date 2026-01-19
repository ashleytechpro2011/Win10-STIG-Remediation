<#
.SYNOPSIS
    Enforces password complexity and minimum length settings to comply with STIG requirements WN10-AC-000035 and WN10-AC-000040.

.DESCRIPTION
    Exports the local security policy, modifies the following entries:
      - MinimumPasswordLength = 14
      - PasswordComplexity = 1
    Then reapplies the updated configuration using `secedit`. This ensures users must use passwords 
    that are at least 14 characters long and include a mix of character types.

.NOTES
    Author          : Malaya M.
    LinkedIn        : https://linkedin.com/in/malaya-m
    GitHub          : https://github.com/malaya-m
    Date Created    : 2025-07-22
    Last Modified   : 2025-07-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035, WN10-AC-000040

.TESTED ON
    Date(s) Tested  : 2025-07-22
    Tested By       : Malaya M.
    Systems Tested  : Windows 10 (10.0.19045.5487)
    PowerShell Ver. : 5.1

.USAGE
    Run this script as Administrator in a PowerShell session.

    Example:
    PS C:\> .\Set-PasswordPolicy.ps1
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
        Write-Host "Modifying password policy entries..." -ForegroundColor Cyan

        (Get-Content $exportPath) `
            -replace 'MinimumPasswordLength\s*=\s*\d+', 'MinimumPasswordLength = 14' `
            -replace 'PasswordComplexity\s*=\s*\d+', 'PasswordComplexity = 1' `
            | Set-Content $updatedPath

        Write-Host "Applying updated security policy..." -ForegroundColor Cyan
        secedit /configure /db $dbPath /cfg $updatedPath /areas SECURITYPOLICY | Out-Null

        Write-Host "Password policy successfully updated." -ForegroundColor Green
        Write-Host "Run 'gpupdate /force' or restart the system to ensure enforcement." -ForegroundColor Yellow
    }
    else {
        Write-Warning "Export failed. File not found: $exportPath"
    }
}
catch {
    Write-Warning "Error during password policy configuration: $($_.Exception.Message)"
}
