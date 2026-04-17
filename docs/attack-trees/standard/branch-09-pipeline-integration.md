---
branch_number: 9
branch_name: "Pipeline Integration Exploitation"
assessment_types: ["Type 2"]
risk_level: "Medium"
asvs_chapters: ["V4", "V5"]
aisvs_chapters: []
mitre_techniques: ["T1552", "T1530", "T1565", "T1041", "T1550"]
tags: ["pipeline", "etl", "data-flow", "credential-exposure", "data-sprawl"]
related_branches: [3, 4, 8]
---

# Branch 9: Pipeline Integration Exploitation

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 (Conditional: if data pipeline in scope) |
| **Risk Prevalence** | Medium |
| **ASVS Chapters** | V4 (API), V5 (File Handling) |
| **AISVS Chapters** | N/A |
| **Related Branches** | [Branch 3](../branch-03-integration-points.md) (Integration), [Branch 4](../branch-04-business-disruption.md) (Disruption), [Branch 8](../branch-08-cicd-pipeline.md) (CI/CD) |

## Business Impact

Data pipelines (ETL/ELT) handle large volumes of sensitive data across multiple environments. Security gaps in pipeline architecture can lead to credential exposure, data sprawl, and unauthorized access to data in motion and at rest.

**Key Business Risks:**
- Credential theft at pipeline stages
- Uncontrolled data replication across environments
- Sensitive data propagation to lower-trust environments
- ETL/ELT logic tampering affecting data integrity
- Weak egress controls enabling data exfiltration

## Attack Tree

```text
Goal: Exploit data pipeline integrations to access or manipulate data
├── 9.1 Hop-to-Hop Credential Compromise
│   ├── Service account credential theft at any pipeline stage
│   │   └── Technique: T1552 (Unsecured Credentials)
│   ├── API key reuse across pipeline stages
│   │   └── Technique: T1552 (Unsecured Credentials)
│   ├── Credential exposure in pipeline orchestration logs
│   │   └── Technique: T1552 (Unsecured Credentials)
│   └── Shared credentials between production and non-production stages
│       └── Technique: T1552 (Unsecured Credentials)
├── 9.2 Data Amplification and Sprawl
│   ├── Uncontrolled data replication across pipeline stages
│   │   └── Technique: T1530 (Data from Cloud Storage Object)
│   ├── Sensitive data propagation to lower-trust environments
│   │   └── Technique: T1530 (Data from Cloud Storage Object)
│   ├── Lack of data minimization in intermediate stages
│   │   └── Technique: T1530 (Data from Cloud Storage Object)
│   └── Test data containing production PII
│       └── Technique: T1530 (Data from Cloud Storage Object)
├── 9.3 Transformation Logic Tampering
│   ├── Malicious modification of ETL/ELT logic (e.g., DBT models)
│   │   └── Technique: T1565 (Data Manipulation)
│   ├── Data filtering bypass allowing sensitive data through
│   │   └── Technique: T1565 (Data Manipulation)
│   ├── Business rule modification affecting data integrity
│   │   └── Technique: T1565 (Data Manipulation)
│   └── Version control gaps in transformation code
│       └── Technique: T1565 (Data Manipulation)
└── 9.4 Egress Point Exploitation
    ├── Unencrypted data at final output stage
    │   └── Technique: T1041 (Exfiltration Over C2 Channel)
    ├── Weak or missing PGP/GPG key management
    │   └── Technique: T1550 (Use Alternate Authentication Material)
    ├── Overly permissive file sharing links
    │   └── Technique: T1041 (Exfiltration Over C2 Channel)
    └── Missing access controls on output storage
        └── Technique: T1041 (Exfiltration Over C2 Channel)
```text

## Sub-Branch Details

### 9.1 Hop-to-Hop Credential Compromise

**Threat Description:** Exposure or theft of credentials used for authentication between pipeline stages.

**Common Attack Patterns:**
- Hardcoded credentials in pipeline scripts
- Credentials logged in plain text
- Service account keys stored in environment variables
- Shared credentials across dev/staging/prod

**Business Context:**
- Pipelines often span multiple security boundaries
- Each hop represents a potential credential exposure
- Shared credentials amplify breach impact

### 9.2 Data Amplification and Sprawl

**Threat Description:** Uncontrolled replication and distribution of data across pipeline stages.

**Common Attack Patterns:**
- Full table replication when only deltas needed
- Production data in development environments
- Lack of data retention policies
- Sensitive data in test datasets

**Business Context:**
- Data sprawl increases attack surface
- Compliance violations from data in wrong environments
- Recovery complexity from multiple data copies

### 9.3 Transformation Logic Tampering

**Threat Description:** Modification of business logic to alter data processing behavior.

**Common Attack Patterns:**
- Malicious DBT model changes
- Filtering logic bypass
- Aggregation manipulation
- Column-level data manipulation

**Business Context:**
- Logic errors can affect data integrity
- Hard to detect without reconciliation checks
- Can persist for extended periods

### 9.4 Egress Point Exploitation

**Threat Description:** Weaknesses in final data delivery mechanisms.

**Common Attack Patterns:**
- Unencrypted file delivery
- Weakly protected cloud storage
- Permissive sharing links
- Missing access expiration

**Business Context:**
- Final stage where data leaves controlled environment
- Often overlooked in security reviews
- Can expose data to unintended recipients

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1552 | Unsecured Credentials | 9.1 | Credential Access | Pipeline credentials |
| T1530 | Data from Cloud Storage Object | 9.2 | Collection | Data sprawl |
| T1565 | Data Manipulation | 9.3 | Impact | Logic tampering |
| T1041 | Exfiltration Over C2 Channel | 9.4 | Exfiltration | Egress exploitation |
| T1550 | Use Alternate Authentication Material | 9.4 | Defense Evasion | Key compromise |

## Assessment Questions

### Credentials

1. Are pipeline credentials stored in secrets managers?
2. Are credentials rotated regularly?
3. Are credentials scoped to specific pipeline stages?
4. Are credentials excluded from logs?
5. Are production credentials isolated from non-production?

### Data Flow

1. Is data flow documented (diagrams, catalogs)?
2. Is data minimized at each stage?
3. Are data retention policies enforced?
4. Is sensitive data identified and protected?
5. Is data lineage tracked?

### Transformation

1. Is transformation code version controlled?
2. Are changes reviewed before deployment?
3. Is data quality validated at each stage?
4. Are business rules documented?
5. Is reconciliation performed between stages?

### Egress

1. Is egress data encrypted?
2. Are access controls enforced on destinations?
3. Are sharing links time-limited?
4. Is egress monitored and logged?
5. Are recipients authorized?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 9.1 | V4.1 | API authentication |
| 9.1 | V4.2 | API authorization |
| 9.2 | V5.1 | File upload security |
| 9.2 | V5.2 | File storage security |
| 9.4 | V4.3 | API output validation |

## Indicators of Compromise

**Credential Compromise Indicators:**
- Credentials in pipeline logs
- Failed authentication attempts
- Credential usage from unexpected locations
- Shared credential usage across environments
- Credential rotation failures

**Data Sprawl Indicators:**
- Unexplained data growth
- Sensitive data in development
- Uncontrolled data replication
- Missing data retention enforcement
- Unsanctioned data exports

**Logic Tampering Indicators:**
- Unexpected data changes
- Transformation code changes
- Data quality anomalies
- Business rule violations
- Schema changes

## Mitigating Requirements

### For Credentials

1. **Secrets Management:** Store in dedicated secrets manager
2. **Scoped Credentials:** Different credentials per stage
3. **Regular Rotation:** Automated credential rotation
4. **Log Sanitization:** Exclude credentials from logs
5. **Least Privilege:** Minimal permissions per credential

### For Data Flow

1. **Data Minimization:** Only necessary data at each stage
2. **Classification:** Identify and protect sensitive data
3. **Retention Policies:** Automated data lifecycle management
4. **Lineage Tracking:** Understand data movement
5. **Environment Isolation:** Separate data per environment

### For Egress

1. **Encryption:** Encrypt all egress data
2. **Access Controls:** Restrict destination access
3. **Time Limits:** Expire sharing links automatically
4. **Monitoring:** Log and alert on egress
5. **Authorization:** Verify recipient authorization

## Related Branches

- **[Branch 3: Integration Point Exploitation](../branch-03-integration-points.md)** — API integration risks
- **[Branch 4: Vendor Business Disruption](../branch-04-business-disruption.md)** — Pipeline availability
- **[Branch 8: CI/CD Pipeline Compromise](../branch-08-cicd-pipeline.md)** — Build pipeline risks

## References

- [OWASP Data Security](https://owasp.org/www-project-data-security/)
- [NIST Data Integrity](https://csrc.nist.gov/projects/data-integrity)
