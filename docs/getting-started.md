# Getting Started with Threat Modeling

Welcome! This guide will help you get up and running with the threat modeling framework.

## For Security Analysts

### Getting Oriented (60-90 minutes)

**Minutes 0-15: Understand the Framework**
- Review the [README](../README.md) repository overview (5 min)
- Read the [Assessment Type Guide](assessment-type-guide.md) for type selection (5 min)

**Minutes 15-45: See an Example**
- Open a complete example assessment:
  - [Type 1: Vendor Assessment](../examples/fictional-vendor-assessment/examplecorp-threat-model.md)
  - [Type 2: Application Assessment](../examples/fictional-application-assessment/analyticspipeline-threat-model.md)
  - [Type 3: Infrastructure Assessment](../examples/fictional-infrastructure-assessment/examplecloud-infrastructure-threat-model.md)
- Review both the lean report AND the supporting analysis

**Minutes 45-90: Try It Yourself**
- Pick a fictional scenario (make up a vendor or system)
- Walk through the [SOP phases](../docs/SOP.md) using the example as a guide
- Use the [reference catalog](reference.md) for MITRE ATT&CK techniques
- For systems with AI features, also reference MITRE ATLAS (AI-specific threats) and OWASP AISVS (AI security requirements) as conditional additions

### Your First Assessment

#### Before You Start

1. **Confirm the assessment type**

   For the complete decision tree and type definitions, see the [Assessment Type Guide](./assessment-type-guide.md).

   - Vendor evaluation → **Type 1**
   - Internal application/pipeline → **Type 2**
   - Cloud infrastructure → **Type 3**
   - If the system uses AI/ML (LLMs, models, agents, vector databases) → same type, plus ATLAS branches and AISVS requirements

2. **Review the system profile** (if provided)
   - Requestor should complete [system profile template](../templates/system-profile-template.md)
   - Identify Required vs Important field gaps

3. **Gather your tools**
   - Reference catalog (for MITRE techniques)
   - Attack tree branches (from reference.md)
   - Template for your assessment type
   - If system has AI features: MITRE ATLAS (AI-specific threats) and OWASP AISVS (AI security requirements) as conditional additions to the base type

#### During Assessment

**Phase 1: Asset & Data Flow** (Days 1-2)
- Identify what data is at risk
- Map data flows and trust boundaries
- Document assumptions if intake is incomplete

**Phase 2: Attack Surface** (Days 2-4)
- Research vendor/system infrastructure
- Identify integration points and access vectors
- Select applicable attack tree branches

**Phase 3: Threat Analysis** (Days 4-7)
- Build attack trees
- Map threats to MITRE ATT&CK (standard) or ATT&CK + ATLAS (if system has AI features)
- Score with Likelihood × Impact matrix

**Phase 4: Data Population** (Day 7)
- Populate threat catalog, findings catalog, and assumptions register with raw data from Phase 3

**Phase 5: Report Generation** (Days 7-8)
- Populate lean report template
- Create supporting analysis
- Document sources in findings catalog

**Phase 6: Quality Review** (Days 8-10)
- Verify all High threats have MITRE mappings
- Check source hyperlinks work
- Validate cross-document consistency

After the sprint, a **Feedback Loop** of up to 5 business days allows stakeholders to review the draft, provide feedback, and escalate risks.

### Common Pitfalls

| Pitfall | How to Avoid |
|---------|--------------|
| Creating findings without threat roots | Every TM-XXX must map to T-XXX |
| Using RFC 2119 keywords in lean report | Use advisory language (recommend/consider) in lean report; save MUST/SHOULD for security requirements |
| Forgetting Appendix A diagrams | Always include context diagram; container diagram if business-critical+ |
| Incomplete source attribution | Every claim needs a hyperlink or assumption flag |

### Need Help?

- **Methodology questions:** See [SOP.md](SOP.md)
- **MITRE technique lookup:** See [reference.md](reference.md)
- **Template guidance:** See template-specific README files in `templates/`

---

## For Requestors (Non-Security Stakeholders)

### How to Request a Threat Model Assessment

#### Step 1: Determine If You Need One

You should request a threat model assessment if:
- You're evaluating a new vendor (SaaS product)
- You're building a new data pipeline or integration
- You're migrating infrastructure to the cloud
- You're renewing a vendor contract and want risk validation

#### Step 2: Complete the System Profile

Download and complete the [System Profile Template](../templates/system-profile-template.md). Focus on:
- **Required fields** (blocking — assessment cannot start without these)
- **Important fields** (affects quality — fill what you can)
- **Optional fields** (helpful context — nice to have)

#### Step 3: Submit Your Request

Submit the completed system profile to the Security Architecture Team.

#### Step 4: What Happens Next

| Timeline | Activity |
|----------|----------|
| Days 1-2 | Analyst reviews your intake; may request clarification |
| Days 2-4 | Attack surface analysis — you may be asked for architecture details |
| Days 4-7 | Threat analysis — the main assessment work |
| Day 7 | Data population — analyst populates catalogs and registers |
| Days 7-8 | Report writing |
| Days 8-10 | Quality review |
| Day 10 | Deliver draft report for your review |
| Days 10-15 | Feedback loop — review draft, provide feedback, escalate risks |

#### What You'll Receive

- **Lean Report** (~5-10 pages) — Executive summary with key findings
- **Supporting Analysis** (~15-30 pages) — Full technical details, attack trees, threat catalog

For Type 2 and 3 assessments, you'll also receive:
- **Security Requirements** — ASVS 5.0-aligned requirements for implementation (plus AISVS requirements if the system uses AI/ML)

#### Understanding the Output

| Risk Level | What It Means |
|------------|---------------|
| **High** | Immediate action recommended — significant security concern |
| **Medium** | Address in next planning cycle — moderate risk |
| **Low** | Monitor and address as resources allow — acceptable risk |

### Tips for a Smooth Assessment

1. **Provide complete intake information** — The more context upfront, the faster the assessment
2. **Include architecture diagrams** — Even hand-drawn sketches help
3. **Identify your technical contact** — Someone who can answer implementation questions
4. **Respond promptly to questions** — Assessment clock pauses during "Needs Info" status

---

## Resources Quick Reference

| Resource | Purpose |
|----------|---------|
| [SOP.md](SOP.md) | Complete methodology reference |
| [reference.md](reference.md) | MITRE ATT&CK/ATLAS, attack trees, risk matrix, ASVS/AISVS reference |
| [assessment-type-guide.md](assessment-type-guide.md) | Assessment type decision tree and definitions |
| [consumer-guide.md](consumer-guide.md) | Detailed requestor guidance |

## Examples

Complete fictional examples are available in `examples/`:
- **Type 1:** ExampleCorp vendor assessment
- **Type 2:** ExampleAnalytics data pipeline
- **Type 3:** ExampleCloud infrastructure

---

*Last updated: 2026-04-15*
