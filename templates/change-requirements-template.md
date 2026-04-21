---
title: "Change Security Requirements: [Change Name] (Delta)"
subtitle: "[System Name] Threat Model Assessment"
author: "Security Architecture Team"
date: "YYYY-MM-DD"
version: "1.0"
classification: "Internal/Confidential"
template: "[path/to/template.latex]"
---

<!-- Delta security requirements for [change description]. Extends baseline established in [Baseline Security Requirements Document] -->

---

## Document Control

| Field | Value |
|-------|-------|
| Version | [1.0] |
| Date | [YYYY-MM-DD] |
| Author | [Name / Role] |
| Status | [Draft / Draft-Reviewed / Final] |
| Assessment Mode | **Delta** |
| Baseline Reference | [Link to baseline security requirements] |
| Threat Model Reference | [Link to change threat model] |

---

## Introduction

### Purpose

This document defines **delta security requirements** — new or modified requirements introduced by [change description]. These requirements extend the baseline established in [Baseline Security Requirements Document].

### Scope

| In Scope (Delta) | Out of Scope (Baseline) |
|------------------|------------------------|
| [New component/integration security] | [Core system requirements] |
| [New data type controls] | [Existing data handling] |
| [New vendor-specific controls] | [General authentication, encryption] |

### Risk Amplification Notice

> **⚠️ Risk Amplification:** [Document any compounding risks when this change adds to existing systems. Describe how failure points multiply when adding new integrations, data flows, or vendors to an existing system. Note concurrent breach notification obligations across multiple frameworks if applicable.]

### Compliance Mapping (Delta)

| Requirement Source | Priority | Rationale |
|-------------------|----------|-----------|
| [New vendor/framework] | **Required** | [Why this delta is required] |
| [New data type] | **Required** | [Why baseline didn't address this] |
| [New control category] | **Required** | [Why this is new] |

---

## Delta Requirements by Category

> **Section Ordering:** Delta requirements are organized by implementation workflow (authentication → session management → access control → data protection → etc.)

> **Prerequisite Warning:** The baseline system has [N] critical findings including [key gaps]. The delta requirements below introduce NEW controls for [change-specific risks]. These delta requirements are additive—they do not remediate baseline vulnerabilities. Address baseline critical findings first, or this change compounds an already unacceptable risk posture.

### [Category Name] ([Change-Specific])

| ID | Requirement | ASVS/SSR Ref | Threat Ref | Priority | Verification |
|----|-------------|--------------|------------|----------|--------------|
| **[VXX.X]** | **[Clear requirement statement using RFC 2119]** | **[SSR reference]** | **[T-XXX]** | **Required** | **[Verification method]** |

<!-- Use bold formatting for delta-specific requirements to distinguish from baseline -->

### Access Control ([New Data Type] Controls - NEW)

<!-- Include when change introduces data types requiring specific access controls -->

| ID | Requirement | ASVS/SSR Ref | Threat Ref | Priority | Verification |
|----|-------------|--------------|------------|----------|--------------|
| **[VXX.X-DATA]** | **[Data-type-specific access control]** | **[SSR ref]** | **[T-XXX]** | **Required** | **[Verification]** |

> **Implementation Guidance:**
> - [Specific configuration details]
> - [Monitoring requirements]

### AI/ML Security ([Specific Risk] - if applicable)

<!-- Include when change affects AI/ML components -->

| ID | Requirement | Framework Ref | Threat Ref | Priority | Verification |
|----|-------------|---------------|------------|----------|--------------|
| **[VX.X]** | **[AI-specific requirement]** | **[NIST AI RMF / AISVS ref]** | **[T-XXX]** | **Required** | **[Verification]** |

---

## Stage-Specific Delta Requirements (Data Pipelines)

<!-- For data pipeline changes: document requirements by stage -->

### Stage N-Delta: [New/Modified Stage]

| ID | Requirement | Verification Method | Threat Ref |
|----|-------------|---------------------|------------|
| **[PREFIX-N]** | **[Requirement specific to this stage]** | **[Verification]** | **[T-XXX]** |

<!-- ID prefix: IN- (Ingestion), WH- (Warehouse), TR- (Transform), EG- (Egress), [Vendor]- -->

---

## [New Data Type] Governance Requirements (NEW)

<!-- Include when change introduces new data classifications requiring governance -->

### [Data Type] Data Controls

| ID | Requirement | Policy Reference | Threat Ref | Priority |
|----|-------------|------------------|------------|----------|
| **[DT-1]** | **[Governance requirement]** | **[Policy ref]** | **[T-XXX]** | [Required/Recommended] |

### [Data Type] Evidence Requirements

| Control | Evidence Required | Review Frequency |
|---------|-------------------|------------------|
| [Control name] | [Evidence description] | [Frequency] |

---

## Delta Traceability Matrix

### Delta Threat to Delta Requirement Mapping

| Threat ID | Threat Description | Mitigating Delta Requirements | Residual Risk |
|-----------|--------------------|-------------------------------|---------------|
| **[T-XXX]** | **[New threat from change assessment]** | **[VX.X, PREFIX-N]** | **[Risk level]** |

**Note on [Threat ID]:** [Any commentary on threat mitigation approach or rationale]

### Baseline Requirement Reference

Each delta requirement builds upon the baseline. See [Baseline Security Requirements] for complete baseline coverage.

> **Baseline Prerequisite:** The delta requirements below assume baseline vulnerabilities have been remediated. These requirements address [change-specific risks] only—they do not fix baseline gaps. Address critical baseline findings first, or this change compounds existing security debt.

| Delta Requirement | Extends Baseline | Modification |
|-------------------|------------------|--------------|
| [VXX.X] | [VXX.X (baseline ref)] | [How this modifies/extends baseline] |
| [PREFIX-N] | [N/A - new component] | [New requirement for this change] |

---

## Implementation Priority

### Phase 1: Immediate ([Change Component] Security)

| Priority | Requirement | Threat Mitigated |
|----------|-------------|------------------|
| P1 | [Requirement ID] | [Threat ID] |
| P1 | [Requirement ID] | [Threat ID] |

### Phase 2: High Priority ([New Risk Category])

| Priority | Requirement | Threat Mitigated |
|----------|-------------|------------------|
| P2 | [Requirement ID] | [Threat ID] |

### Phase 3: Medium Priority ([Remaining Controls])

| Priority | Requirement | Threat Mitigated |
|----------|-------------|------------------|
| P3 | [Requirement ID] | [Threat ID] |

---

## Data Source Reference

<!-- Link to CSV source of truth files -->

This document was drafted from structured data captured in:

| CSV Source | File Path | Row Count |
|------------|-----------|-----------|
| Delta Threats | `data/threats.csv` | [N] |
| Delta Findings | `data/findings.csv` | [N] |
| Delta Requirements | `data/requirements.csv` | [N] |

---

*End of Delta Security Requirements Document*

**Related Documents:**
- Security Requirements: [System Name] — Baseline
- Change Assessment: [Change Name] (Delta)
- Change Supporting Analysis: [Change Name] (Delta)
