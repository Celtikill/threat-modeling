# Attack Tree Branch Selection Guide

## Overview

This guide helps analysts select the appropriate standard attack tree branches for each assessment type. The framework defines **21 universal branches** — 14 standard branches applicable to traditional systems, plus 7 AI-specific branches for systems with AI features.

All branches are documented in the [Attack Tree Library](./attack-trees/). Select branches based on assessment type and system context.

**Quick Links:**
- [Attack Tree Hub](./attack-trees/) — Unified entry point with branch details
- [Quick Reference](./attack-trees/quick-reference.md) — Executive summary and MITRE technique mappings

---

## Quick Reference: Branch Applicability Matrix

### Standard Branches (1-14) — Traditional Systems

| Branch | Branch Name | Type 1 (Vendor) | Type 2 (Application) | Type 3 (Infrastructure) | ASVS 5.0 Chapters |
|--------|-------------|-------------|-------------------|---------------------|-------------------|
| 1 | [Vendor Infrastructure Compromise](./attack-trees/standard/branch-01-vendor-infrastructure.md) | Required | Required | Required | V11, V12, V13 |
| 2 | [Vendor Personnel Threats](./attack-trees/standard/branch-02-vendor-personnel.md) | Required | Required | Exclude | V6, V8 |
| 3 | [Integration Point Exploitation](./attack-trees/standard/branch-03-integration-points.md) | Required | Required | Required | V4, V9, V12 |
| 4 | [Vendor Business Disruption](./attack-trees/standard/branch-04-business-disruption.md) | Required | Required | Exclude | V2, V14 |
| 5 | [Infrastructure Component Compromise](./attack-trees/standard/branch-05-infrastructure-components.md) | Required | Required | Required | V11, V13 |
| 6 | [Application Layer Exploitation](./attack-trees/standard/branch-06-application-layer.md) | Exclude | Required | Exclude | V1, V2, V3 |
| 7 | [Authentication and Authorization Exploitation](./attack-trees/standard/branch-07-authentication.md) | Exclude | Required | Exclude | V6, V7, V8 |
| 8 | [CI/CD Pipeline Compromise](./attack-trees/standard/branch-08-cicd-pipeline.md) | Exclude | Conditional* | Exclude | V10, V15 |
| 9 | [Pipeline Integration Exploitation](./attack-trees/standard/branch-09-pipeline-integration.md) | Exclude | Conditional** | Exclude | V4, V5 |
| 10 | [IAM Privilege Escalation](./attack-trees/standard/branch-10-iam-privilege.md) | Exclude | Exclude | Required | V6, V8, V10 |
| 11 | [Network Lateral Movement](./attack-trees/standard/branch-11-network-lateral.md) | Exclude | Exclude | Required | V12, V13 |
| 12 | [Public Exposure Exploitation](./attack-trees/standard/branch-12-public-exposure.md) | Exclude | Exclude | Required | V3, V13 |
| 13 | [Credential and Secret Theft](./attack-trees/standard/branch-13-credential-theft.md) | Exclude | Exclude | Required | V6, V9, V11 |
| 14 | [Logging Evasion](./attack-trees/standard/branch-14-logging-evasion.md) | Exclude | Exclude | Required | V16 |

*Include Branch 8 if CI/CD pipeline is in scope
**Include Branch 9 if data pipeline is in scope

### AI-Specific Branches (15-21) — Systems with AI/ML Components

AI-specific branches apply when the system under assessment includes AI/ML components. Add these branches within Type 2 or Type 3 assessments when the AI modifier applies.

| Branch | Branch Name | Type 2 (if AI) | Type 3 (if AI) | AISVS Chapters |
|--------|-------------|:---------:|:---------:|----------------|
| 15 | [AI Training Data Poisoning](./attack-trees/ai-specific/branch-15-training-data-poisoning.md) | ✅ | ✅ | C1 |
| 16 | [AI Prompt Injection](./attack-trees/ai-specific/branch-16-prompt-injection.md) | ✅ | ➕ | C2 |
| 17 | [AI Model Extraction and Theft](./attack-trees/ai-specific/branch-17-model-extraction.md) | ✅ | ➕ | C3, C7, C11 |
| 18 | [AI Agent and Orchestration Abuse](./attack-trees/ai-specific/branch-18-agent-abuse.md) | ✅ | ❌ | C9, C10 |
| 19 | [AI Vector Database and Embedding Attacks](./attack-trees/ai-specific/branch-19-vector-database.md) | ✅ | ✅ | C8 |
| 20 | [AI Output Manipulation and Jailbreaks](./attack-trees/ai-specific/branch-20-output-manipulation.md) | ✅ | ➕ | C7, C11 |
| 21 | [AI Supply Chain and Model Poisoning](./attack-trees/ai-specific/branch-21-model-poisoning.md) | ✅ | ✅ | C3, C6 |

✅ = Required when AI modifier applies | ➕ = Conditional* | ❌ = Exclude

*Include if system exposes AI capabilities via infrastructure

---

## Branch Selection Rules

### Rule 1: Assessment Type Determines Applicable Branches

**Type 1: Third-Party Vendor:**
- Must include: Branches 1-5
- Must exclude: Branches 6-14 (not applicable to vendor assessments)
- Must exclude: Branches 15-21 (unless assessing an AI vendor)

**Type 2: Internal Application:**
- Must include: Branches 1-5, 6-7
- Conditional: Branches 8-9 (if CI/CD or data pipeline in scope)
- AI systems: Add Branches 15-21

**Type 3: Infrastructure-Only:**
- Must include: Branches 1, 3-5, 10-14
- Must exclude: Branches 2, 4, 6-9
- AI systems: Add Branches 15-21

### Rule 2: Branch Numbers Are Fixed

- Branch numbers are **universal identifiers** across all assessment types
- **Never renumber branches** for a specific assessment
- If a branch is not applicable, **exclude it** rather than renumbering remaining branches
- Branch 1 is always "Vendor Infrastructure Compromise" regardless of assessment type

### Rule 3: Branch Names Are Standard

- Use the **exact branch names** from the standard library
- Do not create custom branch names
- Map custom concepts to standard branches using sub-branches

**Example — Mapping Custom Concepts:**

❌ Incorrect: Create "Branch 4: Data Residency Violations"
✅ Correct: Use "Branch 3: Integration Point Exploitation" with sub-branch "3.3 Data Residency Control Failures"

### Rule 4: Document Exclusions

Every excluded branch must have a justification in the Excluded Branches table:

| Branch | Reason for Exclusion |
|--------|---------------------|
| Branch 6: Application Layer Exploitation | Infrastructure-only assessment; no application code in scope |
| Branch 8: CI/CD Pipeline Compromise | CI/CD infrastructure assessed separately |

### Rule 5: Threat ID Uniqueness

- Threat IDs must be **unique** within an assessment (T-001, T-002, etc.)
- Never reuse threat IDs across different branches
- Renumber if duplicates are discovered during review

❌ Incorrect: T-002 used in both Branch 2 and Branch 4
✅ Correct: T-002 (Branch 2), T-008 (Branch 4)

---

## ASVS 5.0 to Branch Mapping

Use this table to identify which branches cover which ASVS chapters:

| ASVS Chapter | ASVS Title | Primary Branch | Secondary Branches |
|--------------|------------|----------------|---------------------|
| V1 | Encoding and Sanitization | 6 | 3 |
| V2 | Validation and Business Logic | 6 | 4 |
| V3 | Web Frontend Security | 6 | 12 |
| V4 | API and Web Service | 3 | 9 |
| V5 | File Handling | 9 | — |
| V6 | Authentication | 7 | 2, 10, 13 |
| V7 | Session Management | 7 | — |
| V8 | Authorization | 7 | 2, 10 |
| V9 | Self-contained Tokens | 3 | 13 |
| V10 | OAuth and OIDC | 8 | 10 |
| V11 | Cryptography | 5 | 1, 13 |
| V12 | Secure Communication | 3 | 1, 11 |
| V13 | Configuration | 5 | 1, 11, 12 |
| V14 | Data Protection | 4 | — |
| V15 | Secure Coding | 8 | 6 |
| V16 | Security Logging | 14 | — |
| V17 | WebRTC | 3 | — |

---

## AISVS to Branch Mapping

Use this table to identify which AI branches cover which AISVS chapters:

| AISVS Chapter | AISVS Title | Primary Branch | Secondary Branches |
|---------------|-------------|----------------|---------------------|
| C1 | Training Data Integrity | 15 | 21 |
| C2 | User Input Validation | 16 | — |
| C3 | Model Lifecycle Management | 17 | 21 |
| C4 | Infrastructure Security | 1 | 5 |
| C5 | Access Control | 2 | 7, 10 |
| C6 | Supply Chain Security | 21 | — |
| C7 | Model Behavior Control | 20 | 17 |
| C8 | Memory and Embeddings | 19 | — |
| C9 | Agentic Action Security | 18 | — |
| C10 | MCP Security | 18 | — |
| C11 | Adversarial Robustness | 20 | 17 |
| C12 | Privacy Protection | 4 | — |
| C13 | Monitoring and Logging | 14 | — |
| C14 | Human Oversight | 4 | — |

---

## Branch Selection Decision Tree

```text
Start: What type of system are you assessing?
│
├─ Is it an external SaaS vendor?
│  └─ YES → Type 1: Third-Party Vendor
│     └─ Does the vendor provide AI/ML services?
│        ├─ YES → Branches 1-5 + 15-21 (if applicable)
│        └─ NO → Branches 1-5 only
│
├─ Is it a custom application or data pipeline?
│  └─ YES → Type 2: Internal Application
│     └─ Does it use AI/ML capabilities?
│        ├─ YES → Branches 1-9 + 15-21
│        └─ NO → Branches 1-9
│
├─ Is it cloud/network infrastructure?
│  └─ YES → Type 3: Infrastructure-Only
│     └─ Does it host AI/ML workloads?
│        ├─ YES → Branches 1, 3-5, 10-14 + 15-21
│        └─ NO → Branches 1, 3-5, 10-14
│
└─ Unclear?
   └─ Complete system profile and analyst will determine
```text

---

## Branch Selection Worksheet Template

Copy this worksheet into your Supporting Analysis:

```markdown
### Branch Selection Worksheet

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
```text

---

## Validation Checklist

Before finalizing branch selection, verify:

- [ ] All applicable branches for this assessment type are included
- [ ] Excluded branches are documented with justification
- [ ] Branch numbers match the standard library (1-21)
- [ ] Branch names match the standard library exactly
- [ ] No custom branch names have been created
- [ ] AI branches (15-21) are included only for systems with AI features
- [ ] ASVS/AISVS chapter mappings are documented for each applicable branch

---

*Document version: 1.0 | Aligned with ASVS 5.0 and AISVS 1.0*
