# Supporting Analysis: ExampleCloud Infrastructure — Multi-Account Posture

<!-- This is a FICTIONAL example supporting analysis demonstrating the Type 3 (Infrastructure-Only) methodology. All infrastructure details and scenarios are fictitious. -->

---

## Document Control

| Field | Value |
|-------|-------|
| **Version** | 1.0 |
| **Assessment Date** | 2026-01-20 |
| **Assessor** | Security Architecture Team |
| **Business Owner** | [Example Organization] Infrastructure Team |
| **Status** | Final |
| **Lean Report** | [examplecloud-infrastructure-threat-model.md](./examplecloud-infrastructure-threat-model.md) |

---

## Table of Contents

- [Attack Tree Analysis](#attack-tree-analysis)
- [Finding-to-Threat Traceability](#finding-to-threat-traceability)
- [Complete Threat Catalog](#complete-threat-catalog)
- [Residual Risk Analysis](#residual-risk-analysis)
- [Personnel Access Analysis](#personnel-access-analysis)
- [Responsibility Boundary Analysis](#responsibility-boundary-analysis)
- [Assumptions Register](#assumptions-register)
- [Findings Reference Catalog](#findings-reference-catalog)

---

## Attack Tree Analysis

### Primary Goal

**Goal:** Compromise organizational infrastructure through configuration or access control weaknesses

**Scoring methodology:** Qualitative Likelihood x Impact matrix (High/Medium/Low) per SOP Section 3.3.

### Attack Tree Structure

```
Goal: Compromise organizational infrastructure through configuration or access control weaknesses
├── Branch 1: Vendor Infrastructure Compromise
│   ├── 1.1 External Attack on Vendor Systems
│   │   └── T-002: Attacker compromises management endpoint via public internet
│   └── 1.2 Supply Chain Attacks Through Vendor
│       └── T-004: Brute force attack against exposed authentication
├── Branch 3: Integration Point Exploitation
│   └── 3.1 API Security Vulnerabilities
│       └── (no threats identified)
├── Branch 5: Infrastructure Component Compromise
│   ├── 5.1 DMZ and Perimeter Security Attacks
│   │   └── T-006: VPC peering allows lateral movement
│   └── 5.2 Critical Infrastructure Component Attacks
│       └── T-007: Overprivileged role enables privilege escalation
├── Branch 10: IAM Privilege Escalation
│   ├── 10.1 Role Assumption Chain Attacks
│   │   └── T-001: Attacker exploits overprivileged service role
│   └── 10.2 Policy Misconfiguration
│       └── T-005: Compromised access keys enable persistent access
├── Branch 11: Network Lateral Movement
│   ├── 11.1 Security Group Misconfiguration
│   │   └── (no threats identified)
│   └── 11.2 VPC and Network Exploitation
│       └── (no threats identified)
├── Branch 12: Public Exposure Exploitation
│   ├── 12.1 Storage Misconfiguration
│   │   └── T-008: Misconfigured storage bucket becomes publicly accessible
│   └── 12.2 Service Exposure
│       └── (no threats identified)
├── Branch 13: Credential and Secret Theft
│   ├── 13.1 Secrets Manager Exploitation
│   │   └── (no threats identified)
│   └── 13.2 Key Management Exploitation
│       └── (no threats identified)
└── Branch 14: Logging Evasion
    ├── 14.1 CloudTrail and Audit Log Bypass
    │   └── T-003: Unauthorized access undetected due to logging gaps
    └── 14.2 Detection Avoidance
        └── (no threats identified)
```

### Excluded Branches

| Branch | Reason for Exclusion |
|--------|----------------------|
| Branch 2: Vendor Personnel Threats | Infrastructure-only assessment |
| Branch 4: Vendor Business Disruption | Infrastructure-only assessment |
| Branch 6: Application Layer Exploitation | Infrastructure-only assessment |
| Branch 7: Authentication and Authorization Exploitation | Covered in Branch 10 |
| Branch 8: CI/CD Pipeline Compromise | CI/CD not in scope |
| Branch 9: Pipeline Integration Exploitation | No data pipeline in scope |
| Branches 15-21 | Not an AI-enabled system |

---

## Finding-to-Threat Traceability

| Finding ID | Vulnerability | Threat ID(s) | Threat Scenario | Framework Mapping |
|------------|---------------|--------------|-----------------|-------------------|
| TM-001 | Overprivileged IAM Roles | T-001 | Attacker exploits overprivileged service role to access production data | CIS 1.0 - IAM Policies |
| TM-002 | Public Endpoint Exposure | T-002 | Attacker compromises management endpoint via public internet | CIS 4.0 - Network Access |
| TM-003 | Logging Gaps | T-003 | Unauthorized access undetected due to logging gaps | CIS 3.0 - Logging |

---

## Complete Threat Catalog

### Branch 1: Vendor Infrastructure Compromise

**ASVS Chapters:** V11, V12, V13

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|--------------|-----------|
| **T-002** | **Attacker compromises management endpoint via public internet** | **Medium** | **High** | **High** | **T1190** | **Public exposure increases attack surface; management interfaces high value** |
| T-004 | Brute force against exposed authentication | Medium | Medium | **Medium** | T1110 | No account lockout observed; logging gaps delay detection |

### Branch 3: Integration Point Exploitation

**ASVS Chapters:** V4, V9, V12

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| (No threats identified in this branch) | | | | | | |

### Branch 5: Infrastructure Component Compromise

**ASVS Chapters:** V11, V13

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-006 | Lateral movement via VPC peering | Low | High | **Medium** | T1021 | Network connectivity between accounts enables movement |
| T-007 | Privilege escalation via role assumption | Low | High | **Medium** | T1078 | Trust relationships between accounts may be overpermissive |

### Branch 10: IAM Privilege Escalation

**ASVS Chapters:** V6, V8, V10

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| **T-001** | **Attacker exploits overprivileged service role** | **Medium** | **High** | **High** | **T1078** | **Overprivileged roles enable broad access; common cloud attack vector** |
| T-005 | Compromised long-lived access keys | Low | High | **Medium** | T1078 | Keys may be exposed in code/repos; enables persistent access |

### Branch 11: Network Lateral Movement

**ASVS Chapters:** V12, V13

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| (No threats identified in this branch) | | | | | | |

### Branch 12: Public Exposure Exploitation

**ASVS Chapters:** V3, V13

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-008 | Publicly exposed storage bucket | Low | High | **Medium** | T1530 | Common misconfiguration; high impact if sensitive data |

### Branch 13: Credential and Secret Theft

**ASVS Chapters:** V6, V9, V11

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| (No threats identified in this branch) | | | | | | |

### Branch 14: Logging Evasion

**ASVS Chapters:** V16

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-003 | Unauthorized access undetected | Medium | Medium | **Medium** | T1562 | Logging gaps delay detection; attacker dwell time increases |

### Threat Summary

| Risk Level | Count |
|------------|-------|
| High | 2 |
| Medium | 5 |
| Low | 0 |
| **Total** | **7** |

### High-Rated Threat Detail Cards

#### Threat T-001: Overprivileged Service Role Exploitation

**Risk Level:** High
**Scope:** Type 3 Infrastructure — ExampleCloud IAM configuration
**MITRE ATT&CK:** T1078.004 - Valid Accounts: Cloud Accounts

**Observation:**
IAM policy analysis revealed overprivileged service roles:
- `prod-service-role`: Has `*:*` permissions (full admin)
- Used by 12 different services across production and staging
- No conditions restricting access to specific resources
- Last policy review: 18 months ago

**Risk:**
Overprivileged roles create significant blast radius:
- Compromise of any service using this role grants full account access
- No resource-level restrictions limit scope
- Cross-service role sharing increases exposure
- Violates least privilege principle

**Evidence:**
- IAM Policy Analysis Report (automated scan)
- Cloud provider IAM policy JSON
- Assumption: A-01 (see Assumptions Register)

**Recommendation:**
Implement least-privilege IAM policies with:
- Resource-level permissions (ARNs specified)
- Action-level restrictions (no wildcard permissions)
- Condition keys for context-based access
- Separate roles per service/function

**Priority:** Immediate

#### Threat T-002: Public Management Endpoint Compromise

**Risk Level:** High
**Scope:** Type 3 Infrastructure — ExampleCloud network exposure
**MITRE ATT&CK:** T1190 - Exploit Public-Facing Application

**Observation:**
Network analysis identified publicly exposed management interfaces:
- Cloud console accessible from any IP (0.0.0.0/0)
- Management API endpoints on public subnets
- No IP allowlisting or VPN requirement
- Load balancers expose management paths

**Risk:**
Public exposure increases attack surface:
- Brute force attacks against admin credentials
- Exploitation of known vulnerabilities in management interfaces
- No network-level defense in depth
- Depends solely on authentication controls

**Evidence:**
- Network architecture diagram
- Security group rules (inbound allow 0.0.0.0/0)
- Automated public exposure scan

**Recommendation:**
Restrict management access:
- Implement IP allowlisting (corporate network ranges)
- Require VPN or bastion host for management access
- Move management endpoints to private subnets
- Implement additional MFA for management operations

**Priority:** Immediate

---

## Residual Risk Analysis

### High-Rated Threats — Residual Risk After Mitigations

| Threat ID | Threat | Pre-Mitigation Risk | Mitigating Requirements | Residual Risk | Notes |
|-----------|--------|---------------------|-------------------------|---------------|-------|
| T-001 | Overprivileged service role | **High** | Least-privilege policies, role separation | **Medium** | Operational overhead of managing granular policies |
| T-002 | Public management endpoint | **High** | IP restrictions, private subnets, VPN | **Low** | Well-understood control with proven effectiveness |

### Residual Risk Summary

| Residual Risk Level | Count |
|---------------------|-------|
| High | 0 |
| Medium | 2 |
| Low | 5 |

**Overall Residual Risk:** Medium — Mitigating requirements address immediate High risks; remaining Medium risks acceptable for mission-critical infrastructure.

---

## Personnel Access Analysis

### IAM Principals with Infrastructure Access

| Principal | Type | Permissions | MFA | Last Used | Risk |
|-----------|------|-------------|-----|-----------|------|
| admin-role | Role | Full administrator | No | Daily | **High** |
| developer-group | Group | Developer permissions | Yes | Daily | Medium |
| ci-cd-role | Role | Deployment permissions | N/A | Hourly | Medium |
| service-account-1 | Service | Overprivileged (*) | N/A | Hourly | **High** |
| audit-role | Role | Read-only | Yes | Weekly | Low |

*Service account uses `*:*` permissions (see T-001)

### Access Patterns

| Pattern | Observation | Risk |
|---------|-------------|------|
| Console access | 15 users with console access, 2 without MFA | Medium |
| CLI/Programmatic | 8 service accounts, 3 with unused access keys | Medium |
| Cross-account | 5 roles with cross-account trust | Medium |
| Privileged operations | Admin role used for routine operations | **High** |

---

## Responsibility Boundary Analysis

### Organization Responsibilities

| Area | Responsibility |
|------|----------------|
| IAM policy design | Implement least-privilege, resource-level policies |
| Network segmentation | Configure VPCs, subnets, security groups |
| Access logging | Enable and monitor cloud audit logs |
| Key rotation | Rotate access keys on defined schedule |
| Compliance monitoring | Verify against CIS benchmarks |

### Cloud Provider Responsibilities

| Area | Responsibility |
|------|----------------|
| Physical security | Data center security, hardware lifecycle |
| Hypervisor security | Virtualization layer protection |
| API availability | Service uptime and availability |
| Encryption at rest | Underlying storage encryption |
| Network backbone | Provider network infrastructure |

### Shared Responsibilities

| Area | Organization | Cloud Provider |
|------|--------------|----------------|
| Encryption in transit | Configure TLS, certificate management | Provide TLS termination endpoints |
| Patch management | Guest OS, applications | Host OS, hypervisor |
| Backup and recovery | Configure backup policies, test recovery | Provide backup infrastructure |
| Incident response | Customer data, access patterns | Infrastructure incidents |

---

## Assumptions Register

| ID | Assumption | Source | Impact if Invalid | Validation Method | Status |
|----|-----------|--------|-------------------|-------------------|--------|
| A-01 | Service roles reviewed within last year | IAM policy timestamp | Unknown privilege escalation if roles stale | Review IAM access analyzer findings | Unvalidated |
| A-02 | CloudTrail enabled in all accounts | Account baseline | No audit trail if logging not enabled | Verify CloudTrail configuration | Validated |
| A-03 | MFA enforced for console access | IAM policy condition | Account compromise if MFA not enforced | Check IAM policy conditions | Unvalidated |

### Assumption Summary

| Status | Count |
|--------|-------|
| Validated | 1 |
| Unvalidated | 2 |
| Invalidated | 0 |
| **Total** | **3** |

### Intake Assumptions

| ID | Assumption | Intake Source | Impact if Invalid | Closure Action |
|----|-----------|---------------|-------------------|----------------|
| IA-01 | IAM policies follow least privilege | Infrastructure inventory | High exposure if overprivileged | Run IAM Access Analyzer, generate findings |
| IA-02 | Network segmentation enforces environment isolation | Architecture diagram | Cross-environment access if shared | Verify VPC peering and routing rules |

### Assessment Discoveries

| ID | Discovery | Phase | Impact on Findings |
|----|-----------|-------|-------------------|
| D-01 | `*:*` permissions identified on prod-service-role | Phase 2 | Elevated to High risk (T-001) |
| D-02 | Management endpoints accessible from 0.0.0.0/0 | Phase 2 | Elevated to High risk (T-002) |

---

## Findings Reference Catalog

### ExampleCloud Infrastructure

| Finding | Source | Type |
|---------|--------|------|
| Overprivileged IAM role | IAM Access Analyzer | Automated scan |
| Public management exposure | Network configuration | Configuration review |
| Logging configuration | CloudTrail settings | Configuration review |

### Framework References

| Finding | Source | URL |
|---------|--------|-----|
| MITRE ATT&CK T1078 | MITRE ATT&CK | https://attack.mitre.org/techniques/T1078/ |
| MITRE ATT&CK T1190 | MITRE ATT&CK | https://attack.mitre.org/techniques/T1190/ |
| CIS Benchmark 1.0 | CIS | https://www.cisecurity.org/benchmarks |
| CIS Benchmark 3.0 | CIS | https://www.cisecurity.org/benchmarks |
| CIS Benchmark 4.0 | CIS | https://www.cisecurity.org/benchmarks |

---

*This is a fictional example supporting analysis for demonstration purposes only. All infrastructure details and scenarios are fictitious.*
