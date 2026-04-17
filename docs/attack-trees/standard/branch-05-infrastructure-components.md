---
branch_number: 5
branch_name: "Infrastructure Component Compromise"
assessment_types: ["Type 1", "Type 2", "Type 3"]
risk_level: "High"
asvs_chapters: ["V11", "V13"]
aisvs_chapters: ["C4"]
mitre_techniques: ["T1595", "T1203", "T1498", "T1496", "T1078"]
tags: ["infrastructure", "components", "dmz", "perimeter", "redundancy"]
related_branches: [1, 3, 10, 11, 12, 13, 14]
---

# Branch 5: Infrastructure Component Compromise

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | All (Type 1, 2, 3) |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V11 (Cryptography), V13 (Configuration) |
| **AISVS Chapters** | C4 (Infrastructure Security) |
| **Related Branches** | [Branch 1](../branch-01-vendor-infrastructure.md) (Vendor), [Branch 3](../branch-03-integration-points.md) (Integration), [Branch 10](../branch-10-iam-privilege.md) (IAM), [Branch 11](../branch-11-network-lateral.md) (Network), [Branch 12](../branch-12-public-exposure.md) (Exposure), [Branch 13](../branch-13-credential-theft.md) (Secrets), [Branch 14](../branch-14-logging-evasion.md) (Logging) |

## Business Impact

Infrastructure components are the foundation of secure operations. Compromising critical components like firewalls, load balancers, or API gateways can bypass multiple security controls simultaneously and enable widespread access.

**Key Business Risks:**
- Perimeter security bypass
- Cascading infrastructure failures
- Administrative boundary escalation
- Denial of service through component compromise
- Single point of failure exploitation

## Attack Tree

```text
Goal: Compromise critical infrastructure components
├── 5.1 DMZ and Perimeter Security Attacks
│   ├── Firewall cluster bypass via zero-day vulnerabilities
│   │   └── Technique: T1595 (Active Scanning)
│   ├── Load balancer SSL termination compromise
│   │   └── Technique: T1203 (Exploitation for Client Execution)
│   ├── API gateway authentication bypass
│   │   └── Technique: T1078 (Valid Accounts)
│   └── Network segmentation boundary violations
│       └── Technique: T1021 (Remote Services)
├── 5.2 Critical Infrastructure Component Attacks
│   ├── Message router/traffic director compromise
│   │   └── Technique: T1203 (Exploitation for Client Execution)
│   ├── Routing table manipulation affecting service delivery
│   │   └── Technique: T1496 (Endpoint Denial of Service)
│   ├── Failover trigger manipulation preventing redundancy
│   │   └── Technique: T1490 (Inhibit System Recovery)
│   └── Administrative access boundary escalation
│       └── Technique: T1548 (Abuse Elevation Control)
└── 5.3 Redundancy Mechanism Exploitation
    ├── Coordinated multi-provider DDoS attacks
    │   └── Technique: T1498 (Network Denial of Service)
    ├── BGP hijacking targeting primary service routes
    │   └── Technique: T1496 (Endpoint Denial of Service)
    ├── Carrier failover window exploitation during critical periods
    │   └── Technique: T1496 (Endpoint Denial of Service)
    └── Cross-provider infrastructure dependency attacks
        └── Technique: T1490 (Inhibit System Recovery)
```text

## Sub-Branch Details

### 5.1 DMZ and Perimeter Security Attacks

**Threat Description:** Attacks targeting perimeter security components that protect internal resources.

**Common Attack Patterns:**
- Firewall rule bypass through protocol tunneling
- Load balancer cookie manipulation
- WAF rule evasion
- Reverse proxy exploitation

**Business Context:**
- Perimeter components are high-value targets
- Compromise can expose entire internal network
- Zero-day vulnerabilities in common components create widespread risk

### 5.2 Critical Infrastructure Component Attacks

**Threat Description:** Attacks on essential infrastructure services that enable system operation.

**Common Attack Patterns:**
- DNS server compromise for traffic redirection
- DHCP manipulation for network positioning
- Certificate authority compromise
- Time service (NTP) attacks

**Business Context:**
- Infrastructure components often have excessive privileges
- Compromise affects availability and security simultaneously
- Recovery requires coordination across multiple systems

### 5.3 Redundancy Mechanism Exploitation

**Threat Description:** Attacks that undermine failover and redundancy systems.

**Common Attack Patterns:**
- Health check manipulation causing false failover
- Split-brain scenarios in clustered systems
- Backup power system compromise
- Geographic redundancy bypass

**Business Context:**
- Redundancy creates complex attack surface
- Failover windows create vulnerability periods
- Multi-site dependencies increase exposure

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1595 | Active Scanning | 5.1 | Reconnaissance | Finding component weaknesses |
| T1203 | Exploitation for Client Execution | 5.1, 5.2 | Execution | Component exploitation |
| T1078 | Valid Accounts | 5.1 | Initial Access | Gateway credential abuse |
| T1021 | Remote Services | 5.1 | Lateral Movement | Boundary violation |
| T1496 | Endpoint Denial of Service | 5.2, 5.3 | Impact | Routing manipulation |
| T1490 | Inhibit System Recovery | 5.2, 5.3 | Impact | Redundancy bypass |
| T1498 | Network Denial of Service | 5.3 | Impact | DDoS attacks |
| T1548 | Abuse Elevation Control | 5.2 | Privilege Escalation | Admin boundary escalation |

## Assessment Questions

### Perimeter Security

1. What perimeter security components are in use (firewalls, WAF, IDS)?
2. Are components regularly patched and updated?
3. Is network segmentation properly implemented?
4. Are DMZ systems hardened and minimized?
5. Is SSL/TLS termination secure?

### Critical Components

1. What infrastructure components are single points of failure?
2. Are administrative interfaces properly secured?
3. Is component configuration version controlled?
4. Are components monitored for anomalies?
5. Is there separation between component management and usage?

### Redundancy

1. What redundancy exists for critical components?
2. Are failover mechanisms regularly tested?
3. Is geographic diversity maintained?
4. Are backup components equally secured?
5. What is the recovery time for component failures?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 5.1 | V11.1 | Secure cryptographic configuration |
| 5.1 | V13.1 | Secure build and deployment |
| 5.1 | V13.2 | Dependency management |
| 5.2 | V13.3 | Configuration hardening |
| 5.3 | V14.2 | Backup and recovery procedures |

## Indicators of Compromise

**Component Compromise Indicators:**
- Unusual component configuration changes
- Component restart or service disruption
- Administrative access from unusual sources
- Component log anomalies or gaps
- Performance degradation in component services

**Redundancy Exploitation Indicators:**
- Unscheduled failover events
- Health check failures
- Geographic traffic anomalies
- Synchronization failures between redundant systems
- Failback failures

## Mitigating Requirements

### For Perimeter Security

1. **Harden Components:** Minimize attack surface on DMZ systems
2. **Regular Updates:** Patch components promptly
3. **Monitor Configuration:** Detect unauthorized changes
4. **Segment Networks:** Implement proper network zoning
5. **Test Boundaries:** Validate segmentation effectiveness

### For Critical Components

1. **Identify Dependencies:** Map critical component relationships
2. **Secure Administration:** Strong authentication for management
3. **Version Control:** Track all configuration changes
4. **Monitor Health:** Alert on component anomalies
5. **Plan Recovery:** Document component restoration procedures

### For Redundancy

1. **Test Failover:** Regularly validate redundancy mechanisms
2. **Secure Equally:** Apply same security to backup systems
3. **Monitor Synchronization:** Detect divergence between systems
4. **Plan for Split-Brain:** Document resolution procedures
5. **Geographic Distribution:** Maintain physical separation

## Related Branches

- **[Branch 1: Vendor Infrastructure](../branch-01-vendor-infrastructure.md)** — Vendor-provided infrastructure
- **[Branch 3: Integration Point Exploitation](../branch-03-integration-points.md)** — Integration component risks
- **[Branch 10: IAM Privilege Escalation](../branch-10-iam-privilege.md)** — Administrative access
- **[Branch 11: Network Lateral Movement](../branch-11-network-lateral.md)** — Post-compromise movement
- **[Branch 12: Public Exposure Exploitation](../branch-12-public-exposure.md)** — Exposed components
- **[Branch 13: Credential and Secret Theft](../branch-13-credential-theft.md)** — Component credentials
- **[Branch 14: Logging Evasion](../branch-14-logging-evasion.md)** — Component monitoring

## References

- [NIST Security Architecture](https://csrc.nist.gov/publications/detail/sp/800-160/vol-1/final)
- [CIS Critical Security Controls](https://www.cisecurity.org/controls)
- [MITRE ATT&CK Network Security](https://attack.mitre.org/techniques/T1021/)
