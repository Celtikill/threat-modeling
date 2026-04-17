---
branch_number: 13
branch_name: "Credential and Secret Theft"
assessment_types: ["Type 3"]
risk_level: "High"
asvs_chapters: ["V6", "V9", "V11"]
aisvs_chapters: []
mitre_techniques: ["T1552", "T1555", "T1550"]
tags: ["credentials", "secrets", "key-management", "secrets-manager"]
related_branches: [2, 7, 10]
---

# Branch 13: Credential and Secret Theft

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 3 |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V6 (Authentication), V9 (Tokens), V11 (Cryptography) |
| **AISVS Chapters** | N/A |
| **Related Branches** | [Branch 2](../branch-02-vendor-personnel.md) (Personnel), [Branch 7](../branch-07-authentication.md) (Auth), [Branch 10](../branch-10-iam-privilege.md) (IAM) |

## Business Impact

Credential theft provides attackers with legitimate access to systems, often bypassing security controls that focus on external threats. Compromised credentials can lead to data breaches, unauthorized resource access, and privilege escalation.

**Key Business Risks:**
- Overly permissive access to secrets managers
- Unrotated secrets creating extended exposure windows
- Hardcoded credentials in code or configuration
- Insecure storage of sensitive credentials
- Token theft and replay attacks

## Attack Tree

```text
Goal: Steal credentials and secrets to gain unauthorized access
├── 13.1 Secrets Manager Exploitation
│   ├── Overly permissive access to secrets manager
│   │   └── Technique: T1552.001 (Credentials In Files)
│   ├── Unrotated secrets in secrets manager
│   │   └── Technique: T1552 (Unsecured Credentials)
│   ├── Secrets referenced in CloudFormation/Terraform state files
│   │   └── Technique: T1552.001 (Credentials In Files)
│   └── Missing encryption on secret values
│       └── Technique: T1555 (Credentials from Password Stores)
└── 13.2 Key Management Exploitation
    ├── KMS key policy misconfiguration allowing decryption
    │   └── Technique: T1552.004 (Private Keys)
    ├── Missing key rotation policies
    │   └── Technique: T1552.004 (Private Keys)
    ├── Hardcoded credentials in IaC templates
    │   └── Technique: T1552.001 (Credentials In Files)
    └── Environment variables containing credentials in compute instances
        └── Technique: T1552.001 (Credentials In Files)
```text

## Sub-Branch Details

### 13.1 Secrets Manager Exploitation

**Threat Description:** Attacks targeting secrets management services like AWS Secrets Manager, Azure Key Vault, or HashiCorp Vault.

**Common Attack Patterns:**
- Overly permissive IAM policies for secrets access
- Secrets cached in application memory dumps
- State files containing plaintext secrets
- Lack of secret versioning and rotation

**Business Context:**
- Secrets managers are critical trust anchors
- Misconfiguration can expose all secrets
- Rotation is essential but often neglected

### 13.2 Key Management Exploitation

**Threat Description:** Attacks on cryptographic key management systems.

**Common Attack Patterns:**
- KMS key policies allowing decryption by unintended principals
- Lack of automatic key rotation
- Hardcoded keys in source code
- Environment variable exposure
- Weak key generation practices

**Business Context:**
- Keys protect data at rest
- Key compromise affects all protected data
- Recovery from key compromise is difficult

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1552 | Unsecured Credentials | 13.1, 13.2 | Credential Access | General credential theft |
| T1552.001 | Credentials In Files | 13.1, 13.2 | Credential Access | Hardcoded credentials |
| T1555 | Credentials from Password Stores | 13.1 | Credential Access | Browser-stored credentials |
| T1552.004 | Private Keys | 13.2 | Credential Access | Cryptographic keys |
| T1550 | Use Alternate Authentication Material | 13.2 | Defense Evasion | Token replay |

## Assessment Questions

### Secrets Management

1. Are secrets stored in dedicated secrets managers?
2. Is access to secrets manager scoped by principle of least privilege?
3. Are secrets rotated automatically?
4. Are secrets encrypted at rest?
5. Is secret access logged?

### Key Management

1. Are KMS keys managed by cloud provider or HSM?
2. Is key rotation automated?
3. Are key policies restrictive?
4. Are private keys never committed to source control?
5. Is key usage monitored?

### Credential Hygiene

1. Are credentials never hardcoded?
2. Are environment variables scanned for secrets?
3. Are state files secured?
4. Are credentials never logged?
5. Are credentials rotated on suspected compromise?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 13.1 | V6.1 | Secure credential storage |
| 13.1 | V9.1 | Token security |
| 13.2 | V11.1 | Cryptographic key management |
| 13.2 | V11.2 | Key rotation |

## Indicators of Compromise

**Secrets Exploitation Indicators:**
- Unusual secrets manager access
- Secret retrieval from unexpected locations
- Secret access outside of expected patterns
- Secrets manager policy changes
- Failed secret decryption attempts

**Key Exploitation Indicators:**
- KMS key usage anomalies
- Decryption from unexpected principals
- Key policy modifications
- Private key exposure in logs
- Cryptographic operation anomalies

## Mitigating Requirements

### For Secrets

1. **Dedicated Manager:** Use purpose-built secrets managers
2. **Access Control:** Strict IAM policies for secrets access
3. **Automatic Rotation:** Regular secret rotation
4. **Encryption:** Encrypt secrets at rest and in transit
5. **Audit Logging:** Comprehensive access logging

### For Keys

1. **HSM Protection:** Use hardware security modules where appropriate
2. **Automatic Rotation:** Enforce key rotation policies
3. **Restrictive Policies:** Minimal key usage permissions
4. **No Hardcoding:** Never commit keys to source control
5. **Usage Monitoring:** Alert on anomalous key usage

## Related Branches

- **[Branch 2: Vendor Personnel Threats](../branch-02-vendor-personnel.md)** — Personnel-based credential compromise
- **[Branch 7: Authentication and Authorization Exploitation](../branch-07-authentication.md)** — Authentication weaknesses
- **[Branch 10: IAM Privilege Escalation](../branch-10-iam-privilege.md)** — IAM-based credential abuse

## References

- [AWS Secrets Manager Security](https://docs.aws.amazon.com/secretsmanager/latest/userguide/security.html)
- [Azure Key Vault Security](https://docs.microsoft.com/en-us/azure/key-vault/general/security-features)
- [GCP Secret Manager Security](https://cloud.google.com/secret-manager/docs/overview)
