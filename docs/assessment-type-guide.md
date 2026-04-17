# Assessment Type Guide

---

## Overview

The threat modeling framework supports three assessment types. When a system includes AI/ML components, additional ATLAS threat branches and AISVS security requirements apply as conditional additions within the base type.

| Type | Name | Description |
|------|------|-------------|
| **1** | Third-Party Vendor | External vendor/SaaS relationship risk |
| **2** | Internal Application | Internally-owned systems, data pipelines, custom applications |
| **3** | Infrastructure-Only | Cloud/network posture and configuration |

**AI modifier:** When the system under assessment includes AI/ML components (inference endpoints, RAG pipelines, model training, AI agents, vector databases), add AI-specific attack tree branches (15-21) and AISVS security requirements within the base type.

---

## Decision Tree

### Quick Decision Rule

> **If it involves code your team writes → Type 2.**
> **If it evaluates a vendor relationship → Type 1.**
> **If it's cloud/network configuration only → Type 3.**
> **If it uses AI/ML → same type, plus ATLAS branches and AISVS requirements.**

### Detailed Decision Flow

```text
Is it an external SaaS vendor or product being evaluated or renewed?
  └─ Yes → Type 1: Third-Party Vendor

Is it a custom-built system, internal service, or data pipeline?
  └─ Yes → Type 2: Internal Application
     (This includes multi-vendor chains — treat as 2, not 1)
     └─ Does it use AI/ML (LLMs, models, agents)?
        └─ Yes → Type 2 + AI modifier (add ATLAS branches 15-21 + AISVS)

Is it cloud infrastructure, network posture, or IaC configuration?
  └─ Yes → Type 3: Infrastructure-Only
     └─ Does it host AI/ML workloads?
        └─ Yes → Type 3 + AI modifier (add ATLAS branches 15-21 + AISVS)
```text

If none of these clearly fit, describe your system in the system profile (sections A3-A5) and the analyst will determine the right assessment type.

---

## Type Details

### Type 1: Third-Party Vendor

**When to Use:** Evaluating or renewing a vendor or SaaS product
**Examples:** ExampleCRM, ExampleDataProvider, cloud storage vendors
**Phase 2 Variant:** [Phase 2A: Third-Party Vendor](./SOP.md#phase-2a-third-party-vendor) — vendor infrastructure, personnel, business continuity
**Template:** [1-vendor-template.md](../templates/lean-report/1-vendor-template.md)

**Deliverables:**
- Lean Report (with Vendor Recommendation: Proceed / Proceed with Conditions / Do Not Proceed)
- Supporting Analysis

**Key Characteristics:**
- External entity outside organizational control
- Evaluation of vendor's security posture
- Personnel and business continuity risks assessed
- Results inform go/no-go decisions

---

### Type 2: Internal Application

**When to Use:** Assessing custom apps, data pipelines, internal services, or multi-vendor architectures
**Examples:** Financial data pipeline (ExampleERP → ExampleETL → ExampleWarehouse → ExampleTransform → ExampleFiles), internal API service
**Phase 2 Variant:** [Phase 2B: Internal Application](./SOP.md#phase-2b-internal-application) — attack tree analysis, CI/CD, team access
**Template:** [2-application-template.md](../templates/lean-report/2-application-template.md)

**Deliverables:**
- Lean Report
- Supporting Analysis
- Security Requirements (ASVS 5.0; ASVS 5.0 + AISVS if AI modifier applies)

**Key Characteristics:**
- Code your team writes or maintains
- Includes multi-vendor chains (treat as Type 2, not Type 1)
- Attack tree analysis is central to assessment
- CI/CD pipeline risks assessed

**AI Modifier (applies when system uses AI/ML):**
- Add attack tree branches 15-21 from the [Attack Tree Library](./attack-trees/)
- Include [OWASP AISVS](https://github.com/OWASP/AISVS/) requirements alongside ASVS 5.0
- Threat analysis uses both MITRE ATT&CK and [MITRE ATLAS](https://atlas.mitre.org/)
- Examples of AI modifier triggers: inference endpoints, RAG pipelines, model training, AI agents, chatbots

**Notes:**
- Data pipeline variants use pipeline-specific guidance in Phase 2.5
- Multi-vendor architectures (chained SaaS) are Type 2, not Type 1

---

### Type 3: Infrastructure-Only

**When to Use:** Assessing cloud accounts, network architecture, IAM, or public exposure
**Examples:** AWS multi-account posture review, VPC architecture assessment
**Phase 2 Variant:** [Phase 2C: Infrastructure-Only](./SOP.md#phase-2c-infrastructure-only) — IAM, network, secrets, logging
**Template:** [3-infrastructure-template.md](../templates/lean-report/3-infrastructure-template.md)

**Deliverables:**
- Lean Report
- Supporting Analysis
- Security Requirements (ASVS 5.0; ASVS 5.0 + AISVS if AI modifier applies)

**Key Characteristics:**
- Cloud/network configuration focus
- IAM privilege escalation risks
- Network lateral movement assessment
- Public exposure surface analysis

**AI Modifier (applies when infrastructure hosts AI/ML workloads):**
- Add attack tree branches 15-21 from the [Attack Tree Library](./attack-trees/)
- Include [OWASP AISVS](https://github.com/OWASP/AISVS/) requirements alongside ASVS 5.0
- Threat analysis uses both MITRE ATT&CK and [MITRE ATLAS](https://atlas.mitre.org/)
- Examples of AI modifier triggers: model serving clusters, vector databases, MLOps pipelines, training infrastructure

**Input Format:**
- Can use `scope.txt` format: AWS account IDs, public IPs, hostnames, ARNs, URLs, CIDR ranges

---

## Summary Table

| Type | Phase 2 Variant | Template | Security Requirements | AI Modifier |
|------|-----------------|----------|----------------------|-------------|
| Type 1: Third-Party Vendor | Phase 2A | 1-vendor-template.md | N/A | N/A |
| Type 2: Internal Application | Phase 2B | 2-application-template.md | ASVS 5.0 | + ATLAS branches 15-21 + AISVS |
| Type 3: Infrastructure-Only | Phase 2C | 3-infrastructure-template.md | ASVS 5.0 | + ATLAS branches 15-21 + AISVS |

---

## Cross-References

- **Consumer-facing guidance:** See [Consumer Guide](./consumer-guide.md) for requestor-oriented explanation
- **Analyst workflow:** See [SOP.md](./SOP.md) for detailed phase-by-phase guidance
- **Attack tree branches:** See [Attack Tree Library](./attack-trees/) for branch applicability by type
- **Branch selection:** See [Branch Selection Guide](./branch-selection-guide.md) for detailed selection rules
- **Intake form:** See [system-profile-template.md](../templates/system-profile-template.md) for the request form

---

*Last Updated: 2026-04-15*