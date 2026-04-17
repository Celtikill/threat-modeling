# Supporting Analysis: ExampleAnalytics Pipeline — Data Warehouse Integration

<!-- This is a FICTIONAL example supporting analysis demonstrating the Type 2 (Internal Application) methodology. All system names, data, and scenarios are fictitious. -->

---

## Document Control

| Field | Value |
|-------|-------|
| **Version** | 1.0 |
| **Assessment Date** | 2026-02-01 |
| **Assessor** | Security Architecture Team |
| **Business Owner** | [Example Organization] Data Engineering |
| **Status** | Final |
| **Lean Report** | [analyticspipeline-threat-model.md](./analyticspipeline-threat-model.md) |

---

## Table of Contents

- [Attack Tree Analysis](#attack-tree-analysis)
- [Finding-to-Threat Traceability](#finding-to-threat-traceability)
- [Complete Threat Catalog](#complete-threat-catalog)
- [Residual Risk Analysis](#residual-risk-analysis)
- [Personnel Access Analysis](#personnel-access-analysis)
- [Responsibility Boundary Analysis](#responsibility-boundary-analysis)
- [Assumptions Register](#assumptions-register)
- [Engineering Discovery Questionnaire](#engineering-discovery-questionnaire)
- [Findings Reference Catalog](#findings-reference-catalog)

---

## Attack Tree Analysis

### Primary Goal

**Goal:** Compromise organizational data/functionality through application architectural weaknesses

**Scoring methodology:** Qualitative Likelihood x Impact matrix (High/Medium/Low) per SOP Section 3.3. See [reference.md](../../docs/reference.md#risk-assessment-matrix) for scoring details.

### Attack Tree Structure

```
Goal: Compromise organizational data/functionality through pipeline architectural weaknesses
├── Branch 1: Vendor Infrastructure Compromise
│   ├── 1.1 External Attack on Vendor Systems
│   │   └── T-008: Compromised ExampleSource vendor accesses downstream
│   └── 1.2 Supply Chain Attacks Through Vendor
│       └── T-009: ExampleBI exposes data through misconfiguration
├── Branch 2: Vendor Personnel Threats
│   ├── 2.1 Malicious Vendor Insider
│   │   └── (no threats identified)
│   └── 2.2 Compromised Vendor Personnel
│       └── (no threats identified)
├── Branch 3: Integration Point Exploitation
│   ├── 3.1 API Security Vulnerabilities
│   │   └── T-002: Unencrypted data interception between stages
│   └── 3.2 Data Transmission Compromise
│       └── T-005: Transform stage injection attack
├── Branch 5: Infrastructure Component Compromise
│   ├── 5.1 DMZ and Perimeter Security Attacks
│   │   └── T-001: Long-lived service credentials stolen
│   └── 5.2 Critical Infrastructure Component Attacks
│       └── T-004: API keys committed to source control
├── Branch 6: Application Layer Exploitation
│   ├── 6.1 Input Validation Failures
│   │   └── T-003: Developer accidentally accesses production
│   └── 6.2 Authentication and Session Weaknesses
│       └── (no threats identified)
├── Branch 7: Authentication and Authorization Exploitation
│   ├── 7.1 Credential Compromise
│   │   └── T-006: Compromised extract stage accesses warehouse
│   └── 7.2 Privilege Escalation
│       └── T-007: Service account reuse across stages
└── Branch 9: Pipeline Integration Exploitation
    ├── 9.1 Hop-to-Hop Credential Compromise
    │   └── (no threats identified)
    └── 9.2 Data Amplification and Sprawl
        └── (no threats identified)
```

### Excluded Branches

| Branch | Reason for Exclusion |
|--------|----------------------|
| Branch 4: Vendor Business Disruption | Pipeline availability managed by vendors; not in organizational control |
| Branch 8: CI/CD Pipeline Compromise | CI/CD infrastructure not in scope; assessed separately |
| Branches 10-14 | Infrastructure-only branches; application assessment |
| Branches 15-21 | Not an AI-enabled system |

---

## Finding-to-Threat Traceability

| Finding ID | Vulnerability | Threat ID(s) | Threat Scenario | ASVS Mapping |
|------------|---------------|--------------|-----------------|--------------|
| TM-001 | Weak service account management | T-001 | Attacker compromises service account credentials | V4.1 - Auth Architecture |
| TM-002 | Inconsistent encryption | T-002 | Man-in-the-middle intercepts unencrypted flow | V6.1 - Data Protection |
| TM-003 | Environment isolation gaps | T-003 | Developer accidentally accesses production | V4.3 - Access Control |

---

## Complete Threat Catalog

### Branch 1: Vendor Infrastructure Compromise

**ASVS Chapters:** V11, V12, V13

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-008 | Upstream vendor compromise cascades downstream | Low | High | **Medium** | T1199 - Trusted Relationship | Vendor chain creates trust boundaries; difficult to detect |
| T-009 | Downstream BI misconfiguration exposes data | Low | Medium | **Low** | T1083 - File and Directory Permissions | BI configuration errors may over-share; lower likelihood |

### Branch 2: Vendor Personnel Threats

**ASVS Chapters:** V6, V8

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| (No threats identified in this branch) | | | | | | |

### Branch 3: Integration Point Exploitation

**ASVS Chapters:** V4, V9, V12

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-002 | Man-in-the-middle intercepts data flow | Low | High | **Medium** | T1557 - Man-in-the-Middle | HTTPS assumed but not verified; certificate validation gaps possible |
| T-005 | Malicious transform injection | Low | Medium | **Low** | T1055 - Process Injection | Requires prior compromise; transform stage has input validation |

### Branch 5: Infrastructure Component Compromise

**ASVS Chapters:** V11, V13

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-001 | Service account credentials compromised | Medium | High | **High** | T1078 - Valid Accounts | Long-lived credentials without rotation; high value pipeline access |
| T-004 | Hardcoded API keys in repositories | Low | High | **Medium** | T1552 - Unsecured Credentials | Source scanning may miss keys; credential reuse amplifies impact |

### Branch 6: Application Layer Exploitation

**ASVS Chapters:** V1, V2, V3

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-003 | Developer accidentally accesses production data | Medium | Medium | **Medium** | T1078 - Valid Accounts | Shared infrastructure enables human error; insider threat scenario |

### Branch 7: Authentication and Authorization Exploitation

**ASVS Chapters:** V6, V7, V8

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-006 | Lateral movement between pipeline stages | Low | High | **Medium** | T1078 - Valid Accounts | Shared service accounts enable stage-to-stage movement |
| T-007 | Privilege escalation via account reuse | Medium | Medium | **Medium** | T1078 - Valid Accounts | Same credentials across environments increase blast radius |

### Branch 9: Pipeline Integration Exploitation

**ASVS Chapters:** V4, V5

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| (No threats identified in this branch) | | | | | | |

### Threat Summary

| Risk Level | Count |
|------------|-------|
| High | 1 |
| Medium | 5 |
| Low | 2 |
| **Total** | **8** |

### High-Rated Threat Detail Card

#### Threat T-001: Service Account Credential Compromise

**Risk Level:** High
**Scope:** Type 2: Internal Application — ExampleAnalytics Pipeline service account architecture
**MITRE ATT&CK:** T1078.004 - Valid Accounts: Cloud Accounts

**Observation:**
The ExampleAnalytics pipeline uses service account credentials for inter-service authentication. During architecture review, we identified that:
- Service account credentials are manually rotated (no automation)
- No documented rotation schedule or SLA
- Credentials shared across development and production environments
- No centralized secrets management (credentials in environment variables)

**Risk:**
Long-lived, shared credentials create significant attack surface:
- Credential theft via log analysis, environment inspection, or repository scanning
- Indefinite persistence if credentials not rotated post-incident
- Cross-environment access if one environment compromised
- Privilege escalation within pipeline stages

**Evidence:**
- Intake: A5 Integration — service account authentication described as "shared credentials"
- Documentation: Architecture diagram shows credential flow between stages
- Assumption: A-01 (see Assumptions Register)

**Recommendation:**
Implement automated credential rotation with 90-day maximum lifetime. Deploy centralized secrets manager (e.g., ExampleSecrets Manager, ExampleVault). Separate credentials per environment with no cross-environment sharing.

**Priority:** Immediate

---

## Residual Risk Analysis

### High-Rated Threats — Residual Risk After Mitigations

| Threat ID | Threat | Pre-Mitigation Risk | Mitigating Requirements | Residual Risk | Notes |
|-----------|--------|---------------------|-------------------------|---------------|-------|
| T-001 | Service account credential compromise | **High** | Automated rotation, secrets manager, environment separation | **Low** | 90-day rotation + centralized vault reduces exposure window significantly |

### Residual Risk Summary

| Residual Risk Level | Count |
|---------------------|-------|
| High | 0 |
| Medium | 5 |
| Low | 3 |

**Overall Residual Risk:** Medium — After implementing High-rated threat mitigation, remaining risks are acceptable for business-critical data pipeline.

---

## Personnel Access Analysis

### Personnel with Data Access

| Role | Access Level | Systems | Provisioning Method | MFA |
|------|-------------|---------|---------------------|-----|
| Data Engineer | Admin | All pipeline stages | LDAP group membership | Yes |
| Analytics Developer | Read-Write | ExampleBI, ExampleWarehouse | LDAP group membership | Yes |
| Pipeline Operator | Admin | ExampleTransform orchestration | Service account | N/A |
| Support Engineer | Read-Only | Logs, monitoring | Break-glass procedure | Yes |
| Service Accounts | Varies | Inter-service authentication | Manual credential distribution | N/A |

### Access Provisioning and Deprovisioning

| Process | Description | SLA | Gap |
|---------|-------------|-----|-----|
| New employee access | Manager approval + LDAP group | 24 hours | None |
| Role change | HR ticket triggers group update | 48 hours | None |
| Termination | HR ticket triggers immediate revocation | 4 hours | None |
| Service account provisioning | Manual creation + credential distribution | Unspecified | **No documented process** |
| Access review | Quarterly access certification | 90 days | None |

---

## Responsibility Boundary Analysis

### Organization Responsibilities

| Area | Responsibility |
|------|----------------|
| Data classification | Define sensitivity levels, retention requirements |
| Service account governance | Establish rotation policy, monitor compliance |
| Encryption requirements | Mandate TLS 1.3 minimum for all connections |
| Environment isolation | Separate production from non-production |
| Access logging | Require comprehensive audit trails |
| Incident response | Define escalation procedures for pipeline compromises |

### External Party Responsibilities

| Vendor | Area | Responsibility |
|--------|------|----------------|
| ExampleSource | Data extraction | Provide secure API, access logging |
| ExampleTransform | Data transformation | Secure processing environment, input validation |
| ExampleWarehouse | Data storage | Encryption at rest, access controls |
| ExampleBI | Visualization | Row-level security, secure embedding |

---

## Assumptions Register

| ID | Assumption | Source | Impact if Invalid | Validation Method | Status |
|----|-----------|--------|-------------------|-------------------|--------|
| A-01 | Service account credentials are manually rotated annually | Architecture review interview | High exposure if credentials never rotated | Review credential rotation logs | Unvalidated |
| A-02 | HTTPS is used for all inter-service communication | Architecture diagram | Data exposure if HTTP used anywhere | Scan API endpoints, review configurations | Validated |
| A-03 | Production and development environments share underlying VPC | Architecture interview | Environment isolation impossible if shared network | Review network topology | Validated |

### Assumption Summary

| Status | Count |
|--------|-------|
| Validated | 2 |
| Unvalidated | 1 |
| Invalidated | 0 |
| **Total** | **3** |

### Intake Assumptions

| ID | Assumption | Intake Source | Impact if Invalid | Closure Action |
|----|-----------|---------------|-------------------|----------------|
| IA-01 | Credential rotation frequency is annual (not documented) | A5 Integration — rotation not specified | Extended credential exposure if rotation less frequent | Request formal credential lifecycle documentation |

### Assessment Discoveries

| ID | Discovery | Phase | Impact on Findings |
|----|-----------|-------|-------------------|
| D-01 | Service accounts share credentials across environments | Phase 2 | Elevated risk rating for T-001 from Medium to High |
| D-02 | No centralized secrets management identified | Phase 2 | Added T-004 to threat catalog |

---

## Engineering Discovery Questionnaire

### Pipeline Architecture

**1. How are service account credentials distributed to pipeline stages?**
- Current: Environment variables during deployment
- Ideal: Centralized secrets manager with dynamic credential injection

**2. What is the current credential rotation frequency?**
- Current: Unknown (assumed annual based on interview)
- Target: 90 days maximum, ideally 30 days

**3. Are inter-service communications verified to use TLS 1.3?**
- Status: Assumed yes; configuration review recommended
- Risk: Downgrade attacks possible if not enforced

### Environment Separation

**4. What network controls enforce environment isolation?**
- Current: Logical separation via naming conventions
- Gap: No network segmentation identified

**5. Can developers access production data for debugging?**
- Current: Unknown (assumption: yes, based on shared infrastructure)
- Risk: Insider threat, accidental data modification

### Monitoring and Response

**6. Is data access logged across all pipeline stages?**
- Current: Partial (ExampleWarehouse logs confirmed; others unknown)
- Gap: Centralized logging not implemented

**7. What is the incident response SLA for pipeline compromises?**
- Current: Uses standard organizational IR process
- Gap: No pipeline-specific playbooks identified

---

## Findings Reference Catalog

### ExampleAnalytics Pipeline

| Finding | Source | Type |
|---------|--------|------|
| Service account credential sharing | Architecture interview | Intake |
| Environment co-location | Architecture diagram | Intake |
| HTTPS requirement (assumed) | A5 Integration documentation | Intake |

### Framework References

| Finding | Source | URL |
|---------|--------|-----|
| MITRE ATT&CK T1078 | MITRE ATT&CK | https://attack.mitre.org/techniques/T1078/ |
| MITRE ATT&CK T1557 | MITRE ATT&CK | https://attack.mitre.org/techniques/T1557/ |
| ASVS V4.1 | OWASP ASVS 5.0 | https://owasp.org/www-project-application-security-verification-standard/ |
| ASVS V6.1 | OWASP ASVS 5.0 | https://owasp.org/www-project-application-security-verification-standard/ |

---

## Glossary

| Term | Definition |
|------|------------|
| ASVS | OWASP Application Security Verification Standard (v5.0) |
| ETL | Extract, Transform, Load — data pipeline pattern |
| IAM | Identity and Access Management |
| MITRE ATT&CK | Framework of cyber threat tactics and techniques |
| RBAC | Role-Based Access Control |

---

*This is a fictional example supporting analysis for demonstration purposes only. All systems, data types, and scenarios are fictitious.*
