---
branch_number: 12
branch_name: "Public Exposure Exploitation"
assessment_types: ["Type 3"]
risk_level: "High"
asvs_chapters: ["V3", "V13"]
aisvs_chapters: []
mitre_techniques: ["T1190", "T1619", "T1530", "T1583", "T1584"]
tags: ["public-exposure", "s3", "storage", "database", "subdomain-takeover"]
related_branches: [3, 10, 11, 13]
---

# Branch 12: Public Exposure Exploitation

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 3 |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V3 (Frontend), V13 (Configuration) |
| **AISVS Chapters** | N/A |
| **Related Branches** | [Branch 3](../branch-03-integration-points.md) (Integration), [Branch 10](../branch-10-iam-privilege.md) (IAM), [Branch 11](../branch-11-network-lateral.md) (Network), [Branch 13](../branch-13-credential-theft.md) (Secrets) |

## Business Impact

Publicly exposed resources represent direct attack vectors that bypass perimeter security. Misconfigured cloud storage, databases, and orphaned DNS records can lead to immediate data breaches without sophisticated exploitation.

**Key Business Risks:**
- Data exposure through publicly accessible storage
- Database exposure without authentication
- Subdomain takeover via orphaned DNS records
- Snapshot and backup exposure
- Service discovery by attackers

## Attack Tree

```text
Goal: Exploit publicly exposed resources to access data/systems
├── 12.1 Storage Misconfiguration
│   ├── Publicly accessible S3 buckets or blob storage
│   │   └── Technique: T1530 (Data from Cloud Storage Object)
│   ├── Unencrypted data in public-facing storage
│   │   └── Technique: T1530 (Data from Cloud Storage Object)
│   ├── Misconfigured bucket policies allowing anonymous access
│   │   └── Technique: T1530 (Data from Cloud Storage Object)
│   └── Snapshot sharing with unintended accounts
│       └── Technique: T1619 (Cloud Storage Object Discovery)
└── 12.2 Service Exposure
    ├── Exposed databases (RDS, ElastiCache, Elasticsearch) to internet
    │   └── Technique: T1190 (Exploit Public-Facing Application)
    ├── Orphaned DNS records (subdomain takeover)
    │   └── Technique: T1583 (Acquire Infrastructure)
    ├── Unprotected API endpoints without WAF
    │   └── Technique: T1190 (Exploit Public-Facing Application)
    └── Expired or misconfigured TLS certificates
        └── Technique: T1584 (Compromise Infrastructure)
```text

## Sub-Branch Details

### 12.1 Storage Misconfiguration

**Threat Description:** Cloud storage resources inadvertently configured with public access.

**Common Attack Patterns:**
- S3 bucket with "Public" ACL
- Blob storage with anonymous read access
- EBS snapshots shared publicly
- RDS snapshots with public access
- CloudFront origin exposure

**Business Context:**
- Storage misconfigurations are common and easily exploited
- Automated tools continuously scan for public storage
- Often affects backup data with historical records

### 12.2 Service Exposure

**Threat Description:** Infrastructure services accessible from the internet without adequate protection.

**Common Attack Patterns:**
- Database listening on public IP
- Elasticsearch clusters without authentication
- Subdomain takeover on expired resources
- API endpoints without rate limiting or WAF
- Management interfaces exposed publicly

**Business Context:**
- Service exposure creates direct attack paths
- Subdomain takeover can be used for phishing
- Databases are high-value targets for attackers

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1530 | Data from Cloud Storage Object | 12.1 | Collection | Storage access |
| T1619 | Cloud Storage Object Discovery | 12.1 | Discovery | Storage enumeration |
| T1190 | Exploit Public-Facing Application | 12.2 | Initial Access | Database exposure |
| T1583 | Acquire Infrastructure | 12.2 | Resource Development | Subdomain takeover |
| T1584 | Compromise Infrastructure | 12.2 | Resource Development | TLS exploitation |

## Assessment Questions

### Storage Security

1. Are all storage buckets private by default?
2. Is public access blocked at the account level?
3. Are encryption requirements enforced?
4. Are snapshots and backups secured?
5. Is access logging enabled?

### Service Exposure

1. Are databases in private subnets?
2. Are orphaned DNS records cleaned up?
3. Are management interfaces restricted?
4. Is WAF deployed for public endpoints?
5. Are TLS certificates valid and current?

### Discovery and Monitoring

1. Is continuous exposure scanning performed?
2. Are public resources alerted on?
3. Is cloud asset inventory maintained?
4. Are unauthorized exposures detected?
5. Is remediation automated?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 12.1 | V3.1 | Secure frontend |
| 12.1 | V13.1 | Secure configuration |
| 12.2 | V13.2 | Access restrictions |
| 12.2 | V13.3 | TLS configuration |

## Indicators of Compromise

**Storage Exploitation Indicators:**
- Unusual storage access patterns
- Downloads from unexpected locations
- Bucket policy changes
- Snapshot sharing modifications
- Anonymous access attempts

**Service Exposure Indicators:**
- Connections to exposed databases
- Subdomain resolution anomalies
- API endpoint scanning
- Certificate validation failures
- Management interface access attempts

## Mitigating Requirements

### For Storage

1. **Private by Default:** Block public access organization-wide
2. **Encryption:** Enforce encryption at rest
3. **Access Logging:** Monitor all access
4. **Snapshot Security:** Secure snapshots and backups
5. **Regular Audits:** Continuous exposure scanning

### For Service Exposure

1. **Private Subnets:** Keep databases private
2. **DNS Hygiene:** Clean up orphaned records
3. **WAF Protection:** Deploy for public endpoints
4. **TLS Management:** Automate certificate renewal
5. **Access Restrictions:** Restrict management interfaces

### For Monitoring

1. **Continuous Scanning:** Automated exposure detection
2. **Alerting:** Immediate notification of public resources
3. **Asset Inventory:** Maintain cloud resource inventory
4. **Remediation:** Automated remediation workflows
5. **Compliance Checks:** Regular compliance verification

## Related Branches

- **[Branch 3: Integration Point Exploitation](../branch-03-integration-points.md)** — API exposure
- **[Branch 10: IAM Privilege Escalation](../branch-10-iam-privilege.md)** — Access control
- **[Branch 11: Network Lateral Movement](../branch-11-network-lateral.md)** — Post-exploitation movement
- **[Branch 13: Credential and Secret Theft](../branch-13-credential-theft.md)** — Credential exposure

## References

- [AWS S3 Security](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html)
- [Azure Storage Security](https://docs.microsoft.com/en-us/azure/storage/common/storage-security-guide)
- [GCP Storage Security](https://cloud.google.com/storage/docs/security)
