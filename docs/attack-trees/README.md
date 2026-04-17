# Attack Tree Library

A collection of attack trees for threat model assessments.

## Overview

- **Branches 1-14**: Standard threats (vendor, application, infrastructure)
- **Branches 15-21**: AI-specific threats (ML, LLM, agents)

## Attack Tree Methodology

This library follows [attack tree methodology](https://www.schneier.com/academic/archives/1999/12/attack_trees.html) for systematic threat identification.

### Gate Logic

Attack trees use two fundamental gate types to model attacker paths:

| Gate | Symbol | Meaning | Attacker Perspective |
|------|--------|---------|-------------------|
| **OR** | ∨ | Attacker can succeed via **any** child path | Easier — multiple options available |
| **AND** | ∧ | Attacker must succeed at **all** children | Harder — multiple requirements must be met |

### Default Logic in This Library

The hierarchical branch structure uses **OR logic by default**:
- Each branch represents an alternative attack path
- The attacker needs to succeed at only one branch to achieve the goal
- Sub-branches within a branch are also OR conditions

**Example:** Branch 1 (Vendor Infrastructure) OR Branch 2 (Vendor Personnel) OR Branch 3 (Integration Points) — the attacker can choose any path.

### When AND Gates Apply

AND gates are used when an attacker must satisfy multiple conditions simultaneously:
- **Sequential attacks:** Must breach perimeter AND escalate privileges AND access database
- **Multi-factor bypass:** Must compromise password AND bypass MFA
- **Compound conditions:** Multiple security controls must be defeated together

AND gates are documented explicitly in branch files when they occur.

### Relationship to Risk Matrix

**Important distinction:** Attack tree gates differ from the risk matrix used in threat scoring. See [reference.md line 356](../reference.md#risk-assessment-matrix) for the critical distinction:
- **Attack tree AND:** Attacker must satisfy multiple conditions (makes attack harder)
- **Risk matrix:** Critical risk = High Likelihood × High Impact (conjunction of two independent dimensions)

## Quick Start

| If you are... | Start here |
|---------------|------------|
| **Security Analyst** | [Navigation Guide](./navigation-guide.md) — Assessment types with MITRE techniques |
| **CISO/Executive** | [Quick Reference](./quick-reference.md) — Risk heat map and business impact |
| **Compliance Officer** | [Navigation Guide](./navigation-guide.md#compliance-officer-view) — ASVS/AISVS alignment |
| **Product Manager** | [Navigation Guide](./navigation-guide.md#product-manager-view) — Component-aligned threats |

## Branch Matrix

### Standard Branches (1-14)

| # | Branch | Type 1 | Type 2 | Type 3 | Risk |
|---|--------|:------:|:------:|:------:|:----:|
| 1 | [Vendor Infrastructure](./standard/branch-01-vendor-infrastructure.md) | ✅ | ✅ | ✅ | M |
| 2 | [Vendor Personnel](./standard/branch-02-vendor-personnel.md) | ✅ | ✅ | ❌ | H |
| 3 | [Integration Points](./standard/branch-03-integration-points.md) | ✅ | ✅ | ✅ | H |
| 4 | [Business Disruption](./standard/branch-04-business-disruption.md) | ✅ | ✅ | ❌ | M |
| 5 | [Infrastructure Components](./standard/branch-05-infrastructure-components.md) | ✅ | ✅ | ✅ | H |
| 6 | [Application Layer](./standard/branch-06-application-layer.md) | ❌ | ✅ | ❌ | H |
| 7 | [Auth/Authz](./standard/branch-07-authentication.md) | ❌ | ✅ | ❌ | H |
| 8 | [CI/CD Pipeline](./standard/branch-08-cicd-pipeline.md) | ❌ | ➕ | ❌ | M |
| 9 | [Pipeline Integration](./standard/branch-09-pipeline-integration.md) | ❌ | ➕ | ❌ | M |
| 10 | [IAM Privilege](./standard/branch-10-iam-privilege.md) | ❌ | ❌ | ✅ | H |
| 11 | [Network Lateral](./standard/branch-11-network-lateral.md) | ❌ | ❌ | ✅ | M |
| 12 | [Public Exposure](./standard/branch-12-public-exposure.md) | ❌ | ❌ | ✅ | H |
| 13 | [Credential Theft](./standard/branch-13-credential-theft.md) | ❌ | ❌ | ✅ | H |
| 14 | [Logging Evasion](./standard/branch-14-logging-evasion.md) | ❌ | ❌ | ✅ | M |

### AI-Specific Branches (15-21)

AI-specific branches apply when the system under assessment includes AI/ML components. Add these branches within Type 2 or Type 3 assessments when the AI modifier applies.

| # | Branch | Type 2 (if AI) | Type 3 (if AI) | Risk |
|---|--------|:---------:|:---------:|:----:|
| 15 | [AI Training Poisoning](./ai-specific/branch-15-training-data-poisoning.md) | ✅ | ✅ | H |
| 16 | [AI Prompt Injection](./ai-specific/branch-16-prompt-injection.md) | ✅ | ➕ | H |
| 17 | [AI Model Extraction](./ai-specific/branch-17-model-extraction.md) | ✅ | ➕ | M |
| 18 | [AI Agent Abuse](./ai-specific/branch-18-agent-abuse.md) | ✅ | ❌ | H |
| 19 | [AI Vector DB](./ai-specific/branch-19-vector-database.md) | ✅ | ✅ | M |
| 20 | [AI Output Manipulation](./ai-specific/branch-20-output-manipulation.md) | ✅ | ➕ | H |
| 21 | [AI Supply Chain](./ai-specific/branch-21-model-poisoning.md) | ✅ | ✅ | H |

**Legend:** ✅ = Required | ➕ = Conditional | H/M/L = Risk level

**AI Modifier:** When a Type 2 or Type 3 assessment involves systems with AI/ML components (inference endpoints, RAG pipelines, model training, AI agents, vector databases), add branches 15-21 as applicable. See [Assessment Type Guide](../assessment-type-guide.md) for type selection.

## High-Risk Branches (Priority)

**Credential-Based:** 2, 7, 10, 13  
**Application:** 6  
**Infrastructure:** 12  
**AI-Specific:** 15, 16, 18, 20, 21

## Documentation

- [Navigation Guide](./navigation-guide.md) — Assessment types and role-based views
- [Quick Reference](./quick-reference.md) — Risk summaries and MITRE mappings
- [Branch Selection Guide](../branch-selection-guide.md) — Selection rules

Each branch file includes YAML frontmatter for programmatic access:

```yaml
---
branch_number: 6
assessment_types: ["Type 2"]
risk_level: "High"
mitre_techniques: ["T1190", "T1059"]
---
```
