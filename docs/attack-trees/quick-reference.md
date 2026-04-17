# Attack Tree Quick Reference

One-page reference for threat model assessments, with sections for both executive decision-making and technical analysis.

---

## Branch Overview

| # | Branch | Risk | Assessment Types | Key Techniques |
|---|--------|:----:|:----------------:|----------------|
| 1 | [Vendor Infrastructure](./standard/branch-01-vendor-infrastructure.md) | M | All | T1190, T1078 |
| 2 | [Vendor Personnel](./standard/branch-02-vendor-personnel.md) | H | 1, 2 | T1078, T1566 |
| 3 | [Integration Points](./standard/branch-03-integration-points.md) | H | All | T1190, T1550 |
| 4 | [Business Disruption](./standard/branch-04-business-disruption.md) | M | 1, 2 | T1490, T1485 |
| 5 | [Infrastructure Components](./standard/branch-05-infrastructure-components.md) | H | All | T1595, T1203 |
| 6 | [Application Layer](./standard/branch-06-application-layer.md) | H | 2 | T1190, T1059, T1068 |
| 7 | [Auth/Authz](./standard/branch-07-authentication.md) | H | 2 | T1078, T1110, T1550 |
| 8 | [CI/CD Pipeline](./standard/branch-08-cicd-pipeline.md) | M | 2* | T1195.002, T1078 |
| 9 | [Pipeline Integration](./standard/branch-09-pipeline-integration.md) | M | 2* | T1552, T1530 |
| 10 | [IAM Privilege](./standard/branch-10-iam-privilege.md) | H | 3 | T1078, T1548 |
| 11 | [Network Lateral](./standard/branch-11-network-lateral.md) | M | 3 | T1021, T1550 |
| 12 | [Public Exposure](./standard/branch-12-public-exposure.md) | H | 3 | T1190, T1619 |
| 13 | [Credential Theft](./standard/branch-13-credential-theft.md) | H | 3 | T1552, T1555 |
| 14 | [Logging Evasion](./standard/branch-14-logging-evasion.md) | M | 3 | T1562.008 |
| 15 | [AI Training Poisoning](./ai-specific/branch-15-training-data-poisoning.md) | H | 2/3 (if AI) | AML.T0043 |
| 16 | [AI Prompt Injection](./ai-specific/branch-16-prompt-injection.md) | H | 2/3 (if AI) | AML.T0051, AML.T0052 |
| 17 | [AI Model Extraction](./ai-specific/branch-17-model-extraction.md) | M | 2/3 (if AI) | AML.T0044 |
| 18 | [AI Agent Abuse](./ai-specific/branch-18-agent-abuse.md) | H | 2 (if AI) | AML.T0056 |
| 19 | [AI Vector DB](./ai-specific/branch-19-vector-database.md) | M | 2/3 (if AI) | AML.T0053 |
| 20 | [AI Output Manipulation](./ai-specific/branch-20-output-manipulation.md) | H | 2/3 (if AI) | AML.T0051 |
| 21 | [AI Supply Chain](./ai-specific/branch-21-model-poisoning.md) | H | 2/3 (if AI) | AML.T0043 |

---

## For Executives: Risk-Prioritized Summary

### 🔴 High-Risk Branches (Immediate Attention)

| Branch | Category | Business Impact | Priority Action |
|--------|----------|-----------------|-----------------|
| 2 | Personnel | Data breach via insider/compromised credentials | Verify MFA enforcement |
| 3 | Integration | Data interception, API abuse | Review integration security |
| 6 | Application | Code exploitation (OWASP Top 10) | Application security review |
| 7 | Auth/Authz | Unauthorized access, privilege escalation | Verify auth controls |
| 10 | IAM | Unauthorized cloud infrastructure access | Enforce least privilege |
| 12 | Exposure | Public data breach | Review public resources |
| 13 | Credentials | Unauthorized access via stolen secrets | Secrets management review |
| 15-21 | AI-Specific | Model corruption, IP theft, unintended behavior | AI-specific controls |

### 🟡 Medium-Risk Branches (Standard Controls)

| Branch | Category | Business Impact | Priority Action |
|--------|----------|-----------------|-----------------|
| 1 | Vendor Infrastructure | Supply chain attack | Confirm SOC 2 |
| 4 | Business Disruption | Service unavailability | Establish SLA/backup |
| 5 | Infrastructure | Component failure | Verify redundancy |
| 8 | CI/CD | Supply chain via build | Secure pipeline |
| 9 | Data Pipeline | Data sprawl | Pipeline security |
| 11 | Network | Lateral movement | Network segmentation |
| 14 | Logging | Undetected compromise | Enable comprehensive logging |

---

## For Analysts: Technical Reference

### Quick Lookup by Technique

| Technique | Tactic | Branches |
|-----------|--------|----------|
| T1078 Valid Accounts | Initial Access | 2, 7, 10, 13 |
| T1190 Exploit Public-Facing | Initial Access | 1, 3, 6, 12 |
| T1059 Command/Scripting | Execution | 6 |
| T1110 Brute Force | Credential Access | 7 |
| T1548 Privilege Escalation | Privilege Escalation | 7, 10 |
| T1552 Unsecured Credentials | Credential Access | 9, 13 |
| T1566 Phishing | Initial Access | 2 |
| AML.T0051 Prompt Injection | ML Attack | 16, 20 |
| AML.T0043 Model Poisoning | ML Attack | 15, 21 |

### ASVS Quick Mapping

| Chapter | Primary Branches |
|---------|------------------|
| V1-V3 (Architecture/Input) | 6 |
| V4 (API) | 3, 9 |
| V6 (Authentication) | 2, 7, 10, 13 |
| V8 (Authorization) | 7, 10 |
| V10 (OAuth) | 8 |
| V11 (Crypto) | 1, 5, 13 |
| V12 (Communication) | 3 |
| V13 (Configuration) | 5, 11, 12 |
| V14 (Data Protection) | 4 |
| V16 (Logging) | 14 |

### Branch Summaries

**1. Vendor Infrastructure:** External attacks, supply chain compromise → T1190, T1078  
**2. Vendor Personnel:** Insider threats, credential compromise → T1078, T1566  
**3. Integration Points:** API vulnerabilities, data transmission compromise → T1190, T1550  
**4. Business Disruption:** Availability attacks, data integrity → T1490, T1565  
**5. Infrastructure Components:** Perimeter attacks, component compromise → T1595, T1203  
**6. Application Layer:** Injection attacks, auth weaknesses, IDOR → T1190, T1059, T1068  
**7. Authentication/Authorization:** Credential compromise, session exploitation, privilege escalation → T1078, T1110, T1550  
**8. CI/CD Pipeline:** Repository manipulation, build injection, dependency attacks → T1195.002, T1078  
**9. Pipeline Integration:** Credential theft, data sprawl, transformation tampering → T1552, T1530  
**10. IAM Privilege:** Role assumption chains, policy misconfig, federation exploitation → T1078, T1548  
**11. Network Lateral:** Security group misconfig, VPC exploitation → T1021, T1550  
**12. Public Exposure:** Storage misconfig, service exposure → T1190, T1530  
**13. Credential Theft:** Secrets manager exploitation, key management → T1552, T1555  
**14. Logging Evasion:** CloudTrail bypass, detection avoidance → T1562.008, T1070  
**15. Training Data Poisoning:** Data source compromise, label integrity → AML.T0043  
**16. Prompt Injection:** Direct/indirect injection attacks → AML.T0051, AML.T0052  
**17. Model Extraction:** Query-based extraction, IP theft → AML.T0044  
**18. Agent Abuse:** Credential compromise, tool chain manipulation → AML.T0056  
**19. Vector DB Attacks:** Store compromise, RAG exploitation → AML.T0053  
**20. Output Manipulation:** Jailbreaks, integrity attacks → AML.T0051  
**21. AI Supply Chain:** Model distribution compromise, training pipeline injection → AML.T0043

---

## Assessment Type Summary

### Type 1: Third-Party Vendor (Branches 1-5)
**Key Question:** Can we trust this vendor with our data?  
**Priority:** Branches 2, 3 (High) → Branches 1, 4, 5 (Medium)

### Type 2: Internal Application (Branches 1-9)
**Key Question:** Is our application code secure?  
**Priority:** Branches 2, 6, 7 (High) → Branches 3, 1, 4, 5, 8, 9 (Medium)  
**AI Modifier:** Add Branches 15-21 if system uses AI/ML

### Type 3: Infrastructure (Branches 1, 3-5, 10-14)
**Key Question:** Is our cloud infrastructure properly configured?  
**Priority:** Branches 10, 12, 13 (High) → Branches 3, 5, 11, 14 (Medium)  
**AI Modifier:** Add Branches 15-21 (conditional) if infrastructure hosts AI workloads

---

## Next Steps

| If you need... | Go to... |
|----------------|----------|
| Detailed branch documentation | [Attack Tree Hub](./README.md) |
| Assessment type guidance | [Navigation Guide](./navigation-guide.md) |
| Complete branch details | [Standard](./standard/) or [AI-specific](./ai-specific/) branches |

---

*Document Version: 2.0 | Consolidated for dual-audience access*
