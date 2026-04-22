# Lean Report Template Selection Guide

## ⚠️ DEPRECATED: Combined Template

This file previously contained the combined lean report template with all three assessment type variants embedded.

**This approach has been deprecated** in favor of **split templates** that are easier to use and less error-prone.

---

## 📝 Current Template Structure

Please use one of the following dedicated templates based on your assessment type:

### Type 1: Third-Party Vendor Assessment
**File:** [`1-vendor-template.md`](./1-vendor-template.md)

**Use when:** Evaluating or renewing a SaaS vendor relationship

**Key features:**
- Vendor Recommendation field (Proceed/Proceed with Conditions/Do Not Proceed)
- Company Intelligence section
- Focus on vendor-managed infrastructure

**Example:** [ExampleCorp vendor assessment](../../examples/fictional-vendor-assessment/examplecorp-threat-model.md)

---

### Type 2: Internal Application Assessment
**File:** [`2-application-template.md`](./2-application-template.md)

**Use when:** Assessing a custom application, data pipeline, internal service, or multi-vendor chain

**Key features:**
- System Architecture Overview section
- Code repository and deployment model fields
- Multi-vendor chain guidance

**Example:** [ExampleAnalytics pipeline assessment](../../examples/fictional-application-assessment/analyticspipeline-threat-model.md)

---

### Type 3: Infrastructure-Only Assessment
**File:** [`3-infrastructure-template.md`](./3-infrastructure-template.md)

**Use when:** Assessing cloud accounts, IAM, network posture, or infrastructure-as-code

**Key features:**
- Infrastructure Scope Overview section
- Resource inventory table
- Network architecture focus

**Example:** [ExampleCloud infrastructure assessment](../../examples/fictional-infrastructure-assessment/examplecloud-infrastructure-threat-model.md)

---

## 🎯 Quick Decision Guide

| If your assessment is about... | Use Template |
|-------------------------------|--------------|
| A SaaS vendor or product evaluation | [1-vendor-template.md](./1-vendor-template.md) |
| A custom app, data pipeline, or service | [2-application-template.md](./2-application-template.md) |
| Cloud accounts, IAM, or network posture | [3-infrastructure-template.md](./3-infrastructure-template.md) |

---

## 📋 Template Instructions

Each template includes:
1. **Document Control** — Version tracking and accountability
2. **Assessment Overview** — Key facts and risk rating
3. **Risk Management Summary** — Critical findings and breakdown
4. **System Profile and Context** — Type-specific profile section
5. **Asset & Data Flow Analysis** — Data classification and flows
6. **Top Priority Risks** — High-rated threats with MITRE mappings
7. **Ongoing Risk Management** — Mitigating requirements and monitoring
8. **Assessment Sources and Methodology** — Sources and confidence levels
9. **Appendix A** — Architecture diagrams

---

## 🛠️ Working with Templates

1. **Copy the appropriate template** to your working directory
2. **Replace all `[placeholder]` text** with actual content
3. **Delete instructional comments** (lines starting with `<!--`)
4. **Fill all required tables** — don't leave template text
5. **Add Appendix A diagrams** — at minimum, a context diagram

---

## 📚 Related Resources

- [Template README](./README.md) — Additional template guidance
- [Supporting Analysis Template](../supporting-analysis-template.md) — Full analytical work product
- [SOP Methodology](../../docs/SOP.md) — Complete assessment methodology

---

*Last updated: 2026-04-06 | Framework v4.1*
