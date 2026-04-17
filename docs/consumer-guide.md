# Threat Modeling Service — Consumer Guide

This guide explains the threat modeling service provided by the Security Architecture Team. It is written for non-security stakeholders — product owners, engineers, architects, and business owners — who are requesting or participating in a threat model assessment.

---

## What Is a Threat Model?

A threat model is a **design-level security assessment**. It evaluates the architecture, data flows, trust boundaries, and integration patterns of a system to identify where the design creates or fails to mitigate risk. It then defines mitigating requirements to address those risks.

**What it produces:**

- A report identifying architectural attack surfaces, systemic design vulnerabilities, and data exposure patterns. Assessments may surface design vulnerabilities requiring mitigation.
- Mitigating requirements prioritized by risk level (High / Medium / Low)
- For **vendor assessments (Type 1)**: a vendor recommendation (Proceed / Proceed with Conditions / Do Not Proceed) to inform risk management decisions
- Supporting analysis including attack trees, MITRE ATT&CK mappings, and a complete threat catalog

**What it does NOT do:**

- It is not a **vulnerability assessment** — it does not comprehensively enumerate implementation-level weaknesses (specific CVEs, missing patches, software bugs, or misconfigurations)
- It is not a **penetration test** — it does not attempt to exploit vulnerabilities
- For **internal systems (Types 2/3)**, it does not make go/no-go decisions — it defines mitigating requirements for systems the organization already owns or operates
- It does not certify compliance (HIPAA, SOC 2, PCI DSS, etc.)
- It does not audit vendor certifications — it notes what a vendor claims but does not independently verify

Threat modeling assesses *how a system is designed* (or how it fits into a broader design), not *how it is implemented*. Implementation-level security testing (vulnerability scanning, penetration testing) is complementary but separate.

---

## Assessment Types

For complete type definitions, decision tree, and detailed guidance, see the [Assessment Type Guide](./assessment-type-guide.md).

The service supports three assessment types:

| Type | Name | When to Use | Example |
|------|------|-------------|---------|
| **1** | Third-Party Vendor | Evaluating or renewing a vendor or SaaS product | ExampleCRM, ExampleDataProvider |
| **2** | Internal Application | Assessing a custom app, data pipeline, internal service, or multi-vendor architecture | Financial data pipeline (ExampleERP → ExampleETL → ExampleWarehouse → ExampleTransform → ExampleFiles) |
| **3** | Infrastructure-Only | Assessing cloud accounts, network architecture, IAM, or public exposure | AWS multi-account posture review |

When a Type 2 or Type 3 assessment involves systems with AI/ML components (inference endpoints, RAG pipelines, model training, AI agents, vector databases), additional ATLAS threat branches and AISVS security requirements apply. See the [Assessment Type Guide](./assessment-type-guide.md) for details.

### Which Type Do I Need?

**Quick rule of thumb:**
- If it evaluates a vendor relationship → **Type 1**
- If it involves code your team writes → **Type 2**
- If it's cloud/network configuration only → **Type 3**
- If it uses AI/ML → same type, plus ATLAS branches and AISVS requirements

For the complete decision tree, see the [Assessment Type Guide](./assessment-type-guide.md#decision-tree).

If none of these clearly fit, describe your system in the system profile (sections A3-A5) and the analyst will determine the right assessment type.

---

## What to Expect

### Process Timeline

| Phase | Jira Status | Duration | Your Involvement |
|-------|-------------|----------|------------------|
| **Intake & Scoping** | To Do | Variable (2-5 days typical) | Complete the system profile, respond to clarifying questions, confirm scope |
| **Assessment Sprint** | In Progress | **2 weeks (10 business days)** | Available for questions; provide SME access as needed; review draft report |
| **Delivery** | Complete | — | Receive final report (included in the sprint) |
| **Feedback Loop** | — | **5 business days** | Review draft report, provide feedback, escalate risks if needed |

The assessment follows a **2-week sprint model**: once the analyst has all required intake information and moves the issue to In Progress, the target is to deliver the final report within 10 business days.

If the analyst needs clarification during the sprint, the issue moves to **Needs Info** — this pauses the sprint clock. Prompt responses (within 1-2 business days) help keep the assessment on track. Slow responses risk pushing completion forward an indeterminate amount of time. 

**Your responsiveness during intake directly affects how quickly the sprint starts.** The faster intake is complete, the sooner the 2-week clock begins.

### Deliverables by Assessment Type

| Assessment Type | Lean Report | Supporting Analysis | Security Requirements | Vendor Recommendation |
|----------------|-------------|--------------------|-----------------------|----------------------|
| Type 1: Third-Party Vendor | Yes | Yes | No | Yes |
| Type 2: Internal Application | Yes | Yes | Yes (ASVS 5.0; + AISVS if AI) | No |
| Type 3: Infrastructure-Only | Yes | Yes | Yes (ASVS 5.0; + AISVS if AI) | No |

- **Lean Report** (~300-400 lines): Executive-friendly summary with top priority risks, mitigating requirements, and architecture diagrams
- **Vendor Recommendation** (Type 1 only): Proceed / Proceed with Conditions / Do Not Proceed — included in the lean report Assessment Overview to inform risk management decisions
- **Supporting Analysis**: Detailed analytical work product with full attack trees, complete threat catalog, residual risk analysis, and assumptions register
- **Security Requirements**: OWASP ASVS 5.0-aligned requirements derived from the threat model findings, with threat-to-requirement traceability. For assessments involving AI/ML components, OWASP AISVS requirements are also included.

### Feedback Loop

After the assessment sprint delivers the draft report, there is a **5-business-day feedback window** for stakeholder review. During this period:

1. **Stakeholder review** — The business owner and technical contacts review the draft report for factual accuracy, validate or invalidate flagged assumptions, and confirm that system descriptions are correct.
2. **Incorporate feedback** — The analyst addresses review comments, corrects any inaccuracies, and updates findings where evidence supports a different conclusion.
3. **Risk escalation** — If Critical or High findings require immediate attention, the analyst works with stakeholders to escalate to security leadership during the feedback window rather than waiting for final delivery.

The feedback window ensures the final report reflects accurate system understanding before it is finalized and distributed.

---

## Your Role

### Before the Assessment

1. **provide a reasonably-complete system profile** — See the [system profile](../templates/system-profile-template.md) for an example of what helps us deliver our service.
2. **Gather supporting artifacts** — Architecture diagrams, data flow diagrams, vendor security documentation, scope files (for infrastructure assessments, use the `scope.txt` format), API specifications
3. **Identify key contacts** — A business owner (accountable for the system) and a technical point of contact (can answer architecture and implementation questions)

The quality of the threat model depends directly on the quality of the intake. The more context you provide upfront, the faster and more accurate the assessment. As the requestor, you are accountable for intake quality.

> **Information quality matters.** Fields left blank during intake are documented as assumptions with Low confidence in the final report. Reports based heavily on assumptions may understate or overstate risk. Completing all intake fields — especially data inventory (A4), integrations (A5), and trust boundaries (A6) — produces the most accurate assessment.

### During the Assessment

- **Respond to analyst questions** within 1-2 business days — delays in responses delay the assessment
- **Provide access** to documentation, subject matter experts, or system details as requested
- **Flag constraints** — regulatory deadlines, organizational changes, timeline pressures, or other factors the analyst should know about

### After the Assessment

- **Review the draft report** for factual accuracy — are system descriptions correct? Are assumptions valid?
- **Validate or invalidate flagged assumptions** — the report's Assumptions Register identifies every unverified claim with confidence levels; your feedback here directly improves accuracy
- **Prioritize mitigating requirements** — determine implementation order based on risk level and business impact
- **Review the Assumptions Register** — understand where intake information was incomplete or incorrect, and prioritize validating assumptions to improve assessment accuracy

---

## How to Submit a Request

**Option 1: work management software** (coming soon)

A "Threat Model Request" issue type with structured intake is available.

---

## Frequently Asked Questions

**How long does an assessment take?**

There are two phases: **intake** (variable) and the **assessment sprint** (2 weeks). Intake duration depends on how quickly you provide complete information — typically 2-5 business days. Once intake is complete and the analyst starts work, the target is delivery within 10 business days (one 2-week sprint). Life-safety and mission-critical systems receive priority scheduling.

**What if I am not sure which assessment type I need?**

Select your best guess on the system profile. The analyst will confirm or adjust the type during triage. When in doubt, describe what you are trying to assess and the analyst will determine the right approach.

**Can I request an expedited assessment?**

Yes. Set Priority to "Expedited" on the system profile and note the deadline in the Business Requirements field. The Security Architecture Team will evaluate feasibility and confirm timing.

**What if my system spans multiple types?**

For example, a data pipeline (Type 2) running on AWS infrastructure (Type 3). In most cases, treat as the primary type (Type 2 for the pipeline) and note the infrastructure context in the system profile. The analyst may recommend a separate infrastructure assessment if warranted.

**What happens if new information emerges after the assessment is complete?**

Contact the Security Architecture Team. Minor updates (new integrations, changed data types) can be incorporated as addenda. Significant changes (new architecture, new vendor relationships) may warrant a reassessment.

**How often should assessments be refreshed?**

Consider reassessment when: the system undergoes significant architecture changes, a security incident occurs, a vendor relationship is renewed, or annually for life-safety and mission-critical systems.

**Do I need to provide an architecture diagram?**

It is strongly recommended. Even a rough hand-drawn diagram helps the analyst understand data flows and trust boundaries. If you don't have one, the analyst will work with you to create one during Phase 1.

**Who sees the final report?**

The report is shared with the business owner and stakeholders identified during intake. Distribution beyond that group is at the business owner's discretion. Reports are marked CONFIDENTIAL.

**What if I disagree with a finding?**

The draft review phase is specifically for this. Flag any findings you believe are inaccurate, and the analyst will work with you to resolve disagreements before the report is finalized. Findings are evidence-based — if evidence supports a different conclusion, the report is updated.
