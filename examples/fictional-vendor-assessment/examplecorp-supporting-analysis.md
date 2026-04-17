# Supporting Analysis: ExampleCorp — SaaS Analytics Platform

<!-- This is a FICTIONAL example supporting analysis demonstrating the Type 1 (Third-Party Vendor) methodology. All company names, data, and scenarios are fictitious. -->

---

## Document Control

| Field | Value |
|-------|-------|
| **Version** | 1.0 |
| **Assessment Date** | 2026-01-15 |
| **Assessor** | Security Architecture Team |
| **Business Owner** | [Example Organization] |
| **Status** | Final |
| **Lean Report** | [examplecorp-threat-model.md](./examplecorp-threat-model.md) |

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

**Goal:** Compromise organizational data/systems through ExampleCorp relationship

**Scoring methodology:** Qualitative Likelihood x Impact matrix (High/Medium/Low) per SOP Section 3.3. See [reference.md](../../docs/reference.md#risk-assessment-matrix) for scoring details.

### Attack Tree Structure

```
Goal: Compromise organizational data/systems through ExampleCorp relationship
├── Branch 1: Vendor Infrastructure Compromise
│   ├── 1.1 External Attack on Vendor Systems
│   │   ├── T-001: Phishing attack against admin credentials
│   │   └── T-004: Credential stuffing using leaked passwords
│   └── 1.2 Supply Chain Attacks Through Vendor
│       └── T-005: Weak SSO configuration exploitation
├── Branch 2: Vendor Personnel Threats
│   ├── 2.1 Malicious Vendor Insider
│   │   └── T-002: Insider with excessive privileges
│   └── 2.2 Compromised Vendor Personnel
│       └── T-006: Multi-tenant isolation failure
├── Branch 3: Integration Point Exploitation
│   ├── 3.1 API Security Vulnerabilities
│   │   └── T-008: Data replication to non-approved regions
│   └── 3.2 Data Transmission Compromise
│       └── (no threats identified)
├── Branch 4: Vendor Business Disruption
│   ├── 4.1 Service Availability Attacks
│   │   └── T-003: Rate limit bypass causing DoS
│   └── 4.2 Data Integrity Attacks
│       └── T-007: Supply chain attack via compromised dependency
└── Branch 5: Infrastructure Component Compromise
    └── 5.1 DMZ and Perimeter Security Attacks
        └── (no threats identified)
```

### Excluded Branches

| Branch | Reason for Exclusion |
|--------|----------------------|
| Branches 6-14 | Type 1 (Vendor) assessment; application and infrastructure branches not applicable |
| Branches 15-21 | Not an AI-enabled system |

---

## Finding-to-Threat Traceability

| Finding ID | Vulnerability | Threat ID(s) | Threat Scenario | Regulatory Intent |
|------------|---------------|--------------|-----------------|-------------------|
| TM-001 | Single-factor authentication for administrative access | T-001 | Attacker compromises admin credentials via phishing | Administrative safeguards require unique user identification (HIPAA 164.312(a)(2)(i)) |
| TM-002 | Data residency controls not explicitly defined | T-008 | Regulatory compliance gap for multi-national data storage | Data sovereignty requirements in GDPR Article 44 and equivalent regulations |
| TM-003 | API rate limiting insufficient for production workloads | T-003 | Denial of service via API abuse | Availability controls to ensure system resilience |

---

## Complete Threat Catalog

### Branch 1: Vendor Infrastructure Compromise

**ASVS Chapters:** V11, V12, V13

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-001 | External attacker compromises admin credentials via phishing | Medium | High | **High** | T1078 - Valid Accounts | Admin credentials provide broad access; phishing is common attack vector |
| T-004 | Attacker uses credential stuffing with leaked passwords | Low | High | **Medium** | T1110 - Brute Force | Depends on password reuse; monitored but possible |
| T-005 | Weak SSO configuration allows account takeover | Low | Medium | **Low** | T1556 - Modify Authentication Process | SAML configuration complexity creates opportunity |

### Branch 2: Vendor Personnel Threats

**ASVS Chapters:** V6, V8

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-002 | Insider with excessive privileges accesses customer data | Medium | Medium | **Medium** | T1078.004 - Cloud Accounts | Vendor insider threat with elevated permissions |
| T-006 | Multi-tenant isolation failure exposes customer data | Low | High | **Medium** | T1499 - Endpoint Denial of Service | Shared infrastructure risk; low likelihood but high impact |

### Branch 3: Integration Point Exploitation

**ASVS Chapters:** V4, V9, V12

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-008 | Data replication to non-approved regions via API | Medium | Medium | **Medium** | N/A - Compliance | API allows data transfer to unapproved jurisdictions; regulatory risk |

### Branch 4: Vendor Business Disruption

**ASVS Chapters:** V2, V14

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| T-003 | API abuse causes service degradation | Medium | Medium | **Medium** | T1498 - Direct Network Flood | Insufficient rate limiting enables abuse |
| T-007 | Supply chain attack via compromised dependency | Low | Medium | **Low** | T1195 - Supply Chain Compromise | Vendor manages dependencies; limited visibility |

### Branch 5: Infrastructure Component Compromise

**ASVS Chapters:** V11, V13

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| (No threats identified in this branch) | | | | | | |

### Threat Summary

| Risk Level | Count |
|------------|-------|
| High | 1 |
| Medium | 4 |
| Low | 2 |
| **Total** | **7** |

### High-Rated Threat Detail Cards

#### Threat T-001: Administrative Credential Compromise

**Risk Level:** High
**Scope:** Type 1: Third-Party Vendor Assessment — ExampleCorp administrative access
**MITRE ATT&CK:** T1078 - Valid Accounts

**Observation:**
ExampleCorp's administrative access relies on single-factor authentication. Documentation review revealed no explicit MFA requirement for admin accounts. Vendor security whitepaper states "password-based authentication" without mentioning additional factors.

**Risk:**
Administrative access to ExampleAnalytics platform would enable:
- Access to all customer data across multi-tenant infrastructure
- Ability to modify authentication settings and access controls
- Potential for data exfiltration or service disruption
- Lateral movement to connected storage systems

The threat is scored High due to the combination of:
- Medium Likelihood: Phishing campaigns targeting SaaS administrators are common
- High Impact: Administrative compromise affects all organizational data in the platform

**Evidence:**
- Documentation: ExampleCorp Security Whitepaper (Section 4.2) — Accessed 2026-01-10
- Vendor attestation: SOC 2 Type II report does not explicitly verify MFA enforcement
- Assumption: A-01 (see Assumptions Register)

**Recommendation:**
Implement multi-factor authentication for all administrative accounts. Require phishing-resistant MFA methods (FIDO2/WebAuthn or TOTP) rather than SMS-based authentication.

**Priority:** Immediate

---

## Residual Risk Analysis

### High-Rated Threats — Residual Risk After Mitigations

| Threat ID | Threat | Pre-Mitigation Risk | Mitigating Requirements | Residual Risk | Notes |
|-----------|--------|---------------------|-------------------------|---------------|-------|
| T-001 | Admin credential compromise | **High** | MFA implementation, access logging, session management | **Medium** | Residual risk from phishing-resistant MFA bypass techniques (MFA fatigue, Adversary-in-the-Middle) |

### Residual Risk Summary

| Residual Risk Level | Count |
|---------------------|-------|
| High | 0 |
| Medium | 1 |
| Low | 6 |

**Overall Residual Risk:** Medium — Mitigating requirements reduce risk to acceptable levels for business-critical vendor relationship.

---

## Personnel Access Analysis

### Personnel with Data Access

| Role | Access Level | Data Types Accessible | Background Check | MFA Enforced |
|------|-------------|----------------------|------------------|--------------|
| Platform Administrator | Admin | All customer data | Yes | **No** |
| Customer Success | Read-Write | Customer metadata | Yes | Yes |
| Support Engineer | Read-Only | Support tickets | Yes | Yes |
| Database Administrator | Admin | All data (infrastructure) | Yes | Unknown |

### Access Provisioning and Deprovisioning

| Process | Description | SLA |
|---------|-------------|-----|
| New access request | Manager approval + HR verification | 48 hours |
| Access modification | Same as new request | 48 hours |
| Access revocation (planned) | HR notification triggers deprovisioning | 24 hours |
| Access revocation (emergency) | Immediate via admin console | 1 hour |
| Access review cadence | Quarterly access certification | 90 days |

---

## Responsibility Boundary Analysis

### Organization Responsibilities

| Area | Responsibility |
|------|----------------|
| Data classification | Define data sensitivity levels and handling requirements |
| User access management | Provision/deprovision user accounts, manage entitlements |
| Data residency compliance | Define approved geographic regions for data storage |
| Incident escalation | Report security incidents to ExampleCorp within 24 hours |

### Vendor Responsibilities

| Area | Responsibility |
|------|----------------|
| Infrastructure security | Patch management, vulnerability scanning, network security |
| Encryption at rest | AES-256 encryption for all stored data |
| Encryption in transit | TLS 1.3 for all data transmission |
| Physical security | Data center security, environmental controls |
| Backup and recovery | Daily backups, 30-day retention, tested quarterly |

### Shared Responsibilities

| Area | Organization | Vendor |
|------|--------------|--------|
| Authentication | Define MFA policy | Implement and enforce MFA |
| Access logging | Review logs monthly | Provide log access, retain 90 days |
| Incident response | Coordinate communication | Technical investigation |

---

## Assumptions Register

| ID | Assumption | Source | Impact if Invalid | Validation Method | Status |
|----|-----------|--------|-------------------|-------------------|--------|
| A-01 | ExampleCorp encrypts data at rest using AES-256 | Vendor security whitepaper | Data exposure if unencrypted or weaker cipher used | Request encryption configuration details | Validated |
| A-02 | SOC 2 Type II report covers all relevant controls | Vendor attestation | Compliance gap if scope is limited | Review full SOC 2 report | Unvalidated |
| A-03 | Data residency controls exist but are not documented | Intake gap (A6 Trust Boundaries) | Regulatory violation if data stored in unapproved regions | Request data residency documentation | Unvalidated |

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
| IA-01 | API rate limiting exists but thresholds unknown | A5 Integration — rate limiting not specified | Service degradation if limits too low; availability issues | Request rate limit documentation and test results |
| IA-02 | Data residency controls assumed based on enterprise vendor profile | A4 Data Inventory — residency controls not specified | Regulatory compliance gap if data stored outside approved regions | Request data residency configuration and verification |

### Assessment Discoveries

| ID | Discovery | Phase | Impact on Findings |
|----|-----------|-------|-------------------|
| D-01 | Vendor MFA implementation gap discovered during documentation review | Phase 2 | Elevated T-001 from Medium to High risk |

---

## Findings Reference Catalog

### ExampleCorp

| Finding | Source | URL |
|---------|--------|-----|
| AES-256 encryption at rest | Security Whitepaper v2.1 | (internal documentation) |
| TLS 1.3 in transit | Security Whitepaper v2.1 | (internal documentation) |
| 99.9% SLA commitment | Service Level Agreement | (internal documentation) |
| SOC 2 Type II certification | Trust Center | (internal documentation) |

### Regulatory and Framework References

| Finding | Source | URL |
|---------|--------|-----|
| MITRE ATT&CK T1078 | MITRE ATT&CK | https://attack.mitre.org/techniques/T1078/ |
| MITRE ATT&CK T1498 | MITRE ATT&CK | https://attack.mitre.org/techniques/T1498/ |
| NIST Risk Assessment Guidance | NIST SP 800-30 | https://csrc.nist.gov/publications/detail/sp/800-30/final |

---

## Glossary

| Term | Definition |
|------|------------|
| ASVS | OWASP Application Security Verification Standard (v5.0) |
| BYOT | Bring Your Own Telecom — client owns carrier relationships |
| CIA | Confidentiality, Integrity, Availability |
| MITRE ATT&CK | Framework of cyber threat tactics and techniques |
| SaaS | Software as a Service |

---

*This is a fictional example supporting analysis for demonstration purposes only. All organizations, scenarios, and data are fictitious.*
