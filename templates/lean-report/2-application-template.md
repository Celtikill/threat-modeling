---
title: "Threat Model: [System Name]"
subtitle: "[Context — e.g., ETL Pipeline for Analytics]"
author: "[Name / Role]"
date: "[YYYY-MM-DD]"
version: "[1.0]"
status: "[Draft / Draft-Reviewed / Final]"
assessor: "[Name / Role]"
business_owner: "[Name / Title]"
assessment_type: "Type 2: Internal Application"
assessment_mode: "[Baseline / Delta / Re-baseline]"
regulatory_context: "[HIPAA / 42 CFR Part 2 / Life-Safety Regulations / None]"
life_safety_critical: "[Yes / No]"
risk_rating: "[Critical / High / Medium / Low]"
classification: "[CONFIDENTIAL / Internal / Public]"
template: "[path/to/latex-template.latex]"
logo: "[path/to/organization-logo.png]"
toc: true
---

# Threat Model: [System Name] — [Context]

<!-- Replace frontmatter values above and delete this comment block
     [System Name] = system or pipeline name
     [Context] = use case or service description
     This template is for Type 2: Internal Application assessments -->

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
| **Prior Baseline Reference** | [Link to prior baseline, if Delta/Re-baseline] |

> **Source Age Notice:** Assessment sources have access dates documented in Section 7. Source age affects confidence levels.

---

## Executive Summary

*Leadership-focused urgent action statement with security/compliance context and risk visualization.*

### Executive Action Required

\begin{center}
\textbf{\large Executive Action Required}
\end{center}

**[Number] critical findings** expose [system description] to potential compromise. [One-sentence summary of combined risk]. Left unaddressed, these vulnerabilities could expose [organization] to [regulatory/operational consequences]. Immediate executive attention is required to prioritize remediation of [top 1-2 risk categories].

### Security & Compliance Context

[2-3 paragraphs covering:]
- **Regulatory implications:** Applicable frameworks (HIPAA, GDPR, SOC 2, etc.) and specific obligations triggered
- **Operational impact:** Business process disruption, service availability concerns
- **Financial exposure:** Contract penalties, breach costs, grant funding implications

> **Regulatory Context:** [Cite specific regulations applicable to this assessment with links to authoritative sources. E.g., "HIPAA Security Rule — 45 CFR 164.312: https://www.ecfr.gov/current/title-45/part-164"]

> **Research Citation:** [For high-sensitivity assessments, cite relevant incident research: "[Breach/incident description] [Source: public reporting, access date YYYY-MM-DD]"]

> **Note:** Source age and access dates are tracked in Section 7. Assess confidence accordingly.

### Risk Quadrant Chart

```mermaid
quadrantChart
    title Risk Matrix: [N] Critical/High Findings
    x-axis Low Likelihood --> High Likelihood
    y-axis Low Impact --> High Impact
    quadrant-1 Immediate Action Required
    quadrant-2 Catastrophic but Rare
    quadrant-3 Low Priority
    quadrant-4 Likely but Limited
    "TM-001 Finding": [0.75, 0.85]
    "TM-002 Finding": [0.60, 0.90]
    "TM-003 Finding": [0.85, 0.75]
```

*Plot Critical findings (0.7+ impact) mandatorily. Plot High findings (0.5-0.7 impact) if space permits.*

---

## 1. Assessment Overview

*Key facts about this assessment in a single scannable table.*

| Field | Value |
|-------|-------|
| **Assessment Type** | Type 2: Internal Application |
| **System** | [System name] |
| **Service/Product** | [Application, pipeline, or service being assessed] |
| **Integration Partners** | [Vendors/systems in the data flow, if any — or "None"] |
| **Assessment Date** | [YYYY-MM-DD] |
| **Assessor** | [Name / Role] |
| **Business Owner** | [Name / Title] |
| **Risk Rating** | [Critical / High / Medium / Low] |
| **Assessment Mode** | [Baseline / Delta / Re-baseline] |
| **Prior Baseline Reference** | [Link to prior baseline, if Delta/Re-baseline] |
| **Regulatory Context** | [HIPAA / 42 CFR Part 2 / Life-Safety Regulations / None] |

---

## 2. Risk Management Summary

*Critical findings and risk breakdown by category.*

### Critical Findings

<!-- 3-7 key findings, icon-prefixed. Every finding MUST map to a T-XXX threat scenario -->
<!-- Use emoji: ⚠️ = warning/high risk, 🛡️ = security control, 🔗 = integration, 📋 = compliance, 👤 = personnel -->

| Finding ID | Vulnerability | Threat ID | Threat Scenario | Risk Level |
|------------|---------------|-----------|-----------------|------------|
| ⚠️ **TM-001** | [Vulnerability description] | T-001 | [Attacker action exploiting this vulnerability] | High |
| 📋 **TM-002** | [Compliance/accountability gap] | T-002 | [How gap enables threat actor] | High |
| 👤 **TM-003** | [Personnel/insider gap] | T-003 | [Insider threat scenario] | High |

> **Note on Accountability Gaps:** Findings like "Unknown Business Owner" ARE threat-rooted. The threat scenario is: "Malicious insider exploits lack of oversight to compromise CIA of data/services." Map these to T-XXX threats.
>
> **Compliance Outputs vs. Findings:** Sector-specific reporting obligations (e.g., HHS for healthcare) are **OUTPUTS** of threat modeling, not findings. They apply to TM-XXX findings with technical threat roots.

### Risk Level Breakdown

| Category | Category Rating | Key Drivers |
|----------|-----------------|-------------|
| Data Security | [Critical/High/Medium/Low] | [Primary risk drivers] |
| Infrastructure | [Critical/High/Medium/Low] | [Primary risk drivers] |
| Personnel | [Critical/High/Medium/Low] | [Primary risk drivers] |
| Business Continuity | [Critical/High/Medium/Low] | [Primary risk drivers] |

---

## 3. System Profile and Context

*What is being assessed and how it integrates with organizational systems.*

### System Architecture Overview

| Attribute | Value |
|-----------|-------|
| **System Type** | [Custom app / Data pipeline / Internal service / Multi-vendor chain] |
| **Deployment Model** | [Cloud-native / Hybrid / On-premises] |
| **Primary Technology Stack** | [Languages, frameworks, platforms] |
| **Source Code Repository** | [Location or N/A] |
| **Vendor Dependencies** | [List any external vendors in the architecture, or "None"] |
| **Cloud Provider** | [AWS / Azure / GCP / Private / Multiple] |
| **Recent Changes** | [Architectural changes, migrations, incidents — or "None"] |

### Service Integration Summary

| Attribute | Value |
|-----------|-------|
| **Service Type** | [API / Pipeline / Web app / Integration] |
| **Integration Method** | [REST API, message queue, file transfer, etc.] |
| **Service Criticality** | [Life-Safety / Mission-Critical / Business-Critical / Operational] |
| **Users Affected** | [Description and count] |
| **Data Sensitivity** | [Critical / High / Medium / Low] |

---

## 4. Asset & Data Flow Analysis

*What data is at risk, how it moves, and how it is accessed. See Appendix A for architecture diagrams.*

### Data Classification Matrix

| Data Type | Volume | Sensitivity | Retention | Primary System | Regulatory Driver |
|-----------|--------|-------------|-----------|----------------|-------------------|
| [Data type] | [High/Med/Low] | [Critical/High/Med/Low] | [Duration + basis] | [System name] | [Regulation or "Baseline"] |
| [Data type] | [High/Med/Low] | [Critical/High/Med/Low] | [Duration + basis] | [System name] | [Regulation or "Baseline"] |

### Data Layer Architecture (Optional)

*For multi-stage data pipelines: document processing layers and access controls per layer.*

> **Document Age Notice:** Note source age and terminology alignment with current implementation.

| Layer | Stage | Description | Role Required |
|-------|-------|-------------|---------------|
| [Layer name] | [Stage] | [What data exists here] | [Access role] |
| [Layer name] | [Stage] | [What data exists here] | [Access role] |

> **Validation Note:** Confirm role permissions and document source [REF, section].

### Data Flow Summary

*Categorize flows by risk level where applicable. Bold high-sensitivity data flows.*

#### Primary Data Flows

| Flow | Direction | Data Types | Protocol |
|------|-----------|------------|----------|
| [Source] → [Destination] | [Inbound/Outbound/Bidirectional] | **[High-sensitivity types]** / [Standard types] | [HTTPS/SFTP/etc.] |
| [Source] → [Destination] | [Inbound/Outbound/Bidirectional] | [Data types] | [HTTPS/SFTP/etc.] |

#### Egress/Secondary Flows (if applicable)

| Flow | Direction | Data Types | Protocol |
|------|-----------|------------|----------|
| [Source] → [Destination] | [Outbound] | [Data types] | [Protocol + encryption status] |

### Access Vectors

| Vector | Description |
|--------|-------------|
| Network Access | [How network connectivity is established] |
| Authentication | [Auth mechanisms: SSO, API keys, certificates, etc.] |
| Authorization Levels | [Access levels and permissions] |
| Access Duration | [Ongoing / Time-limited / On-demand] |

### High-Risk Data Type Analysis (Optional)

*For data types with unique risk profiles: exemptions from standard protections, unusual retention, or cross-layer re-identification risks.*

**[Data Type] Risk Profile**

**Exemption from Standard Protections**

[Explain why this data type bypasses normal protections — e.g., life-safety requirements, operational needs, regulatory mandates.]

**Time-Based Risk Implications**

[For data types that accumulate over time without purging: explain expanding attack surface and compounding breach impact.]

**Related Threats**

| Threat ID | Description | Risk Level |
|-----------|-------------|------------|
| T-XXX | [Threat specific to this data type] | **High/Critical** |
| T-XXX | [Threat specific to this data type] | **High/Critical** |

**Regulatory Context**

- **[Regulation]** — [Specific requirements this data type triggers]
- **[Regulation]** — [Tension between standard practice and exemption rationale]

> **Note:** [Compensating controls or mitigations that should be evaluated.]

---

## 5. Top Priority Risks

*High-rated threats requiring management attention.*

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Mitigating Requirement |
|-----------|--------|------------|--------|------------|---------------|---------------------|
| T-001 | [Threat description] | [H/M/L] | [H/M/L] | **High** | [Technique ID] | [Mitigating requirement] |
| T-002 | [Threat description] | [H/M/L] | [H/M/L] | **High** | [Technique ID] | [Mitigating requirement] |

### AI/ML Risk Rationale (Optional)

*For assessments involving AI/ML components: document model risk classification and training data concerns.*

Per [assessment context], this system operates [AI/ML component description]. These models [training/prediction behavior] on [data source].

**Baseline AI Risks:** [Description of AI-specific risks — e.g., training data poisoning, model extraction, adversarial inputs].

**NIST AI RMF Classification:** [High risk / Limited risk / Minimal risk] — Document if model affects safety, rights, or critical decisions.

---

## 6. Ongoing Risk Management

*Mitigating requirements and monitoring considerations.*

### Mitigating Requirements

**Technical**

1. [Mitigation description]
2. [Mitigation description]

**Operational**

1. [Mitigation description]
2. [Mitigation description]

### Key Monitoring Points

| Monitoring Area | Recommendation | Frequency |
|-----------------|----------------|-----------|
| [Area] | [What to monitor] | [Real-time / Daily / Monthly / Quarterly / Annual] |

---

## 7. Assessment Sources and Methodology

*Where assessment information came from and how confident we are in it.*

### Information Sources

#### Vendor Documentation

| Vendor | Resource | URL | Purpose |
|--------|----------|-----|---------|
| **[Vendor name]** | [Document name] | [URL](https://example.com) | [What this source informed] |

#### Framework References

| Framework | URL | Purpose |
|-----------|-----|---------|
| **MITRE ATT&CK** | [MITRE ATT&CK Framework](https://attack.mitre.org/) | Threat technique mapping |
| **MITRE ATLAS** | [MITRE ATLAS Framework](https://atlas.mitre.org/) | AI/ML-specific threats (if applicable) |

#### Internal Documentation

| Document | Date | Source | Key Finding |
|----------|------|--------|-------------|
| **[Document name]** | [YYYY-MM] | [Internal/Consumer-provided] | [Relevant finding from this source] |

### Assessment Confidence Levels

| Assessment Area | Confidence | Source |
|-----------------|------------|--------|
| [Area] | [High/Medium/Low] | [Source type] |

**Overall Confidence Level:** [High/Medium/Low] — [One-sentence justification]

---

## Appendix A: Architecture Diagrams

*Architecture diagrams referenced from Section 4.*

### Context Diagram

```mermaid
%%{init: {'theme':'default', 'themeVariables': {'fontSize':'16px'}}}%%
graph LR
    accTitle: Application Context Diagram
    accDescr: High-level view showing the application in its ecosystem

    A[🏛️ Organization] --> B[🔧 Application]
    B --> C[👥 End Users]
    B --> D[💾 Data Store]

    linkStyle 0 stroke:#333333,stroke-width:2px
    linkStyle 1 stroke:#333333,stroke-width:2px
    linkStyle 2 stroke:#333333,stroke-width:2px
```

### Container Diagram

<!-- Recommended if service criticality is Business-Critical or higher -->

```mermaid
%%{init: {'theme':'default', 'themeVariables': {'fontSize':'16px'}}}%%
graph TB
    accTitle: Application Container Diagram
    accDescr: Technical architecture showing application components

    subgraph "🏛️ Organization"
        A[🖥️ Client Systems] --> B[🔐 Auth Provider]
    end
    subgraph "🔧 Application"
        C[🚪 API Layer] --> D[⚙️ Business Logic]
        D --> E[💾 Database]
        D --> F[📊 Cache Layer]
    end
    B --> C

    linkStyle 0 stroke:#333333,stroke-width:2px
    linkStyle 1 stroke:#333333,stroke-width:2px
    linkStyle 2 stroke:#333333,stroke-width:2px
    linkStyle 3 stroke:#333333,stroke-width:2px
    linkStyle 4 stroke:#333333,stroke-width:2px
```

---

*Document generated using Threat Modeling Framework v5.0*
