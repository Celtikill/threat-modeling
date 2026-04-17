---
branch_number: 14
branch_name: "Logging Evasion"
assessment_types: ["Type 3"]
risk_level: "Medium"
asvs_chapters: ["V16"]
aisvs_chapters: ["C13"]
mitre_techniques: ["T1562.008", "T1070", "T1562", "T1565"]
tags: ["logging", "detection-evasion", "cloudtrail", "audit"]
related_branches: [10, 11, 12, 13]
---

# Branch 14: Logging Evasion

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 3 |
| **Risk Prevalence** | Medium |
| **ASVS Chapters** | V16 (Security Logging) |
| **AISVS Chapters** | C13 (Monitoring and Logging) |
| **Related Branches** | [Branch 10](../branch-10-iam-privilege.md) (IAM), [Branch 11](../branch-11-network-lateral.md) (Network), [Branch 12](../branch-12-public-exposure.md) (Exposure), [Branch 13](../branch-13-credential-theft.md) (Secrets) |

## Business Impact

Logging evasion allows attackers to operate undetected, extending dwell time and increasing damage. Without proper logging and monitoring, security incidents may go unnoticed for extended periods.

**Key Business Risks:**
- CloudTrail disabled or misconfigured
- Log data events not captured
- Log deletion or modification
- GuardDuty suppression rules hiding activity
- Detection gaps during log rotation

## Attack Tree

```text
Goal: Evade detection by manipulating or disabling logging
├── 14.1 CloudTrail and Audit Log Bypass
│   ├── CloudTrail disabled in specific regions
│   │   └── Technique: T1562.008 (Impair Defenses: Disable Cloud Logs)
│   ├── S3 data events not logged
│   │   └── Technique: T1562.008 (Impair Defenses: Disable Cloud Logs)
│   ├── Log integrity validation disabled
│   │   └── Technique: T1070 (Indicator Removal)
│   └── Log delivery to attacker-accessible bucket
│       └── Technique: T1070 (Indicator Removal)
└── 14.2 Detection Avoidance
    ├── GuardDuty suppression rules hiding malicious activity
    │   └── Technique: T1562 (Impair Defenses)
    ├── VPC Flow Log gaps in critical subnets
    │   └── Technique: T1562.008 (Impair Defenses: Disable Cloud Logs)
    ├── Log deletion from centralized logging (CloudWatch, S3)
    │   └── Technique: T1070 (Indicator Removal)
    └── Timing attacks during log rotation windows
        └── Technique: T1562 (Impair Defenses)
```text

## Sub-Branch Details

### 14.1 CloudTrail and Audit Log Bypass

**Threat Description:** Attacks that disable, modify, or redirect cloud audit logging.

**Common Attack Patterns:**
- CloudTrail stopped or deleted
- Data events (S3, Lambda) not captured
- Multi-region trail gaps
- Log file integrity validation disabled
- Logs delivered to compromised storage

**Business Context:**
- CloudTrail is foundational for AWS security
- Data events capture high-value actions
- Log integrity is critical for forensics

### 14.2 Detection Avoidance

**Threat Description:** Techniques to avoid detection by security monitoring tools.

**Common Attack Patterns:**
- GuardDuty filter rule abuse
- VPC Flow Log manipulation
- Log deletion before analysis
- Activity during log rotation windows
- Log file modification

**Business Context:**
- Detection tools only work with proper logging
- Log retention policies affect incident investigation
- Real-time alerting requires complete logs

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1562.008 | Impair Defenses: Disable Cloud Logs | 14.1, 14.2 | Defense Evasion | Log disabling |
| T1070 | Indicator Removal | 14.1, 14.2 | Defense Evasion | Log deletion/modification |
| T1562 | Impair Defenses | 14.2 | Defense Evasion | Detection suppression |
| T1565 | Data Manipulation | 14.2 | Impact | Log tampering |

## Assessment Questions

### CloudTrail Configuration

1. Is CloudTrail enabled in all regions?
2. Are data events (S3, Lambda) captured?
3. Is log file validation enabled?
4. Are logs delivered to a secure, separate account?
5. Is CloudTrail protected from modification?

### Detection Tools

1. Is GuardDuty enabled and monitored?
2. Are VPC Flow Logs enabled on all subnets?
3. Are security findings alerted on?
4. Is log integrity verified?
5. Are detection gaps identified?

### Log Management

1. Are logs retained for compliance requirements?
2. Are logs backed up to immutable storage?
3. Is log access restricted?
4. Are logs analyzed regularly?
5. Is log tampering detectable?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 14.1 | V16.1 | Audit logging |
| 14.1 | V16.2 | Log integrity |
| 14.2 | V16.3 | Security monitoring |
| 14.2 | V16.4 | Log protection |

## Indicators of Compromise

**Log Bypass Indicators:**
- CloudTrail status changes
- Log delivery failures
- Data event configuration changes
- Log file validation failures
- Unauthorized log access

**Detection Avoidance Indicators:**
- GuardDuty filter changes
- VPC Flow Log configuration changes
- Log deletion events
- Log file modifications
- Monitoring service disruptions

## Mitigating Requirements

### For CloudTrail

1. **Multi-Region:** Enable in all regions
2. **Data Events:** Capture S3 and Lambda data events
3. **Log Validation:** Enable log file integrity validation
4. **Cross-Account:** Deliver to separate security account
5. **Protection:** Prevent CloudTrail modification

### For Detection

1. **GuardDuty:** Enable and monitor findings
2. **Flow Logs:** Enable on all VPCs and subnets
3. **Alerting:** Real-time alerting on threats
4. **Integration:** SIEM integration for analysis
5. **Tuning:** Minimize false positives

### For Log Management

1. **Retention:** Meet compliance requirements
2. **Immutability:** Write-once storage for critical logs
3. **Access Control:** Restrict log access
4. **Analysis:** Regular log analysis
5. **Backup:** Secure log backups

## Related Branches

- **[Branch 10: IAM Privilege Escalation](../branch-10-iam-privilege.md)** — IAM manipulation
- **[Branch 11: Network Lateral Movement](../branch-11-network-lateral.md)** — Network evasion
- **[Branch 12: Public Exposure Exploitation](../branch-12-public-exposure.md)** — Exposure evasion
- **[Branch 13: Credential and Secret Theft](../branch-13-credential-theft.md)** — Credential evasion

## References

- [AWS CloudTrail Security](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/security.html)
- [Azure Monitor Security](https://docs.microsoft.com/en-us/azure/security/fundamentals/log-management-overview)
- [GCP Cloud Logging Security](https://cloud.google.com/logging/docs/security)
