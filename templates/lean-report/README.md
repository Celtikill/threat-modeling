# Lean Report Templates

This directory contains threat model lean report templates for each of the three assessment types defined in the framework.

## Quick Selection

| Assessment Type | Template File | When to Use |
|-----------------|---------------|-------------|
| **Type 1: Third-Party Vendor** | [`1-vendor-template.md`](./1-vendor-template.md) | Evaluating or renewing a SaaS vendor relationship |
| **Type 2: Internal Application** | [`2-application-template.md`](./2-application-template.md) | Custom app, data pipeline, internal service, or multi-vendor chain |
| **Type 3: Infrastructure-Only** | [`3-infrastructure-template.md`](./3-infrastructure-template.md) | Cloud accounts, IAM, network posture, infrastructure-as-code |

**AI modifier:** For systems with AI/ML components (inference endpoints, RAG pipelines, model training, AI agents, vector databases), use the base type template and add AI-specific attack tree branches (15-21) from the [Attack Tree Library](../../docs/attack-trees/) and AISVS security requirements.

## Template Structure

All templates follow the same 8-section structure (7 numbered sections plus Appendix A):

1. **Assessment Overview** — Key facts, risk rating, vendor recommendation (Type 1 only)
2. **Risk Management Summary** — Critical findings and risk breakdown
3. **System Profile and Context** — Type-specific profile section
4. **Asset & Data Flow Analysis** — Data classification and flows
5. **Top Priority Risks** — High-rated threats with MITRE mappings
6. **Ongoing Risk Management** — Mitigating requirements and monitoring
7. **Assessment Sources and Methodology** — Sources and confidence levels

Plus **Appendix A** for architecture diagrams.

## How to Use

1. **Determine your assessment type** using the table above or the [SOP guidance](../../docs/SOP.md#assessment-types)
2. **Open the appropriate template file**
3. **Replace all placeholder text** marked with `[brackets]`
4. **Follow the HTML comment instructions** throughout the template
5. **Delete instructional comments** before finalizing

## Key Differences by Type

### Type 1 (Vendor)
- Includes **Vendor Recommendation** field (Proceed/Proceed with Conditions/Do Not Proceed)
- Has **Company Intelligence** section for vendor profile
- Focuses on vendor-managed infrastructure

### Type 2 (Application)
- No vendor recommendation (not a go/no-go decision)
- Has **System Architecture Overview** section
- Includes code repository and deployment model
- May include multi-vendor chain analysis

### Type 3 (Infrastructure)
- No vendor recommendation (not a go/no-go decision)
- Has **Infrastructure Scope Overview** section
- Focuses on IAM, network, and configuration
- Includes resource inventory

## Legacy Template

The original combined template with all three variants is preserved as [`template.md`](./template.md) for reference, but new assessments should use the split templates above.

## Related Templates

- [Supporting Analysis Template](../supporting-analysis-template.md) — Full threat catalog, attack trees, assumptions
- [Security Requirements Template](../security-requirements-template.md) — ASVS 5.0-aligned requirements (Types 2/3 only)
- [System Profile Template](../system-profile-template.md) — Intake form for assessment requests
