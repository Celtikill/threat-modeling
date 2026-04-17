---
branch_number: 2
branch_name: "Vendor Personnel Threats"
assessment_types: ["Type 1", "Type 2"]
risk_level: "High"
asvs_chapters: ["V6", "V8"]
aisvs_chapters: ["C5"]
mitre_techniques: ["T1078", "T1566", "T1484", "T1555"]
tags: ["vendor", "personnel", "insider-threat", "social-engineering", "credentials"]
related_branches: [1, 3, 7, 10, 13]
---

# Branch 2: Vendor Personnel Threats

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 1, 2 |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V6 (Authentication), V8 (Authorization) |
| **AISVS Chapters** | C5 (Access Control) |
| **Related Branches** | [Branch 1](../branch-01-vendor-infrastructure.md) (Infrastructure), [Branch 3](../branch-03-integration-points.md) (Integration), [Branch 7](../branch-07-authentication.md) (Auth), [Branch 10](../branch-10-iam-privilege.md) (IAM), [Branch 13](../branch-13-credential-theft.md) (Secrets) |

## Business Impact

Personnel-related threats represent persistent high-risk scenarios because they exploit legitimate access privileges. Even well-vetted vendors can experience credential compromise through social engineering, and malicious insiders have inherent trust that bypasses many technical controls.

**Key Business Risks:**
- Data breach through compromised credentials
- Unauthorized data access by vendor staff
- Insider theft of customer data
- Administrative privilege abuse
- Social engineering of vendor support

## Attack Tree

```text
Goal: Exploit vendor personnel to compromise customer data
├── 2.1 Malicious Vendor Insider
│   ├── Vendor employee intentional data theft
│   │   └── Technique: T1078 (Valid Accounts)
│   ├── Vendor administrator abuse of privileges
│   │   └── Technique: T1078.004 (Valid Accounts: Cloud Accounts)
│   ├── Vendor contractor with malicious intent
│   │   └── Technique: T1078 (Valid Accounts)
│   └── Vendor executive business email compromise
│       └── Technique: T1078 (Valid Accounts)
└── 2.2 Compromised Vendor Personnel
    ├── Social engineering of vendor staff
    │   └── Technique: T1566 (Phishing)
    ├── Credential compromise of vendor employees
    │   └── Technique: T1555 (Credentials from Password Stores)
    ├── Phishing attacks targeting vendor personnel
    │   └── Technique: T1566.001 (Phishing: Spearphishing Attachment)
    └── Physical security breaches at vendor facilities
        └── Technique: T1098 (Account Manipulation)
```text

## Sub-Branch Details

### 2.1 Malicious Vendor Insider

**Threat Description:** Vendor employees, contractors, or administrators with legitimate access who intentionally abuse their privileges.

**Common Attack Patterns:**
- Customer data exfiltration by employee with database access
- Administrator creating backdoor accounts
- Contractor copying customer data before contract end
- Executive email compromise for wire fraud

**Business Context:**
- Vendor employees have privileged access to customer environments
- Background checks reduce but don't eliminate risk
- Motivations include financial gain, espionage, or grievance

### 2.2 Compromised Vendor Personnel

**Threat Description:** Legitimate vendor credentials compromised through external attacks, enabling adversary access.

**Common Attack Patterns:**
- Phishing campaign targeting vendor support staff
- Credential stuffing using breached passwords
- SIM swapping for MFA bypass
- Session hijacking on vendor-managed devices

**Business Context:**
- Vendors are high-value targets due to customer access
- Social engineering often succeeds against support staff
- Vendor MFA gaps enable credential abuse

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1078 | Valid Accounts | 2.1 | Persistence | Insider abuse |
| T1078.004 | Valid Accounts: Cloud Accounts | 2.1 | Persistence | Admin abuse |
| T1566 | Phishing | 2.2 | Initial Access | Social engineering |
| T1566.001 | Phishing: Spearphishing | 2.2 | Initial Access | Targeted phishing |
| T1555 | Credentials from Password Stores | 2.2 | Credential Access | Credential theft |
| T1098 | Account Manipulation | 2.2 | Persistence | Physical breach |

## Assessment Questions

### Personnel Security

1. Does the vendor conduct background checks on personnel?
2. What is the vendor's personnel termination process?
3. Are vendor administrators required to use MFA?
4. Does the vendor conduct security awareness training?
5. How does the vendor detect insider threats?

### Access Controls

1. Do vendor personnel have access to customer data?
2. Is vendor access scoped to minimum necessary?
3. Are vendor actions logged and monitored?
4. Can vendor access be revoked immediately?
5. Is there separation of duties within vendor staff?

### Credential Security

1. Does the vendor enforce strong password policies?
2. Is MFA required for all vendor access?
3. How are vendor credentials stored and protected?
4. Does the vendor rotate credentials regularly?
5. Are vendor credentials ever shared?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 2.1 | V6.1 | Secure authentication mechanism |
| 2.1 | V6.4 | Credential recovery protection |
| 2.1 | V8.1 | Access control design |
| 2.2 | V6.2 | MFA implementation |
| 2.2 | V14.1 | Data classification |

## Indicators of Compromise

**Malicious Insider Indicators:**
- Unusual data access patterns (bulk downloads, off-hours)
- Access to data outside job responsibilities
- Attempts to escalate privileges
- Circumvention of monitoring/logging
- Communication with competitors

**Compromised Account Indicators:**
- Login from unusual locations
- Impossible travel (multiple distant locations)
- Failed MFA attempts followed by successful authentication
- Password reset requests
- Unusual API usage patterns

## Mitigating Requirements

### For Vendor Personnel

1. **Enforce Multi-Factor Authentication:** Require MFA for all vendor access
2. **Implement Least Privilege:** Scope vendor access to minimum necessary
3. **Enable Comprehensive Logging:** Log all vendor actions with alerting
4. **Conduct Background Checks:** Verify vendor personnel screening
5. **Require Security Training:** Ensure vendor staff are trained on threats

### For Access Management

1. **Just-in-Time Access:** Grant access only when needed
2. **Regular Access Reviews:** Review vendor permissions quarterly
3. **Segregate Vendor Access:** Isolate vendor networks where possible
4. **Monitor for Anomalies:** Alert on unusual vendor activity
5. **Maintain Revocation Capability:** Ensure immediate access termination

## Related Branches

- **[Branch 1: Vendor Infrastructure](../branch-01-vendor-infrastructure.md)** — Technical infrastructure risks
- **[Branch 3: Integration Point Exploitation](../branch-03-integration-points.md)** — Technical integration risks
- **[Branch 7: Authentication and Authorization Exploitation](../branch-07-authentication.md)** — Auth controls
- **[Branch 10: IAM Privilege Escalation](../branch-10-iam-privilege.md)** — Privilege management
- **[Branch 13: Credential and Secret Theft](../branch-13-credential-theft.md)** — Credential security

## References

- [CERT Insider Threat Center](https://www.sei.cmu.edu/research-capabilities/insider-threat/)
- [MITRE ATT&CK Insider Threat](https://attack.mitre.org/tactics/TA0002/)
- [NIST Insider Threat Program](https://csrc.nist.gov/projects/insider-threat)
