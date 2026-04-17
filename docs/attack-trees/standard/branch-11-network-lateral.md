---
branch_number: 11
branch_name: "Network Lateral Movement"
assessment_types: ["Type 3"]
risk_level: "Medium"
asvs_chapters: ["V12", "V13"]
aisvs_chapters: []
mitre_techniques: ["T1021", "T1550", "T1590", "T1538", "T1018"]
tags: ["network", "lateral-movement", "security-groups", "vpc", "peering"]
related_branches: [5, 10, 12]
---

# Branch 11: Network Lateral Movement

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 3 |
| **Risk Prevalence** | Medium |
| **ASVS Chapters** | V12 (Communication), V13 (Configuration) |
| **AISVS Chapters** | N/A |
| **Related Branches** | [Branch 5](../branch-05-infrastructure-components.md) (Components), [Branch 10](../branch-10-iam-privilege.md) (IAM), [Branch 12](../branch-12-public-exposure.md) (Exposure) |

## Business Impact

Network lateral movement enables attackers to traverse from initial access points to high-value targets. Weak network segmentation and overly permissive security group rules can allow attackers to move freely across the infrastructure.

**Key Business Risks:**
- Unrestricted east-west traffic enabling lateral movement
- VPC peering creating unintended trust boundaries
- Overly permissive security group rules
- Data exfiltration via network paths
- Compromise propagation across network segments

## Attack Tree

```text
Goal: Move laterally through network infrastructure
├── 11.1 Security Group Misconfiguration
│   ├── Overly permissive inbound rules (0.0.0.0/0)
│   │   └── Technique: T1021 (Remote Services)
│   ├── Missing egress restrictions enabling data exfiltration
│   │   └── Technique: T1041 (Exfiltration Over C2 Channel)
│   ├── Security group rule sprawl obscuring effective permissions
│   │   └── Technique: T1590 (Gather Victim Network Information)
│   └── Cross-VPC access through peering without NACLs
│       └── Technique: T1021 (Remote Services)
└── 11.2 VPC and Network Exploitation
    ├── VPC peering exploitation for lateral movement
    │   └── Technique: T1021 (Remote Services)
    ├── Transit Gateway route manipulation
    │   └── Technique: T1550 (Use Alternate Authentication Material)
    ├── SSRF to cloud metadata service (169.254.169.254)
    │   └── Technique: T1550 (Use Alternate Authentication Material)
    └── DNS rebinding attacks against internal services
        └── Technique: T1590 (Gather Victim Network Information)
```text

## Sub-Branch Details

### 11.1 Security Group Misconfiguration

**Threat Description:** Overly permissive security group rules that allow unintended network access.

**Common Attack Patterns:**
- Security groups allowing 0.0.0.0/0 inbound
- Missing egress restrictions
- Overly broad port ranges
- Self-referencing rules creating loops
- Default security groups left unchanged

**Business Context:**
- Security groups are the primary network control in cloud environments
- Misconfigurations often accumulate over time
- Difficult to audit effectively at scale

### 11.2 VPC and Network Exploitation

**Threat Description:** Attacks leveraging VPC networking features to enable lateral movement.

**Common Attack Patterns:**
- VPC peering trust boundary exploitation
- Transit Gateway routing abuse
- Metadata service exploitation (SSRF)
- DNS rebinding for internal service access

**Business Context:**
- VPC peering creates implicit trust relationships
- Complex routing can obscure security boundaries
- Metadata services are high-value targets

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1021 | Remote Services | 11.1, 11.2 | Lateral Movement | Network access |
| T1041 | Exfiltration Over C2 Channel | 11.1 | Exfiltration | Egress exploitation |
| T1590 | Gather Victim Network Information | 11.1, 11.2 | Reconnaissance | Network mapping |
| T1550 | Use Alternate Authentication Material | 11.2 | Lateral Movement | Metadata exploitation |
| T1538 | Cloud Service Dashboard | 11.2 | Discovery | Network discovery |
| T1018 | Remote System Discovery | 11.2 | Discovery | Network enumeration |

## Assessment Questions

### Security Groups

1. Are default security groups restricted?
2. Are overly permissive rules (0.0.0.0/0) avoided?
3. Is egress filtering implemented?
4. Are security groups reviewed regularly?
5. Is least privilege enforced?

### VPC Architecture

1. Is network segmentation implemented?
2. Are VPC peering connections reviewed?
3. Is Transit Gateway routing secured?
4. Are private subnets used for sensitive resources?
5. Is network ACL layering used appropriately?

### Network Monitoring

1. Is VPC Flow logging enabled?
2. Are network anomalies detected?
3. Is east-west traffic monitored?
4. Are network policies enforced?
5. Is lateral movement detectable?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 11.1 | V12.1 | Transport layer security |
| 11.1 | V13.1 | Secure configuration |
| 11.2 | V13.2 | Network segmentation |

## Indicators of Compromise

**Security Group Exploitation Indicators:**
- Connections from unexpected sources
- Port scanning activity
- Connection attempts to restricted ports
- Security group rule changes
- Unusual traffic patterns

**Network Exploitation Indicators:**
- VPC peering traffic anomalies
- Metadata service access
- DNS rebinding attempts
- Transit Gateway route changes
- Network reconnaissance activity

## Mitigating Requirements

### For Security Groups

1. **Default Deny:** Default security groups should deny all
2. **Least Privilege:** Minimal necessary access
3. **Egress Filtering:** Restrict outbound traffic
4. **Regular Review:** Quarterly security group audits
5. **Automated Analysis:** Detect overly permissive rules

### For VPC Architecture

1. **Network Segmentation:** Separate networks by function
2. **Peering Review:** Validate all VPC peering connections
3. **Private Subnets:** Sensitive resources in private subnets
4. **NACL Layering:** Defense in depth with NACLs
5. **Transit Gateway Security:** Secure routing policies

### For Monitoring

1. **Flow Logging:** Enable VPC Flow Logs
2. **Traffic Analysis:** Monitor for anomalies
3. **Alerting:** Alert on suspicious patterns
4. **East-West Visibility:** Monitor internal traffic
5. **Incident Response:** Network-focused IR procedures

## Related Branches

- **[Branch 5: Infrastructure Component Compromise](../branch-05-infrastructure-components.md)** — Component security
- **[Branch 10: IAM Privilege Escalation](../branch-10-iam-privilege.md)** — Identity-based movement
- **[Branch 12: Public Exposure Exploitation](../branch-12-public-exposure.md)** — Entry points

## References

- [AWS VPC Security](https://docs.aws.amazon.com/vpc/latest/userguide/security.html)
- [Azure Network Security](https://docs.microsoft.com/en-us/azure/security/fundamentals/network-best-practices)
- [GCP Network Security](https://cloud.google.com/architecture/network-security)
