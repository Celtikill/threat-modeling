---
branch_number: 6
branch_name: "Application Layer Exploitation"
assessment_types: ["Type 2"]
risk_level: "High"
asvs_chapters: ["V1", "V2", "V3"]
aisvs_chapters: []
mitre_techniques: ["T1190", "T1059", "T1068", "T1565", "T1552", "T1213"]
tags: ["application", "injection", "input-validation", "xss", "ssrf", "deserialization"]
related_branches: [3, 7, 8, 9]
---

# Branch 6: Application Layer Exploitation

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V1 (Architecture), V2 (Validation), V3 (Frontend) |
| **AISVS Chapters** | N/A |
| **Related Branches** | [Branch 3](../branch-03-integration-points.md) (Integration), [Branch 7](../branch-07-authentication.md) (Auth), [Branch 8](../branch-08-cicd-pipeline.md) (CI/CD), [Branch 9](../branch-09-pipeline-integration.md) (Pipeline) |

## Business Impact

Application layer vulnerabilities are among the most common and exploitable attack vectors. The OWASP Top 10 identifies application-layer weaknesses as primary causes of data breaches. These vulnerabilities often allow direct access to sensitive data and systems.

**Key Business Risks:**
- Data breach through injection attacks
- Session hijacking and account takeover
- Application logic abuse for financial fraud
- Information disclosure through error messages
- Denial of service via resource exhaustion

## Attack Tree

```text
Goal: Exploit application vulnerabilities to compromise data/systems
├── 6.1 Input Validation Failures
│   ├── SQL injection via unsanitized API inputs
│   │   └── Technique: T1190 (Exploit Public-Facing Application)
│   ├── Cross-site scripting (XSS) through user-generated content
│   │   └── Technique: T1059 (Command and Scripting Interpreter)
│   ├── Server-side request forgery (SSRF) to internal services
│   │   └── Technique: T1213 (Data from Information Repositories)
│   └── Deserialization vulnerabilities in data processing
│       └── Technique: T1059 (Command and Scripting Interpreter)
├── 6.2 Authentication and Session Weaknesses
│   ├── Broken authentication allowing credential stuffing
│   │   └── Technique: T1078 (Valid Accounts)
│   ├── Session fixation or session hijacking
│   │   └── Technique: T1539 (Steal Web Session Cookie)
│   ├── Weak password policies on service accounts
│   │   └── Technique: T1110 (Brute Force)
│   └── Missing MFA on administrative interfaces
│       └── Technique: T1078 (Valid Accounts)
├── 6.3 Authorization Bypass
│   ├── Insecure direct object references (IDOR)
│   │   └── Technique: T1068 (Exploitation for Privilege Escalation)
│   ├── Broken access control allowing privilege escalation
│   │   └── Technique: T1068 (Exploitation for Privilege Escalation)
│   ├── Missing function-level authorization checks
│   │   └── Technique: T1548 (Abuse Elevation Control)
│   └── API endpoint authorization inconsistencies
│       └── Technique: T1068 (Exploitation for Privilege Escalation)
└── 6.4 Code and Configuration Vulnerabilities
    ├── Secrets committed to source code repositories
    │   └── Technique: T1552 (Unsecured Credentials)
    ├── Misconfigured frameworks exposing debug endpoints
    │   └── Technique: T1083 (File and Directory Discovery)
    ├── Vulnerable third-party dependencies (known CVEs)
    │   └── Technique: T1195.001 (Supply Chain Compromise: Software)
    └── Insecure default configurations in deployment
        └── Technique: T1078 (Valid Accounts)
```text

## Sub-Branch Details

### 6.1 Input Validation Failures

**Threat Description:** Attacks exploiting improper input validation allowing code execution or unauthorized data access.

**Common Attack Patterns:**
- SQL injection through unsanitized parameters
- XSS via reflected or stored payloads
- SSRF to access internal-only services
- XML External Entity (XXE) injection
- Command injection via shell commands

**Business Context:**
- OWASP Top 1: Broken Access Control
- OWASP Top 3: Injection
- Easily exploitable with common tools
- Often lead to complete system compromise

### 6.2 Authentication and Session Weaknesses

**Threat Description:** Attacks targeting authentication mechanisms and session management.

**Common Attack Patterns:**
- Credential stuffing using breached passwords
- Session fixation attacks
- JWT token manipulation
- Weak password policies
- Missing MFA on sensitive operations

**Business Context:**
- OWASP Top 2: Cryptographic Failures
- OWASP Top 7: Identification and Authentication Failures
- Direct path to account compromise

### 6.3 Authorization Bypass

**Threat Description:** Attacks that circumvent access controls to perform unauthorized actions.

**Common Attack Patterns:**
- IDOR by manipulating object identifiers
- Horizontal privilege escalation (access other users' data)
- Vertical privilege escalation (gain admin access)
- Function-level access control bypass
- API authorization inconsistencies

**Business Context:**
- OWASP Top 1: Broken Access Control
- Often combined with other vulnerabilities
- Hard to detect without thorough testing

### 6.4 Code and Configuration Vulnerabilities

**Threat Description:** Attacks exploiting insecure code, dependencies, or deployment configurations.

**Common Attack Patterns:**
- Hardcoded credentials in source code
- Debug endpoints left enabled in production
- Known CVEs in dependencies
- Default credentials unchanged
- Verbose error messages

**Business Context:**
- OWASP Top 6: Vulnerable and Outdated Components
- Supply chain risks through dependencies
- Configuration drift over time

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1190 | Exploit Public-Facing Application | 6.1 | Initial Access | SQL injection |
| T1059 | Command/Scripting Interpreter | 6.1 | Execution | XSS, deserialization |
| T1213 | Data from Info Repositories | 6.1 | Collection | SSRF |
| T1078 | Valid Accounts | 6.2, 6.4 | Initial Access | Auth bypass |
| T1539 | Steal Web Session Cookie | 6.2 | Credential Access | Session hijacking |
| T1110 | Brute Force | 6.2 | Credential Access | Weak passwords |
| T1068 | Exploitation for Privilege Escalation | 6.3 | Privilege Escalation | IDOR, access control |
| T1548 | Abuse Elevation Control | 6.3 | Privilege Escalation | Authz bypass |
| T1552 | Unsecured Credentials | 6.4 | Credential Access | Secrets exposure |
| T1083 | File and Directory Discovery | 6.4 | Discovery | Debug endpoints |
| T1195.001 | Supply Chain Compromise | 6.4 | Initial Access | Vulnerable dependencies |

## Assessment Questions

### Input Validation

1. Are all user inputs validated (type, length, range, format)?
2. Is parameterized/prepared SQL used exclusively?
3. Is output encoding applied before rendering?
4. Are file uploads validated and scanned?
5. Is XML parsing secured against XXE?

### Authentication

1. Is MFA enforced for all users?
2. Are passwords hashed with strong algorithms?
3. Are session tokens cryptographically secure?
4. Is session timeout enforced?
5. Are authentication decisions made server-side?

### Authorization

1. Is access control enforced on every request?
2. Are direct object references protected?
3. Are function-level authorization checks implemented?
4. Is CORS properly configured?
5. Are administrative functions segregated?

### Dependencies and Configuration

1. Are dependencies regularly scanned for vulnerabilities?
2. Is there an SBOM maintained?
3. Are debug endpoints disabled in production?
4. Are default credentials changed?
5. Are error messages generic (not revealing internals)?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 6.1 | V1.5 | Input validation architecture |
| 6.1 | V5.1 | Input validation |
| 6.1 | V5.3 | Output encoding |
| 6.2 | V6.1 | Secure authentication |
| 6.2 | V7.1 | Session management |
| 6.3 | V8.1 | Access control design |
| 6.3 | V8.2 | Authorization checks |
| 6.4 | V10.1 | Dependency management |
| 6.4 | V13.1 | Secure configuration |

## Indicators of Compromise

**Injection Attack Indicators:**
- Database error messages in application logs
- Unusual SQL patterns in application logs
- XSS payloads in user input fields
- Unexpected outbound connections from application
- File system access outside expected paths

**Authentication Weakness Indicators:**
- High volume of failed login attempts
- Login success after many failures
- Session anomalies (multiple IPs, unusual duration)
- Credential stuffing patterns
- Administrative access from unexpected locations

## Mitigating Requirements

### For Input Validation

1. **Validate All Inputs:** Whitelist approach, reject unexpected input
2. **Use Parameterized Queries:** Never concatenate SQL
3. **Encode Output:** Context-appropriate encoding (HTML, JS, CSS, URL)
4. **Sanitize File Uploads:** Type validation, virus scanning, sandboxing
5. **Secure XML Parsing:** Disable external entities

### For Authentication

1. **Enforce MFA:** Required for all user accounts
2. **Strong Passwords:** Complexity and rotation requirements
3. **Secure Sessions:** HttpOnly, Secure, SameSite flags
4. **Rate Limiting:** Prevent brute force attacks
5. **Server-Side Validation:** Never trust client-side decisions

### For Authorization

1. **Default Deny:** Require explicit access grants
2. **Check Every Request:** No implicit trust
3. **Protect Direct References:** Indirect reference maps
4. **Test Thoroughly:** Automated and manual access control testing
5. **Log Access:** Comprehensive authorization logging

## Related Branches

- **[Branch 3: Integration Point Exploitation](../branch-03-integration-points.md)** — API-level risks
- **[Branch 7: Authentication and Authorization Exploitation](../branch-07-authentication.md)** — Auth-specific attacks
- **[Branch 8: CI/CD Pipeline Compromise](../branch-08-cicd-pipeline.md)** — Development pipeline risks
- **[Branch 9: Pipeline Integration Exploitation](../branch-09-pipeline-integration.md)** — Data pipeline risks

## References

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP ASVS V1-V3](https://owasp.org/www-project-application-security-verification-standard/)
- [MITRE ATT&CK Web Application Attacks](https://attack.mitre.org/techniques/T1190/)
