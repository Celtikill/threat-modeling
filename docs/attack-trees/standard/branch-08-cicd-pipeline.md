---
branch_number: 8
branch_name: "CI/CD Pipeline Compromise"
assessment_types: ["Type 2"]
risk_level: "Medium"
asvs_chapters: ["V10", "V15"]
aisvs_chapters: []
mitre_techniques: ["T1078", "T1195.002", "T1059", "T1559", "T1213", "T1098"]
tags: ["cicd", "pipeline", "supply-chain", "build", "deployment", "devops"]
related_branches: [1, 6, 9, 21]
---

# Branch 8: CI/CD Pipeline Compromise

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 (Conditional: if CI/CD in scope) |
| **Risk Prevalence** | Medium |
| **ASVS Chapters** | V10 (OAuth/OIDC), V15 (Secure Coding) |
| **AISVS Chapters** | N/A |
| **Related Branches** | [Branch 1](../branch-01-vendor-infrastructure.md) (Vendor), [Branch 6](../branch-06-application-layer.md) (App Layer), [Branch 9](../branch-09-pipeline-integration.md) (Pipeline), [Branch 21](../../ai-specific/branch-21-model-poisoning.md) (AI Supply Chain) |

## Business Impact

CI/CD pipelines are privileged pathways to production. Compromising the build or deployment process enables attackers to inject malicious code that bypasses traditional security controls, as the code appears legitimate and passes all quality gates.

**Key Business Risks:**
- Supply chain attacks through malicious dependencies
- Code injection in build artifacts
- Tampered deployment packages
- Exposure of secrets in build logs
- Compromise of production via build agents

## Attack Tree

```text
Goal: Compromise CI/CD pipeline to inject malicious code
├── 8.1 Repository Manipulation
│   ├── Malicious code injection via compromised developer credentials
│   │   └── Technique: T1078 (Valid Accounts)
│   ├── Pull request poisoning (malicious contributions)
│   │   └── Technique: T1078 (Valid Accounts)
│   ├── Branch protection bypass
│   │   └── Technique: T1098 (Account Manipulation)
│   └── Secrets in committed code or build scripts
│       └── Technique: T1552 (Unsecured Credentials)
├── 8.2 Build Pipeline Injection
│   ├── Build step modification to inject malicious code
│   │   └── Technique: T1059 (Command and Scripting Interpreter)
│   ├── Artifact tampering between build and deployment
│   │   └── Technique: T1559 (Inter-Process Communication)
│   ├── Compromised build agent or runner
│   │   └── Technique: T1078 (Valid Accounts)
│   └── Cache poisoning in dependency resolution
│       └── Technique: T1213 (Data from Information Repositories)
└── 8.3 Dependency and Supply Chain
    ├── Typosquatting attacks on package registries
    │   └── Technique: T1195.002 (Supply Chain Compromise: Software)
    ├── Compromised upstream packages
    │   └── Technique: T1195.002 (Supply Chain Compromise: Software)
    ├── Stale dependencies with known vulnerabilities
    │   └── Technique: T1195.002 (Supply Chain Compromise: Software)
    └── Unverified dependency provenance
        └── Technique: T1195.002 (Supply Chain Compromise: Software)
```text

## Sub-Branch Details

### 8.1 Repository Manipulation

**Threat Description:** Attacks that inject malicious code into the source code repository.

**Common Attack Patterns:**
- Compromised developer accounts pushing malicious commits
- Malicious pull requests from external contributors
- Branch protection rule bypass (force push to protected branch)
- Secrets committed to repositories

**Business Context:**
- Source code is the ultimate trust anchor
- Modern development workflows involve multiple contributors
- Branch protection can be bypassed with sufficient privileges

### 8.2 Build Pipeline Injection

**Threat Description:** Attacks that compromise the build process to inject malicious code.

**Common Attack Patterns:**
- Modification of CI/CD configuration files (.github/workflows, .gitlab-ci.yml)
- Build script injection
- Shared runner compromise
- Artifact tampering in artifact repositories

**Business Context:**
- Build environments have production access
- Build scripts often execute with elevated privileges
- Shared infrastructure creates cross-contamination risk

### 8.3 Dependency and Supply Chain

**Threat Description:** Attacks leveraging third-party dependencies in the software supply chain.

**Common Attack Patterns:**
- Typosquatting (malicious packages with similar names)
- Compromise of legitimate package maintainers
- Dependency confusion attacks
- Known CVE exploitation in dependencies

**Business Context:**
- Modern applications have hundreds of dependencies
- Supply chain attacks are increasing (SolarWinds, Codecov)
- Dependencies have transitive dependencies (supply chain of supply chain)

## MITRE ATT&CK Mapping

| Technique ID | Technique Name | Sub-Branch | Tactic | Context |
|--------------|----------------|------------|--------|---------|
| T1078 | Valid Accounts | 8.1, 8.2 | Initial Access | Developer/pipeline credentials |
| T1098 | Account Manipulation | 8.1 | Persistence | Branch protection bypass |
| T1552 | Unsecured Credentials | 8.1 | Credential Access | Secrets in repos |
| T1059 | Command/Scripting Interpreter | 8.2 | Execution | Build script injection |
| T1559 | Inter-Process Communication | 8.2 | Execution | Artifact tampering |
| T1213 | Data from Info Repositories | 8.2 | Collection | Cache poisoning |
| T1195.002 | Supply Chain Compromise: Software | 8.3 | Initial Access | Dependency attacks |

## Assessment Questions

### Repository Security

1. Are branch protection rules enforced (required reviews, status checks)?
2. Is commit signing required for sensitive repositories?
3. Are secrets scanning tools configured?
4. Is external contributor access restricted?
5. Is repository access logged and monitored?

### Build Pipeline

1. Are build agents isolated (dedicated vs. shared)?
2. Is pipeline configuration version controlled?
3. Are production secrets accessible in build pipelines?
4. Is artifact signing implemented?
5. Is pipeline access limited to necessary personnel?

### Dependencies

1. Are dependencies scanned for vulnerabilities?
2. Is an SBOM maintained?
3. Are dependencies pinned to specific versions?
4. Is private package registry used to prevent confusion?
5. Are transitive dependencies tracked?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 8.1 | V10.2 | Repository security |
| 8.1 | V15.1 | Secure coding practices |
| 8.2 | V15.2 | Build process security |
| 8.2 | V15.3 | Deployment security |
| 8.3 | V15.4 | Dependency management |

## Indicators of Compromise

**Repository Manipulation Indicators:**
- Unusual commit patterns (off-hours, unusual authors)
- Large additions to build scripts
- New dependencies added without review
- Branch protection rule changes
- Force pushes to protected branches

**Build Pipeline Indicators:**
- Pipeline configuration changes
- Build script modifications
- Artifact hash mismatches
- Failed security scans bypassed
- Unusual build agent activity

**Supply Chain Indicators:**
- New dependencies from unknown sources
- Dependency version changes
- Typosquatting attempts detected
- Vulnerable dependency alerts
- Unexpected network calls from dependencies

## Mitigating Requirements

### For Repositories

1. **Branch Protection:** Required reviews, status checks, signed commits
2. **Secrets Scanning:** Automated detection in commits
3. **Access Control:** Principle of least privilege for repository access
4. **Audit Logging:** Track all repository changes
5. **Dependency Review:** Scan PRs for dependency changes

### For Build Pipelines

1. **Isolated Agents:** Dedicated build agents per project
2. **Immutable Infrastructure:** Ephemeral build environments
3. **Artifact Signing:** Cryptographic verification of builds
4. **Pipeline as Code:** Version controlled pipeline definitions
5. **Least Privilege:** Minimal permissions for pipeline execution

### For Dependencies

1. **Vulnerability Scanning:** Automated dependency scanning
2. **SBOM Generation:** Track all dependencies
3. **Pin Versions:** Exact version specifications
4. **Private Registry:** Prevent dependency confusion
5. **Vendor Assessment:** Evaluate dependency maintainers

## Related Branches

- **[Branch 1: Vendor Infrastructure](../branch-01-vendor-infrastructure.md)** — Vendor supply chain risks
- **[Branch 6: Application Layer Exploitation](../branch-06-application-layer.md)** — Application vulnerabilities
- **[Branch 9: Pipeline Integration Exploitation](../branch-09-pipeline-integration.md)** — Data pipeline risks
- **[Branch 21: AI Supply Chain](../../ai-specific/branch-21-model-poisoning.md)** — AI-specific supply chain

## References

- [OWASP CI/CD Security](https://owasp.org/www-project-ci-cd-security/)
- [NIST SSDF](https://csrc.nist.gov/publications/detail/white-paper/2023/06/27/security-measures-for-software-security/v1_0/final)
- [SLSA Framework](https://slsa.dev/)
