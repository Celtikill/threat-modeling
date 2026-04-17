# Attack Tree Navigation Guide

Find the right attack tree branches for your assessment type or role.

---

## By Assessment Type

| Assessment Type | Description | Applicable Branches | Quick Link |
|-----------------|-------------|---------------------|------------|
| **Type 1** | Third-Party Vendor | 1-5 | [Details](#type-1-vendor-assessment) |
| **Type 2** | Internal Application | 1-9 (+ 15-21 if AI) | [Details](#type-2-application-assessment) |
| **Type 3** | Infrastructure-Only | 1, 3-5, 10-14 (+ 15-21 if AI) | [Details](#type-3-infrastructure-assessment) |

**AI modifier:** When the system under assessment includes AI/ML components, add AI-specific branches (15-21) within the base type.

### Type 1: Vendor Assessment
**Focus:** Evaluating external SaaS vendors, service providers.

| Branch | Name | Risk | Business Impact |
|--------|------|:----:|-----------------|
| 1 | [Vendor Infrastructure](./standard/branch-01-vendor-infrastructure.md) | M | Supply chain attack |
| 2 | [Vendor Personnel](./standard/branch-02-vendor-personnel.md) | H | Insider threat, credential abuse |
| 3 | [Integration Points](./standard/branch-03-integration-points.md) | H | Data interception, API abuse |
| 4 | [Business Disruption](./standard/branch-04-business-disruption.md) | M | Service unavailability |
| 5 | [Infrastructure Components](./standard/branch-05-infrastructure-components.md) | H | Infrastructure failure |

**Key Questions:**
1. Vendor security posture (SOC 2, certifications)?
2. Data flow between organization and vendor?
3. Integration points (APIs, network connections)?
4. Incident response capability?
5. Recovery plan if vendor becomes unavailable?

### Type 2: Application Assessment
**Focus:** Custom applications, data pipelines, internal services.

| Branch | Name | Risk | ASVS |
|--------|------|:----:|------|
| 1-5 | Core vendor/infrastructure branches | Varies | V2, V4, V6, V8, V11-14 |
| 6 | [Application Layer](./standard/branch-06-application-layer.md) | H | V1-V3 |
| 7 | [Auth/Authz](./standard/branch-07-authentication.md) | H | V6-V8 |
| 8 | [CI/CD Pipeline](./standard/branch-08-cicd-pipeline.md) | M* | V10, V15 |
| 9 | [Pipeline Integration](./standard/branch-09-pipeline-integration.md) | M* | V4, V5 |

*Include 8 if CI/CD in scope; 9 if data pipeline in scope

**AI Modifier (if system uses AI/ML):** Add branches 15-21:

| Branch | Name | Risk | AISVS |
|--------|------|:----:|-------|
| 15 | [Training Data Poisoning](./ai-specific/branch-15-training-data-poisoning.md) | H | C1, C21 |
| 16 | [Prompt Injection](./ai-specific/branch-16-prompt-injection.md) | H | C2 |
| 17 | [Model Extraction](./ai-specific/branch-17-model-extraction.md) | M | C3, C7, C11 |
| 18 | [Agent Abuse](./ai-specific/branch-18-agent-abuse.md) | H | C9, C10 |
| 19 | [Vector DB Attacks](./ai-specific/branch-19-vector-database.md) | M | C8 |
| 20 | [Output Manipulation](./ai-specific/branch-20-output-manipulation.md) | H | C7, C11 |
| 21 | [AI Supply Chain](./ai-specific/branch-21-model-poisoning.md) | H | C3, C6 |

### Type 3: Infrastructure Assessment
**Focus:** Cloud accounts, IAM, network architecture.

| Branch | Name | Risk | ASVS |
|--------|------|:----:|------|
| 1 | [Vendor Infrastructure](./standard/branch-01-vendor-infrastructure.md) | M | V11-13 |
| 3 | [Integration Points](./standard/branch-03-integration-points.md) | H | V4, V9, V12 |
| 4 | [Business Disruption](./standard/branch-04-business-disruption.md) | M | V2, V14 |
| 5 | [Infrastructure Components](./standard/branch-05-infrastructure-components.md) | H | V11, V13 |
| 10 | [IAM Privilege](./standard/branch-10-iam-privilege.md) | H | V6, V8, V10 |
| 11 | [Network Lateral](./standard/branch-11-network-lateral.md) | M | V12, V13 |
| 12 | [Public Exposure](./standard/branch-12-public-exposure.md) | H | V3, V13 |
| 13 | [Credential Theft](./standard/branch-13-credential-theft.md) | H | V6, V9, V11 |
| 14 | [Logging Evasion](./standard/branch-14-logging-evasion.md) | M | V16 |

**AI Modifier (if infrastructure hosts AI workloads):** Add branches 15-21 (conditional):

| Branch | Condition |
|--------|-----------|
| 15 | If hosting training pipelines |
| 16 | If exposing LLM APIs |
| 17 | If serving proprietary models |
| 18 | If supporting AI agents (typically excluded for infrastructure-only) |
| 19 | If hosting vector stores |
| 20 | If exposing AI outputs |
| 21 | If using external AI models |

---

## By Role

### CISO / Executive View
**Entry Point:** Risk heat map and business impact

**High-Priority Categories:**
| Category | Branches | Risk | Business Impact |
|----------|----------|:----:|-----------------|
| Credential Compromise | 2, 7, 10, 13 | High | Unauthorized access, data breach |
| Application Exploitation | 6, 7 | High | Data exposure, compliance violations |
| Infrastructure Exposure | 12, 13 | High | Public data breach |
| AI-Specific Threats | 15-21 | High | Model theft, IP loss |

**Key Leadership Questions:**
- Vendor compromise resilience? → Branches 1, 4, 5
- Credential-based attack exposure? → Branches 2, 7, 10, 13
- AI/ML attack surface? → Branches 15-21
- Integration point security? → Branches 3, 9

### Security Analyst View
**Entry Point:** Technique-focused navigation

**Technique → Branch Mapping:**
- T1078 Valid Accounts → Branches 2, 7, 10, 13
- T1190 Exploit Public-Facing App → Branches 1, 3, 6, 12
- T1566 Phishing → Branch 2
- AML.T0051 Prompt Injection → Branches 16, 20

See [Quick Reference](./quick-reference.md) for complete MITRE mapping.

### Compliance Officer View
**Entry Point:** Framework-aligned navigation

**ASVS → Branch Mapping:**
| Chapter | Primary Branches |
|---------|------------------|
| V6 (Authentication) | 2, 7, 10, 13 |
| V8 (Authorization) | 7, 10 |
| V14 (Data Protection) | 4 |
| V16 (Logging) | 14 |

**AISVS → Branch Mapping:**
| Chapter | Primary Branches |
|---------|------------------|
| C1 (Training Data) | 15, 21 |
| C2 (Input Validation) | 16 |
| C7 (Model Behavior) | 20, 17 |

### Product Manager View
**Entry Point:** System component-aligned

**By Component:**
- **Authentication System** → Branches 7, 10, 13
- **Data Pipeline** → Branches 3, 9, 4
- **Cloud Infrastructure** → Branches 10, 11, 12, 13, 14
- **AI/ML Features** → Branches 15-21
- **Third-Party Integrations** → Branches 1, 2, 3

---

## Decision Tree

```text
Start: What type of system are you assessing?
│
├─ External SaaS vendor?
│  └─ YES → Type 1: Third-Party Vendor (Branches 1-5)
│
├─ Custom application or data pipeline?
│  └─ YES → Type 2: Internal Application (Branches 1-9)
│     └─ AI/ML capabilities?
│        ├─ YES → Add Branches 15-21 (+ AISVS)
│        └─ NO → Standard branches only
│
├─ Cloud/network infrastructure?
│  └─ YES → Type 3: Infrastructure-Only (Branches 1, 3-5, 10-14)
│     └─ Hosts AI workloads?
│        ├─ YES → Add Branches 15-21 conditional (+ AISVS)
│        └─ NO → Standard branches only
│
└─ Unclear?
   └─ Complete system profile; analyst will determine
```text

---

## Branch Selection Worksheet

| Branch | Type 1 | Type 2 | Type 2 (if AI) | Type 3 | Type 3 (if AI) |
|--------|:------:|:------:|:--------------:|:------:|:--------------:|
| 1 | ✅ | ✅ | ✅ | ✅ | ✅ |
| 2 | ✅ | ✅ | ✅ | ❌ | ❌ |
| 3 | ✅ | ✅ | ✅ | ✅ | ✅ |
| 4 | ✅ | ✅ | ✅ | ❌ | ❌ |
| 5 | ✅ | ✅ | ✅ | ✅ | ✅ |
| 6 | ❌ | ✅ | ✅ | ❌ | ❌ |
| 7 | ❌ | ✅ | ✅ | ❌ | ❌ |
| 8 | ❌ | ➕ | ➕ | ❌ | ❌ |
| 9 | ❌ | ➕ | ➕ | ❌ | ❌ |
| 10 | ❌ | ❌ | ❌ | ✅ | ✅ |
| 11 | ❌ | ❌ | ❌ | ✅ | ✅ |
| 12 | ❌ | ❌ | ❌ | ✅ | ✅ |
| 13 | ❌ | ❌ | ❌ | ✅ | ✅ |
| 14 | ❌ | ❌ | ❌ | ✅ | ✅ |
| 15 | ❌ | ❌ | ✅ | ❌ | ✅ |
| 16 | ❌ | ❌ | ✅ | ❌ | ➕ |
| 17 | ❌ | ❌ | ✅ | ❌ | ➕ |
| 18 | ❌ | ❌ | ✅ | ❌ | ❌ |
| 19 | ❌ | ❌ | ✅ | ❌ | ✅ |
| 20 | ❌ | ❌ | ✅ | ❌ | ➕ |
| 21 | ❌ | ❌ | ✅ | ❌ | ✅ |

**Legend:** ✅ = Required | ➕ = Conditional | ❌ = Not applicable

---

## See Also

- [Attack Tree Hub](./README.md) — Main attack tree documentation
- [Quick Reference](./quick-reference.md) — Condensed branch summary
- [Branch Selection Guide](../branch-selection-guide.md) — Detailed ASVS/AISVS mappings