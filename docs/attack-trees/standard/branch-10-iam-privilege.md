---
branch_number: 10
branch_name: "IAM Privilege Escalation"
assessment_types: ["Type 3"]
risk_level: "High"
asvs_chapters: ["V6", "V8", "V10"]
aisvs_chapters: ["C5"]
mitre_techniques: ["T1078", "T1548", "T1484", "T1550", "T1556", "T1071"]
tags: ["iam", "privilege-escalation", "cloud", "role-assumption", "policy"]
related_branches: [2, 7, 11, 13]
---

# Branch 10: IAM Privilege Escalation

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 3 |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V6 (Authentication), V8 (Authorization), V10 (OAuth/OIDC) |
| **AISVS Chapters** | C5 (Access Control) |
| **Related Branches** | [Branch 2](../branch-02-vendor-personnel.md) (Personnel), [Branch 7](../branch-07-authentication.md) (Auth), [Branch 11](../branch-11-network-lateral.md) (Network), [Branch 13](../branch-13-credential-theft.md) (Secrets) |

## Business Impact

IAM privilege escalation enables attackers to gain unauthorized access to cloud resources, often starting from limited permissions and escalating to full administrative control. This is a critical attack vector in cloud environments.

**Key Business Risks:**
- Unauthorized access to cloud resources
- Data exfiltration from cloud storage
- Resource manipulation and deletion
- Cryptocurrency mining on compromised resources
- Cross-account lateral movement

## Attack Tree

```text
Goal: Escalate IAM privileges to gain unauthorized cloud access
├── 10.1 Role Assumption Chain Attacks
│   ├── Chained role assumptions escalating from limited to admin
│   │   └── Technique: T1078.004 (Valid Accounts: Cloud Accounts)
│   ├── Cross-account role assumption abuse
│   │   └── Technique: T1078.004 (Valid Accounts: Cloud Accounts)
│   ├── Wildcard resource policies enabling unintended access
│   │   └── Technique: T1484 (Domain Policy Modification)
│   └── Service-linked role exploitation
│       └── Technique: T1078.004 (Valid Accounts: Cloud Accounts)
├── 10.2 Policy Misconfiguration
│   ├── Overly permissive IAM policies (Action: *, Resource: *)
│   │   └── Technique: T1484 (Domain Policy Modification)
│   ├── Missing condition keys allowing unscoped access
│   │   └── Technique: T1484 (Domain Policy Modification)
│   ├── Inline policies shadowing managed policy restrictions
│   │   └── Technique: T1484 (Domain Policy Modification)
│   └── Trust policy misconfiguration on roles
│       └── Technique: T1078.004 (Valid Accounts: Cloud Accounts)
└── 10.3 Federation Exploitation
    ├── SAML assertion manipulation
    │   └── Technique: T1550 (Use Alternate Authentication Material)
    ├── OIDC token forgery or replay
    │   └── Technique: T1550 (Use Alternate Authentication Material)
    ├── IdP compromise granting cloud access
    │   └── Technique: T1556 (Modify Authentication Process)
    └── Session duration abuse in federated roles
        └── Technique: T1071 (Application Layer Protocol)
```text

## Sub-Branch Details

### 10.1 Role Assumption Chain Attacks

**Threat Description:** Exploiting trust relationships between IAM roles to escalate privileges.

**Common Attack Patterns:**
- Chained role assumption through multiple trust relationships
- Cross-account role assumption from compromised account
- Service-linked role abuse
- PassRole privilege escalation

**Business Context:**
- Cloud IAM is complex with many trust relationships
- Role chains can create unexpected privilege paths
- Service roles often have excessive permissions

### 10.2 Policy Misconfiguration

**Threat Description:** Overly permissive IAM policies that grant excessive access.

**Common Attack Patterns:**
- Wildcard permissions (*:Actions, *:Resources)
- Missing conditions on sensitive actions
- Inline policies bypassing managed policy restrictions
- Trust policies allowing overly broad assumption

**Business Context:**
- Default policies are often overly permissive
- Policy sprawl makes review difficult
- Least privilege requires continuous effort

### 10.3 Federation Exploitation

**Threat Description:** Attacks on federated identity relationships between IdPs and cloud providers.

**Common Attack Patterns:**
- SAML signature bypass
- OIDC token manipulation
- IdP compromise cascading to cloud access
- Extended session duration abuse

**Business Context:**
- Federation extends trust boundary to IdP
- Token security is critical
- Session management is complex across domains

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1078.004 | Valid Accounts: Cloud Accounts | 10.1 | Persistence | Role assumption |
| T1484 | Domain Policy Modification | 10.1, 10.2 | Privilege Escalation | IAM policy changes |
| T1550 | Use Alternate Authentication Material | 10.3 | Defense Evasion | Token abuse |
| T1556 | Modify Authentication Process | 10.3 | Credential Access | IdP compromise |
| T1071 | Application Layer Protocol | 10.3 | Command and Control | Session abuse |

## Assessment Questions

### Role Management

1. Is least privilege enforced for all roles?
2. Are trust relationships reviewed regularly?
3. Is cross-account access minimized?
4. Are service roles scoped to specific functions?
5. Is role assumption logged and monitored?

### Policy Configuration

1. Are wildcard permissions avoided?
2. Are condition keys used appropriately?
3. Are policies version controlled?
4. Is policy drift detected and remediated?
5. Are inline policies reviewed regularly?

### Federation

1. Is SAML properly configured and validated?
2. Is OIDC token validation secure?
3. Is IdP security reviewed?
4. Are session durations limited?
5. Is federated access monitored?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 10.1 | V6.1 | Secure authentication |
| 10.1 | V8.1 | Access control design |
| 10.2 | V8.2 | Authorization checks |
| 10.3 | V10.1 | OAuth/OIDC security |

## Indicators of Compromise

**Role Abuse Indicators:**
- Unusual role assumption patterns
- Cross-account access from unexpected sources
- Service role usage outside expected scope
- Trust policy changes
- Role assumption by disabled accounts

**Policy Exploitation Indicators:**
- Policy changes granting broad access
- Wildcard permission grants
- Condition key removals
- Trust policy modifications
- Policy attachment to unexpected identities

**Federation Indicators:**
- SAML assertion anomalies
- OIDC token validation failures
- Extended session durations
- IdP security incidents
- Unusual federated access patterns

## Mitigating Requirements

### For Roles

1. **Least Privilege:** Minimal permissions for each role
2. **Trust Boundaries:** Clear trust relationships
3. **Regular Review:** Periodic trust relationship audit
4. **Monitoring:** Alert on unusual role assumptions
5. **Service Role Limits:** Scope service roles tightly

### For Policies

1. **No Wildcards:** Avoid *:Action and *:Resource
2. **Condition Keys:** Enforce conditions on sensitive actions
3. **Version Control:** Track all policy changes
4. **Automated Analysis:** Detect overly permissive policies
5. **Regular Review:** Quarterly policy audits

### For Federation

1. **SAML Validation:** Strict signature and assertion validation
2. **OIDC Security:** Secure token validation
3. **IdP Security:** Monitor IdP security posture
4. **Session Limits:** Short session durations
5. **Federation Monitoring:** Alert on federation anomalies

## Related Branches

- **[Branch 2: Vendor Personnel Threats](../branch-02-vendor-personnel.md)** — Credential compromise
- **[Branch 7: Authentication and Authorization Exploitation](../branch-07-authentication.md)** — Auth weaknesses
- **[Branch 11: Network Lateral Movement](../branch-11-network-lateral.md)** — Post-escalation movement
- **[Branch 13: Credential and Secret Theft](../branch-13-credential-theft.md)** — Credential security

## References

- [AWS IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [Azure AD Security](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/security-operations)
- [GCP IAM Overview](https://cloud.google.com/iam/docs/overview)
