# Attack Trees by Assessment Type

Quick reference for which attack tree branches apply to each assessment type.

## Type 1: Third-Party Vendor

| Branch | Name | Risk | MITRE ATT&CK |
|--------|------|------|---------------|
| 1 | [Vendor Infrastructure Compromise](standard/branch-01-vendor-infrastructure.md) | Medium | T1078, T1190, T1566 |
| 2 | [Vendor Personnel Threats](standard/branch-02-vendor-personnel.md) | High | T1078, T1566 |
| 3 | [Integration Point Exploitation](standard/branch-03-integration-points.md) | High | T1190, T1552 |
| 4 | [Vendor Business Disruption](standard/branch-04-business-disruption.md) | Medium | T1498, T1489 |
| 5 | [Infrastructure Component Compromise](standard/branch-05-infrastructure-components.md) | High | T1190, T1562 |

## Type 2: Internal Application

| Branch | Name | Risk | MITRE ATT&CK |
|--------|------|------|---------------|
| 1 | [Vendor Infrastructure Compromise](standard/branch-01-vendor-infrastructure.md) | Medium | T1078, T1190, T1566 |
| 2 | [Vendor Personnel Threats](standard/branch-02-vendor-personnel.md) | High | T1078, T1566 |
| 3 | [Integration Point Exploitation](standard/branch-03-integration-points.md) | High | T1190, T1552 |
| 4 | [Vendor Business Disruption](standard/branch-04-business-disruption.md) | Medium | T1498, T1489 |
| 5 | [Infrastructure Component Compromise](standard/branch-05-infrastructure-components.md) | High | T1190, T1562 |
| 6 | [Application Layer Exploitation](standard/branch-06-application-layer.md) | High | T1190, T1059 |
| 7 | [Authentication and Authorization Exploitation](standard/branch-07-authentication.md) | High | T1078, T1110 |
| 8 | [CI/CD Pipeline Compromise](standard/branch-08-cicd-pipeline.md) | Medium | T1195, T1552 |
| 9 | [Pipeline Integration Exploitation](standard/branch-09-pipeline-integration.md) | Medium | T1195, T1530 |

**AI Modifier (if AI features):** Add branches 15-21

## Type 2 (if AI): Add These Branches

| Branch | Name | Risk | MITRE ATLAS |
|--------|------|------|-------------|
| 15 | [AI Training Data Poisoning](ai-specific/branch-15-training-data-poisoning.md) | High | AML.T0043 |
| 16 | [AI Prompt Injection](ai-specific/branch-16-prompt-injection.md) | High | AML.T0051, AML.T0054, AML.T0057 |
| 17 | [AI Model Extraction](ai-specific/branch-17-model-extraction.md) | Medium | AML.T0044, AML.T0055 |
| 18 | [AI Agent and Orchestration Abuse](ai-specific/branch-18-agent-abuse.md) | High | AML.T0056 |
| 19 | [AI Vector Database Attacks](ai-specific/branch-19-vector-database.md) | Medium | AML.T0053, AML.T0055 |
| 20 | [AI Output Manipulation](ai-specific/branch-20-output-manipulation.md) | High | AML.T0051, AML.T0054, AML.T0063 |
| 21 | [AI Supply Chain and Model Poisoning](ai-specific/branch-21-model-poisoning.md) | High | AML.T0043, AML.T0010 |

## Type 3: Infrastructure-Only

| Branch | Name | Risk | MITRE ATT&CK |
|--------|------|------|---------------|
| 1 | [Vendor Infrastructure Compromise](standard/branch-01-vendor-infrastructure.md) | Medium | T1078, T1190, T1566 |
| 3 | [Integration Point Exploitation](standard/branch-03-integration-points.md) | High | T1190, T1552 |
| 5 | [Infrastructure Component Compromise](standard/branch-05-infrastructure-components.md) | High | T1190, T1562 |
| 10 | [IAM Privilege Escalation](standard/branch-10-iam-privilege.md) | High | T1078, T1484 |
| 11 | [Network Lateral Movement](standard/branch-11-network-lateral.md) | Medium | T1021, T1550 |
| 12 | [Public Exposure Exploitation](standard/branch-12-public-exposure.md) | High | T1190, T1562 |
| 13 | [Credential and Secret Theft](standard/branch-13-credential-theft.md) | High | T1552, T1555 |
| 14 | [Logging Evasion](standard/branch-14-logging-evasion.md) | Medium | T1562, T1070 |

**AI Modifier (if AI workloads):** Add branches 15-21 (same as Type 2 AI modifier above, except branch 18 does not apply to infrastructure-only)