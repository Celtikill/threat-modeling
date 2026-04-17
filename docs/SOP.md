# Threat Modeling SOP

---

## Document Control

| Field | Value |
|-------|-------|
| **Version** | 5.0 |
| **Last Updated** | 2026-04-15 |
| **Next Review** | 2026-09-23 |
| **Owner** | Security Architecture Team |

### Change History

| Version | Date | Changes |
|---------|------|---------|
| 5.0 | 2026-04-15 | Restructured to 6-phase sprint model (added Phase 4: Data Population); added Feedback Loop as post-sprint activity; folded AI-enabled assessments into Type 2 and Type 3 as conditional elements; removed Type 2-AI and Type 3-AI as separate types; deduplicated type definitions (reference assessment-type-guide.md) |
| 4.1 | 2026-03-23 | Added Phase 0 Intake and Scoping with intake template and consumer guide; expanded Phase 2 into type-specific variants (2A/2B/2C); created ASVS 5.0 security requirements template; added attack tree branches 6-14 and MITRE techniques for internal application and infrastructure types; generalized vendor-specific language across templates; added Jira Cloud intake issue type specification |
| 4.0 | 2026-03-23 | Declared three assessment types (2A/2B/2C) with Phase 2 variant anchors; refocused to technical advisory analysis; 5 phases with vendor-only Phase 2 content |
| 3.0 | 2026-02-19 | Refocused to technical advisory analysis; 6 phases collapsed to 5; extracted reference material to reference.md; removed compliance gatekeeping |
| 2.2 | 2026-02-10 | Simplified risk scoring to qualitative High/Medium/Low |
| 2.1 | 2026-02-10 | Added Findings Reference Catalog and Assumptions Register requirements |
| 2.0 | 2025-09-18 | Added NIST CSF 2.0 alignment, BYOT model guidance, UX improvements |
| 1.5 | 2025-06-01 | Added MITRE ATLAS for AI systems |
| 1.0 | 2025-01-15 | Initial release |

---

## Quick Navigation

**For Security Analysts:**
[Phase 0: Intake](#phase-0-intake-and-scoping) |
[Phase 1: Asset ID](#phase-1-asset-and-data-flow-identification) |
[Phase 2: Attack Surface](#phase-2-attack-surface-analysis) |
[Phase 3: Threat Analysis](#phase-3-threat-analysis) |
[Phase 4: Data Population](#phase-4-data-population) |
[Phase 5: Report Generation](#phase-5-report-generation) |
[Phase 6: Quality Review](#phase-6-quality-review) |
[Feedback Loop](#feedback-loop) |
[Templates](#templates-and-tools) |
[Reference Catalog](./reference.md)

**For Requestors:**
[Consumer Guide](./consumer-guide.md) |
[System Profile](../templates/system-profile-template.md) |
[Assessment Types](#assessment-types)

**For Executives:**
[Document Structure](#document-structure) |
[Report Structure](#42-report-structure-lean-template)

**Worked Examples:** See [examples/](../../examples/) directory for fictional demonstration assessments

---

## Advisory Language

This SOP uses advisory language throughout. Recommendations indicate best practice for thorough assessments; adapt depth and coverage to the complexity and criticality of the system or relationship under analysis. **Exception:** Type 1 (Third-Party Vendor) reports include a vendor recommendation (Proceed / Proceed with Conditions / Do Not Proceed) to support risk management decisions.

### Input Ownership

Assessment artifacts come from three sources. The SOP notes which applies at each step.

| Source | When | Documentation |
|--------|------|---------------|
| **Adopt** | Consumer provided the artifact in intake (diagram, inventory, scope file) | Cite as "Consumer-provided" in Findings Reference Catalog |
| **Extend** | Consumer provided a partial version; analyst adds security context, identifies gaps, or corrects inaccuracies | Note original source + analyst additions; corrections documented as Assessment Discoveries in Supporting Analysis |
| **Create** | Consumer did not provide it; analyst builds from assumptions and research | Document as Intake Assumption in Supporting Analysis with impact on assessment confidence |

---

## Purpose and Scope

This SOP provides systematic guidance for conducting design-level security assessments of systems, applications, and vendor relationships. It evaluates architecture, data flows, trust boundaries, and integration patterns to identify where system design creates or fails to mitigate risk. Assessments may surface systemic (design) vulnerabilities requiring mitigation. The output includes a threat model report with mitigating requirements and a supporting analysis with full threat catalog, assumptions register (including intake assumptions and discoveries), and findings catalog. For Types 2 and 3, prescriptive security requirements are also produced. Type 1 (vendor) assessments additionally produce a vendor recommendation (Proceed / Proceed with Conditions / Do Not Proceed). This is not vulnerability assessment (implementation-level enumeration) or penetration testing (exploitation).

**Target Audience:** Security analysts, risk assessors, threat modeling practitioners, and stakeholders requesting assessments

### References

- Threat Assessment Templates ([1-vendor-template.md](../templates/lean-report/1-vendor-template.md), [2-application-template.md](../templates/lean-report/2-application-template.md), [3-infrastructure-template.md](../templates/lean-report/3-infrastructure-template.md))
- Supporting Analysis Template ([supporting-analysis-template.md](../templates/supporting-analysis-template.md))
- System Profile Template ([system-profile-template.md](../templates/system-profile-template.md))
- Security Requirements Template ([security-requirements-template.md](../templates/security-requirements-template.md)) — OWASP ASVS 5.0 aligned, with OWASP AISVS for AI components
- Reference Catalog ([reference.md](./reference.md)) — MITRE ATT&CK and ATLAS techniques, attack tree branches, risk matrix, diagram reference
- Attack Tree Methodology
- [MITRE ATT&CK Framework](https://attack.mitre.org/) — standard cyber threat tactics and techniques
- [MITRE ATLAS Framework](https://atlas.mitre.org/) — AI/ML-specific adversarial tactics and techniques
- [OWASP AISVS](https://github.com/OWASP/AISVS/) — AI Application Security Verification Standard for ML/GenAI systems

---

## Assessment Types

This SOP supports three assessment types. Declare the assessment type during [Phase 0: Intake and Scoping](#phase-0-intake-and-scoping). For complete type definitions, decision tree, and detailed guidance, see the [Assessment Type Guide](./assessment-type-guide.md).

| Type | Description | When to Use | Phase 2 Variant | Deliverables |
|------|-------------|-------------|-----------------|--------------|
| **Third-Party Vendor** | External vendor/SaaS relationship risk | Evaluating a new or existing vendor relationship | [2A](#phase-2a-third-party-vendor) | Lean Report (with Vendor Recommendation) + Supporting Analysis |
| **Internal Application** | Internally-owned systems, data pipelines, custom applications | Assessing custom apps, data pipelines, internal services, multi-vendor architectures | [2B](#phase-2b-internal-application) | Lean Report + Supporting Analysis + Security Requirements (ASVS 5.0) |
| **Infrastructure-Only** | Cloud/network posture and configuration | Assessing AWS accounts, VPCs, IAM, network architecture, public exposure | [2C](#phase-2c-infrastructure-only) | Lean Report + Supporting Analysis + Security Requirements (ASVS 5.0) |

**Notes:**

- **Internal Application** includes data pipeline and multi-vendor architecture variants. When the system under assessment chains multiple SaaS vendors (e.g., ExampleERP → ExampleETL → ExampleWarehouse → ExampleTransform → ExampleFiles), treat it as an Internal Application assessment with pipeline-specific guidance in Phase 2.5.
- **Infrastructure-Only** assessments can use `scope.txt`-format infrastructure inventories (AWS account IDs, public IPs, hostnames, ARNs, URLs, CIDR ranges) as direct input to Phase 3.
- **Systems with AI features:** When a Type 2 or Type 3 assessment involves systems with AI/ML components (inference endpoints, RAG pipelines, model training, AI agents, vector databases), add AI-specific attack tree branches (15-21 from the [Attack Tree Library](./attack-trees/)) and include [OWASP AISVS](https://github.com/OWASP/AISVS/) requirements alongside ASVS 5.0. Threat analysis uses both MITRE ATT&CK (for infrastructure and application threats) and [MITRE ATLAS](https://atlas.mitre.org/) (for AI-specific adversarial techniques).
- **Template Selection:** Type 2 assessments with AI features use the [2-application-template.md](../templates/lean-report/2-application-template.md) plus AI-specific attack tree branches. Type 3 assessments with AI features use the [3-infrastructure-template.md](../templates/lean-report/3-infrastructure-template.md) plus AI-specific branches.
- The Security Requirements document follows [OWASP ASVS v5.0](https://owasp.org/www-project-application-security-verification-standard/) (May 2025, 17 chapters) and is produced using [security-requirements-template.md](../templates/security-requirements-template.md). Organization-specific regulatory overlays may adapt or extend the standard ASVS framework (e.g., healthcare organizations may use a Baseline/Enhanced model with sector-specific controls).
- **Life-safety systems:** For systems supporting crisis intervention or emergency services, additional regulatory obligations may apply (e.g., 42 CFR Part 2 criminal penalties for SUD records, sector-specific incident reporting). See [Phase 3.5](#35-regulatory-reporting-requirements-life-safety-systems).

### Roles and Accountability

See the RASCI Matrix in the repository README for role definitions and accountability assignments across the assessment lifecycle.

---

## Threat Modeling Process Overview

0. [Intake and Scoping](#phase-0-intake-and-scoping)
1. [Asset and Data Flow Identification](#phase-1-asset-and-data-flow-identification)
2. [Attack Surface Analysis](#phase-2-attack-surface-analysis) (type-specific: [2A](#phase-2a-third-party-vendor) | [2B](#phase-2b-internal-application) | [2C](#phase-2c-infrastructure-only))
3. [Threat Analysis](#phase-3-threat-analysis) (attack trees, MITRE mapping, risk scoring)
4. [Data Population](#phase-4-data-population) (populate catalogs, registers, gap analysis)
5. [Report Generation](#phase-5-report-generation)
6. [Quality Review](#phase-6-quality-review)

**Post-Sprint:** [Feedback Loop](#feedback-loop) (5 business days)

---

## Phase 0: Intake and Scoping

**Phase 0 of 7** | [-> Phase 1](#phase-1-asset-and-data-flow-identification)

**Estimated Time:** 1-2 hours (requestor) + 30 min (analyst review)

**Sprint alignment:** Phase 0 is a **pre-sprint activity**. The 2-week assessment sprint begins when the issue moves to In Progress (all intake prerequisites met). See [Sprint Budget](#sprint-budget) for how the 10 business days are allocated across Phases 1-6.

### 0.1 Intake Form Distribution

Provide the requestor with the [System Profile Template](../templates/system-profile-template.md). For requestors unfamiliar with the service, also share the [Consumer Guide](./consumer-guide.md).

The requestor completes:
- Universal sections (business context, system description, data profile, documentation, integration points, known risks, stakeholders)
- The type-specific section matching their assessment type (vendor, application, or infrastructure)

For direct submission, the [system profile](../templates/system-profile-template.md) serves as a standalone alternative.

### 0.2 Analyst Review

Upon receiving the completed intake form, the analyst should:

1. Confirm the **assessment type** is appropriate for the request (see [Assessment Types](#assessment-types) decision table)
2. **Check assessment inventory** to determine if a prior baseline exists for this system (needed for Mode Selection in 0.3)
3. Assess completeness against the intake form's Field Criticality designations:
   - **Required fields blank** → issue cannot move to In Progress; return to requestor via Needs Info
   - **Important fields blank** → create Assumptions Register entries with confidence: Low, source: "Intake gap (section X blank)"; document expected impact on assessment accuracy
4. Review provided diagrams and documentation for adequacy
5. Identify gaps that will require follow-up during Phase 1
6. Estimate assessment complexity and timeline
7. Apply client-specific regulatory overlays where applicable (e.g., healthcare clients may require HIPAA, 42 CFR Part 2, or sector-specific ASVS adaptations beyond the standard framework)

### 0.3 Assessment Mode Selection

The analyst determines the appropriate assessment mode based on system maturity and change context:

| Mode | When to Use | Scope | Deliverable Structure |
|------|-------------|-------|----------------------|
| **Baseline** | New system; first assessment of existing system; system without prior threat model | Complete system architecture | Full threat model + supporting analysis + security requirements |
| **Delta** | Change to system with existing baseline threat model (\u003c12 months old) | Change impact only | Change assessment + update to baseline |
| **Re-baseline** | System unchanged but baseline \u003e12 months old; significant architectural shift | Complete system (refreshed) | Full threat model (replaces prior baseline) + change log |

**Assessment Portfolio Model:** Each system maintains a **baseline threat model** (living document) plus **change assessments** (delta documents). This prevents redundant analysis while maintaining institutional knowledge.

**Decision Tree:**
```text
Has this system been assessed before?
├── No → Baseline Mode
└── Yes → Is prior baseline \u003c12 months old?
    ├── Yes → Delta Mode (what changed?)
    └── No → Is the change significant/architectural?
        ├── Yes → Re-baseline Mode (treat as new baseline)
        └── No → Delta Mode (update existing baseline)
```text

**Intake Requirement:** Requestor must indicate:
- Is this a new system or change to existing?
- If change: When was last threat model completed?
- If change: What specifically is changing?
- **If change: Does this alter trust boundaries, data flows, or authentication mechanisms?** (If yes → may trigger Re-baseline mode)

### 0.4 Scoping Agreement

The analyst and requestor align on:

| Field | Description |
|-------|-------------|
| Assessment Type | Confirmed type (Third-Party Vendor / Internal Application / Infrastructure-Only) |
| **Assessment Mode** | **Baseline** / **Delta** / **Re-baseline** |
| Scope Boundary | What is in scope and explicitly out of scope |
| **Prior Baseline Reference** | For Delta/Re-baseline: Link to existing baseline assessment |
| Deliverables | Per assessment type and mode (see [Document Structure](#document-structure)) |
| Sprint Start | Date issue moves to In Progress (2-week sprint begins) |
| Key Contacts | Who to contact for follow-up questions during Phases 1-3 |

### Phase 0 Completion Checklist

- [ ] Intake form received and reviewed
- [ ] Assessment type confirmed
- [ ] **Assessment mode confirmed (Baseline/Delta/Re-baseline)**
- [ ] **Prior baseline referenced (if Delta/Re-baseline mode)**
- [ ] Scope boundary agreed
- [ ] Existing documentation collected
- [ ] Key stakeholder contacts identified
- [ ] Follow-up questions documented for Phase 1
- [ ] Jira tracking issue created (if applicable)

### Sprint Budget

Once the issue moves to **In Progress**, the assessment targets completion within **10 business days** (one 2-week sprint). Time spent in Needs Info pauses the sprint clock. The analyst hour range (12-23 hrs) reflects assessment complexity: Type 1 (vendor) and simple Type 3 (infrastructure) assessments tend toward the lower end; Type 2 (application) with AI features or complex multi-vendor pipelines tend toward the upper end.

| Phase | Analyst Hours (est.) | Sprint Days (approx.) |
|-------|---------------------|----------------------|
| Phase 1: Asset & Data Flow | 2-4 hrs | Days 1-2 |
| Phase 2: Attack Surface | 2-5 hrs | Days 2-4 |
| Phase 3: Threat Analysis | 4-7 hrs | Days 4-7 |
| Phase 4: Data Population | 1-2 hrs | Day 7 |
| Phase 5: Report Generation | 2-3 hrs | Days 7-8 |
| Phase 6: Quality Review | 1-2 hrs | Days 8-9 |
| Buffer / Draft Review | — | Day 10 |
| **Total** | **~12-23 hrs** | **10 days** |

Day ranges overlap because phases can begin before the prior phase is fully complete. The buffer on day 10 accommodates draft review feedback and final polishing.

---

## Document Structure

**Deliverable Structure by Assessment Mode:**

### Baseline Mode (New System) and Re-baseline Mode

| Deliverable | Audience | Content | Baseline | Re-baseline |
|-------------|----------|---------|----------|-------------|
| **Baseline Threat Model Report** | Business decision makers | Lean 8-section report per type-specific template | ✅ | ✅ |
| **Baseline Supporting Analysis** | Security analyst (primary), technical reviewers | Full analytical work product | ✅ | ✅ |
| **Security Requirements** | Development/operations teams | ASVS 5.0-aligned requirements (**Types 2 and 3 only; not produced for Type 1**) | ✅ (Type 2/3) | ✅ (Type 2/3) |
| **Baseline Change Log** | Security architect | Document trigger and changes since prior baseline | ❌ | ✅ |
| **Archived Prior Baseline** | Security architect (reference) | Prior baseline with `.archived-YYYY-MM-DD` suffix | ❌ | ✅ |

### Delta Mode (Change to Existing System)

| Deliverable | Audience | Content |
|-------------|----------|---------|
| **Change Assessment Report** | Business decision makers | Delta-focused report — what changed, threats introduced, threats heightened, mitigating requirements for change. Includes Mermaid diagrams illustrating before/after architecture. |
| **Change Requirements** | Development/operations teams | ASVS 5.0-aligned requirements specific to the change — new requirements introduced, baseline requirements heightened |
| **Change Supporting Analysis** | Security architect | Change-specific attack tree branches, delta threat catalog, assumptions register for change |

**Note:** Delta Mode is **only available for Type 2 (Internal Application) and Type 3 (Infrastructure-Only)**. Type 1 (Vendor) assessments do not support Delta Mode; vendor changes require full Re-baseline assessment.

**Assessment Portfolio Structure:**

```text
system-name/
├── baseline-threat-model.md              (living document)
├── baseline-supporting-analysis.md       (living document)
├── baseline-requirements.md              (living document, Types 2 & 3 only)
└── changes/
    ├── YYYY-MM-DD-change-description/
    │   ├── change-assessment.md
    │   ├── change-requirements.md
    │   └── change-supporting-analysis.md
    └── YYYY-MM-DD-change-description/
        ├── change-assessment.md
        ├── change-requirements.md
        └── change-supporting-analysis.md
```text

The **Baseline** documents are living documents updated during each change assessment. The **Change** documents capture delta analysis and are retained for audit trail.

### Re-baseline Mode: Baseline Lifecycle

When Re-baseline mode is triggered (>12 months since prior baseline OR significant architectural shift):

| Action | Description |
|--------|-------------|
| **Archive Prior Baseline** | Rename existing baseline files with `.archived-YYYY-MM-DD` suffix before creating new baseline |
| **Create Change Log** | Document what triggered re-baseline and key changes since prior baseline |
| **New Baseline** | Treat as fresh Baseline Mode assessment; complete threat model replaces prior |

**Change Log Format (for Re-baseline):**
```markdown
## Baseline Change Log

| Date | Trigger | Description | Prior Baseline Ref |
|------|---------|-------------|-------------------|
| YYYY-MM-DD | [Time elapsed / Architectural shift] | [Summary of changes] | [Link to archived baseline] |
```text

### Delta Mode: Living Document Updates

In Delta Mode, the analyst updates the root baseline documents in-place:
1. Review existing baseline threats
2. Add newly introduced threats with `[Added: YYYY-MM-DD]` annotation
3. Update existing threats if heightened by change
4. Preserve historical context through annotations

### Delta Mode: Diagram Requirements

Change assessments must include **Mermaid diagrams** illustrating:
- **Before/After architecture** showing the change impact
- **Modified trust boundaries** (if any)
- **Updated data flows** for new or modified integrations

Diagrams should be included in the Change Assessment Report appendix.

**Note:** The **Threat Model Report** (Baseline or Change) is the primary deliverable. It follows the lean template structure and targets ~300-400 lines when filled. The **Supporting Analysis** contains the full analytical work product from Phases 1-3.

---

## Phase 1: Asset and Data Flow Identification

**Phase 1 of 7** | [-> Phase 2](#phase-2-attack-surface-analysis)

**Estimated Time:** 2-4 hours | **Template:** [Threat Assessment Worksheet](./reference.md#threat-assessment-worksheet-template)

### 1.1 Data Classification Assessment

**Objective:** Understand what data is at risk in the system under assessment

#### Process

**1. Inventory Data Types in Scope** *(Adopt / Extend / Create)*

**Adopt** the consumer's A4 Data Inventory as the starting point. **Extend** with additional data types discovered during assessment (new integrations, vendor subprocessors, undocumented data flows). **Create** from scratch only if A4 was left blank — document as an Intake Assumption in the Supporting Analysis.

Common data types to verify or add:

- Customer PII (names, emails, addresses, phone numbers)
- Financial data (payment information, bank details, transaction records)
- Business intelligence (strategic plans, market data, competitive information)
- Technical data (system configurations, API keys, integration details)
- Authentication data (credentials, tokens, certificates)

**2. Assess Data Sensitivity Levels**

| Level | Description | Examples |
|-------|-------------|----------|
| Critical | Regulated data, high-value IP | PII, PHI, financial data |
| High | Business confidential | Customer data, internal systems data |
| Medium | Internal operational | Non-sensitive business information |
| Low | Public information | General operational data |

**3. Document Data Volumes and Retention**

| Volume | Size |
|--------|------|
| High | >10GB |
| Medium | 1-10GB |
| Low | <1GB |

- Identify retention requirements: Legal holds, regulatory requirements
- Map data lifecycle: Creation -> Processing -> Storage -> Deletion

### 1.2 Data Flow Mapping

**Objective:** Visualize how data moves between systems to identify attack vectors

#### Methodology

**1. Identify Integration Points** *(Adopt / Extend / Create)*

**Adopt** the consumer's A5 Integration and Data Flow table and any attached data flow diagram. **Extend** with integration points discovered during assessment. **Create** from scratch only if A5 was incomplete and no diagram was attached — document as G-NNN.

Verify or add these integration types:

- API connections (REST, GraphQL, SOAP)
- File transfers (SFTP, email, cloud storage)
- Direct database connections
- Screen scraping or web portals
- Real-time streaming connections

**2. Map Data Flow Directions**

| Direction | Description |
|-----------|-------------|
| Inbound | Data flowing from external systems/services into the organization |
| Outbound | Data flowing from organizational systems to external systems/services |
| Bidirectional | Data flowing both ways |
| Third-party | External party sharing data with their vendors/subprocessors |

**3. Document Access Patterns**

- Network access methods (VPN, direct internet, private connection)
- Authentication mechanisms (SSO, API keys, certificates, shared accounts)
- Authorization levels (read-only, read-write, admin access)
- Access frequency (real-time, batch, on-demand)

### 1.3 Contextual Diagram Creation *(Adopt / Extend / Create)*

**Objective:** Produce architecture diagrams that match service criticality and reveal key attack vectors

**Adopt** consumer-provided architecture or data flow diagrams from intake Part E attachments. A hand-drawn consumer sketch is a valid starting point. **Extend** into Context/Container format by adding trust boundaries, security annotations, and threat-relevant detail, then render in mermaid. **Create** from scratch only if no diagram was attached — document as an Intake Assumption in the Supporting Analysis; analyst-created diagrams should be validated by the Technical Contact during draft review.

See the Diagram Reference section in reference.md for diagram examples and emoji reference.

**Context Diagram (recommended for all assessments):** Shows the system in scope as a single box, surrounded by its users and external systems.

**Container Diagram (recommended for business-critical+ services):** Zooms into the system boundary, showing high-level technical building blocks.

#### Simplified Validation

- Diagram complexity matches service criticality
- Key infrastructure dependencies visible with appropriate emoji
- Security boundaries clearly shown
- Failover paths represented for critical services

### Phase 1 Completion Checklist

Before proceeding to Phase 2, confirm the following are addressed:

- [ ] Data classification matrix completed for all data types
- [ ] Data flow directions documented (inbound/outbound/bidirectional)
- [ ] Context diagram created and validated
- [ ] Integration points identified and documented

---

## Phase 2: Attack Surface Analysis

**Phase 2 of 7** | [<- Phase 1](#phase-1-asset-and-data-flow-identification) | [-> Phase 3](#phase-3-threat-analysis)

Phase 2 has three type-specific variants. Follow the variant matching your declared assessment type:

- [Phase 2A: Third-Party Vendor](#phase-2a-third-party-vendor) (Type 1)
- [Phase 2B: Internal Application](#phase-2b-internal-application) (Type 2)
- [Phase 2C: Infrastructure-Only](#phase-2c-infrastructure-only) (Type 3)

> **Note:** Phase 2 variant labels (2A/2B/2C) correspond to assessment types (Type 1/Type 2/Type 3) respectively. The variant numbering reflects the Phase 2 sub-section, not the assessment type number.

---

### Phase 2A: Third-Party Vendor

**Estimated Time:** 2-3 hours

#### 1.1 Vendor Infrastructure Assessment *(Adopt / Extend / Create)*

**Objective:** Understand the vendor's technology stack and design-level security posture

**Adopt** vendor security documentation provided in intake (SOC 2 reports, security whitepapers, trust page content from intake section 1.1). **Extend** with independent research: public vulnerability history, breach reports, technology stack analysis. **Create** vendor infrastructure profile from public sources only if no vendor documentation was provided — document as G-NNN.

#### Information to Gather or Verify

**Infrastructure Architecture**

- Cloud provider (AWS, Azure, GCP, private cloud)
- Geographic locations of data centers
- Network architecture and segmentation
- Load balancing and redundancy

**Technology Stack** (recommended)

- Operating systems and versions
- Web servers and application platforms
- Database systems
- Third-party components and dependencies

**Security Controls**

- Firewalls and network security
- Endpoint protection
- Security monitoring (SIEM/SOAR)
- Vulnerability management processes

#### 1.2 Personnel Risk Surface

**Objective:** Assess human-factor risks within vendor organization

#### Assessment Areas

**Access Management**

- Number of personnel with data access
- Background check requirements
- Access provisioning/deprovisioning processes
- Privileged access management

**Organizational Structure** (recommended)

- Security team size and expertise
- Reporting relationships
- Vendor management oversight
- Subcontractor relationships

**Security Culture** (recommended)

- Security awareness training programs
- Incident reporting culture
- Security policy compliance
- Executive security sponsorship

#### 1.3 Business Continuity Surface

**Objective:** Identify threats to service availability and business operations

#### Risk Areas

**Operational Dependencies**

- Single points of failure
- Critical personnel dependencies
- Technology infrastructure dependencies
- Third-party service dependencies

**Financial Stability** (recommended)

- Revenue trends and profitability
- Funding sources and runway
- Customer concentration risk
- Market position and competition

#### 1.4 Redundancy and Failover Assessment

**Objective:** Understand business continuity mechanisms and their vulnerabilities

#### Critical for Life-Safety Services

**Provider/Carrier Redundancy Analysis** (recommended for life-safety services)

- Primary, secondary, tertiary service providers
- Geographic distribution of providers
- Shared infrastructure dependencies (BGP, DNS, CDN)
- Cross-provider failure correlation risks

**Failover Mechanism Assessment** (recommended for life-safety services)

- Automatic vs. manual failover procedures
- Failover detection timing and thresholds
- Rollback capabilities and procedures
- Testing frequency and validation methods

**Service Degradation Scenarios** (consider for critical services)

- Partial service availability during failover windows
- Performance impact during provider switching
- Data consistency during transitions
- User experience during service recovery

#### Phase 2A Completion Checklist

- [ ] Vendor infrastructure architecture documented
- [ ] Security controls inventory completed
- [ ] Personnel access management assessed
- [ ] Business continuity risks identified
- [ ] Redundancy mechanisms documented (if life-safety)

---

### Phase 2B: Internal Application

**Estimated Time:** 3-5 hours

#### 2.1 Application Architecture Review *(Adopt / Extend / Create)*

**Objective:** Understand the application's architecture, technology stack, and ownership

**Adopt** the consumer's intake section 2.1 (Architecture Overview) and 2.2 (Application Context) as the starting point. **Extend** with security-relevant observations: dependency risks, deployment pipeline gaps, environment isolation. **Create** architecture profile only if 2.1/2.2 were blank — document as G-NNN.

**Information to Verify or Extend:**

- Deployment model (cloud-native, hybrid, on-premises)
- Technology stack (languages, frameworks, databases, platforms)
- Team ownership and change velocity
- Source code repository and CI/CD pipeline
- External dependencies and vendor components

##### 2.1a Source Code as Source of Truth

For Type 2 (Internal Application) assessments, source code can be the primary artifact when intake documentation is incomplete. This subsection guides source code-based assessment.

**When Source Code is Authoritative:**

| Scenario | Code Authority Level | Intake Alternative |
|----------|---------------------|-------------------|
| No architecture documentation exists | **Primary source** | Code review replaces missing docs |
| Authentication mechanisms unclear | **Primary source** | Review auth handlers, middleware, decorators |
| Data flow paths unknown | **Primary source** | Trace from entry points to data sinks |
| API endpoints undocumented | **Primary source** | Enumerate from route definitions |
| Configuration in IaC only | **Supporting source** | Cross-reference with deployed resources |

**Analyst Approach:**

1. **Clone and Orient:** Clone the repository and identify the entry points (main.py, app.py, server.js, etc.)
2. **Map Attack Surface:** Trace request flows from HTTP handlers → business logic → data access
3. **Identify Trust Boundaries:** Note where data crosses authentication/authorization boundaries
4. **Document Dependencies:** Inventory external calls, database connections, third-party integrations
5. **Find Security-Relevant Code:** Search for keywords: `auth`, `password`, `token`, `encrypt`, `hash`, `validate`, `sanitize`

**Intake Gap Handling:**

When information is derived from code review rather than intake documentation, record as an Intake Assumption in the Supporting Analysis:

```markdown
| A-009 | No architecture documentation provided; architecture derived from code review | High | Medium | Code review: src/handlers/*.py lines 1-150 | Validate with technical contact during Phase 1 interview |
```text

**Caveats and Limitations:**

| Concern | Mitigation |
|---------|------------|
| Code ≠ Deployed Reality | Ask: "Is what I see in the repo what's running in production?" |
| Configuration Outside Repo | Check: Environment variables, external config stores, IaC templates |
| Dynamic Behavior | Note: Code shows static paths; runtime may differ (feature flags, routing) |
| Incomplete Coverage | Document: "Source code review covers /src; /legacy or /admin not reviewed" |

**Validation Steps:**

- [ ] Code review findings validated with technical contact (not just accepted as truth)
- [ ] Deployment configuration reviewed (not just application code)
- [ ] Differences between environments noted (dev vs staging vs prod)
- [ ] Assumptions documented where code was unclear or incomplete

#### 2.2 Attack Tree Threat Analysis

**Objective:** Systematically identify threats using attack trees mapped to application trust boundaries

Attack trees model how an attacker achieves their goal through various attack paths. For Type 2 (Internal Application) assessments, focus on:

- **Entry points** — Where can attackers interact with the system (APIs, web interfaces, file uploads)?
- **Trust boundaries** — Where does unauthenticated data become trusted? Where does user-controlled data enter the system?
- **Attack paths** — What sequences of vulnerabilities could lead to compromise?

See reference.md for the standard attack tree branch library (branches 6-9 for application assessments).

#### 2.3 CI/CD Pipeline and Supply Chain

**Objective:** Assess risks in the build, deployment, and dependency management pipeline

**Assessment Areas:**

- Source code repository security (branch protection, access controls)
- Build pipeline integrity (build injection, secrets in CI/CD)
- Dependency management (third-party libraries, vulnerability scanning)
- Deployment process (artifact signing, environment promotion)
- Secrets management in pipeline (API keys, credentials, tokens)

#### 2.4 Internal Team Access Analysis

**Objective:** Assess human-factor risks within the development and operations teams

**Assessment Areas:**

- Developer access to production systems and data
- Production vs. non-production environment isolation
- Code review and approval processes
- Service account inventory and privilege levels
- For multi-vendor architectures: vendor personnel access at each stage

#### 2.5 Data Pipeline Variant

**Objective:** Assess stage-to-stage integration risks in multi-vendor data pipelines

*This subsection applies when the Internal Application is a data pipeline chaining multiple SaaS vendors or systems.*

**Assessment Areas:**

- Stage-to-stage integration (authentication, authorization, data exposure per hop)
- Data amplification patterns (does data expand or replicate as it moves through stages?)
- Environment isolation (can dev/staging access production data at any stage?)
- Hop-to-hop trust boundary analysis (where does organizational control end at each stage?)
- Egress controls (encryption, access control, key management at the final output stage)

#### Phase 2 Completion Checklist

- [ ] Application architecture documented (tech stack, deployment, team)
- [ ] Attack tree analysis completed for application trust boundaries
- [ ] CI/CD pipeline and supply chain risks identified
- [ ] Internal team access analyzed (developers, operators, admins)
- [ ] Pipeline stage-to-stage risks documented (if data pipeline variant)

---

### Phase 2C: Infrastructure-Only

**Estimated Time:** 3-5 hours

*Infrastructure-Only assessments can use `scope.txt`-format infrastructure inventories as direct input.*

#### 3.1 Cloud Account Architecture *(Adopt / Extend / Create)*

**Objective:** Understand the cloud organization structure and account isolation

**Adopt** the consumer's intake section 3.1 (Infrastructure Scope) and scope.txt if attached. **Extend** with security context: account isolation assessment, cross-account trust analysis. **Create** infrastructure inventory only if 3.1 was blank and no scope.txt provided — document as G-NNN.

**Information to Verify or Extend:**

- Cloud provider(s) and account/subscription structure
- Organization hierarchy and billing boundaries
- Account isolation strategy (production, development, security, logging)
- Cross-account access patterns and trust relationships

#### 3.2 IAM and RBAC Analysis

**Objective:** Assess identity and access management architecture

**Assessment Areas:**

- Identity providers (federated SSO, local accounts, service accounts)
- Role hierarchy and privilege levels
- Service account inventory and permissions
- Cross-account role assumption patterns
- Privileged access management (break-glass procedures, just-in-time access)

#### 3.3 Network Architecture

**Objective:** Assess network segmentation and exposure

**Assessment Areas:**

- VPC design (count, purpose, peering relationships)
- Security groups and NACLs (allow/deny rules, overly permissive rules)
- VPN, Transit Gateway, and PrivateLink configurations
- Internet-facing resources (load balancers, API gateways, CDN)
- DNS configuration and certificate management

#### 3.4 Public Exposure Surface *(Adopt / Extend / Create)*

**Objective:** Assess exposure risk of internet-facing resources

**Adopt** the consumer's public IP inventory from intake section 3.1 and scope.txt if attached. **Extend** with exposure assessment: DNS analysis, certificate status, WAF presence, orphaned resource discovery. **Create** exposure inventory only if not provided — document as G-NNN.

**Assessment Areas:**

- Public IP addresses and DNS records
- Internet-facing services (web servers, APIs, databases, storage)
- CDN and WAF configuration
- Certificate validity and renewal processes
- Orphaned or forgotten resources (shadow IT)

#### 3.5 Secrets and Key Management

**Objective:** Assess how secrets, keys, and certificates are managed

**Assessment Areas:**

- Secrets manager usage (AWS Secrets Manager, HashiCorp Vault, etc.)
- KMS configuration and key rotation policies
- Certificate stores and lifecycle management
- Hardcoded credentials in IaC or configuration files
- Secrets rotation cadence and procedures

#### 3.6 Logging, Monitoring, and Detection

**Objective:** Assess the ability to detect and respond to infrastructure threats

**Assessment Areas:**

- CloudTrail configuration (all regions, all accounts, log integrity)
- VPC Flow Logs (enabled, retention, analysis)
- GuardDuty or equivalent threat detection
- SIEM integration and alerting rules
- Log retention and tamper protection

#### Phase 2C Completion Checklist

- [ ] Cloud account architecture documented
- [ ] IAM and RBAC analysis completed
- [ ] Network architecture and segmentation assessed
- [ ] Public exposure surface inventoried
- [ ] Secrets and key management reviewed
- [ ] Logging, monitoring, and detection assessed

---

## Phase 3: Threat Analysis

**Phase 3 of 7** | [<- Phase 2](#phase-2-attack-surface-analysis) | [-> Phase 4](#phase-4-data-population)

**Estimated Time:** 4-7 hours | **Template:** [Threat Assessment Worksheet](./reference.md#threat-assessment-worksheet-template)

This phase combines threat identification (attack trees), MITRE ATT&CK mapping, and risk scoring into a single analytical workflow. Reference material for this phase is in [reference.md](./reference.md).

### 3.1 Attack Tree Construction

**Objective:** Systematically identify threat vectors using attack tree methodology

**Primary Goal Definition** (select by assessment type):

| Type | Primary Goal |
|------|-------------|
| Type 1: Third-Party Vendor | "Compromise organizational data/systems through vendor relationship" |
| Type 2: Internal Application | "Compromise organizational data/functionality through application architectural weaknesses" |
| Type 3: Infrastructure-Only | "Compromise organizational infrastructure through configuration or access control weaknesses" |

#### Attack Tree Example Structure

```text
Goal: Compromise Customer PII via Vendor
├── Branch 1: Vendor Infrastructure Compromise
│   ├── 1.1 External Attack on Vendor Systems
│   │   ├── Exploit unpatched vulnerabilities
│   │   ├── Cloud misconfiguration exploitation
│   │   └── Supply chain attack
│   └── 1.2 Insider Threat
│       ├── Malicious vendor employee
│       └── Compromised vendor credentials
├── Branch 2: Integration Point Exploitation
│   ├── 2.1 API Vulnerabilities
│   │   ├── Authentication bypass
│   │   └── Injection attacks
│   └── 2.2 Data Transmission
│       ├── Man-in-the-middle attack
│       └── Certificate compromise
└── Branch 3: Business Disruption
    ├── 3.1 Service Availability
    │   ├── DDoS attacks
    │   └── Vendor outage
    └── 3.2 Data Integrity
        ├── Data corruption
        └── Unauthorized modification
```text

Assess each applicable attack tree branch for your assessment type. See [reference.md — Standard Attack Tree Branch Library](./reference.md#standard-attack-tree-branch-library) for the full branch definitions and the [Branch Applicability table](./reference.md#branch-applicability-by-assessment-type) for which branches apply to each type.

**Attack Tree Logic:** Branches represent alternative attack paths (OR logic) — the attacker can succeed via any single branch. See [attack-trees/README.md](./attack-trees/README.md#attack-tree-methodology) for gate logic details and AND gate usage.

**Worked Example:** See the [ExampleCorp Supporting Analysis](../examples/fictional-vendor-assessment/examplecorp-supporting-analysis.md#attack-tree-analysis) for a worked example.

### 3.2 MITRE ATT&CK and ATLAS Mapping

**Objective:** Map identified threats to standardized attack techniques

#### Standard Assessments (Types 1, 2, 3)

For each High-risk threat identified in the attack tree, map to the appropriate MITRE ATT&CK technique. See [reference.md — MITRE ATT&CK Technique Catalog](./reference.md#mitre-attck-technique-catalog) for the reference catalog of techniques relevant to each assessment type.

Use [technique prevalence mapping](./reference.md#technique-prevalence-mapping) to inform likelihood assessments.

#### Systems with AI Features (Type 2 or Type 3 with AI modifier)

For systems incorporating AI/ML components, use a dual-framework approach:

| Threat Category | Primary Framework | Secondary Framework |
|----------------|-------------------|---------------------|
| Infrastructure compromise (cloud, IAM, network) | MITRE ATT&CK | — |
| Application-layer attacks (authentication, APIs) | MITRE ATT&CK | — |
| AI-specific attacks (model extraction, poisoning) | MITRE ATLAS | ATT&CK (for delivery/access) |
| LLM attacks (prompt injection, jailbreaking) | MITRE ATLAS | ATT&CK (for access chain) |
| Training data attacks | MITRE ATLAS | — |

**Key MITRE ATLAS Tactics for AI Systems:**

| ATLAS Tactic | Applicable To | Example Techniques |
|--------------|---------------|---------------------|
| ML Attack Staging (AML.T0030) | All AI systems | AML.T0043 Craft Adversarial Data |
| ML Model Access (AML.T0040) | Systems with model endpoints | AML.T0044 Full ML Model Access |
| LLM Manipulation | LLM/GenAI applications | AML.T0051 LLM Prompt Injection |
| Resource Development | Supply chain attacks | AML.T0010 Acquire Public ML Model |

**Mapping Example:**

| Threat | ATT&CK Technique | ATLAS Technique |
|--------|------------------|-----------------|
| Attacker uses stolen API key to access model endpoint | T1078.004 Valid Accounts: Cloud Accounts | AML.T0044 Full ML Model Access |
| Attacker poisons training data via compromised CI/CD | T1195.002 Supply Chain Compromise | AML.T0043 Craft Adversarial Data |
| Prompt injection via web application vulnerability | T1190 Exploit Public-Facing Application | AML.T0051 LLM Prompt Injection |

### 3.3 Threat Scoring

For each identified threat, assess likelihood and impact using a qualitative High/Medium/Low scale. See [reference.md — Risk Assessment Matrix](./reference.md#risk-assessment-matrix) for the full scoring framework including factor descriptions and the risk matrix.

#### Risk Level Definitions

See [reference.md — Risk Level Definitions](./reference.md#risk-level-definitions) for complete definitions. Summary:

| Level | When to Apply | Response Timeline |
|-------|---------------|-------------------|
| **Critical** | High Likelihood × High Impact; life-safety exposure; unresolvable design vulnerability | Immediate (7 days); executive sponsorship required |
| **High** | Significant business impact, regulatory exposure, or life-safety concerns | Priority attention (30 days) |
| **Medium** | Moderate business impact, manageable operational disruption | Action within 90 days |
| **Low** | Limited impact, routine operational concerns | Regular monitoring |

### 3.4 Documentation Requirements

For each **Critical** and **High** risk, recommend documenting:

1. Threat description and attack path
2. Likelihood and impact justification
3. MITRE ATT&CK technique mapping (standard assessments)
4. MITRE ATT&CK and/or ATLAS technique mapping (systems with AI features)
5. Mitigating requirements
6. Residual risk after mitigations
7. Monitoring and detection recommendations

#### AI Feature Additional Requirements

For assessments where the AI modifier applies (Type 2 or Type 3 with AI/ML components), additionally document:

1. **Model Risk Classification** — Per [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework): Is the model "high risk" (affecting safety, rights, or critical decisions)?
2. **Adversarial Robustness Assessment** — Has the model been tested against adversarial inputs?
3. **Training Data Provenance** — Data sources, labeling methodology, and bias assessment
4. **AI Supply Chain Dependencies** — Model weights, pre-training data, third-party model cards
5. **Inference Security Controls** — Rate limiting, input validation, output filtering, prompt injection defenses
6. **AISVS Chapter Mapping** — Map mitigating requirements to [AISVS chapters](./reference.md#asvs-50-and-aisvs-chapter-reference)

### Phase 3 Completion Checklist

Before proceeding to Phase 4, confirm the following are addressed:

- [ ] All applicable attack tree branches assessed (Type 1: branches 1-5, Type 2: 1-9, Type 3: 1 + 3-5 + 10-14)
- [ ] Threats documented in Threat Assessment Worksheet
- [ ] High-risk threats mapped to MITRE ATT&CK techniques
- [ ] Likelihood and impact levels assigned (High/Medium/Low)
- [ ] Risk levels calculated (Critical/High/Medium/Low)

---

### 3.5 Regulatory Reporting Requirements (Life-Safety Systems)

For assessments involving **life-safety systems** (e.g., crisis intervention, emergency services, healthcare critical infrastructure):

**Design Vulnerability Identification:**
- Flag High-rated threats representing systemic (design) weaknesses for sector-specific reporting
- Document in Supporting Analysis: "This finding flagged for reporting under applicable sector-specific requirements"
- Report timing: Within "reasonable time" of identification

**Required Documentation:**
- Threat ID and description
- Design vulnerability category (authentication, encryption, access control, etc.)
- Discovery date
- Planned remediation
- Applicable regulatory framework reference

**Reporting Pathway:**
```text
Crisis Center discovers vulnerability → Network Administrator → Regulatory Authority (e.g., HHS for healthcare)
```text

**Reference:** Sector-specific regulatory requirements should be documented in the organization-specific canonical repository.
- [ ] AI/ML threats assessed (if applicable)

---

## Phase 4: Data Population

**Phase 4 of 7** | [<- Phase 3](#phase-3-threat-analysis) | [-> Phase 5](#phase-5-report-generation)

**Estimated Time:** 1-2 hours

**Objective:** Populate the threat catalog, findings catalog, assumptions register, and source documentation with raw data from Phase 3 analysis. This phase separates analytical population from report writing.

### 4.1 Populate Threat Catalog

Transfer threat analysis results into the Supporting Analysis document:

- [ ] Each identified threat has a T-XXX entry with description, likelihood, impact, and risk level
- [ ] High-rated threats include MITRE ATT&CK technique IDs
- [ ] AI-specific threats (if applicable) include ATLAS technique IDs

### 4.2 Populate Findings and Assumptions

- [ ] Each TM-XXX finding maps to at least one T-XXX threat
- [ ] Assumptions register populated with all unvalidated claims
- [ ] Assessment discoveries documented where intake information was corrected

### 4.3 Source Documentation

- [ ] All sources hyperlinked with confidence levels
- [ ] Findings Reference Catalog entries created for each claim
- [ ] Date of access recorded for all web sources

### Phase 4 Completion Checklist

Before proceeding to Phase 5, confirm the following are addressed:

- [ ] Threat catalog complete with all applicable branches
- [ ] Findings catalog populated with MITRE mappings
- [ ] Assumptions register includes all unvalidated claims with confidence levels
- [ ] Sources documented with hyperlinks and access dates

---

## Phase 5: Report Generation

**Phase 5 of 7** | [<- Phase 4](#phase-4-data-population) | [-> Phase 6](#phase-6-quality-review)

**Estimated Time:** 2-3 hours

### 5.1 Source Documentation

**Source Catalog:**

- All sources should be hyperlinked
- Confidence levels should be assigned (High/Medium/Low)
- Date of last review should be included

**Source Confidence Framework:**

| Confidence | Description |
|------------|-------------|
| High | Verified official documentation, direct vendor communication |
| Medium | Industry standards, third-party assessments, public documentation |
| Low | Inferred from general practices, incomplete information, assumptions |

### 5.2 Report Structure (Lean Template)

The threat model report should use the appropriate type-specific template ([1-vendor-template.md](../templates/lean-report/1-vendor-template.md), [2-application-template.md](../templates/lean-report/2-application-template.md), or [3-infrastructure-template.md](../templates/lean-report/3-infrastructure-template.md)). All templates define 7 numbered sections plus Document Control and Appendix A:

| Section | Purpose | Format |
|---------|---------|--------|
| Document Control | Version tracking, accountability | Table |
| 1. Assessment Overview | Summary of subject, risk rating, and vendor recommendation (Type 1 only) | Table |
| 2. Risk Management Summary | Critical findings and risk breakdown | Tables |
| 3. System Profile and Context | Type-specific profile: Vendor Profile (Type 1) / System Profile (Type 2) / Infrastructure Scope Overview (Type 3) and integration details | Tables + blockquote callouts |
| 4. Asset & Data Flow Analysis | Data classification, flow summary, access vectors | Tables; diagrams in Appendix A |
| 5. Top Priority Risks | High-rated threats with MITRE mappings and mitigating requirements | Single table |
| 6. Ongoing Risk Management | Mitigating requirements (Technical/Operational), monitoring | Numbered lists + tables |
| 7. Assessment Sources and Methodology | Hyperlinked sources, confidence levels | Numbered list + table |
| Appendix A: Architecture Diagrams | Context diagram (recommended), Container diagram (if business-critical+) | Mermaid code blocks |

**Report design principles:**
- Tables as the primary format — scannable, consistent
- No inline mermaid diagrams — all diagrams in Appendix A, referenced from Section 4
- No narrative paragraphs except blockquote callouts for key concerns
- Target ~300-400 lines when filled

**Full technical analysis in Supporting Analysis document:**
- Attack tree analysis (full branch structure + threat tables)
- High-rated threat detail cards (Observation / Risk / Evidence / Recommendation)
- Residual risk analysis
- Personnel access analysis
- Responsibility boundary analysis
- Assumptions register (intake assumptions, assessment discoveries)
- Findings reference catalog
- Engineering discovery questionnaire (Type 2, optional)
- Glossary

**Additional deliverable produced in Phase 5:**
- Security Requirements (Types 2/3) — per [security-requirements-template.md](../templates/security-requirements-template.md)

The **Supporting Analysis** document should conform to [supporting-analysis-template.md](../templates/supporting-analysis-template.md).

**Worked Examples:** See [ExampleCorp Threat Model](../../examples/fictional-vendor-assessment/examplecorp-threat-model.md) for a worked lean report. See [ExampleCorp Supporting Analysis](../../examples/fictional-vendor-assessment/examplecorp-supporting-analysis.md) for a supporting analysis example.

### Phase 5 Completion Checklist

Before proceeding to Phase 6, confirm the following are addressed:

- [ ] Lean report populated per appropriate type-specific template
- [ ] Supporting analysis populated per supporting-analysis-template.md, including:
  - Intake Assumptions: document unvalidated assumptions with intake sources
  - Assessment Discoveries: document significant findings from research and corrections
- [ ] All sources hyperlinked with confidence levels
- [ ] Architecture diagrams included in Appendix A

---

## Phase 6: Quality Review

**Phase 6 of 7** | [<- Phase 5](#phase-5-report-generation)

**Estimated Time:** 1-2 hours

### 6.1 Validation Checklist

**Streamlined Validation Steps:**

- [ ] Diagram complexity aligns with service criticality (Phase 1.3)
- [ ] Infrastructure components have corresponding threat analysis (Phase 2 -> Phase 3)
- [ ] Risk levels reflect actual business impact
- [ ] Threats are clearly described for business stakeholders
- [ ] Mitigating requirements are practical and actionable

### 6.2 Risk Prioritization Review

Factors for prioritization beyond risk level:

| Factor | Consideration |
|--------|---------------|
| Regulatory Impact | GDPR, HIPAA, SOX implications |
| Customer Impact | Number of customers affected |
| Competitive Impact | IP or competitive advantage loss |
| Operational Impact | Business process disruption |
| Remediation Feasibility | Ease of implementing mitigations |

### Phase 6 Completion Checklist

Before finalizing the assessment, confirm the following are addressed:

- [ ] All threats assessed using qualitative Likelihood x Impact matrix
- [ ] Risk levels assigned (High/Medium/Low)
- [ ] High risks fully documented per Phase 3.4 recommendations
- [ ] Validation checklist completed
- [ ] Section 3 uses correct assessment-type variant (vendor profile / system architecture / infrastructure scope)
- [ ] Personnel Access Analysis uses correct type variant (vendor / internal team / IAM principals)
- [ ] Security Requirements document completed (Type 2 and 3)
- [ ] Supporting Analysis includes Intake Assumptions for all unvalidated assumptions and Assessment Discoveries for corrections/new findings

---

## Feedback Loop

**Post-Sprint Activity** | Duration: 5 business days

After the assessment sprint delivers the draft report (Phase 6), a feedback loop ensures stakeholder alignment before final delivery.

### Stakeholder Review

The draft report is shared with the business owner and technical contact for review:

| Activity | Owner | Duration | Outcome |
|----------|-------|----------|---------|
| **Stakeholder Review** | Business Owner + Tech Contact | 2-3 days | Feedback on findings, risk ratings, recommendations |
| **Incorporate Feedback** | Analyst | 1-2 days | Updated report reflecting stakeholder input |
| **Risk Escalation** | Risk Manager (if needed) | 1 day | Escalation of critical/high findings requiring executive attention |

### Feedback Loop Process

1. **Share draft report** with stakeholders identified during Phase 0 scoping
2. **Collect written feedback** on findings, risk ratings, and recommendations
3. **Incorporate feedback** into the report and supporting analysis
4. **Escalate to risk managers** any critical or high findings that require executive decision-making
5. **Mark issue as Complete** when feedback is resolved

**Needs Info during Feedback Loop:** If stakeholders require significant clarification, the issue moves to Needs Info — this pauses the feedback loop clock.

---

## Cross-Cutting Requirements

The following requirements apply across all phases and should be maintained throughout the assessment process. These deliverables are included in the **Supporting Analysis** document (not the lean report). The lean report's Section 7 (Assessment Sources and Methodology) provides a summary of sources and confidence levels.

### Findings Reference Catalog

The Supporting Analysis document should include a comprehensive, hyperlinked reference catalog documenting the source of every feature, finding, and claim made about the subject(s) under assessment.

**Objective:** Ensure all assertions in the threat model are traceable to primary sources, enabling independent verification.

#### Recommendations

**1. Catalog All Vendor-Specific Findings**

For each vendor assessed, document every finding with:

| Field | Description |
|-------|-------------|
| Finding | The specific feature, certification, control, or claim being referenced |
| Source | The document, page, or publication where the information was found |
| URL | A direct, valid hyperlink to the source material |

**2. Organize by Vendor and Category**

- Group findings by vendor (primary vendor, integration partners)
- Include a separate section for regulatory and framework references
- Include a separate section for threat intelligence sources (incident reports, news articles)

**3. Validate Hyperlinks** (recommended)

- Verify all hyperlinks resolve to the intended content at the time of assessment
- Note any sources that are behind authentication, paywalls, or are otherwise not publicly accessible
- Archive critical source pages where possible (PDF snapshots or web archive links)

**4. Cross-Reference with Confidence Levels**

Each finding in the catalog should be traceable to the confidence level assigned in the Source Documentation section (High/Medium/Low).

#### Findings Reference Catalog Template

```text
### [Vendor Name]

| Finding | Source | URL | Access Date |
|---------|--------|-----|-------------|
| [Specific claim] | [Document/page name] | [https://...] | [YYYY-MM-DD] |
```text

**Worked Example:** See [ExampleCorp Findings Reference Catalog](../../examples/fictional-vendor-assessment/examplecorp-supporting-analysis.md#findings-reference-catalog) for a worked example.

### Assumptions Register

The Supporting Analysis document should include an Assumptions Register documenting every assumption made during the threat assessment, along with validation status and impact analysis.

**Objective:** Make implicit assumptions explicit so that stakeholders can validate them and understand the conditions under which the assessment's conclusions hold.

#### Recommendations

**1. Document All Assumptions**

For each assumption, record:

| Field | Description |
|-------|-------------|
| ID | Unique identifier (A-01, A-02, etc.) |
| Assumption | Clear statement of what is being assumed |
| Impact if Invalid | How the assessment conclusions would change if this assumption is wrong |
| Validation Method | How this assumption can be verified |
| Status | Validated, Unvalidated, or Invalidated |

**2. Categories of Assumptions to Capture**

- **Vendor assumptions** — Platform versions, deployment models, certifications claimed vs. verified
- **Integration assumptions** — API protocols, authentication methods, data flow directions
- **Regulatory assumptions** — Applicability of specific regulations, compliance interpretations
- **Organizational assumptions** — Customer capabilities, staffing, existing controls
- **Threat assumptions** — Incident status, threat actor capabilities, likelihood assessments
- **Data assumptions** — Types and volumes of data shared, sensitivity classifications

**3. Track Validation Status**

- Mark assumptions as **Validated** when confirmed by the customer, vendor, or primary evidence
- Mark assumptions as **Unvalidated** when verification has not been completed
- Mark assumptions as **Invalidated** when evidence contradicts the assumption (update affected findings accordingly)

**4. Review Assumptions Before Finalizing**

Before the assessment moves from Draft to Final status:
- All high-impact assumptions should be validated
- Any remaining unvalidated assumptions should be flagged in the Assessment Overview
- Invalidated assumptions should trigger a reassessment of affected findings

#### Assumptions Register Template

```text
| ID | Assumption | Impact if Invalid | Validation Method | Status |
|----|-----------|-------------------|-------------------|--------|
| A-01 | [Assumption statement] | [Impact description] | [How to verify] | Unvalidated |
```text

**Worked Example:** See [ExampleCorp Assumptions Register](../../examples/fictional-vendor-assessment/examplecorp-supporting-analysis.md#assumptions-register) for a worked example.

---

## Quality Assurance and Review

### Threat Model Review Checklist

#### Report Completeness (per type-specific lean report template)

- [ ] Document Control completed (version, date, assessor, business owner, status)
- [ ] Section 1: Assessment Overview table populated; Vendor Recommendation present and justified (Type 1 only)
- [ ] Section 2: Critical findings and risk breakdown documented
- [ ] Section 3: System profile (type-specific variant) and service integration summary populated
- [ ] Section 4: Data classification matrix, data flow summary, and access vectors documented
- [ ] Section 5: All High-rated threats listed with MITRE ATT&CK mappings and mitigating requirements
- [ ] Section 6: Mitigating requirements grouped (Technical/Operational) with monitoring points
- [ ] Section 7: All sources hyperlinked with confidence levels
- [ ] Appendix A: Context diagram included; Container diagram included if business-critical+

#### Supporting Analysis Completeness (per [supporting-analysis-template.md](../templates/supporting-analysis-template.md))

- [ ] Document Control completed
- [ ] Full attack tree analysis documented with all applicable branches
- [ ] Complete threat catalog with Likelihood, Impact, Risk Level, and MITRE mappings
- [ ] Residual risk analysis for all High threats
- [ ] Personnel access analysis assessed
- [ ] Responsibility boundary analysis defined
- [ ] Assumptions Register completed with validation status for all assumptions
- [ ] Findings Reference Catalog completed with valid hyperlinks for all claims
- [ ] Glossary included

#### Accuracy

- [ ] Risk levels reflect organizational risk tolerance
- [ ] Likelihood assessments based on credible threat intelligence
- [ ] Impact assessments align with business criticality
- [ ] Mitigating requirements are practical and effective

#### Clarity

- [ ] Threats clearly described for business audience
- [ ] Risk prioritization clearly justified
- [ ] Recommendations are actionable
- [ ] Report follows table-first format per template

### Peer Review Process

| Review Type | Reviewer | Focus |
|-------------|----------|-------|
| Technical Review | Security architect | Validates threat identification |
| Business Review | Business stakeholder | Confirms impact assessments |
| Risk Review | Risk management | Validates scoring methodology |

---

## Templates and Tools

### Threat Assessment Worksheet

See [reference.md — Threat Assessment Worksheet Template](./reference.md#threat-assessment-worksheet-template) for the worksheet template.

### Lean Report Template

See type-specific templates ([1-vendor-template.md](../templates/lean-report/1-vendor-template.md), [2-application-template.md](../templates/lean-report/2-application-template.md), [3-infrastructure-template.md](../templates/lean-report/3-infrastructure-template.md)) for the full lean report templates with placeholder guidance.

The template produces a 7-section report targeting ~300-400 lines when filled. All lean report deliverables should conform to this template structure.

### Supporting Analysis Template

See [supporting-analysis-template.md](../templates/supporting-analysis-template.md) for the full supporting analysis template with placeholder guidance.

The template covers the complete analytical work product (attack trees, threat catalog, residual risk, assumptions register, findings catalog). All supporting analysis deliverables should conform to this template structure.

### Reference Catalog

See [reference.md](./reference.md) for the full reference catalog including MITRE ATT&CK techniques, attack tree branch library, risk assessment matrix, and diagram reference.

---

## Glossary

| Term | Definition |
|------|------------|
| **BYOT** | Bring Your Own Telecom — A service model where the client owns carrier relationships while the vendor processes messages |
| **Service Border** | The boundary where vendor responsibility ends and client responsibility begins |
| **Attack Tree** | Hierarchical model showing how an attacker achieves a goal through multiple attack paths; primary threat identification method in this framework |
| **Context Diagram** | High-level architecture diagram showing the system in scope surrounded by users and external systems |
| **Container Diagram** | Architecture diagram zooming into the system boundary, showing high-level technical building blocks |
| **Assessment Type** | One of three assessment categories: Third-Party Vendor (Type 1), Internal Application (Type 2), or Infrastructure-Only (Type 3). Systems with AI features use the same types with additional ATLAS branches and AISVS requirements. |
| **ASVS** | OWASP Application Security Verification Standard — framework for defining security requirements (v5.0, May 2025) |
| **AISVS** | OWASP AI Application Security Verification Standard — security requirements for systems with AI features |
| **ATLAS** | MITRE Adversarial Threat Landscape for Artificial Intelligence Systems — framework of AI/ML-specific adversary tactics and techniques |
| **ATT&CK** | MITRE Adversarial Tactics, Techniques, and Common Knowledge — framework of cyber threat tactics and techniques |
| **CIS Benchmark** | Center for Internet Security configuration baselines for cloud platforms and operating systems |
| **Security Requirements** | ASVS-aligned document produced for Type 2 and 3 assessments, mapping threats to mitigating requirements. Systems with AI features include AISVS requirements. |
