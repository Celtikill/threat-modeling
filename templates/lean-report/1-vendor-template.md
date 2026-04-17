# Third-Party Vendor Threat Model: [Vendor Name] — [Context]

<!-- Replace [Vendor Name] with the vendor name (e.g., "ExampleCRM")
     Replace [Context] with the use case or service description (e.g., "CRM for Sales Operations")
     This template is for Type 1: Third-Party Vendor assessments -->

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

---

## 1. Assessment Overview

*Key facts about this assessment in a single scannable table.*

| Field | Value |
|-------|-------|
| **Assessment Type** | Type 1: Third-Party Vendor |
| **Vendor** | [Vendor name] |
| **Service/Product** | [Service, product, or system being assessed] |
| **Integration Partners** | [Other vendors/systems in the data flow, if any — or "None"] |
| **Assessment Date** | [YYYY-MM-DD] |
| **Assessor** | [Name / Role] |
| **Business Owner** | [Name / Title] |
| **Risk Rating** | [Critical / High / Medium / Low] |
| **Assessment Mode** | [Baseline / Re-baseline] — *Delta mode is not available for Type 1; vendor changes require Re-baseline* |
| **Prior Baseline Reference** | [Link to prior baseline, if Delta/Re-baseline] |
| **Regulatory Context** | [HIPAA / 42 CFR Part 2 / Life-Safety Regulations / None] |
| **Vendor Recommendation** | [Proceed / Proceed with Conditions / Do Not Proceed] |

> **Vendor Recommendation Guidance:**
> - **Proceed:** Risk is acceptable; no blocking findings
> - **Proceed with Conditions:** Risk is manageable if mitigating requirements are implemented
> - **Do Not Proceed:** Unacceptable risk identified; blocking findings in Section 5

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

> **Note on Accountability Gaps:** Findings like "Unknown Business Owner" ARE threat-rooted. The threat scenario is: "Malicious insider exploits lack of oversight to compromise CIA of data/services." Map these to T-XXX threats per the Threat-Rooted Findings Requirement.
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

## 3. Vendor Profile and Context

*Who is being assessed and how they integrate with organizational systems.*

### Company Intelligence

| Attribute | Value |
|-----------|-------|
| **Founded** | [Year] |
| **Employees** | [Count or estimate] |
| **Headquarters** | [City, State/Country] |
| **Ownership** | [Public / Private — PE-backed, VC-backed, etc.] |
| **Revenue** | [Amount or "Not disclosed"] |
| **Cloud Provider** | [AWS / Azure / GCP / Private] |
| **Compliance** | [SOC 2, ISO 27001, HIPAA, FedRAMP, etc.] |
| **Recent News/Concerns** | [Acquisitions, incidents, leadership changes — or "None identified"] |

### Service Integration Summary

| Attribute | Value |
|-----------|-------|
| **Service Type** | [SaaS / API / On-prem / Hybrid] |
| **Integration Method** | [REST API, SSO, file transfer, etc.] |
| **Service Criticality** | [Life-Safety / Mission-Critical / Business-Critical / Operational] |
| **Users Affected** | [Description and count] |
| **Data Sensitivity** | [Critical / High / Medium / Low] |

---

## 4. Asset & Data Flow Analysis

*What data is at risk, how it moves, and how it is accessed. See Appendix A for architecture diagrams.*

### Data Classification Matrix

| Data Type | Volume | Sensitivity | Retention | Regulatory Driver |
|-----------|--------|-------------|-----------|-------------------|
| [Data type] | [High/Med/Low] | [Critical/High/Med/Low] | [Duration + basis] | [Regulation or "Baseline"] |
| [Data type] | [High/Med/Low] | [Critical/High/Med/Low] | [Duration + basis] | [Regulation or "Baseline"] |

### Data Flow Summary

| Flow | Direction | Data Types | Protocol |
|------|-----------|------------|----------|
| [Organization] → [Vendor] | Outbound | [Data types] | [HTTPS/SFTP/etc.] |
| [Vendor] → [Organization] | Inbound | [Data types] | [HTTPS/SFTP/etc.] |

### Access Vectors

| Vector | Description |
|--------|-------------|
| Network Access | [How network connectivity is established] |
| Authentication | [Auth mechanisms: SSO, API keys, certificates, etc.] |
| Authorization Levels | [Access levels and permissions] |
| Access Duration | [Ongoing / Time-limited / On-demand] |

---

## 5. Top Priority Risks

*High-rated threats requiring management attention.*

| Threat ID | Threat | Likelihood | Impact | Risk Level | MITRE ATT&CK | Mitigating Requirement |
|-----------|--------|------------|--------|------------|---------------|---------------------|
| T-001 | [Threat description] | [H/M/L] | [H/M/L] | **High** | [Technique ID] | [Mitigating requirement] |
| T-002 | [Threat description] | [H/M/L] | [H/M/L] | **High** | [Technique ID] | [Mitigating requirement] |

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

1. **[Source name]** — [URL](https://example.com) — [Brief description]
2. **[Source name]** — [URL](https://example.com) — [Brief description]

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
    accTitle: Vendor Context Diagram
    accDescr: High-level view showing the vendor service in its ecosystem with organizational connections

    A[🏛️ Organization] --> B[🔧 Vendor Service]
    B --> C[👥 End Users]

    linkStyle 0 stroke:#333333,stroke-width:2px
    linkStyle 1 stroke:#333333,stroke-width:2px
```

### Container Diagram

<!-- Recommended if service criticality is Business-Critical or higher -->

```mermaid
%%{init: {'theme':'default', 'themeVariables': {'fontSize':'16px'}}}%%
graph TB
    accTitle: Vendor Container Diagram
    accDescr: Technical architecture showing vendor infrastructure components

    subgraph "🏛️ Organization"
        A[🖥️ Systems] --> B[🔐 Identity Provider]
    end
    subgraph "🔧 Vendor Infrastructure"
        C[🚪 API Gateway] --> D[⚙️ Processing]
        D --> E[💾 Database]
    end
    B --> C

    linkStyle 0 stroke:#333333,stroke-width:2px
    linkStyle 1 stroke:#333333,stroke-width:2px
    linkStyle 2 stroke:#333333,stroke-width:2px
    linkStyle 3 stroke:#333333,stroke-width:2px
```

---

*Document generated using Threat Modeling Framework v5.0*
