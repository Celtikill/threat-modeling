---
branch_number: 7
branch_name: "Authentication and Authorization Exploitation"
assessment_types: ["Type 2"]
risk_level: "High"
asvs_chapters: ["V6", "V7", "V8"]
aisvs_chapters: []
mitre_techniques: ["T1078", "T1110", "T1550", "T1539", "T1552", "T1548", "T1212"]
tags: ["authentication", "authorization", "session", "oauth", "jwt", "privilege-escalation"]
related_branches: [2, 6, 10, 13]
---

# Branch 7: Authentication and Authorization Exploitation

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V6 (Authentication), V7 (Session), V8 (Authorization) |
| **AISVS Chapters** | N/A |
| **Related Branches** | [Branch 2](../branch-02-vendor-personnel.md) (Personnel), [Branch 6](../branch-06-application-layer.md) (App Layer), [Branch 10](../branch-10-iam-privilege.md) (IAM), [Branch 13](../branch-13-credential-theft.md) (Secrets) |

## Business Impact

Authentication and authorization are the gatekeepers of system access. Compromising these controls enables unauthorized access to data and functionality, often with minimal detection. These attacks can escalate from single account compromise to full administrative access.

**Key Business Risks:**
- Account takeover and impersonation
- Privilege escalation to administrative access
- Credential stuffing using breached passwords
- Session hijacking and token theft
- Unauthorized cross-tenant access in multi-tenant systems

## Attack Tree

```text
Goal: Exploit authentication and authorization weaknesses
├── 7.1 Credential Compromise
│   ├── Credential stuffing using leaked credential databases
│   │   └── Technique: T1110 (Brute Force)
│   ├── Password spraying against SSO or application login
│   │   └── Technique: T1110.003 (Brute Force: Password Spraying)
│   ├── API key theft from logs, repositories, or environment variables
│   │   └── Technique: T1552 (Unsecured Credentials)
│   └── OAuth token theft or replay attacks
│       └── Technique: T1550 (Use Alternate Authentication Material)
├── 7.2 Session and Token Exploitation
│   ├── JWT signature bypass or algorithm confusion attacks
│   │   └── Technique: T1550 (Use Alternate Authentication Material)
│   ├── Session token prediction or brute-force
│   │   └── Technique: T1110 (Brute Force)
│   ├── OAuth redirect URI manipulation
│   │   └── Technique: T1550 (Use Alternate Authentication Material)
│   └── PKCE bypass in mobile/SPA applications
│       └── Technique: T1550 (Use Alternate Authentication Material)
└── 7.3 Privilege Escalation
    ├── Role assignment manipulation through API abuse
    │   └── Technique: T1548 (Abuse Elevation Control)
    ├── Admin privilege escalation via parameter tampering
    │   └── Technique: T1068 (Exploitation for Privilege Escalation)
    ├── Service account impersonation
    │   └── Technique: T1078 (Valid Accounts)
    └── Cross-tenant data access in multi-tenant applications
        └── Technique: T1068 (Exploitation for Privilege Escalation)
```text

## Sub-Branch Details

### 7.1 Credential Compromise

**Threat Description:** Attacks that obtain legitimate credentials through various means.

**Common Attack Patterns:**
- Credential stuffing with breached password databases
- Password spraying against common accounts
- API key exposure in code repositories
- OAuth token interception
- Phishing for credentials

**Business Context:**
- High prevalence (OWASP Top 7)
- Often first step in multi-stage attacks
- Reuse of credentials across services amplifies impact

### 7.2 Session and Token Exploitation

**Threat Description:** Attacks that steal or manipulate session tokens and authentication artifacts.

**Common Attack Patterns:**
- JWT algorithm confusion (none/HS256 switch)
- Session fixation
- Cookie theft via XSS
- Token replay attacks
- PKCE downgrade attacks

**Business Context:**
- Tokens often have extended lifetimes
- Client-side token storage creates exposure
- Mobile and SPA applications have unique token risks

### 7.3 Privilege Escalation

**Threat Description:** Attacks that elevate access from normal user to privileged accounts.

**Common Attack Patterns:**
- Parameter manipulation to assign admin roles
- Mass assignment attacks
- IDOR to access admin functions
- Service account compromise for system access
- Cross-tenant data leakage

**Business Context:**
- OWASP Top 1: Broken Access Control
- Often combined with authentication weaknesses
- Can result in complete system compromise

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1078 | Valid Accounts | 7.1, 7.3 | Initial Access | Compromised credentials |
| T1110 | Brute Force | 7.1, 7.2 | Credential Access | Credential stuffing |
| T1110.003 | Brute Force: Password Spraying | 7.1 | Credential Access | Targeted brute force |
| T1552 | Unsecured Credentials | 7.1 | Credential Access | API key exposure |
| T1550 | Use Alternate Authentication Material | 7.1, 7.2 | Defense Evasion | Token theft/replay |
| T1539 | Steal Web Session Cookie | 7.2 | Credential Access | Session hijacking |
| T1548 | Abuse Elevation Control | 7.3 | Privilege Escalation | Role manipulation |
| T1068 | Exploitation for Privilege Escalation | 7.3 | Privilege Escalation | Access control bypass |
| T1212 | Exploitation for Credential Access | 7.1 | Credential Access | Authentication bypass |

## Assessment Questions

### Credential Security

1. Is MFA enforced for all user accounts?
2. Are passwords checked against breached credential databases?
3. Is credential stuffing protection implemented?
4. Are API keys rotated regularly?
5. Are credentials never logged or transmitted in plaintext?

### Session Management

1. Are session tokens cryptographically random?
2. Are sessions invalidated on logout and password change?
3. Is session timeout enforced?
4. Are JWTs signed with strong algorithms (RS256, ES256)?
5. Is token binding used where appropriate?

### Authorization Controls

1. Is access control enforced server-side?
2. Are role assignments validated before execution?
3. Is there separation between user and admin functions?
4. Is direct object access properly authorized?
5. Is multi-tenant data properly isolated?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 7.1 | V6.1 | Secure authentication mechanisms |
| 7.1 | V6.2 | Multi-factor authentication |
| 7.1 | V6.4 | Credential recovery protection |
| 7.2 | V7.1 | Session management |
| 7.2 | V9.1 | Self-contained tokens (JWT) |
| 7.3 | V8.1 | Access control design |
| 7.3 | V8.2 | Authorization checks |

## Indicators of Compromise

**Credential Compromise Indicators:**
- Login from unusual locations or devices
- Successful login after many failed attempts
- Use of breached passwords (detected via monitoring)
- API key usage from unexpected sources
- OAuth token usage anomalies

**Session Exploitation Indicators:**
- Session usage from multiple locations
- Session duration anomalies
- Token manipulation attempts (algorithm switch)
- Cookie theft indicators
- Session fixation patterns

**Privilege Escalation Indicators:**
- Role assignment changes
- Access to admin functions from standard users
- Parameter manipulation in requests
- Cross-tenant access attempts
- Service account abuse

## Mitigating Requirements

### For Credentials

1. **Enforce MFA:** Required for all accounts, especially privileged
2. **Block Breached Passwords:** Check against Have I Been Pwned databases
3. **Rate Limit Login:** Prevent credential stuffing and brute force
4. **Secure API Keys:** Rotate regularly, store in secrets managers
5. **Monitor for Abuse:** Alert on credential-related anomalies

### For Sessions

1. **Strong Token Generation:** Cryptographically secure random values
2. **Short Lifetimes:** Access tokens with limited expiry
3. **Secure Storage:** HttpOnly, Secure, SameSite cookies
4. **Proper Invalidation:** Tokens revoked on logout/password change
5. **Algorithm Validation:** Reject "none" algorithm in JWTs

### For Authorization

1. **Server-Side Enforcement:** Never trust client-side authorization
2. **Default Deny:** Require explicit permission grants
3. **Role Validation:** Verify role assignments on every request
4. **Tenant Isolation:** Strict separation in multi-tenant apps
5. **Audit Logging:** Log all authorization decisions

## Related Branches

- **[Branch 2: Vendor Personnel Threats](../branch-02-vendor-personnel.md)** — Credential compromise through personnel
- **[Branch 6: Application Layer Exploitation](../branch-06-application-layer.md)** — Application-level auth weaknesses
- **[Branch 10: IAM Privilege Escalation](../branch-10-iam-privilege.md)** — Infrastructure IAM risks
- **[Branch 13: Credential and Secret Theft](../branch-13-credential-theft.md)** — Secrets management

## References

- [OWASP Top 10 - A07:2021](https://owasp.org/Top10/A07_2021-Identification_and_Authentication_Failures/)
- [OWASP Cheat Sheet - Authentication](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- [NIST SP 800-63B - Authentication](https://pages.nist.gov/800-63-3/sp800-63b.html)
