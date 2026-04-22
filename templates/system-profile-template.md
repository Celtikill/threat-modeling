---
title: "Threat Model Intake: [System/Vendor Name]"
subtitle: "Assessment Request Form"
date: "[YYYY-MM-DD]"
version: "1.0"
requestor: "[Name / Role]"
business_owner: "[Name / Title]"
life_safety_critical: "[Yes / No / Unknown]"
regulatory_context: "[HIPAA / 42 CFR Part 2 / SOC 2 / ISO 27001 / None / Unknown]"
assessment_type: "[Type 1 / Type 2 / Type 3 / TBD]"
priority: "[Standard / Expedited]"
---

# Threat Model Intake Form

Complete this form to request a threat model assessment. For guidance on each field, see the [Consumer Guide](../docs/consumer-guide.md#completing-the-intake-form).

> **Accountability:** The Requestor/Owner is accountable for the quality of intake information. The Security Analyst is responsible for conducting the assessment. Incomplete intake produces assumptions in the assessment, which may lead to inaccurate findings.

> **Life-Safety Criticality:** Systems supporting crisis intervention, emergency services, or patient safety may require expedited assessment paths and additional regulatory review. Mark **Life-Safety** in A3 if applicable.

*Complete Part A (all types). If you selected an assessment type in A2, complete the matching part (1, 2, or 3). If unsure, complete whichever sections you can — the analyst will guide you. Then complete Part E.*

---

## Field Criticality

| Criticality | Meaning | Impact if Blank |
|-------------|---------|-----------------|
| **Required** | Assessment cannot proceed without this information | Issue remains in To Do / Needs Info until provided |
| **Important** | Assessment quality degrades significantly without this | Analyst documents as Low-confidence assumption; findings may be inaccurate |
| **Optional** | Helpful context but not blocking | Analyst proceeds without it |

| Section | Criticality |
|---------|-------------|
| A1. Requestor Information | Required |
| A2. Assessment Type | Optional (analyst determines if blank) |
| A3. System Overview | Required |
| A4. Data Inventory | Required (at least one data type) |
| A5. Integration and Data Flow | Required (at least one integration) |
| A6. Trust Boundaries | Important |
| A7. Existing Controls | Important |
| A8. Known Concerns | Optional |
| A9. Personnel Access Inventory | Important |
| Type-specific first subsection (1.1, 2.1, or 3.1) | Required |
| Type-specific remaining subsections | Important |
| Part E. Attachments | Optional (architecture diagram strongly recommended) |

---

## Part A: Common Information

### A1. Requestor Information

| Field | Value |
|-------|-------|
| Requestor Name | |
| Business Owner | |
| Technical Contact | |
| Department | |
| Date Requested | |
| Desired Completion | |
| Priority | [ ] Standard / [ ] Expedited |

### A2. Assessment Type *(Optional)*

*If you know which type fits, select it. If not, leave this blank — the analyst will determine the type based on your A3-A5 answers. See the [Assessment Type Guide](../docs/assessment-type-guide.md) for detailed guidance.*

| If your system is... | Select |
|----------------------|--------|
| An external SaaS vendor or product being evaluated or renewed | **Type 1: Third-Party Vendor** → Complete Part 1 |
| A custom application, data pipeline, internal service, or multi-vendor architecture | **Type 2: Internal Application** → Complete Part 2 |
| Cloud infrastructure, network posture, or IaC configuration | **Type 3: Infrastructure-Only** → Complete Part 3 |
| Not sure / doesn't clearly fit one type | Leave blank — complete A3-A5 and the analyst will determine |

**Selected type:** ____________

### A3. System Overview

| Field | Value |
|-------|-------|
| System/Vendor Name | |
| Brief Description | |
| Business Purpose | |
| Service Criticality | [ ] Life-Safety / [ ] Mission-Critical / [ ] Business-Critical / [ ] Operational |
| Users Affected | |
| Regulatory Context | [ ] HIPAA / [ ] PCI DSS / [ ] 42 CFR Part 2 / [ ] GDPR / [ ] CCPA / [ ] SOX / [ ] None identified |

### A4. Data Inventory

| Data Type | Sensitivity | Volume | Regulatory Driver | Data Source | Last Updated |
|-----------|-------------|--------|-------------------|-------------|--------------|
| | [ ] Critical / High / Medium / Low | | | [e.g., "Data warehouse inventory", "API schema", "Manual estimate"] | [YYYY-MM-DD] |
| | [ ] Critical / High / Medium / Low | | | | |
| | [ ] Critical / High / Medium / Low | | | | |

<!-- Add rows as needed -->

> **Data Source Documentation:** Identify the source of data inventory information (e.g., "Data catalog export from [date]", "Schema documentation [URL]", "Manual estimate by [Name]"). This enables the analyst to assess source age and validate currency.

> **Regulatory Driver Guidance:** Check all applicable frameworks. Life-safety data (e.g., crisis caller records) may trigger additional obligations. Consult compliance if uncertain.

### A5. Integration and Data Flow

List all systems this system connects to:

| System | Direction | Data Types Exchanged | Protocol | Authentication |
|--------|-----------|---------------------|----------|---------------|
| | [ ] Inbound / Outbound / Bidirectional | | | |
| | [ ] Inbound / Outbound / Bidirectional | | | |

<!-- Add rows as needed -->

**Data flow diagram attached?** [ ] Yes / [ ] No (recommended — even a hand-drawn sketch helps)

**Which threat scenarios concern you most?** (select all that apply)

- [ ] Unauthorized access to sensitive data
- [ ] Authentication bypass or credential theft
- [ ] Data integrity issues or unauthorized modification
- [ ] API or integration abuse
- [ ] Insider threats or excessive access
- [ ] Service disruption or availability issues

### A6. Trust Boundaries *(Important)*

*Where does your organization's control end and another party's begin? Example: "Internet-facing login portal; internal data sync over VPN; vendor manages database infrastructure."*

| Boundary | Description |
|----------|-------------|
| Organizational control boundary | |
| Network boundaries | e.g., Internet-facing / Internal / VPN / PrivateLink |
| Administrative boundaries | e.g., "Our team manages the app; vendor manages the database; cloud provider manages the network" |

### A7. Existing Controls *(Important)*

*If unsure, answer as best you can — the analyst will follow up. Blank answers become assumptions in the report.*

| Control Area | Current Control | Notes |
|-------------|-----------------|-------|
| Authentication | e.g., SSO with Okta, MFA enforced | |
| Encryption (at rest) | e.g., AES-256, vendor-managed keys | |
| Encryption (in transit) | e.g., TLS 1.2+ required | |
| Monitoring/Logging | e.g., CloudWatch, SIEM integration | |
| Access Control | e.g., RBAC, quarterly access reviews | |
| Backup/Recovery | e.g., daily snapshots, 30-day retention | |
| Incident Response | e.g., PagerDuty escalation, runbook exists | |

### A8. Known Concerns

| Area | Details |
|------|---------|
| Specific threats or incidents | |
| Previous audit findings | |
| Risk register items | |
| Areas you specifically want assessed | |

### A9. Personnel Access Inventory *(Important)*

*Document who has access to the system infrastructure. This enables insider threat assessment and compliance verification. Leave blank if unknown — analyst will document as a gap.*

| Access Type | Personnel/Accounts | Access Level | Last Review Date |
|-------------|-------------------|--------------|------------------|
| Cloud console (AWS/Azure/GCP) | e.g., [analyst@example.com], IAM:AdminRole | Administrator / Developer / ReadOnly | |
| Infrastructure deployment | e.g., GitHub Actions service account, Terraform Cloud | | |
| Third-party/vendor access | e.g., contractor@vendor.com via VPN | | |
| Service accounts | e.g., app-runtime-role, backup-service | | |

**Verification method:** [ ] IAM export / [ ] Identity provider audit / [ ] Manual inventory / [ ] Not verified

---

## Part 1: Third-Party Vendor

*Complete this section if you selected Type 1.*

### 1.1 Vendor Information

| Field | Value |
|-------|-------|
| Vendor Legal Name | |
| Vendor Website | |
| Contract Status | [ ] Evaluating / [ ] Negotiating / [ ] Active / [ ] Renewing |
| Security documentation available | [ ] SOC 2 report / [ ] Security whitepaper / [ ] Trust page URL / [ ] None |

### 1.2 Vendor Access

| Field | Value |
|-------|-------|
| What data will the vendor access, store, or process? | |
| What access will vendor personnel have to your systems? | |
| Does the vendor use subprocessors for your data? | |

### 1.3 Contractual Context

| Field | Value |
|-------|-------|
| DPA/BAA in place? | [ ] Yes / [ ] No / [ ] In progress |
| SLA commitments documented? | [ ] Yes / [ ] No |
| Data deletion/return provisions? | [ ] Yes / [ ] No / [ ] Unknown |

---

## Part 2: Internal Application

*Complete this section if you selected Type 2.*

### 2.1 Architecture Overview

| Field | Value |
|-------|-------|
| Deployment Model | [ ] Cloud-native / [ ] Hybrid / [ ] On-premises |
| Technology Stack | |
| Architecture diagram attached? | [ ] Yes / [ ] No |

### 2.2 Application Context

| Field | Value |
|-------|-------|
| System Type | [ ] Custom-built / [ ] COTS / [ ] SaaS pipeline / [ ] Multi-vendor chain |
| Who builds and maintains this? | |
| Source code repository | |
| Change frequency | |

### 2.3 Pipeline Specifics

*Complete if this is a multi-vendor data pipeline.*

| Stage | Vendor/System | Role | Authentication | Data Access Level |
|-------|--------------|------|---------------|------------------|
| Source | | | | |
| Extract/Load | | | | |
| Warehouse | | | | |
| Transform | | | | |
| Egress | | | | |

<!-- Adjust stages to match your pipeline -->

### 2.4 Authentication and Authorization

| Field | Value |
|-------|-------|
| How do users authenticate? | [ ] SSO / [ ] Local accounts / [ ] Service accounts / [ ] Other |
| How are permissions managed? | [ ] RBAC / [ ] ABAC / [ ] Custom / [ ] Other |
| Service account inventory available? | [ ] Yes / [ ] No |

---

## Part 3: Infrastructure-Only

*Complete this section if you selected Type 3.*

### 3.1 Infrastructure Scope

| Field | Value |
|-------|-------|
| Cloud Provider(s) | [ ] AWS / [ ] Azure / [ ] GCP / [ ] Other |
| Account IDs in scope | |
| Public IP addresses / DNS names | |
| scope.txt attached? | [ ] Yes / [ ] No — see `scope.txt` format for infrastructure inventories |

### 3.2 IaC and Configuration

| Field | Value |
|-------|-------|
| IaC Tooling | [ ] OpenTofu / [ ] CloudFormation / [ ] Pulumi / [ ] None |
| CI/CD pipeline for infra changes | |
| Configuration management approach | |

### 3.3 Identity and Access

| Field | Value |
|-------|-------|
| IAM architecture | [ ] Federated / [ ] Local / [ ] Hybrid |
| Privileged access management | |
| Cross-account access patterns | |

### 3.4 Existing Security Posture

| Field | Value |
|-------|-------|
| Security tooling | [ ] GuardDuty / [ ] Security Hub / [ ] WAF / [ ] CSPM / [ ] Other |
| Vulnerability scanning cadence | |
| Network segmentation approach | |
| Applicable frameworks | [ ] CIS Benchmarks / [ ] NIST 800-53 / [ ] AWS Well-Architected / [ ] SOC 2 / [ ] Other |

---

## Part D: Evidence Sources and Documentation

*Document the sources of information provided in this intake. This enables the analyst to assess source age, validate claims, and identify assumptions.*

### Evidence Inventory

| Information Type | Source Document | Location/URL | Date of Source | Confidence |
|------------------|-----------------|--------------|----------------|------------|
| System description | [e.g., "Architecture doc", "Wiki page", "Verbal"] | [Link or path] | [YYYY-MM-DD] | [High/Med/Low] |
| Data inventory | [e.g., "Data catalog export", "Schema docs", "Estimate"] | [Link or path] | [YYYY-MM-DD] | [High/Med/Low] |
| Integration details | [e.g., "API docs", "Network diagram", "Unknown"] | [Link or path] | [YYYY-MM-DD] | [High/Med/Low] |
| Access control info | [e.g., "IAM export", "Access review doc", "Not documented"] | [Link or path] | [YYYY-MM-DD] | [High/Med/Low] |
| Security controls | [e.g., "SOC 2 report", "Security whitepaper", "Unknown"] | [Link or path] | [YYYY-MM-DD] | [High/Med/Low] |

> **Source Age Impact:** Older sources (>6 months) may not reflect current system state. The analyst will flag stale sources as assumptions in the assessment.

> **Confidence Level Guidance:**
> - **High:** Authoritative source (official documentation, automated export) recently verified
> - **Medium:** Informal source (wiki, tribal knowledge) or older authoritative source
> - **Low:** Unverified source, estimate, or significant gaps in documentation

---

## Part E: Attachments Checklist

| Artifact | Attached? | Source Date | Notes |
|----------|-----------|-------------|-------|
| Architecture / data flow diagram | [ ] | [YYYY-MM-DD] | |
| scope.txt (for Type 3 — infrastructure inventory format) | [ ] | [YYYY-MM-DD] | |
| Vendor security documentation (for Type 1) | [ ] | [YYYY-MM-DD] | |
| Previous assessment reports (if reassessment) | [ ] | [YYYY-MM-DD] | |
| Relevant audit findings | [ ] | [YYYY-MM-DD] | |
| API specifications | [ ] | [YYYY-MM-DD] | |
| Network topology diagram | [ ] | [YYYY-MM-DD] | |
| Personnel access inventory (IAM export, access review documentation) | [ ] | [YYYY-MM-DD] | |
| Data classification matrix | [ ] | [YYYY-MM-DD] | |
| Integration inventory | [ ] | [YYYY-MM-DD] | |
