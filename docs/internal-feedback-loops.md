# Internal Feedback Loops: Integrated Architectural Discovery

---

## Overview

This document defines **integrated feedback loops** within the threat modeling framework — a lightweight mechanism where implementation-level findings (particularly from code review in Phase 2B) directly inform and update design-level threat analysis, attack trees, and requirements.

**Core Principle:** Vulnerabilities discovered during code review are not primary deliverables. They are **evidence** that validates (Reinforces), elevates severity (Elevates), or reveals gaps (Reveals) in the architectural threat model. The feedback loop ensures these observations immediately update the threat analysis, requirements, and findings catalog.

**Risk-Based Reporting:** While vulnerability enumeration is not the framework's primary purpose, **Critical and High-risk vulnerabilities are reported as findings according to their risk level.** These findings are framed as incidental discoveries that reinforce (Reinforces), elevate (Elevates), or reveal (Reveals) architectural threats and prioritize requirements. They do not stand alone—they are always threat-rooted and requirement-aligned.

**Workflow:** Code Finding → Threat Alignment (existing or new) → Risk Adjustment → Requirement Update → Documentation Refresh

---

## Feedback Loop Triggers

A feedback loop is triggered during **Phase 2B (Internal Application)** code review when:

| Trigger | Action |
|---------|--------|
| Vulnerability maps to **existing threat class** | Document as Finding; reinforce threat risk rating with evidence |
| Vulnerability represents **novel attack vector** | Add new threat class to attack tree; document as Finding |
| Vulnerability reveals **unconsidered attack surface** | Update Phase 1 data flows; add threat; document as Finding |
| Vulnerability reveals **missing control architecture** | Elevate requirement priority; document architectural gap |

**No Sprint Pause:** Documentation updates occur inline. Only truly exceptional discoveries (e.g., nation-state-level exposure, imminent active exploitation) trigger informal escalation.

---

## The Feedback Loop Flow

```
┌─────────────────────────────────────────────────────────────────────────┐
│  PHASE 2B: Code Review (ongoing)                                        │
│  └─ Vulnerability/Pattern Identified                                    │
│      │                                                                  │
│      ▼                                                                  │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │  DECISION: Novelty Assessment                                    │   │
│  │  Does this represent a new attack vector for THIS system?        │   │
│  │  (Consider: existing attack tree branches, documented flows)      │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│      │                                                                  │
│      ├── NO (Known Pattern) ──► Map to Existing Threat                  │
│      │                              ├─ Document as Finding             │
│      │                              ├─ Add evidence to threat           │
│      │                              └─ Consider risk elevation          │
│      │                                                                  │
│      └── YES (Novel Vector) ──► Create New Threat                       │
│                                     ├─ Add to attack tree              │
│                                     ├─ Complete threat analysis         │
│                                     ├─ Document as Finding             │
│                                     └─ Derive requirements              │
│                                                                          │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │  REQUIREMENT IMPACT                                              │   │
│  │  ├─ New threat → Add requirements                                │   │
│  │  ├─ Elevated threat → Elevate requirement priority               │   │
│  │  └─ Missing control → Document architectural gap                   │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│      │                                                                  │
│      ▼                                                                  │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │  DOCUMENTATION UPDATE (inline, same sprint)                        │   │
│  │  ├─ Update threats.csv                                           │   │
│  │  ├─ Update findings.csv                                          │   │
│  │  ├─ Update requirements.csv (add or elevate)                    │   │
│  │  └─ Refresh Supporting Analysis markdown                         │   │
│  └─────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Threat Alignment Decision Framework

When a vulnerability is identified in code review, assess novelty **within the context of the specific system under assessment**:

### Known Pattern (Map to Existing)

**Criteria:**
- Attack vector is documented in an existing attack tree branch for this system
- Vulnerability class matches threat already catalogued
- Location/component is within scope of existing threat

**Action:**
```markdown
**Finding:** SQL injection in user search endpoint (src/search/handlers.py:89)
**Threat Alignment:** T-007 (Injection Attacks - Branch 6.2)
**Evidence Value:** Demonstrates exploitability; supports High likelihood rating
**Requirement Impact:** Elevate V6.1 (Parameterized Queries) to Required (was Recommended)
```

### Novel Vector (Create New Threat)

**Criteria:**
- Attack vector not represented in existing attack tree branches
- New component, integration, or data flow not previously analyzed
- Unusual vulnerability class for the technology stack

**Action:**
```markdown
**Finding:** GraphQL query depth attack enables DoS (src/graphql/schema.py:45)
**Threat Alignment:** NEW - T-015 (GraphQL-Specific Resource Exhaustion)
**Attack Tree Update:** Add Branch 6.5 "GraphQL Layer Exploitation" → 6.5.1 Query Depth Attack
**Evidence Value:** First demonstration of GraphQL attack surface
**Requirement Impact:** Add new requirement: V6.8 GraphQL query depth limiting
```

### Attack Surface Expansion (Update Scope)

**Criteria:**
- Vulnerability exists in component/endpoint not documented in Phase 1
- Discovery reveals undocumented integration or data flow
- Shadow API, admin interface, or hidden functionality found

**Action:**
```markdown
**Finding:** Undocumented admin API at /api/v1/admin/reset (src/admin/handlers.py:23)
**Phase 1 Update:** Add endpoint to Section 4 Data Flow Analysis
**Threat Alignment:** NEW - T-016 (Unauthorized Admin Function Access)
**Attack Tree Update:** Add Branch 2.4 "Undocumented Endpoint Exploitation"
**Evidence Value:** Reveals expanded attack surface
**Requirement Impact:** Add V1.5 (Admin endpoint authorization review)
```

---

## Inline Documentation Updates

### During Sprint (No Pause)

All updates occur inline during the assessment sprint:

| Deliverable | Update Action |
|-------------|---------------|
| **threats.csv** | Add new threat row OR add Evidence column entry to existing threat |
| **findings.csv** | Add finding row with Threat_Ref pointing to aligned threat |
| **requirements.csv** | Add new requirement OR update Priority/Status for elevated requirement |
| **Supporting Analysis** | Update attack tree, threat catalog, assumptions register |

### Evidence Capture Format

When a vulnerability reinforces an existing threat, capture in threats.csv:

```csv
Threat_ID,Category,Description,Likelihood,Impact,Risk_Level,MITRE_TECHNIQUE,Evidence_From_Code_Review
T-007,Injection,SQL injection via unsanitized user input,High,High,High,T1190,"Finding F-003: src/search/handlers.py:89 uses string concatenation"
```

When creating a new threat from code review:

```csv
Threat_ID,Category,Description,Likelihood,Impact,Risk_Level,MITRE_TECHNIQUE,Evidence_From_Code_Review,Source_Discovery
T-015,Resource Exhaustion,GraphQL query depth attack causing DoS,Medium,High,High,T1499,"Finding F-007: src/graphql/schema.py:45 no depth limiting","Phase 2B code review - novel vector"
```

---

## Requirement Elevation and Addition

### Elevating Existing Requirements

When vulnerability demonstrates threat is more severe than initially assessed:

| Original Priority | Finding Severity | New Priority |
|-------------------|------------------|--------------|
| Optional | High/Critical | Required |
| Recommended | High/Critical | Required |
| Required | Critical | Required (add urgent flag) |

**Documentation:** Update requirements.csv Priority column; add Elevation_Reason note.

### Adding New Requirements

When novel threat requires new control:

1. Derive requirement from threat (standard ASVS/AISVS mapping)
2. Add to requirements.csv with Phase 4 (Data Population)
3. Reference in Security Requirements deliverable
4. Mark Source as "Phase 2B Discovery: [Finding_ID]"

---

## Exceptional Escalation

Only truly exceptional findings warrant informal sprint escalation:

| Severity | Example | Escalation |
|----------|---------|------------|
| **Critical + Active Exploitation** | Live admin panel with default creds, publicly exposed | Immediate stakeholder notification |
| **Critical + Imminent Disclosure** | Finding will be publicly disclosed before sprint ends | Risk manager heads-up |
| **Systemic Architectural Failure** | Entire authentication layer bypassable | May trigger Re-baseline mode discussion |

**Standard Process:** All other findings follow inline documentation workflow.

---

## Cross-References

| Topic | Reference |
|-------|-----------|
| Assessment methodology | [SOP.md](./SOP.md) |
| Phase 2B code review | [SOP.md Phase 2B](./SOP.md#phase-2b-internal-application) |
| CSV templates | [templates/csv/README.md](../templates/csv/README.md) |
| Attack tree branches | [attack-trees/README.md](./attack-trees/README.md) |

---

## Summary

**Integrated feedback loops** treat code review findings as architectural evidence:

1. **Findings reinforce threats (Reinforces)** — Vulns demonstrate exploitability and support risk ratings
2. **Findings elevate threats (Elevates)** — Evidence demonstrates a threat is more severe than initially assessed
3. **Findings reveal gaps (Reveals)** — Uncatalogued attack surfaces, components, or data flows are added to the threat model
4. **Requirements adapt** — New requirements added, existing ones elevated based on evidence
5. **No process pause** — Updates occur inline during sprint
6. **Architecture first** — Threats and requirements are primary; findings are supporting evidence

This maintains the framework's architectural focus while ensuring implementation-level observations directly inform the design-level security model.

---

*Last Updated: 2026-04-22*
