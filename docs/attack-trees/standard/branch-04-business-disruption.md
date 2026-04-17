---
branch_number: 4
branch_name: "Vendor Business Disruption"
assessment_types: ["Type 1", "Type 2"]
risk_level: "Medium"
asvs_chapters: ["V2", "V14"]
aisvs_chapters: ["C12", "C14"]
mitre_techniques: ["T1490", "T1485", "T1496", "T1498", "T1565"]
tags: ["vendor", "availability", "business-continuity", "ransomware", "data-integrity"]
related_branches: [1, 3, 5, 9]
---

# Branch 4: Vendor Business Disruption

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 1, 2 |
| **Risk Prevalence** | Medium |
| **ASVS Chapters** | V2 (Validation), V14 (Data Protection) |
| **AISVS Chapters** | C12 (Privacy), C14 (Human Oversight) |
| **Related Branches** | [Branch 1](../branch-01-vendor-infrastructure.md) (Infrastructure), [Branch 3](../branch-03-integration-points.md) (Integration), [Branch 5](../branch-05-infrastructure-components.md) (Components), [Branch 9](../branch-09-pipeline-integration.md) (Pipeline) |

## Business Impact

Business disruption attacks target service availability and data integrity rather than confidentiality. These attacks can halt operations, corrupt critical data, and cause significant financial losses through downtime and recovery costs.

**Key Business Risks:**
- Service unavailability impacting operations
- Data corruption affecting decision-making
- Ransomware attacks with business continuity implications
- Vendor failure or sudden service termination
- SLA breaches and contractual penalties

## Attack Tree

```text
Goal: Disrupt vendor services or corrupt data to impact business operations
├── 4.1 Service Availability Attacks
│   ├── Targeted attacks on vendor infrastructure
│   │   └── Technique: T1498 (Network Denial of Service)
│   ├── Vendor system failures or outages
│   │   └── Technique: T1496 (Endpoint Denial of Service)
│   ├── Vendor going out of business suddenly
│   │   └── Technique: T1490 (Inhibit System Recovery)
│   └── Ransomware attacks on vendor systems
│       └── Technique: T1486 (Data Encrypted for Impact)
└── 4.2 Data Integrity Attacks
    ├── Unauthorized modification of data in vendor systems
    │   └── Technique: T1565 (Data Manipulation)
    ├── Data corruption in vendor databases
    │   └── Technique: T1485 (Data Destruction)
    ├── Backup system compromises
    │   └── Technique: T1490 (Inhibit System Recovery)
    └── Data deletion or destruction
        └── Technique: T1485 (Data Destruction)
```text

## Sub-Branch Details

### 4.1 Service Availability Attacks

**Threat Description:** Attacks that render vendor services unavailable or significantly degraded.

**Common Attack Patterns:**
- DDoS attacks overwhelming vendor infrastructure
- Ransomware encrypting vendor systems
- Vendor financial failure or acquisition
- Infrastructure failures without adequate redundancy

**Business Context:**
- Vendor SaaS creates single points of failure
- Recovery time depends on vendor's incident response
- Business continuity planning must include vendor scenarios

### 4.2 Data Integrity Attacks

**Threat Description:** Attacks that compromise the accuracy and reliability of data stored or processed by vendors.

**Common Attack Patterns:**
- Database manipulation through compromised credentials
- Backup corruption or deletion
- Transaction log tampering
- Data synchronization failures

**Business Context:**
- Data integrity is harder to detect than breaches
- Corrupted data may be used for critical decisions
- Recovery from integrity compromises is complex

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1498 | Network Denial of Service | 4.1 | Impact | DDoS attacks |
| T1496 | Endpoint Denial of Service | 4.1 | Impact | System failures |
| T1490 | Inhibit System Recovery | 4.1, 4.2 | Impact | Backup destruction |
| T1486 | Data Encrypted for Impact | 4.1 | Impact | Ransomware |
| T1565 | Data Manipulation | 4.2 | Impact | Data tampering |
| T1485 | Data Destruction | 4.2 | Impact | Data deletion |

## Assessment Questions

### Service Availability

1. What is the vendor's published uptime SLA?
2. What redundancy does the vendor maintain?
3. What is the vendor's disaster recovery capability?
4. Has the vendor experienced significant outages historically?
5. What is the vendor's financial stability?

### Data Integrity

1. How does the vendor ensure data integrity?
2. Are there data validation checks in place?
3. How are backups maintained and tested?
4. Is there point-in-time recovery capability?
5. How is data corruption detected?

### Business Continuity

1. What is the recovery time objective (RTO) for vendor services?
2. Is there a backup vendor identified?
3. Can data be exported and migrated if needed?
4. What are the contractual provisions for service termination?
5. Is there insurance coverage for vendor disruption?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 4.1 | V2.1 | Business logic validation |
| 4.1 | V14.1 | Data integrity protection |
| 4.2 | V14.2 | Backup and recovery |
| 4.2 | V14.3 | Data corruption detection |

## Indicators of Compromise

**Availability Attack Indicators:**
- Service degradation or unavailability
- Vendor security incident notifications
- Unusual error rates from vendor APIs
- Vendor communication about outages
- Ransomware reports from vendor

**Integrity Attack Indicators:**
- Data inconsistencies or anomalies
- Unexpected data changes
- Checksum or hash mismatches
- Audit log gaps or anomalies
- Backup verification failures

## Mitigating Requirements

### For Availability

1. **Define SLA Requirements:** Establish minimum availability in contracts
2. **Maintain Redundancy:** Identify backup vendors or internal alternatives
3. **Monitor Availability:** Track vendor uptime and performance
4. **Plan for Exit:** Document data export procedures
5. **Test Recovery:** Validate business continuity plans

### For Data Integrity

1. **Validate Data:** Implement checksums and integrity checks
2. **Backup Data:** Maintain independent backups of critical data
3. **Monitor Changes:** Track data modifications and anomalies
4. **Test Recovery:** Regularly validate backup restoration
5. **Document Procedures:** Establish incident response for integrity issues

## Related Branches

- **[Branch 1: Vendor Infrastructure](../branch-01-vendor-infrastructure.md)** — Infrastructure-level risks
- **[Branch 3: Integration Point Exploitation](../branch-03-integration-points.md)** — Integration-related availability
- **[Branch 5: Infrastructure Components](../branch-05-infrastructure-components.md)** — Component-level redundancy
- **[Branch 9: Pipeline Integration](../branch-09-pipeline-integration.md)** — Pipeline availability

## References

- [NIST Business Continuity Planning](https://csrc.nist.gov/publications/detail/sp/800-34/rev-3/final)
- [MITRE ATT&CK Impact Tactics](https://attack.mitre.org/tactics/TA0040/)
- [OWASP Data Integrity](https://owasp.org/www-project-proactive-controls/)
