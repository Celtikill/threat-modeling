---
branch_number: 21
branch_name: "AI Supply Chain and Model Poisoning"
assessment_types: ["Type 2 (if AI)", "Type 3 (if AI)"]
risk_level: "High"
asvs_chapters: ["V6", "V10"]
aisvs_chapters: ["C3", "C6"]
mitre_techniques: ["AML.T0043", "AML.T0010", "AML.T0061"]
tags: ["ai", "supply-chain", "model-poisoning", "pre-trained", "checkpoint"]
related_branches: [1, 8, 15, 17]
---

# Branch 21: AI Supply Chain and Model Poisoning

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 (if AI), Type 3 (if AI) |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V6 (Authentication), V10 (OAuth/OIDC) |
| **AISVS Chapters** | C3 (Model Lifecycle), C6 (Supply Chain) |
| **Related Branches** | [Branch 1](../standard/branch-01-vendor-infrastructure.md) (Vendor), [Branch 8](../standard/branch-08-cicd-pipeline.md) (CI/CD), [Branch 15](branch-15-training-data-poisoning.md) (Training), [Branch 17](branch-17-model-extraction.md) (Extraction) |

## Business Impact

AI supply chain attacks compromise models during distribution or through poisoned dependencies. Pre-trained models, checkpoints, and training frameworks can all be attack vectors for introducing malicious behavior.

**Key Business Risks:**
- Compromised model registries
- Malicious model serialization
- Poisoned pre-trained weights
- Dependency confusion in ML pipelines
- Checkpoint tampering

## Attack Tree

```text
Goal: Poison AI supply chain to compromise models
├── 21.1 Model Distribution Compromise
│   ├── Compromised model registries (Hugging Face, etc.)
│   │   └── Technique: AML.T0043 (Craft Adversarial Data)
│   ├── Man-in-the-middle on model downloads
│   │   └── Technique: AML.T0010 (ML Supply Chain Compromise)
│   ├── Malicious model serialization (pickle attacks)
│   │   └── Technique: AML.T0010 (ML Supply Chain Compromise)
│   └── Dependency confusion in ML pipelines
│       └── Technique: AML.T0010 (ML Supply Chain Compromise)
└── 21.2 Training Pipeline Injection
    ├── Poisoned pre-trained weights
    │   └── Technique: AML.T0043 (Craft Adversarial Data)
    ├── Malicious optimizer states
    │   └── Technique: AML.T0061 (LLM Prompt Self-Replication)
    ├── Compromised training frameworks (PyTorch, TensorFlow)
    │   └── Technique: AML.T0010 (ML Supply Chain Compromise)
    └── Checkpoint tampering
        └── Technique: AML.T0061 (LLM Prompt Self-Replication)
```text

## Sub-Branch Details

### 21.1 Model Distribution Compromise

**Threat Description:** Attacks on the model distribution and download process.

**Common Attack Patterns:**
- Registry account compromise
- Model upload tampering
- PyTorch/TensorFlow pickle deserialization attacks
- Dependency confusion
- Download interception

**Business Context:**
- Pre-trained models are widely downloaded
- Model registries are high-value targets
- Serialization formats can execute code

### 21.2 Training Pipeline Injection

**Threat Description:** Attacks on training infrastructure and artifacts.

**Common Attack Patterns:**
- Pre-trained weight poisoning
- Optimizer state manipulation
- Framework package compromise
- Checkpoint modification
- Training script injection

**Business Context:**
- Training pipelines have many components
- Framework dependencies are complex
- Checkpoints contain execution code

## MITRE ATLAS Mapping

| Technique ID | Technique Name | Sub-Branch | Context |
|--------------|----------------|------------|---------|
| AML.T0043 | Craft Adversarial Data | 21.1, 21.2 | Data/weight poisoning |
| AML.T0010 | ML Supply Chain Compromise | 21.1, 21.2 | Supply chain |
| AML.T0061 | LLM Prompt Self-Replication | 21.2 | Artifact tampering |

## Assessment Questions

### Model Distribution

1. Are model registries secured?
2. Are downloads authenticated?
3. Are models verified before use?
4. Is serialization secure?
5. Are dependencies pinned?

### Training Pipeline

1. Are training frameworks updated?
2. Are checkpoints secured?
3. Is training infrastructure protected?
4. Are artifacts signed?
5. Is training monitored?

### Supply Chain

1. Are model sources verified?
2. Is provenance tracked?
3. Are dependencies scanned?
4. Is integrity verified?
5. Is the SBOM maintained?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 21.1 | V6.1 | Secure authentication |
| 21.1 | V10.1 | OAuth/OIDC security |
| 21.2 | V10.2 | Artifact security |

## AISVS Requirements

| Sub-Branch | AISVS Section | Verification |
|------------|---------------|--------------|
| 21.1 | C3.1 | Model lifecycle |
| 21.1 | C6.1 | Supply chain security |
| 21.2 | C3.2 | Training security |
| 21.2 | C6.2 | Framework security |

## Indicators of Compromise

**Supply Chain Indicators:**
- Unauthorized model registry access
- Model hash mismatches
- Suspicious serialization patterns
- Dependency changes
- Training artifact anomalies

## Mitigating Requirements

### For Distribution

1. **Registry Security:** Secure model registries
2. **Download Verification:** Verify model integrity
3. **Safe Serialization:** Use safe serialization
4. **Dependency Management:** Pin dependencies
5. **Access Logging:** Log model access

### For Training

1. **Framework Updates:** Keep frameworks updated
2. **Checkpoint Security:** Secure checkpoints
3. **Artifact Signing:** Sign training artifacts
4. **Training Monitoring:** Monitor training
5. **Provenance Tracking:** Track model lineage

## Related Branches

- **[Branch 1: Vendor Infrastructure](../standard/branch-01-vendor-infrastructure.md)** — Vendor supply chain
- **[Branch 8: CI/CD Pipeline](../standard/branch-08-cicd-pipeline.md)** — Build pipeline
- **[Branch 15: Training Data Poisoning](branch-15-training-data-poisoning.md)** — Data poisoning
- **[Branch 17: Model Extraction](branch-17-model-extraction.md)** — Model IP

## References

- [MITRE ATLAS Supply Chain](https://atlas.mitre.org/techniques/AML.T0010)
- [Hugging Face Security](https://huggingface.co/docs/hub/security)
- [OWASP AISVS](https://github.com/OWASP/AISVS/)
