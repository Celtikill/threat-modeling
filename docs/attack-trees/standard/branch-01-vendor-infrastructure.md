---
branch_number: 1
branch_name: "Vendor Infrastructure Compromise"
assessment_types: ["Type 1", "Type 2", "Type 3"]
risk_level: "Medium"
asvs_chapters: ["V11", "V12", "V13"]
aisvs_chapters: ["C4"]
mitre_techniques: ["T1190", "T1078", "T1595", "T1203", "T1195.002"]
tags: ["vendor", "infrastructure", "supply-chain", "external-attack"]
related_branches: [2, 3, 5, 8, 21]
---

# Branch 1: Vendor Infrastructure Compromise

| | |
|:---|:---|
| **Assessment Types** | All (Type 1, 2, 3) |
| **Risk Prevalence** | Medium |
| **ASVS Chapters** | V11-V13 |
| **Related Branches** | [2](../branch-02-vendor-personnel.md), [3](../branch-03-integration-points.md), [5](../branch-05-infrastructure-components.md), [8](../branch-08-cicd-pipeline.md), [21](../../ai-specific/branch-21-model-poisoning.md) |

## Business Impact

Attacks on vendor infrastructure can result in supply chain compromises, multi-tenant data breaches, and widespread service disruption. The impact extends beyond the immediate vendor to all dependent organizations, potentially triggering breach notification obligations and regulatory compliance issues.

## Attack Tree

```text
Goal: Compromise vendor infrastructure to access customer data/systems
├── 1.1 External Attack on Vendor Systems
│   ├── Unpatched vulnerabilities in vendor infrastructure → T1190
│   ├── Weak network security controls → T1021
│   ├── Cloud misconfigurations exposing data → T1595
│   ├── DDoS attacks disrupting services → T1498
│   └── Supply chain attacks through dependencies → T1195.002
└── 1.2 Supply Chain Attacks Through Vendor
    ├── Compromised software updates containing malware → T1195.002
    ├── Malicious dependencies in vendor code → T1195.002
    ├── Compromised vendor development environments → T1078
    └── Insider threats in vendor development teams → T1078
```text

## Sub-Branch Details

### 1.1 External Attack on Vendor Systems

**Threat Description:** Direct attacks against vendor infrastructure components including cloud resources, network perimeters, and exposed services.

**Common Attack Patterns:**
- Exploitation of unpatched CVEs in vendor-facing applications
- Cloud configuration errors (S3 buckets, storage accounts)
- Network segmentation failures enabling lateral movement
- Coordinated DDoS against vendor availability

**Business Context:**
Multi-tenant SaaS creates cascading impact; vendor's incident response capability directly affects your recovery time.

### 1.2 Supply Chain Attacks Through Vendor

**Threat Description:** Attacks that leverage the vendor's software, updates, or dependencies to compromise downstream customers.

**Common Attack Patterns:**
- Malicious code injection in vendor software updates
- Typosquatting attacks on vendor dependencies
- Compromise of vendor CI/CD pipelines
- Vendor developer account takeovers

**Business Context:**
Software supply chain attacks are increasingly common; compromised vendor updates bypass customer perimeter controls.

## MITRE ATT&CK Mapping

| Technique ID | Name | Sub-Branch | Tactic |
|--------------|------|------------|--------|
| T1190 | Exploit Public-Facing Application | 1.1 | Initial Access |
| T1021 | Remote Services | 1.1 | Lateral Movement |
| T1595 | Active Scanning | 1.1 | Reconnaissance |
| T1195.002 | Supply Chain Compromise: Software | 1.1, 1.2 | Initial Access |
| T1078 | Valid Accounts | 1.2 | Persistence |

## Assessment Questions

1. What security certifications does the vendor maintain (SOC 2 Type II, ISO 27001)?
2. Does the vendor sign software artifacts and verify dependencies?
3. Are integration points authenticated and encrypted?

## Indicators of Compromise

- Unusual vendor access patterns (off-hours, unusual locations)
- Vendor-reported security incidents
- Abnormal data transfer volumes to vendor
- Changes to vendor API behavior

## Mitigating Requirements

1. **Verify Security Certifications:** Confirm SOC 2 Type II, ISO 27001, or equivalent
2. **Review Vulnerability Management:** Understand patching SLAs and history
3. **Implement Network Segmentation:** Isolate vendor connections and monitor activity

## References

- [NIST Supply Chain Risk Management](https://csrc.nist.gov/projects/cyber-supply-chain-risk-management)
- [MITRE ATT&CK Supply Chain](https://attack.mitre.org/techniques/T1195/)
