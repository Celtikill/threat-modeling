# Security Requirements: [System/Vendor] — [Context]

<!-- Replace [System/Vendor] with the system or application name and [Context] with the use case description -->
<!-- This document is produced for Type 2 (Internal Application) and Type 3 (Infrastructure-Only) assessments -->
<!-- Required for Type 2 (Internal Application) and Type 3 (Infrastructure-Only) assessments -->

---

## Document Control

| Field | Value |
|-------|-------|
| **Version** | [1.0] |
| **Assessment Date** | [YYYY-MM-DD] |
| **Author** | [Name / Role] |
| **Status** | [Draft / Draft-Reviewed / Final] |
| **Threat Model Reference** | [Link to corresponding lean report] |
| **Supporting Analysis** | [Link to corresponding supporting analysis] |

---

## Introduction

### Purpose

This document defines security requirements that **shall** be implemented to address threats identified in the corresponding threat model for [System/Vendor]. Requirements are based on:

- **[OWASP ASVS v5.0](https://owasp.org/www-project-application-security-verification-standard/)** (Application Security Verification Standard, May 2025)
- **Threat model findings** from the corresponding threat assessment
- **Internal security policies** for [data types: e.g., employee PII, financial records, PHI]

### Scope

| In Scope | Out of Scope |
|----------|--------------|
| [e.g., Authentication and access controls] | [e.g., Vendor company risk (financial health)] |
| [e.g., Data encryption at rest and in transit] | [e.g., Personnel background checks] |
| [e.g., Audit logging and monitoring] | [e.g., Physical security] |
| [e.g., Configuration security] | |
| [e.g., API security] | |

### Requirement Language

This document uses [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119) keywords:

| Keyword | Meaning |
|---------|---------|
| **MUST** | Mandatory requirement. Non-compliance represents an accepted risk that should be documented. |
| **SHOULD** | Recommended requirement. Deviation is acceptable with documented justification. |
| **MAY** | Optional requirement. Included for defense-in-depth or future consideration. |

Requirements are classified as:

| Classification | Description | Examples |
|---------------|-------------|----------|
| **FR** (Functional) | What the system must *do* | Authentication, authorization, encryption, logging, input validation |
| **NFR** (Non-Functional) | How the system must *perform* | Availability, latency, compliance posture, key rotation frequency, retention periods |

### Compliance Mapping

| Requirement Source | ASVS Level | Requirement Level |
|-------------------|------------|-------------------|
| Internal Policy (Critical/High Data) | L2 | MUST |
| Threat Model High-Risk Findings | L2 | MUST |
| Threat Model Medium-Risk Findings | L1 | SHOULD |
| ASVS L3 (Defense in Depth) | L3 | SHOULD |

<!-- ASVS level guidance:
     - L1 → SHOULD (baseline for all assessments)
     - L2 → MUST (standard for assessments with High or Critical data sensitivity)
     - L3 → SHOULD (defense in depth for life-safety or mission-critical systems) -->

### ASVS Version Note

This template references **OWASP ASVS 5.0** (released May 2025). Key changes from ASVS 4.0:

- V1 Architecture has been replaced with V1 Encoding and Sanitization; architecture considerations redistributed across V2, V6, V8, V15
- New chapters added: V3 Web Frontend Security, V9 Self-contained Tokens, V10 OAuth and OIDC, V17 WebRTC
- Verification levels clarified — black-box testing alone is insufficient at all levels
- Requirement IDs use the `v5.0.0-X.Y.Z` format for traceability
- CWE mappings are being transitioned to [OWASP Common Requirement Enumeration (CRE)](https://www.opencre.org/) for more flexible cross-references

---

## Requirements by ASVS 5.0 Category

<!-- Instructions:
     - Populate requirements relevant to the system under assessment
     - Not every chapter applies to every assessment:
       * V3 (Web Frontend) — skip for non-web systems or infrastructure-only
       * V9 (Self-contained Tokens) — include only if JWTs, PASETOs, or similar are used
       * V10 (OAuth and OIDC) — include only if OAuth/OIDC flows are present
       * V17 (WebRTC) — include only if real-time communication is in scope
     - For Infrastructure-Only (Type 3): focus on V6, V8, V11-V14, V16; most application-layer chapters can be marked N/A
     - Each requirement should trace back to a threat from the threat model (Threat Ref column)
     - Class: FR (Functional) or NFR (Non-Functional)
     - Level: MUST (L2, threat-driven), SHOULD (L1/L3), or MAY (optional defense-in-depth) -->

### V1: Encoding and Sanitization

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V1.1 | [FR/NFR] | [Requirement description] | [v5.0.0-1.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

<!-- Skip this section if not applicable to the system -->

---

### V2: Validation and Business Logic

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V2.1 | [FR/NFR] | [Requirement description] | [v5.0.0-2.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V3: Web Frontend Security

<!-- Include only for web-facing applications. Mark N/A for APIs, pipelines, and infrastructure-only. -->

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V3.1 | [FR/NFR] | [Requirement description] | [v5.0.0-3.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V4: API and Web Service

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V4.1 | [FR/NFR] | [Requirement description] | [v5.0.0-4.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V5: File Handling

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V5.1 | [FR/NFR] | [Requirement description] | [v5.0.0-5.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V6: Authentication

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V6.1 | [FR/NFR] | [Requirement description] | [v5.0.0-6.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V7: Session Management

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V7.1 | [FR/NFR] | [Requirement description] | [v5.0.0-7.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V8: Authorization

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V8.1 | [FR/NFR] | [Requirement description] | [v5.0.0-8.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V9: Self-contained Tokens

<!-- Include only if JWTs, PASETOs, or similar self-contained tokens are used in the system -->

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V9.1 | [FR/NFR] | [Requirement description] | [v5.0.0-9.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V10: OAuth and OIDC

<!-- Include only if OAuth 2.0 or OpenID Connect flows are present -->

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V10.1 | [FR/NFR] | [Requirement description] | [v5.0.0-10.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V11: Cryptography

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V11.1 | [FR/NFR] | [Requirement description] | [v5.0.0-11.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V12: Secure Communication

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V12.1 | [FR/NFR] | [Requirement description] | [v5.0.0-12.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V13: Configuration

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V13.1 | [FR/NFR] | [Requirement description] | [v5.0.0-13.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V14: Data Protection

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V14.1 | [FR/NFR] | [Requirement description] | [v5.0.0-14.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V15: Secure Coding and Architecture

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V15.1 | [FR/NFR] | [Requirement description] | [v5.0.0-15.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V16: Security Logging and Error Handling

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V16.1 | [FR/NFR] | [Requirement description] | [v5.0.0-16.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

### V17: WebRTC

<!-- Include only if real-time communication (WebRTC) is in scope. This is rarely applicable. -->

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V17.1 | [FR/NFR] | [Requirement description] | [v5.0.0-17.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

---

## AISVS Requirements (AI-Enabled Systems Only)

<!-- Include this section when the system under assessment includes AI/ML components (LLMs, models, agents, vector databases, RAG pipelines).
     Map AI-specific threats (branches 15-21) to AISVS chapter requirements.
     Reference the OWASP AISVS (https://github.com/OWASP/AISVS/) for detailed requirement specifications.
     Omit this section for systems without AI features. -->

### C1: Training Data Integrity

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C1.1 | [FR/NFR] | [Requirement for training data provenance and integrity] | [C1.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C2: User Input Validation

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C2.1 | [FR/NFR] | [Requirement for input validation and prompt injection prevention] | [C2.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |
| C2.2 | [FR/NFR] | [Requirement for prompt boundary protection] | [C2.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C3: Model Lifecycle Management and Change Control

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C3.1 | [FR/NFR] | [Requirement for model versioning and change control] | [C3.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C4: Infrastructure, Configuration and Deployment Security

<!-- Include when AI workloads have specific infrastructure requirements -->

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C4.1 | [FR/NFR] | [Requirement for AI infrastructure security] | [C4.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C5: Access Control and Identity

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C5.1 | [FR/NFR] | [Requirement for AI system access control] | [C5.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C6: Supply Chain Security for Models, Frameworks and Data

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C6.1 | [FR/NFR] | [Requirement for model supply chain verification] | [C6.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C7: Model Behavior, Output Control and Safety Assurance

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C7.1 | [FR/NFR] | [Requirement for model output filtering and safety] | [C7.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |
| C7.2 | [FR/NFR] | [Requirement for output quality monitoring] | [C7.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C8: Memory, Embeddings and Vector Database Security

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C8.1 | [FR/NFR] | [Requirement for vector database access controls] | [C8.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C9: Autonomous Orchestration and Agentic Action Security

<!-- Include when the system includes AI agents with tool access -->

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C9.1 | [FR/NFR] | [Requirement for agent permission scoping] | [C9.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C10: Model Context Protocol (MCP) Security

<!-- Include when the system uses Model Context Protocol -->

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C10.1 | [FR/NFR] | [Requirement for MCP tool validation] | [C10.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### C11: Adversarial Robustness and Attack Resistance

| ID | Class | Requirement | AISVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|-----------|------------|-------|--------------|
| C11.1 | [FR/NFR] | [Requirement for adversarial robustness testing] | [C11.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

<!-- C12 (Privacy), C13 (Monitoring), C14 (Human Oversight) — include if applicable based on assessment scope -->

---

## System-Specific Requirements

<!-- For Type 2 data pipelines: create a subsection per pipeline stage (e.g., Source, Extract/Load, Warehouse, Transform, Egress)
     For Type 2 applications: create a subsection per major component or service
     For Type 3 infrastructure: create a subsection per cloud account or service layer -->

### Pipeline Stage Pattern (Data Pipelines)

<!-- For data pipelines, use stage-specific prefixes and tables -->

#### Stage 1: Ingestion

| ID | Requirement | Verification Method | Threat Ref |
|----|-------------|---------------------|------------|
| IN-1 | [Requirement specific to ingestion] | [Verification] | [T-NNN] |
| IN-2 | [Requirement specific to ingestion] | [Verification] | [T-NNN] |

#### Stage 2: Warehouse

| ID | Requirement | Verification Method | Threat Ref |
|----|-------------|---------------------|------------|
| WH-1 | [Requirement specific to warehouse] | [Verification] | [T-NNN] |

#### Stage 3: Transform

| ID | Requirement | Verification Method | Threat Ref |
|----|-------------|---------------------|------------|
| TR-1 | [Requirement specific to transformation] | [Verification] | [T-NNN] |

#### Stage 4: Egress

| ID | Requirement | Verification Method | Threat Ref |
|----|-------------|---------------------|------------|
| EG-1 | [Requirement specific to egress] | [Verification] | [T-NNN] |

<!-- ID prefix convention:
     IN- = Ingestion, WH- = Warehouse, TR- = Transform, EG- = Egress
     DB- = DBT, SF- = Snowflake, MA- = Medallion Architecture, AI- = AI/ML Pipeline -->

### Component Pattern (Applications)

#### [Component Name]

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| [CMP-1] | [FR/NFR] | [Requirement specific to this component] | [v5.0.0-x.x.x] | [T-NNN] | [MUST/SHOULD/MAY] | [Verification method] |

### High-Risk Data Type Requirements

<!-- Include when system handles data types with:
     - Regulatory exemptions from standard protections
     - Time-based risk accumulation
     - Cross-layer re-identification risks
     - Sector-specific sensitivity (life-safety, criminal justice, etc.) -->

#### [Data Type] Specific Controls

| ID | Requirement | ASVS Ref | Threat Ref | Priority | Verification |
|----|-------------|----------|------------|----------|--------------|
| [VXX.X-DATA] | [Data-type-specific requirement] | [v5.0.0-x.x.x] | [T-XXX] | [Required] | [Verification] |

> **Implementation Guidance:**
> - [Specific implementation notes for this data type]
> - [Technical configuration details]
> - [Monitoring/alerting requirements]

---

## Verification Criteria

### Automated Verification

| Control | Verification Method | Frequency | Implementation Status |
|---------|---------------------|-----------|----------------------|
| [e.g., TLS Configuration] | [SSL Labs scan, OpenSSL validation] | [Monthly] | [Pending/Implemented] |
| [e.g., Encryption at Rest] | [Vendor configuration API audit] | [Monthly] | [Pending/Implemented] |
| [e.g., Access Control Lists] | [Automated permission scanning] | [Weekly] | [Pending/Implemented] |
| [e.g., Vulnerability Scanning] | [SAST/DAST/Dependency scanning] | [Continuous] | [Pending/Implemented] |

### Manual Verification

| Control | Verification Method | Frequency | Implementation Status |
|---------|---------------------|-----------|----------------------|
| [e.g., Architecture Review] | [Design document review] | [Per change] | [Implemented] |
| [e.g., Code Review] | [Peer review] | [Per deployment] | [Implemented] |
| [e.g., Penetration Testing] | [Third-party security assessment] | [Annual] | [Pending] |
| [e.g., Access Review] | [Quarterly certification] | [Quarterly] | [Pending] |

### Compliance Verification

| Requirement | Evidence Required | Review Frequency |
|-------------|-------------------|------------------|
| [Framework 1] | [Evidence type] | [Frequency] |
| [Framework 2] | [Evidence type] | [Frequency] |

---

## Traceability Matrix

*Maps every High-rated threat from the threat model to specific mitigating requirements in this document.*

| Threat ID | Threat Description | Risk Level | Mitigating Requirements | Residual Risk |
|-----------|-------------------|------------|------------------------|---------------|
| [T-001] | [Threat description] | **High** | [V6.1, V6.2, Prefix-1] | [Medium/Low] |
| [T-002] | [Threat description] | **High** | [V8.1, V11.1, Prefix-2] | [Medium/Low] |
| [T-003] | [Threat description] | **High** | [V12.1, V14.1] | [Medium/Low] |

<!-- Include all High-rated threats. Medium threats may be included for completeness. -->
<!-- Residual Risk: Risk remaining after requirement implementation -->

### Coverage Summary

| Risk Level | Threats | Fully Mitigated | Partially Mitigated | Unmitigated |
|------------|---------|-----------------|---------------------|-------------|
| High | [N] | [N] | [N] | [N] |
| Medium | [N] | [N] | [N] | [N] |

<!-- If any High threats are unmitigated by requirements, flag them with commentary explaining why -->

### ASVS/SSR Category Coverage

| SSR Category | Requirement Count | High Priority | Medium Priority |
|--------------|-------------------|---------------|-----------------|
| V1: Architecture | [N] | [N] | [N] |
| V2: Business Logic | [N] | [N] | [N] |
| V4: API Security | [N] | [N] | [N] |
| V5: Validation | [N] | [N] | [N] |
| V6: Authentication | [N] | [N] | [N] |
| V7: Session Management | [N] | [N] | [N] |
| V8: Access Control | [N] | [N] | [N] |
| V9: File Resources | [N] | [N] | [N] |
| V10: Malicious Code | [N] | [N] | [N] |
| V11: Cryptography | [N] | [N] | [N] |
| V12: Communications | [N] | [N] | [N] |
| V13: Configuration | [N] | [N] | [N] |
| V14: Data Protection | [N] | [N] | [N] |
| V15: AI/ML Security | [N] | [N] | [N] |
| V16: Logging | [N] | [N] | [N] |
| **Total** | **[N]** | **[N]** | **[N]** |
