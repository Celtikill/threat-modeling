# Security Requirements: ExampleCloud Infrastructure — Multi-Account Posture

<!-- This is a FICTIONAL example security requirements document demonstrating Type 3: Infrastructure-Only methodology. All infrastructure details and scenarios are fictitious. -->

---

## Document Control

| Field | Value |
|-------|-------|
| **Version** | 1.0 |
| **Date** | 2026-01-20 |
| **Author** | Security Architecture Team |
| **Status** | Final |
| **Threat Model Reference** | [examplecloud-infrastructure-threat-model.md](./examplecloud-infrastructure-threat-model.md) |
| **Supporting Analysis** | [examplecloud-supporting-analysis.md](./examplecloud-supporting-analysis.md) |

---

## Introduction

### Purpose

This document defines security requirements that **shall** be implemented to address threats identified in the threat model for the ExampleCloud Infrastructure. Requirements are based on:

- **[OWASP ASVS v5.0](https://owasp.org/www-project-application-security-verification-standard/)** (Application Security Verification Standard, May 2025)
- **CIS Benchmarks** for ExampleCloud Platform
- **Threat model findings** from the corresponding threat assessment

### Scope

| In Scope | Out of Scope |
|----------|--------------|
| IAM policies and access controls | Application-layer security |
| Network security and segmentation | Operating system hardening |
| Logging and monitoring | Physical data center security |
| Encryption configuration | End-user security awareness |
| Infrastructure-as-Code security | |

### Requirement Language

This document uses [RFC 2119](https://datatracker.ietf.org/doc/html/rfc2119) keywords:

| Keyword | Meaning |
|---------|---------|
| **MUST** | Mandatory requirement. |
| **SHOULD** | Recommended requirement. |
| **MAY** | Optional requirement. |

---

## Requirements by ASVS 5.0 Category

### V4: Authentication and Authorization (Infrastructure Focus)

*IAM policy requirements for cloud infrastructure*

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| **V4.1** | **FR** | **IAM policies MUST NOT use wildcard (`*`) permissions for actions or resources** | **v5.0.0-4.3.1** | **T-001** | **MUST** | **IAM policy audit** |
| **V4.2** | **FR** | **Service accounts MUST have dedicated roles with least-privilege permissions** | **v5.0.0-4.3.2** | **T-001** | **MUST** | **IAM inventory review** |
| V4.3 | FR | IAM roles SHOULD include conditions restricting access by source IP or VPC | v5.0.0-4.3.x | T-006 | SHOULD | Policy condition review |
| **V4.4** | **FR** | **Console access MUST require multi-factor authentication** | **v5.0.0-4.2.x** | **T-002, T-004** | **MUST** | **IAM configuration audit** |
| V4.5 | NFR | Access keys SHOULD be rotated every 90 days | v5.0.0-4.3.x | T-005 | SHOULD | Key age audit |
| V4.6 | FR | Unused IAM credentials MUST be disabled after 90 days of inactivity | v5.0.0-4.3.x | T-005 | MUST | Credential activity review |

### V6: Data Protection (Infrastructure Encryption)

*Encryption at rest and in transit for infrastructure*

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| V6.1 | FR | All storage buckets MUST enforce encryption at rest using AES-256 | v5.0.0-6.1.x | T-008 | MUST | Storage configuration audit |
| V6.2 | FR | Block storage volumes MUST use encrypted storage | v5.0.0-6.1.x | T-008 | MUST | Volume configuration review |
| V6.3 | FR | Database instances MUST enable encryption at rest | v5.0.0-6.1.x | T-008 | MUST | Database configuration audit |
| V6.4 | FR | API endpoints MUST enforce TLS 1.2 minimum (TLS 1.3 preferred) | v5.0.0-6.2.x | T-002 | MUST | TLS configuration scan |
| V6.5 | FR | TLS certificates MUST be valid and not expired | v5.0.0-6.2.x | T-002 | MUST | Certificate monitoring |

### V8: Exception Handling and Logging

*Cloud audit logging requirements*

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| **V8.1** | **FR** | **Cloud audit logs MUST be enabled for all accounts and all API activity** | **v5.0.0-8.1.x** | **T-003** | **MUST** | **CloudTrail configuration review** |
| **V8.2** | **FR** | **Audit logs MUST be forwarded to a centralized SIEM platform** | **v5.0.0-8.2.x** | **T-003** | **MUST** | **Log forwarding verification** |
| V8.3 | FR | Object-level logging MUST be enabled for sensitive storage buckets | v5.0.0-8.1.x | T-008 | SHOULD | S3 access logging review |
| V8.4 | NFR | Logs MUST be retained for 90 days online and 1 year in archive | v5.0.0-8.2.x | T-003 | MUST | Retention policy verification |
| V8.5 | FR | Real-time alerts MUST be configured for high-risk API calls | v5.0.0-8.3.x | T-001 | MUST | Alert rule review |

### V14: Configuration

*Infrastructure configuration security*

| ID | Class | Requirement | ASVS Ref | Threat Ref | Level | Verification |
|----|-------|-------------|----------|------------|-------|--------------|
| **V14.1** | **FR** | **Management endpoints MUST NOT be accessible from public internet (0.0.0.0/0)** | **v5.0.0-14.x.x** | **T-002** | **MUST** | **Security group audit** |
| V14.2 | FR | Management access SHOULD be restricted to corporate IP ranges or VPN | v5.0.0-14.x.x | T-002 | SHOULD | Network access review |
| V14.3 | FR | Security groups MUST use least-privilege ingress rules | v5.0.0-14.x.x | T-002 | MUST | Security group rule review |
| V14.4 | FR | Default security groups MUST deny all traffic by default | v5.0.0-14.x.x | T-002 | MUST | Default rule verification |
| V14.5 | FR | Infrastructure changes MUST be deployed via automated pipelines | v5.0.0-14.x.x | T-007 | SHOULD | CI/CD pipeline review |

---

## System-Specific Requirements

### IAM Policy Requirements

| ID | Class | Requirement | Threat Ref | Level | Verification |
|----|-------|-------------|------------|-------|--------------|
| IAM-01 | FR | IAM policies MUST specify explicit actions (no `*:*`) | T-001 | MUST | Policy audit |
| IAM-02 | FR | IAM policies MUST specify explicit resource ARNs | T-001 | MUST | Policy audit |
| IAM-03 | FR | Service roles MUST be unique per service/function | T-001 | MUST | Role inventory |
| IAM-04 | NFR | IAM policies SHOULD be reviewed quarterly | T-001 | SHOULD | Review schedule |

### Network Security Requirements

| ID | Class | Requirement | Threat Ref | Level | Verification |
|----|-------|-------------|------------|-------|--------------|
| NET-01 | FR | Production VPCs MUST NOT have direct internet access | T-006 | MUST | VPC routing review |
| NET-02 | FR | NAT Gateways MUST be used for outbound internet from private subnets | T-006 | SHOULD | Network architecture review |
| NET-03 | FR | VPC peering MUST be explicitly authorized and documented | T-006 | MUST | Peering connection audit |
| NET-04 | FR | Network ACLs MUST deny by default | T-002 | SHOULD | ACL rule review |

### Logging and Monitoring Requirements

| ID | Class | Requirement | Threat Ref | Level | Verification |
|----|-------|-------------|------------|-------|--------------|
| LOG-01 | FR | CloudTrail MUST be enabled in all regions | T-003 | MUST | CloudTrail status |
| LOG-02 | FR | CloudTrail logs MUST be encrypted with KMS | T-003 | SHOULD | Encryption verification |
| LOG-03 | FR | Log integrity validation MUST be enabled | T-003 | SHOULD | Integrity check |
| LOG-04 | FR | Alerts MUST trigger on IAM policy changes | T-001 | MUST | Alert configuration |
| LOG-05 | FR | Alerts MUST trigger on root account usage | T-004 | MUST | Alert configuration |

---

## Verification Criteria

### Automated Verification

| Requirement ID | Verification Method | Frequency |
|----------------|-------------------|-----------|
| V4.1 (No wildcards) | IAM policy scanner | Daily |
| V4.4 (MFA) | IAM credential report | Daily |
| V6.4 (TLS 1.2+) | SSL Labs/API scan | Weekly |
| V8.1 (CloudTrail) | Configuration drift detection | Continuous |
| V14.1 (No public mgmt) | Security group scanner | Hourly |

### Manual Verification

| Requirement ID | Verification Method | Frequency |
|----------------|-------------------|-----------|
| V4.2 (Service account roles) | IAM architecture review | Quarterly |
| IAM-01/02 (Explicit policies) | Policy review | Quarterly |
| NET-01/03 (Network segmentation) | Network architecture review | Semi-annual |

---

## Traceability Matrix

| Requirement ID | Threat Ref | Risk Level | Priority |
|----------------|------------|------------|----------|
| **V4.1** | T-001 | High | Critical |
| **V4.2** | T-001 | High | Critical |
| **V4.4** | T-002, T-004 | High | Critical |
| **V8.1** | T-003 | Medium | High |
| **V8.2** | T-003 | Medium | High |
| **V14.1** | T-002 | High | Critical |
| V6.4 | T-002 | Medium | High |
| V8.4 | T-003 | Medium | High |
| IAM-01 | T-001 | High | High |
| IAM-02 | T-001 | High | High |
| NET-01 | T-006 | Medium | Medium |
| LOG-04 | T-001 | Medium | Medium |

---

*This is a fictional example security requirements document for demonstration purposes only. All infrastructure details and scenarios are fictitious.*
