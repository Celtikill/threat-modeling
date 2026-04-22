---
title: "Supporting Analysis: [System/Vendor]"
subtitle: "[Context — e.g., Technical Threat Analysis]"
author: "[Name / Role]"
date: "[YYYY-MM-DD]"
version: "[1.0]"
status: "[Draft / Draft-Reviewed / Final]"
assessment_type: "[Type 1 / Type 2 / Type 3]"
risk_rating: "[Critical / High / Medium / Low]"
classification: "CONFIDENTIAL"
lean_report: "[Link to corresponding lean report]"
---

# Supporting Analysis: [System/Vendor] — [Context]

<!-- Replace frontmatter values above and delete this comment block
     [System/Vendor] = subject name
     [Context] = use case or service description
     This is the retained analytical work product supporting the lean report
     Audience: Security architect and technical reviewers -->

---

## Document Control

*Metadata for version tracking and accountability.*

| Field | Value |
|-------|-------|
| **Version** | [1.0] |
| **Assessment Date** | [YYYY-MM-DD] |
| **Assessor** | [Name / Role] |
| **Business Owner** | [Name / Title] |
| **Status** | [Draft / Draft-Reviewed / Final] |
| **Lean Report** | [Link to corresponding lean report] |

---

## Table of Contents

<!-- Update after completing all sections -->

- [Attack Tree Analysis](#attack-tree-analysis)
- [Finding-to-Threat Traceability](#finding-to-threat-traceability)
- [Complete Threat Catalog](#complete-threat-catalog)
- [Residual Risk Analysis](#residual-risk-analysis)
- [Personnel Access Analysis](#personnel-access-analysis)
- [Responsibility Boundary Analysis](#responsibility-boundary-analysis)
- [Assumptions Register](#assumptions-register)
  - [Assumption Summary](#assumption-summary)
  - [Intake Assumptions](#intake-assumptions)
  - [Assessment Discoveries](#assessment-discoveries)
- [Findings Reference Catalog](#findings-reference-catalog)
- [Engineering Discovery Questionnaire](#engineering-discovery-questionnaire) *(Type 2 only, optional)*
- [Glossary](#glossary)

---

## Attack Tree Analysis

*Full attack tree structure and methodology used to identify threats. See SOP Phase 3 for methodology and reference.md for the standard branch library.*

### Assessment Mode Declaration

<!-- Document the assessment mode per SOP Phase 0.3: Baseline, Delta, or Re-baseline. -->

| Field | Value |
|-------|-------|
| **Assessment Mode** | [Baseline / Delta / Re-baseline] |
| **Rationale** | [New system / Change to existing / >12 months since prior] |
| **Prior Baseline Reference** | [Link to prior baseline, if Delta/Re-baseline] |
| **Baseline Date** | [Date of prior baseline, if applicable] |

### System Scope Declaration

<!-- Structured scope definition for scannable system context. Use for complex systems with multiple components or data flows. -->

| Aspect | Description |
|--------|-------------|
| **Baseline System** | [Complete system description — what the system does, what it handles] |
| **Data Sources** | [List of upstream data sources — APIs, files, streams, databases] |
| **Ingestion Patterns** | [How data enters — connectors, agents, APIs, batch, streaming] |
| **Processing Stages** | [Key transformation/processing stages if multi-stage architecture] |
| **Egress Points** | [Where data exits — APIs, files, reports, downstream systems] |

### Baseline System Description

<!-- For Baseline/Re-baseline modes: Complete system description. For Delta mode: System as it existed pre-change. -->

[Describe the complete baseline system architecture, data flows, trust boundaries, and key components.]

### Change Description (Delta Mode Only)

<!-- For Delta mode: Document the specific change being assessed. -->

| Aspect | Description |
|--------|-------------|
| **Change Type** | [New component / Modified integration / Removed system / Configuration change] |
| **Change Scope** | [What specifically is changing] |
| **Components Affected** | [List of components impacted by change] |
| **New Attack Surface** | [Attack vectors introduced by change] |

### Post-Change System Description

<!-- For all modes: Describe the system as it will exist after the change (or as it exists now for Baseline). -->

[Describe the complete post-change system architecture.]

### Delta Threat Analysis (Delta Mode Only)

<!-- Document threats introduced or heightened by this specific change. -->

| Component | Change Type | Threats Introduced | Threats Heightened |
|-----------|-------------|-------------------|-------------------|
| [Component name] | [New/Modified/Removed] | [T-XXX, T-YYY] | [T-ZZZ] |

### Primary Goal

<!-- State the primary attack goal and scoring methodology -->

<!-- Primary Goal — use the statement matching your assessment type (per SOP Phase 3.1):
     Type 1 (Vendor): "Compromise organizational data/systems through [Vendor] relationship"
     Type 2 (Application): "Compromise organizational data/functionality through application architectural weaknesses"
     Type 3 (Infrastructure): "Compromise organizational infrastructure through configuration or access control weaknesses"
-->
**Goal:** [Select the primary goal matching your assessment type from the comment above]

**Scoring methodology:** Qualitative Likelihood x Impact matrix (High/Medium/Low) per SOP Section 3.3. See [reference.md](../docs/reference.md#risk-assessment-matrix) for scoring details.

### Attack Tree Structure

<!-- Customize branches based on vendor context. Not all standard branches apply to every vendor. -->
<!-- See reference.md for the standard branch library. Document which branches were assessed and which were excluded. -->

```
Goal: [Primary attack goal]
├── Branch 1: [Branch Name]
│   ├── 1.1 [Sub-branch]
│   │   ├── [Leaf threat]
│   │   └── [Leaf threat]
│   └── 1.2 [Sub-branch]
│       ├── [Leaf threat]
│       └── [Leaf threat]
├── Branch 2: [Branch Name]
│   ├── 2.1 [Sub-branch]
│   │   ├── [Leaf threat]
│   │   └── [Leaf threat]
│   └── 2.2 [Sub-branch]
│       └── [Leaf threat]
└── Branch [N]: [Branch Name]
    └── [N].1 [Sub-branch]
        └── [Leaf threat]
```

### Excluded Branches

<!-- Document any standard branches excluded from this assessment with justification -->

| Branch | Reason for Exclusion |
|--------|----------------------|
| [Branch name] | [Justification] |

### Branch Selection Worksheet

<!-- Use this worksheet to document branch selection decisions. Reference the Branch Selection Guide (docs/branch-selection-guide.md) for applicability rules. -->

| Branch # | Branch Name | Applicable? | Justification if Excluded |
|----------|-------------|-------------|---------------------------|
| 1 | Vendor Infrastructure Compromise | [ ] Yes [ ] No | |
| 2 | Vendor Personnel Threats | [ ] Yes [ ] No | |
| 3 | Integration Point Exploitation | [ ] Yes [ ] No | |
| 4 | Vendor Business Disruption | [ ] Yes [ ] No | |
| 5 | Infrastructure Component Compromise | [ ] Yes [ ] No | |
| 6 | Application Layer Exploitation | [ ] Yes [ ] No | |
| 7 | Authentication and Authorization Exploitation | [ ] Yes [ ] No | |
| 8 | CI/CD Pipeline Compromise | [ ] Yes [ ] No | |
| 9 | Pipeline Integration Exploitation | [ ] Yes [ ] No | |
| 10 | IAM Privilege Escalation | [ ] Yes [ ] No | |
| 11 | Network Lateral Movement | [ ] Yes [ ] No | |
| 12 | Public Exposure Exploitation | [ ] Yes [ ] No | |
| 13 | Credential and Secret Theft | [ ] Yes [ ] No | |
| 14 | Logging Evasion | [ ] Yes [ ] No | |
| 15 | AI Training Data Poisoning | [ ] Yes [ ] No | |
| 16 | AI Prompt Injection and Input Manipulation | [ ] Yes [ ] No | |
| 17 | AI Model Extraction and Theft | [ ] Yes [ ] No | |
| 18 | AI Agent and Orchestration Abuse | [ ] Yes [ ] No | |
| 19 | AI Vector Database and Embedding Attacks | [ ] Yes [ ] No | |
| 20 | AI Output Manipulation and Jailbreaks | [ ] Yes [ ] No | |
| 21 | AI Supply Chain and Model Poisoning | [ ] Yes [ ] No | |

### Branch Selection Validation Checklist

Before proceeding, verify:

- [ ] All applicable branches for this assessment type are included (see branch-selection-guide.md)
- [ ] Excluded branches are documented with justification in the table above
- [ ] Branch numbers match the standard library (1-21)
- [ ] Branch names match the standard library exactly
- [ ] No custom branch names have been created (use sub-branches instead)
- [ ] AI branches (15-21) are included only for systems with AI features
- [ ] Assessment type declaration (Type 1, 2, or 3; with AI modifier if applicable) is documented

---

## Finding-to-Threat Traceability

*Documentation of mapping between assessment findings (TM-XXX) and threat scenarios (T-XXX). All findings must be threat-rooted, including accountability gaps that enable insider threats.*

| Finding ID | Vulnerability | Threat ID(s) | Threat Scenario | Regulatory Intent |
|------------|---------------|--------------|-----------------|-------------------|
| TM-XXX-001 | [Vulnerability description] | T-001, T-002 | [Attacker action] | [What regulator anticipated] |
| TM-XXX-002 | [Accountability gap] | T-003 | [How gap enables insider] | [Regulatory requirement rationale] |

**Key Principle:** Accountability gaps (unknown owner, missing process) ARE threat-rooted when they enable malicious insider activity. Document the specific threat scenario enabled by the governance gap.

> **Compliance Outputs vs. Findings:** Sector-specific regulations may require reporting of design vulnerabilities with technical threat roots. Such reporting is a compliance **OUTPUT** of threat modeling, not a finding. Do NOT create TM-XXX findings for:
> - "No HHS reporting pathway"
> - "Missing compliance documentation"
> - "No incident response plan" (unless it enables a specific T-XXX threat)
>
> **Correct approach:** Identify actual technical vulnerabilities (TM-XXX) → Map to threat scenarios (T-XXX) → Flag findings with threat roots for HHS reporting.

---

## Complete Threat Catalog

*All identified threats across all attack tree branches, scored by Likelihood x Impact. High-rated threats are promoted to Section 5 of the lean report.*

<!-- For life-safety system assessments: High-rated threats representing systemic (design) vulnerabilities may require sector-specific reporting. Document reporting requirements in the threat detail card Evidence section. -->

<!-- Create one subsection per attack tree branch. Add or remove subsections to match the branches above. -->

### Branch 1: [Branch Name]

<!-- Optional introductory callout: Summarize branch risk profile and action items -->

> **[N] [Risk]-risk threats** in this branch—[brief threat summary]—[require/present/suggest] [key concern]. 
> **Action needed:** [Specific recommended action for this branch's threats].

**ASVS Chapters:** V11, V12, V13 | **AISVS Chapters:** C4

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | ASVS Ref | AISVS Ref | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|-----------|-----------|
| [T-001] | [Threat description] | [H/M/L] | [H/M/L] | [H/M/L] | [Technique ID] | [e.g., V13.1.1] | [e.g., C4.1.1] | [Brief scoring justification] |
| [T-002] | [Threat description] | [H/M/L] | [H/M/L] | [H/M/L] | [Technique ID] | [e.g., V11.1.1] | [or -] | [Brief scoring justification] |

### Branch 2: [Branch Name]

**ASVS Chapters:** V6, V8 | **AISVS Chapters:** C5

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | ASVS Ref | AISVS Ref | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|-----------|-----------|
| [T-003] | [Threat description] | [H/M/L] | [H/M/L] | [H/M/L] | [Technique ID] | [e.g., V6.1.1] | [e.g., C5.1.1] | [Brief scoring justification] |
| [T-004] | [Threat description] | [H/M/L] | [H/M/L] | [H/M/L] | [Technique ID] | [e.g., V8.1.1] | [or -] | [Brief scoring justification] |

<!-- Repeat for each branch -->

### Branch [N]: [Branch Name]

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Rationale |
|-----------|--------|------------|--------|------------|---------------|-----------|
| [T-NNN] | [Threat description] | [H/M/L] | [H/M/L] | [H/M/L] | [Technique ID] | [Brief scoring justification] |

### Threat Summary

| Risk Level | Count |
|------------|-------|
| Critical | [N] |
| High | [N] |
| Medium | [N] |
| Low | [N] |
| **Total** | **[N]** |

### Critical and High-Rated Threat Detail Cards

*Expanded analysis for each Critical and High-rated threat identified in the catalog above. Each card follows a standardized structure separating observation (what was found) from risk (why it matters), evidence (sources), and recommendation (what to do).*

<!-- Create one card per Critical and High-rated threat. Threat IDs must match the Complete Threat Catalog above. -->

#### Threat [T-NNN]: [Title]

**Risk Level:** Critical / High
**Scope:** [Assessment type and system/vendor area affected]
**MITRE ATT&CK:** [Technique ID — Technique Name]

**Observation:**
[What the assessment identified — factual, based on intake data, vendor documentation, public research, or analyst analysis. Cite specific sources.]

**Risk:**
[Why it matters — reference the relevant attack tree branch, business impact, exploitability. Connect to the threat scoring rationale from the catalog.]

**Evidence:**
[List all sources supporting this finding. Cite by type:]
- Intake: [Section reference, e.g., "A5 — integration uses HTTP, not HTTPS"]
- Documentation: [Vendor trust page, API docs, etc. — with access date]
- Research: [MITRE ATT&CK reference, CVE, incident report]
- Assumption: [If evidence is incomplete, note the assumption ID from the Assumptions Register]

**Recommendation:**
[Specific, actionable mitigating requirement. The security requirements document (Type 2/3) will formalize this using prescriptive language (MUST/SHOULD).]

**Priority:** [Immediate / Near-Term / Strategic]

<!-- Repeat for each High-rated threat -->

---

## Residual Risk Analysis

*Post-mitigation risk assessment for all High-rated threats. Documents expected risk reduction when mitigating requirements are implemented.*

<!-- For Type 1 (Vendor): This residual risk analysis supports the Vendor Recommendation in the lean report.
     The analyst should justify Proceed/Proceed with Conditions/Do Not Proceed based on the residual risk profile. -->

### High-Rated Threats — Residual Risk After Mitigations

| Threat ID | Threat | Pre-Mitigation Risk | Recommended Mitigations | Residual Risk | Notes |
|-----------|--------|---------------------|-------------------------|---------------|-------|
| [T-001] | [Threat description] | **High** | [Specific technical/operational controls] | [H/M/L] | [Caveats, validation status, why residual risk remains] |
| [T-002] | [Threat description] | **High** | [Specific technical/operational controls] | [H/M/L] | [Caveats, validation status, why residual risk remains] |

<!-- Include all High-rated threats from the Complete Threat Catalog -->

### Residual Risk Summary

| Residual Risk Level | Count |
|---------------------|-------|
| High | [N] |
| Medium | [N] |
| Low | [N] |

<!-- If any threats remain High after mitigations, flag them here with additional commentary -->

---

## Personnel Access Analysis

<!-- Assessment type determines focus:
     - Type 1 (Vendor): Vendor personnel with access to organizational data/systems
     - Type 2 (Application): Development/operations team access + vendor personnel in multi-vendor architectures
     - Type 3 (Infrastructure): IAM principals (users, roles, service accounts) with privileged access -->

*Assessment of personnel access to organizational data and systems. See SOP Phase 2.*

### Personnel with Data Access

| Role | Access Level | Data Types Accessible | Background Check | MFA Enforced |
|------|-------------|----------------------|------------------|--------------|
| [Role/Title] | [Admin/Read-Write/Read-Only] | [Data types] | [Yes/No/Unknown] | [Yes/No/Unknown] |
| [Role/Title] | [Admin/Read-Write/Read-Only] | [Data types] | [Yes/No/Unknown] | [Yes/No/Unknown] |

### Access Provisioning and Deprovisioning

| Process | Description | SLA |
|---------|-------------|-----|
| New access request | [Process description] | [Timeframe] |
| Access modification | [Process description] | [Timeframe] |
| Access revocation (planned) | [Process description] | [Timeframe] |
| Access revocation (emergency) | [Process description] | [Timeframe] |
| Access review cadence | [Process description] | [Frequency] |

---

## Responsibility Boundary Analysis

*Delineation of security responsibilities between the organization and external parties.*

<!-- Assessment type determines the boundary:
     - Type 1: Organization vs. Vendor
     - Type 2: Organization vs. External Parties (vendors in pipeline, cloud providers)
     - Type 3: Organization vs. Cloud Provider (shared responsibility model) -->

### Organization Responsibilities

| Area | Responsibility |
|------|----------------|
| [e.g., Data classification] | [Description of responsibility] |
| [e.g., User access management] | [Description of responsibility] |
| [e.g., Incident escalation] | [Description of responsibility] |

### External Party Responsibilities

<!-- Rename this header to match your assessment type:
     - Type 1: "Vendor Responsibilities"
     - Type 2: "External Party Responsibilities"
     - Type 3: "Cloud Provider Responsibilities" -->

| Area | Responsibility |
|------|----------------|
| [e.g., Infrastructure security] | [Description of responsibility] |
| [e.g., Encryption at rest] | [Description of responsibility] |
| [e.g., Patch management] | [Description of responsibility] |

<!-- Add a Shared Responsibilities subsection if needed for jointly-owned areas -->

---

## Assumptions Register

*All assumptions made during the assessment, with validation status and impact analysis. See SOP Cross-Cutting Requirements.*

*Intake assumptions document information not provided during intake; discoveries document new findings that emerged during assessment.*

| ID | Assumption | Source | Impact if Invalid | Validation Method | Status |
|----|-----------|--------|-------------------|-------------------|--------|
| A-01 | [Assumption statement] | [Source of gap] | [How conclusions change if wrong] | [How to verify] | [Validated/Unvalidated/Invalidated] |
| A-02 | [Assumption statement] | [Source of gap] | [How conclusions change if wrong] | [How to verify] | [Validated/Unvalidated/Invalidated] |

<!-- Source values: "Intake gap (A6 blank)", "Vendor docs not provided", "SME unavailable", "Interview — unconfirmed", "Public research — not independently verified" -->
<!-- Categories to consider: Vendor, Integration, Regulatory (framework/requirement), Organizational, Threat Actor, Data, Sector-Specific-Reporting -->
<!-- NOTE: "Regulatory" here refers to framework requirements and compliance obligations, not threat actors.
     Regulatory consequences (penalties, reporting) are captured as Impact factors in threat scoring,
     not as threat actors in the attack tree. -->
<!-- All high-impact assumptions should be validated before moving to Final status -->
<!-- Unvalidated assumptions should be flagged in the lean report's Assessment Overview -->

### Assumption Summary

| Status | Count |
|--------|-------|
| Validated | [N] |
| Unvalidated | [N] |
| Invalidated | [N] |
| **Total** | **[N]** |

### Intake Assumptions

*Document information not provided during intake that was assessed via assumption.*

| ID | Assumption | Intake Source | Impact if Invalid | Closure Action |
|----|-----------|---------------|-------------------|----------------|
| A-001 | [Intake assumption statement] | [A4 Data Inventory, A7 Controls, etc.] | [How assessment conclusions change] | [Action to validate] |

**Categories:**
- **Business Context:** Business owner, operational requirements, service level agreements
- **Data Classification:** Data types, volume, sensitivity, retention requirements
- **Access Management:** Personnel inventory, access levels, provisioning processes
- **Regulatory Scope:** Applicable frameworks, consent workflows, reporting obligations

### Assessment Discoveries

*New information discovered during assessment that was not previously known.*

| ID | Discovery | Phase | Impact on Findings |
|----|-----------|-------|-------------------|
| D-001 | [What was found] | [Phase 1-5] | [How findings changed] |

---

## Findings Reference Catalog

*Comprehensive, hyperlinked source catalog for every finding and claim. See SOP Cross-Cutting Requirements.*

<!-- One subsection per vendor/system assessed, plus sections for regulatory/framework and threat intelligence sources -->

### Security Assessment Findings

<!-- For Type 2 (Application) and Type 3 (Infrastructure) assessments with code review or configuration analysis. Documents direct observations from source review that map to threats. -->

| Finding ID | Description | Source | Risk | Impact | Mapped Threat |
|------------|-------------|--------|------|--------|---------------|
| [F-001] | [Brief finding — e.g., "MD5 tokenization cryptographically broken"] | [`file/path.ext` lines X-Y] | **[Critical/High/Medium]** | [Impact if exploited] | [T-XXX] |
| [F-002] | [Brief finding description] | [`file/path.ext` lines X-Y] | **[Risk level]** | [Impact description] | [T-XXX] |

> **Finding-to-Threat Mapping:** Findings become threats when they enable attacker exploitation. Each finding maps to one or more T-XXX threats in the Complete Threat Catalog.

### [System/Vendor Name]

| Finding | Source | URL | Access Date |
|---------|--------|-----|-------------|
| [Specific claim or feature] | [Document or page name] | [https://...] | [YYYY-MM-DD] |
| [Specific claim or feature] | [Document or page name] | [https://...] | [YYYY-MM-DD] |

<!-- Repeat subsection for each additional system, vendor, or integration partner -->

### Regulatory and Framework References

| Finding | Source | URL | Access Date |
|---------|--------|-----|-------------|
| [Regulatory requirement or framework reference] | [Document or page name] | [https://...] | [YYYY-MM-DD] |
| [Regulatory requirement or framework reference] | [Document or page name] | [https://...] | [YYYY-MM-DD] |

### Threat Intelligence Sources

<!-- Incident reports, news articles, and other threat intelligence referenced in the assessment -->

| Finding | Source | URL | Access Date |
|---------|--------|-----|-------------|
| [Incident or intelligence item] | [Publication name] | [https://...] | [YYYY-MM-DD] |
| [Incident or intelligence item] | [Publication name] | [https://...] | [YYYY-MM-DD] |

---

## Phase 2B Code Review Discoveries

<!-- For Type 2 (Internal Application) assessments: Document vulnerabilities and security-relevant findings discovered during Phase 2B code review. These findings inform and update the architectural threat model. -->

*Implementation-level findings from code review that validate, elevate, or reveal gaps in the design-level threat analysis. Findings are evidence, not primary deliverables — they reinforce the threat model. **Critical and High-risk findings are reported according to their risk level** as incidental discoveries that reveal threats and prioritize requirements.*

**Discovery Log:**

| Finding ID | Source Location | Finding Summary | Threat Alignment | Evidence Value | Requirement Impact | Status |
|------------|-----------------|-----------------|------------------|----------------|-------------------|--------|
| F-XXX | src/path/file.py:NN | [Brief description] | T-XXX (existing) or NEW T-YYY | Reinforces/Elevates/Reveals | [Priority change or new req] | Documented |

**Novel Attack Vectors (New Threats Added):**

| Finding ID | New Threat ID | Attack Tree Branch | Rationale |
|------------|---------------|-------------------|-----------|
| F-XXX | T-YYY | Branch X.Y (new sub-branch) | [Why this is novel for this system] |

**Risk Elevations (Based on Code Evidence):**

| Threat ID | Original Risk | Finding Evidence | Revised Risk | Rationale |
|-----------|---------------|------------------|--------------|-----------|
| T-XXX | Medium | [Code location + finding] | High | [Evidence justifies elevation] |

**Attack Surface Expansions (Undocumented Components):**

| Finding ID | Component/Endpoint | Phase 1 Update | New Threat ID | Documentation |
|------------|-------------------|----------------|---------------|---------------|
| F-XXX | /api/v1/admin/reset | Added to Section 4 | T-ZZZ | [Reference to data flow update] |

---

## Engineering Discovery Questionnaire

<!-- OPTIONAL: Include this section for Type 2 (Internal Application) assessments where direct stakeholder interviews
     inform the threat model. This section captures questions asked and answers received during discovery.
     For Type 1 (Vendor) and Type 3 (Infrastructure), this section is typically not needed. -->

*Questions posed to technical stakeholders during the assessment, with summarized responses.*

| # | Question | Response | Follow-up Needed? |
|---|----------|----------|-------------------|
| 1 | [Question asked during discovery] | [Summarized response] | [Yes/No] |
| 2 | [Question asked during discovery] | [Summarized response] | [Yes/No] |

<!-- Group questions by topic area (e.g., Authentication, Data Flow, Deployment, Monitoring) if the list is long -->

---

## Glossary

*Terms and abbreviations used in this document.*

| Term | Definition |
|------|------------|
| [Term] | [Definition] |
| [Term] | [Definition] |

<!-- Include system/vendor-specific terminology, acronyms, and any terms from the SOP glossary relevant to this assessment -->
