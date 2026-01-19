# Windows 10 STIG Remediation Repository

This repository documents how I secured a Windows 10 virtual machine (hosted on Azure) using [DISA’s Microsoft Windows 10 STIG v3r4](https://www.tenable.com/audits/DISA_STIG_Microsoft_Windows_10_v3r4) guidelines. Through Tenable STIG scans and PowerShell scripts, I identified, remediated, and verified critical misconfigurations.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Initial Scan Results](#initial-scan-results)
3. [Remediation Steps](#remediation-steps)
4. [Priority STIG Remediations](#priority-stig-remediations)
5. [Scripts Directory](#scripts-directory)
7. [Post-Remediation Scan Results](#post-remediation-scan-results)
8. [Post-Remediation Testing](#post-remediation-testing)
9. [Next Steps (Maintenance Mode)](#next-steps-maintenance-mode)

---

## Project Overview

- _**Purpose**_: This project highlights my practical experience applying DISA STIG compliance to harden a Windows 10 system. I used Tenable Nessus to scan for vulnerabilities and remediated high-risk findings with PowerShell, verifying each fix post-deployment.
- _**Scope**_: Focus is placed on high-impact remediations from the v3r4 STIG release, selected based on exploitability, ease of implementation, and overall system impact.

---

## Initial Scan Results

An initial STIG scan was performed on Tenable which detected numerous policy failures. 

<img width="1131" height="342" alt="Screenshot 2025-07-21 at 7 12 36 PM" src="https://github.com/user-attachments/assets/4814a922-11a2-42f7-9adf-e893e588de25" />

[Initial Scan Report](https://github.com/malaya-m/Win10-STIG-Remediation/blob/main/scan-reports/Initial%20Scan%20-%20STIG%20Implementation.pdf)

---

## Remediation Steps

1. **Conduct Initial Scan**  
   Run a baseline vulnerability scan using Tenable Nessus with the DISA Microsoft Windows 10 STIG (v3r4) compliance policy.

2. **Analyze Scan Results**  
   Review the scan report to identify failed STIG checks and categorize findings by severity, exploitability, and ease of implementation.

3. **Prioritize Remediations**  
   Select high-impact, low-disruption controls to address first, focusing on those that can be remediated through automated scripts.

4. **Develop and Execute Scripts**  
   Create and run PowerShell scripts tailored to each STIG control to enforce compliance and harden the system.

5. **Perform Post-Remediation Testing**  
   - Verify registry, policy, and service state changes were applied correctly.  
   - Test system stability and critical functionality.  
   - Review Windows Event Viewer and logs for anomalies.  
   - Conduct a follow-up Nessus scan to validate that remediated STIG checks now pass.

6. **Document and Iterate**  
   Record results, update scripts or configurations as needed, and prepare for ongoing compliance monitoring.

---

## Priority STIG Remediations
The table below highlights the STIG remediations that were prioritized based on exploitability, ease of implementation, and system impact. Each STIG ID in the left column provides a link to more detailed documentation within the [`stig-overview/`](./stig-overview/) folder.


| STIG ID(s)                                  | Script Filename                   | Description                                                                 |
|--------------------------------------------|----------------------------------|-----------------------------------------------------------------------------|
| [`WN10-00-000145`](./stig-overview/WN10-00-000145.md)                              | [`Set-DEP-OptOut.ps1`](./scripts/Set-DEP-OptOut.ps1)             | Sets Data Execution Prevention (DEP) to "OptOut" for enhanced runtime memory protection. |
| [`WN10-00-000155`](./stig-overview/WN10-00-000155.md)                              | [`Disable-PowerShell2.ps1`](./scripts/Disable-PowerShell2.ps1)        | Disables PowerShell 2.0 to prevent downgrade attacks and enable logging in newer versions. |
| [`WN10-00-000175`](./stig-overview/WN10-00-000175.md)                              | [`Disable-SecondaryLogon.ps1`](./scripts/Disable-SecondaryLogon.ps1)      | Disables the Secondary Logon service to minimize privilege abuse and session hijacking risks. |
| [`WN10-CC-000038`](./stig-overview/WN10-CC-000038.md)                              | [`Disable-WDigestAuth.ps1`](./scripts/Disable-WDigestAuth.ps1)              | Disables WDigest authentication to prevent storage of plain-text credentials in memory. |
| [`WN10-CC-000180`](./stig-overview/WN10-CC-000180.md) / [`-000185`](./stig-overview/WN10-CC-000185.md) / [`-000190`](.stig-overview/WN10-CC-000190.md)          | [`Disable-AutoPlay-AutoRun.ps1`](./scripts/Disable-AutoPlay-AutoRun.ps1)           | Disables AutoPlay and AutoRun features across all drives to prevent malware propagation. |
| [`WN10-AU-000500`](./stig-overview/WN10-AU-000500.md) / [`-000505`](./stig-overview/WN10-AU-000505.md) / [`-000510`](./stig-overview/WN10-AU-000510.md)          | [`Set-EventLogSizes-GPO.ps1`](./scripts/Set-EventLogSizes-GPO.ps1)           | Configures Application, Security, and System logs to meet minimum size requirements (32MB, 1000MB, 32MB). |
| [`WN10-AC-000005`](./stig-overview/WN10-AC-000005.md) / [`-000010`](./stig-overview/WN10-AC-000010.md) / [`-000015`](./stig-overview/WN10-AC-000015.md)          | [`Enforce-AccountLockout-NetAccounts.ps1`](./scripts/Enforce-AccountLockout-NetAccounts.ps1)   | Enforces account lockout settings: 3 attempts, 15-minute duration and reset period. |
| [`WN10-AC-000035`](./stig-overview/WN10-AC-000035.md) / [`-000040`](./stig-overview/WN10-AC-000040.md)                    | [`Set-PasswordPolicy.ps1`](./scripts/Set-PasswordPolicy.ps1)         | Enforces strong password policies: minimum 14 characters and complexity enabled. |
| [`WN10-AC-000025`](./stig-overview/WN10-AC-000025.md)                              | [`Set-MaxPasswordAge.ps1`](./scripts/Set-MaxPasswordAge.ps1)        | Enforces regular password changes to limit the lifespan of compromised credentials. |
| [`WN10-AC-000030`](./stig-overview/WN10-AC-000030.md)                              | [`Set-MinPasswordAge.ps1`](./scripts/Set-MinPasswordAge.ps1)     | Ensures users cannot change passwords repeatedly in a short time to bypass history restrictions. |
---

## Scripts Directory

The PowerShell remediation scripts are located in the [`scripts/`](./scripts/) folder. Each `.ps1` file is labeled with the corresponding STIG ID(s) and includes detailed usage instructions and logging output. These scripts were created based on failed controls identified in the initial Tenable STIG scan.

---

## Post-Remediation Scan Results

After running each PowerShell script, a post-remediation scan was performed to validate the STIG checks have passed successfully.

<img width="1130" height="342" alt="Post-remediation scan results" src="https://github.com/user-attachments/assets/369c3103-c8f8-4fcf-95b6-eb01941984e3" />

[Post-Remediation Scan Report](https://github.com/malaya-m/Win10-STIG-Remediation/blob/main/scan-reports/Post-Remediation%20Scan%20-%20STIG%20Implementation.pdf)


### Impact Summary

After implementing the prioritized STIG remediations, I conducted a post-remediation scan using Tenable Nessus. The initial scan identified **147 failed checks**, whereas the post-remediation scan shows **132 remaining failures**, indicating that **15 findings were successfully resolved** through remediation efforts.

---

## Post-Remediation Testing

After each STIG remediation was applied, the following validation steps were performed to ensure the system remained secure and operational:

- **Verified Registry and Policy Changes**  
  Confirmed registry keys, local security policy settings, and service states were updated as expected.

- **Tested System Functionality**  
  Ensured system boot, login, user operations, and critical applications continued to function without issues.

- **Reviewed Updated Nessus Scan Reports**  
  Re-scanned the system using the Tenable Nessus STIG Compliance policy to validate that the remediated controls no longer appeared as findings.

- **Spot-Checked Operational Logs**  
  Reviewed Windows Event Viewer and `secedit` output for errors or misconfigurations introduced by changes.

- **Performed Rollback Tests (if applicable)**  
  Where feasible, validated the ability to revert changes without disrupting system integrity.

---

## Next Steps (Maintenance Mode)

To maintain a secure and compliant system posture beyond the initial remediations, the following practices will be adopted:

- **Conduct Regular Vulnerability Scans**  
  Perform periodic Tenable Nessus scans to detect newly introduced vulnerabilities and verify compliance over time.

- **Track STIG Updates**  
  Monitor DISA releases for new or revised Windows 10 STIG controls and integrate them into the remediation workflow as needed.

- **Monitor System and Security Logs**  
  Continuously review Event Viewer and audit logs to identify anomalous activity or misconfigurations.

- **Enhance Automation and Reporting**  
  Expand the use of PowerShell scripts for compliance checks and integrate reporting tools for streamlined documentation and audit readiness.
