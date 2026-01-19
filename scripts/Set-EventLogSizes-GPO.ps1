<#
.SYNOPSIS
    Sets event log size limits via Group Policy registry keys to comply with STIG requirements WN10-AU-000500, WN10-AU-000505, and WN10-AU-000510.

.DESCRIPTION
    Creates or modifies 'MaxSize' values under the Group Policy registry path for
    Application, Security, and System logs to ensure they meet or exceed DISA STIG 
    minimums.

.NOTES
    Author          : Malaya M.
    LinkedIn        : https://linkedin.com/in/malaya-m
    GitHub          : https://github.com/malaya-m
    Date Created    : 2025-07-22
    Last Modified   : 2025-07-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500, WN10-AU-000505, WN10-AU-000510

.TESTED ON
    Date(s) Tested  : 2025-07-22
    Tested By       : Malaya M.
    Systems Tested  : Windows 10 (10.0.19045.5487)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges.
    Example:
    PS C:\> .\Set-EventLogSizes-GPO.ps1
    After execution, run 'gpupdate /force' or reboot to apply changes.
#>

[CmdletBinding()]
param()

Write-Host "Configuring STIG-compliant event log sizes via Group Policy path..." -ForegroundColor Cyan

$logSettings = @(
    @{ Name = 'Application'; Size = 32768   }, # WN10-AU-000500
    @{ Name = 'Security';    Size = 1024000 }, # WN10-AU-000505
    @{ Name = 'System';      Size = 32768   }  # WN10-AU-000510
)

$basePath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog'

foreach ($log in $logSettings) {
    $logPath = Join-Path $basePath $log.Name
    $propName = 'MaxSize'
    $logSize = $log.Size

    try {
        if (!(Test-Path $logPath)) {
            New-Item -Path $logPath -Force | Out-Null
            Write-Host "Created registry key for $($log.Name) at $logPath."
        }

        New-ItemProperty -Path $logPath `
                         -Name $propName `
                         -PropertyType DWORD `
                         -Value $logSize `
                         -Force | Out-Null

        Write-Host "Set '$propName' to $logSize KB for $($log.Name) log." -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed to configure $($log.Name) log: $($_.Exception.Messa_
