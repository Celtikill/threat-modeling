---
title: "System Profile: [System Name]"
subtitle: "[System Type] — [Environment]"
status: "[Draft / Active / Deprecated]"
last_updated: "[YYYY-MM-DD]"
owning_team: "[Team Name]"
business_owner: "[Name / Email]"
tech_owner: "[Name / Email]"
assessment_type: "[Type 1: Vendor / Type 2: Application / Type 3: Infrastructure / Unknown]"
life_safety_critical: "[Yes / No]"
---

# System Profile: [System Name]

This document provides a standardized description of the system for operational reference, incident response, and security assessment purposes. It follows the organization's system inventory schema and serves as the authoritative source for system boundaries, data classification, and integration details.

> **Maintenance:** The owning team keeps this profile current. Changes to architecture, data flows, or integrations should be reflected here before deployment.

---

## 1. System Identification

| Attribute | Value | Notes |
|-----------|-------|-------|
| **System Name** | | Canonical name used in monitoring, documentation, and vendor communications |
| **System Short Name** | | Identifier for dashboards, ticket tags (e.g., `payment-api`, `analytics-db`) |
| **System Type** | [ ] Vendor SaaS / [ ] Custom Application / [ ] Data Pipeline / [ ] Infrastructure / [ ] Integration | Primary classification |
| **Environment** | [ ] Production / [ ] Staging / [ ] Development / [ ] Multi-environment | |
| **Deployment Model** | [ ] Cloud-native / [ ] Hybrid / [ ] On-premises | |
| **Owning Team** | | Responsible for maintenance and updates |
| **Business Owner** | | Accountable for system function and data |
| **Technical Owner** | | Primary contact for technical questions |
| **Security Assessment Status** | [ ] Not assessed / [ ] Assessment pending / [ ] Assessed [YYYY-MM-DD] / [ ] Re-assessment due | |

---

## 2. Purpose and Scope

### 2.1 Business Function

*What business capability does this system provide?*

```
[2-3 sentence description of business purpose. Example:
"Processes customer payment transactions, validates payment methods against 
fraud rules, and settles transactions with payment processors."]
```

### 2.2 Service Dependencies

*What other services does this depend on? What depends on this?*

| Direction | System | Dependency Type | Impact if Unavailable |
|-----------|--------|---------------|------------------------|
| **Depends On** | | | |
| | | [ ] Hard / [ ] Soft | |
| | | [ ] Hard / [ ] Soft | |
| **Depended On By** | | | |
| | | [ ] Hard / [ ] Soft | |

### 2.3 Service Level Context

| Attribute | Value |
|-----------|-------|
| **Service Criticality** | [ ] Life-Safety / [ ] Mission-Critical / [ ] Business-Critical / [ ] Operational / [ ] Non-Critical |
| **Availability Target** | [e.g., 99.99%, "Best effort", "Business hours only"] |
| **Recovery Time Objective (RTO)** | |
| **Recovery Point Objective (RPO)** | |
| **Maintenance Windows** | |
| **Planned Downtime** | [ ] Scheduled / [ ] Unscheduled / [ ] None planned |

---

## 3. Architecture and Technology

### 3.1 Technology Stack

| Layer | Technology | Version | Notes |
|-------|------------|---------|-------|
| **Runtime / Platform** | e.g., AWS Lambda, Kubernetes, EC2 | | |
| **Primary Language(s)** | e.g., Python 3.11, TypeScript, Go | | |
| **Framework / Libraries** | e.g., FastAPI, Django, React | | |
| **Database(s)** | e.g., PostgreSQL 15, DynamoDB, S3 | | |
| **Message Queue** | e.g., SQS, Kafka, RabbitMQ | | |
| **Cache** | e.g., ElastiCache Redis, CloudFront | | |
| **CI/CD** | e.g., GitHub Actions, GitLab CI | | |

### 3.2 Infrastructure

| Attribute | Value |
|-----------|-------|
| **Cloud Provider(s)** | [ ] AWS / [ ] Azure / [ ] GCP / [ ] Other: ___ |
| **Region(s) / AZs** | |
| **Network Segment** | [ ] Internet-facing / [ ] Internal / [ ] Isolated / [ ] VPC Peered |
| **Infrastructure as Code** | [ ] Terraform / [ ] CloudFormation / [ ] Pulumi / [ ] None |
| **Container Orchestration** | [ ] Kubernetes / [ ] ECS / [ ] Lambda / [ ] N/A |
| **Code Repository** | |

### 3.3 Architecture Diagram

*Link or embed architecture diagram showing major components and data flows.*

| Artifact | Location | Last Updated |
|----------|----------|--------------|
| Architecture Diagram | [Link to diagram] | [YYYY-MM-DD] |
| Data Flow Diagram | [Link to diagram] | [YYYY-MM-DD] |
| Network Topology | [Link to diagram] | [YYYY-MM-DD] |

---

## 4. Data Classification

### 4.1 Data Types Processed

| Data Type | Sensitivity | Volume/Scale | Retention | Encrypted at Rest | Encrypted in Transit | Regulatory Driver |
|-----------|-------------|--------------|-----------|-------------------|----------------------|-------------------|
| | [ ] Critical / High / Medium / Low | | | [ ] Yes / [ ] No / [ ] N/A | [ ] Yes / [ ] No / [ ] N/A | |
| | [ ] Critical / High / Medium / Low | | | | | |
| | [ ] Critical / High / Medium / Low | | | | | |

### 4.2 Data Flows

*Document where data originates and terminates*

| Flow ID | Direction | Source System | Destination System | Data Types | Protocol | Authentication | Frequency |
|---------|-----------|---------------|-------------------|------------|----------|----------------|-----------|
| DF-001 | | | | | | | |
| DF-002 | | | | | | | |

**Flow Descriptions:**

- **DF-001**: [Description of what this flow does]
- **DF-002**: [Description of what this flow does]

### 4.3 Data Residency and Sovereignty

| Attribute | Value |
|-----------|-------|
| **Primary Data Storage Location** | |
| **Backup Locations** | |
| **Cross-Border Data Transfer** | [ ] Yes / [ ] No |
| **Data Sovereignty Requirements** | |

---

## 5. Trust Boundaries and Security Posture

### 5.1 Trust Boundaries

*Define where organizational control changes or where sensitive boundaries exist*

| Boundary | Description | Control Ownership |
|----------|-------------|-------------------|
| **Administrative** | e.g., "Our team manages application; vendor manages database; AWS manages infrastructure" | |
| **Network** | e.g., "Internet-facing ALB → VPC internal subnets → Database in isolated subnet" | |
| **Data Access** | e.g., "Application can decrypt; operators cannot" | |

### 5.2 Security Controls

| Control Category | Implementation | Evidence Location |
|------------------|----------------|-------------------|
| **Authentication** | e.g., "SSO via Okta, MFA required for all accounts" | |
| **Authorization** | e.g., "RBAC with least-privilege; quarterly reviews" | |
| **Encryption (Rest)** | | |
| **Encryption (Transit)** | | |
| **Logging & Monitoring** | | |
| **Vulnerability Management** | | |
| **Backup & Recovery** | | |
| **Incident Response** | | |

### 5.3 Access Inventory

*Who and what has access to this system*

| Access Type | Identity/Account | Access Level | Last Reviewed | MFA Required |
|-------------|------------------|--------------|---------------|--------------|
| Human (production) | | | | [ ] Yes / [ ] No |
| Human (admin) | | | | |
| Service Account | | | | [ ] N/A |
| Third-party/Vendor | | | | |

---

## 6. Vendor Information (if Type 1)

| Attribute | Value |
|-----------|-------|
| **Vendor Legal Name** | |
| **Vendor Website** | |
| **Contract Status** | [ ] Evaluating / [ ] Negotiating / [ ] Active / [ ] Renewing / [ ] Terminated |
| **Data Processing Agreement** | [ ] Signed / [ ] In Progress / [ ] Not Required / [ ] None |
| **Security Documentation** | [ ] SOC 2 Type II / [ ] SOC 2 Type I / [ ] ISO 27001 / [ ] Custom / [ ] None |
| **Vendor Security Contact** | |
| **Subprocessors** | [ ] Yes / [ ] No / [ ] Unknown |

---

## 7. Regulatory and Compliance

| Framework | Applicability | Controls Implemented | Last Assessed |
|-----------|---------------|---------------------|---------------|
| | [ ] Fully / [ ] Partially / [ ] Not Applicable | | |
| | | | |

---

## 8. Operational Context

### 8.1 Change Management

| Attribute | Value |
|-----------|-------|
| **Change Frequency** | [ ] Continuous / [ ] Daily / [ ] Weekly / [ ] Monthly / [ ] Ad-hoc |
| **Approval Process** | |
| **Deployment Method** | [ ] Automated CI/CD / [ ] Manual / [ ] Mixed |
| **Rollback Capability** | [ ] Automated / [ ] Manual / [ ] None |

### 8.2 Observability

| Type | Tool | Alerting |
|------|------|----------|
| Metrics | | |
| Logs | | |
| Traces | | |
| Health Checks | | |

### 8.3 Known Risks and Concerns

| Area | Risk/Concern | Last Updated |
|------|--------------|--------------|
| | | |
| | | |

---

## 9. Supporting Documentation

| Document Type | Location | Version/Date |
|---------------|----------|--------------|
| Runbooks | | |
| API Documentation | | |
| Architecture Decision Records (ADRs) | | |
| Previous Security Assessments | | |
| Incident Response Plans | | |
| Disaster Recovery Plans | | |

---

## 10. Threat Model Assessment

*Completed by Security Architecture — do not modify this section*

| Field | Value |
|-------|-------|
| **Assessment ID** | |
| **Assessment Date** | |
| **Assessor** | |
| **Assessment Type** | [ ] Type 1 (Vendor) / [ ] Type 2 (Application) / [ ] Type 3 (Infrastructure) |
| **Risk Rating** | [ ] Critical / [ ] High / [ ] Medium / [ ] Low |
| **Status** | [ ] Not Started / [ ] In Progress / [ ] Complete / [ ] Remediation Tracked |
| **Report Location** | |
| **Next Assessment Due** | |

### 10.1 Critical Findings Summary

| Finding ID | Description | Severity | Status |
|------------|-------------|----------|--------|
| | | | |

---

## Profile Maintenance Log

| Date | Author | Changes Made |
|------|--------|--------------|
| | | Initial profile creation |
| | | |

---

*Template version: [YYYY-MM-DD] — See [Threat Modeling Framework](https://github.com/celtikill/threat-modeling) for guidance*
