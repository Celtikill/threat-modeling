# Three-Repository Architecture

This document explains the relationship between the threat modeling repositories and how data flows between them.

## Overview

The threat modeling framework is distributed across three repositories with different access levels and purposes:

```text
┌─────────────────────────────────────────────────────────┐
│  celtikill/threat-modeling (This Repo - Public)         │
│  ├── Generic framework, templates, methodology          │
│  ├── Fictional examples for demonstration               │
│  └── Open source - reusable by anyone                   │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼ references framework
┌─────────────────────────────────────────────────────────┐
│  [organization]/threat-modeling-canonical (Org Documentation)   │
│  ├── Organization-specific SOPs and guides              │
│  ├── Wiki content for Confluence                        │
│  └── Regulatory position papers (if applicable)         │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼ references both
┌─────────────────────────────────────────────────────────┐
│  [organization]/threat-modeling-assessment (Private/Restricted) │
│  ├── Actual assessment deliverables                     │
│  ├── Vendor security reviews                            │
│  └── Confidential analysis                              │
└─────────────────────────────────────────────────────────┘
```text

## Repository Purposes

### 1. celtikill/threat-modeling (Public Framework)

**Purpose:** Generic, reusable threat modeling framework

**Contains:**
- Assessment methodology (SOP)
- Generic templates (lean reports, supporting analysis, security requirements)
- MITRE/OWASP reference catalogs
- Fictional example assessments
- Build tools and scripts

**Access:** Public (open source)

**Use Case:** Anyone can fork, adapt, and use this framework for their own threat modeling practice.

### 2. [organization]/threat-modeling-canonical (Organization Documentation)

**Purpose:** Organization-specific documentation and guides

**Contains:**
- Adapted SOPs with organization context
- Wiki content formatted for internal Confluence
- Consumer guides with organization-specific FAQ
- Regulatory position papers (if applicable)

**Access:** Organization-wide (members only)

**Use Case:** Internal teams reference this for organization-specific procedures and documentation.

### 3. [organization]/threat-modeling-assessment (Confidential Deliverables)

**Purpose:** Actual assessment deliverables

**Contains:**
- Real threat model assessments
- Vendor security reviews
- Supporting analysis with actual data
- Security requirements for real systems

**Access:** Restricted (security team only)

**Use Case:** Security architects create and store confidential assessments here.

## Data Flow

### Framework Development

1. Generic framework developed in `celtikill/threat-modeling`
2. Organization adapts framework in `[organization]/threat-modeling-canonical`
3. Security team conducts assessments per organization SOPs

### Assessment Creation

1. **Intake** (canonical repo) — Organization-specific intake forms
2. **Assessment** (assessment repo) — Actual deliverables created
3. **Templates** (framework repo) — Generic templates inform structure

### Publishing Workflow

```text
Assessment (Private) → Summary (Canonical) → Wiki (Org-wide)
     │                        │                      │
     │                        │                      ▼
     │                        ▼              [Confluence/Internal]
     │              [Org Documentation]
     ▼
[Confidential Details]
```text

## Repository Relationships

### Upstream → Downstream

| From | To | Relationship |
|------|----|--------------|
| `celtikill/threat-modeling` | `[organization]/threat-modeling-canonical` | Framework is adapted for organization use |
| `celtikill/threat-modeling` | `[organization]/threat-modeling-assessment` | Templates are instantiated for real assessments |
| `[organization]/threat-modeling-canonical` | `[organization]/threat-modeling-assessment` | Org SOPs guide assessment work |

### Cross-References

When working across repositories:

- **Framework → Assessment:** Reference template structure, not content
- **Assessment → Framework:** Base structure on generic templates
- **Canonical → Framework:** Document adaptations made

## Separation of Concerns

### What Goes Where

| Content Type | Repository | Reason |
|--------------|------------|--------|
| Generic methodology | `celtikill/threat-modeling` | Reusable by anyone |
| Organization adaptations | `[organization]/threat-modeling-canonical` | Org-specific |
| Real assessment data | `[organization]/threat-modeling-assessment` | Confidential |
| Fictional examples | `celtikill/threat-modeling` | Demonstration only |
| PHI/PII data | `[organization]/threat-modeling-assessment` | Privacy protection |
| Vendor recommendations | `[organization]/threat-modeling-assessment` | Business sensitive |

## Access Control

| Repository | Read Access | Write Access |
|------------|-------------|--------------|
| `celtikill/threat-modeling` | Public | Maintainers |
| `[organization]/threat-modeling-canonical` | Org members | Security team |
| `[organization]/threat-modeling-assessment` | Security architects | Lead architects |

## Contributing Across Repositories

### From Framework to Organization

When updating the public framework:

1. Update generic templates in `celtikill/threat-modeling`
2. Notify organization to review adaptations in `[organization]/threat-modeling-canonical`
3. Organization decides whether to adopt changes

### From Organization to Framework

When organization improvements could benefit the public:

1. Extract generic concepts from organization-specific content
2. Contribute back to `celtikill/threat-modeling` via PR
3. Ensure no confidential data is included

## Migration Notes

When moving content between repositories:

1. **To Public Framework:**
   - Remove all organization references
   - Generalize all examples
   - Replace real data with placeholders
   - Ensure no credentials or infrastructure details

2. **To Assessment Repo:**
   - Maintain full context
   - Preserve all source documentation
   - Keep links to canonical organization docs

3. **To Canonical Repo:**
   - Reference public framework for methodology
   - Add organization-specific context
   - Include regulatory requirements

## Why Three Repositories?

This architecture was chosen over two common alternatives:

### Alternative: Monorepo

A single repository containing framework, organization adaptations, and assessments.

**Why not monorepo:**
- Access control granularity is coarse — public framework files would sit alongside confidential assessments
- Accidental exposure risk increases with a larger blast radius
- Release management is complicated — framework versioning and assessment delivery timelines differ
- Organization-specific content cannot be kept private while publishing the generic framework publicly

### Alternative: Two-Repo (Framework + Private)

A public framework repo and a single private repo combining canonical documentation with assessments.

**Why not two-repo:**
- Merging organization-wide documentation (canonical) with restricted deliverables (assessments) creates access control conflicts
- Security architects need access to assessments, but broader organization members need canonical docs without seeing confidential findings
- No clear boundary between "organization-wide reference" and "restricted deliverable" — the canonical repo serves a different audience than the assessment repo

### Why Three Repositories Works

The three-repo model enforces separation by **audience and access level**:
- **Public** (framework): Anyone, anywhere — no confidential content
- **Organization-wide** (canonical): Internal teams — no client-specific findings
- **Restricted** (assessment): Security architects only — confidential findings

This separation makes content boundary enforcement explicit rather than relying on directory-level permissions within a monorepo.

## Summary

The three-repository architecture provides:

- **Reusability:** Public framework can be used by any organization
- **Privacy:** Confidential assessments remain restricted
- **Adaptation:** Organizations customize framework to their needs
- **Traceability:** Clear lineage from generic framework to specific assessments

---

*This architecture ensures appropriate access controls while enabling framework reuse and improvement.*
