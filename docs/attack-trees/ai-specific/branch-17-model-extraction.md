---
branch_number: 17
branch_name: "AI Model Extraction and Theft"
assessment_types: ["Type 2 (if AI)", "Type 3 (if AI)"]
risk_level: "Medium"
asvs_chapters: ["V11"]
aisvs_chapters: ["C3", "C7", "C11"]
mitre_techniques: ["AML.T0044", "AML.T0045", "AML.T0055"]
tags: ["ai", "model-extraction", "ip-theft", "model-stealing", "inference"]
related_branches: [15, 20, 21]
---

# Branch 17: AI Model Extraction and Theft

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 (if AI), Type 3 (if AI, if exposing model) |
| **Risk Prevalence** | Medium |
| **ASVS Chapters** | V11 (Cryptography) |
| **AISVS Chapters** | C3 (Model Lifecycle), C7 (Model Behavior), C11 (Adversarial Robustness) |
| **Related Branches** | [Branch 15](branch-15-training-data-poisoning.md) (Training), [Branch 20](branch-20-output-manipulation.md) (Output), [Branch 21](branch-21-model-poisoning.md) (Supply Chain) |

## Business Impact

Model extraction enables adversaries to steal proprietary AI models through API queries, creating competitive disadvantages and potentially exposing training data or model weaknesses.

**Key Business Risks:**
- Intellectual property theft
- Competitive disadvantage
- Training data reconstruction
- Model inversion attacks
- Membership inference exposing sensitive data

## Attack Tree

```text
Goal: Extract AI model through API queries and analysis
├── 17.1 Model Extraction Attacks
│   ├── Query-based model reconstruction
│   │   └── Technique: AML.T0044 (Full ML Model Access)
│   ├── Membership inference attacks
│   │   └── Technique: AML.T0045 (Infer Training Data)
│   ├── Model inversion for sensitive data extraction
│   │   └── Technique: AML.T0045 (Infer Training Data)
│   └── API abuse for model fingerprinting
│       └── Technique: AML.T0044 (Full ML Model Access)
└── 17.2 Intellectual Property Theft
    ├── Architecture extraction via side channels
    │   └── Technique: AML.T0055 (Unsecured Credentials)
    ├── Weight extraction through adversarial queries
    │   └── Technique: AML.T0055 (Unsecured Credentials)
    ├── Training data reconstruction
    │   └── Technique: AML.T0045 (Infer Training Data)
    └── Proprietary algorithm reverse engineering
        └── Technique: AML.T0044 (Full ML Model Access)
```text

## Sub-Branch Details

### 17.1 Model Extraction Attacks

**Threat Description:** Attacks that reconstruct a model's functionality through API queries.

**Common Attack Patterns:**
- Systematic querying to approximate decision boundaries
- Membership inference to identify training data
- Model inversion to reconstruct training samples
- Confidence score exploitation

**Business Context:**
- API-based models are particularly vulnerable
- Extraction can replicate proprietary functionality
- May expose training data privacy

### 17.2 Intellectual Property Theft

**Threat Description:** Theft of model architecture, weights, and proprietary algorithms.

**Common Attack Patterns:**
- Side-channel analysis (timing, memory)
- Weight extraction via precision queries
- Architecture extraction through behavior analysis
- Algorithm reverse engineering

**Business Context:**
- Models represent significant R&D investment
- Architecture and weights are valuable IP
- Theft creates competitive threats

## MITRE ATLAS Mapping

| Technique ID | Technique Name | Sub-Branch | Context |
|--------------|----------------|------------|---------|
| AML.T0044 | Full ML Model Access | 17.1, 17.2 | Model extraction |
| AML.T0045 | Infer Training Data | 17.1, 17.2 | Data reconstruction |
| AML.T0055 | Unsecured Credentials | 17.2 | IP theft |

## Assessment Questions

### API Protection

1. Is API rate limiting enforced?
2. Are query patterns monitored?
3. Is confidence score exposure limited?
4. Are batch queries restricted?
5. Is API access authenticated?

### Model Protection

1. Is model watermarking implemented?
2. Are output perturbations applied?
3. Is query diversity limited?
4. Are membership inference defenses in place?
5. Is model access logged?

### Data Privacy

1. Is training data protected?
2. Is data reconstruction detectable?
3. Are sensitive data classes protected?
4. Is differential privacy applied?
5. Is data anonymization validated?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 17.1 | V11.1 | Cryptographic protection |
| 17.2 | V11.2 | Key management |

## AISVS Requirements

| Sub-Branch | AISVS Section | Verification |
|------------|---------------|--------------|
| 17.1 | C3.1 | Model access control |
| 17.1 | C11.1 | Adversarial robustness |
| 17.2 | C7.1 | Output control |

## Indicators of Compromise

**Model Extraction Indicators:**
- Unusual query patterns
- High-volume systematic queries
- Query diversity anomalies
- Confidence score exploitation attempts
- Reconstruction-like query sequences

## Mitigating Requirements

### For API Access

1. **Rate Limiting:** Restrict query volume
2. **Query Monitoring:** Detect extraction patterns
3. **Confidence Limiting:** Reduce score precision
4. **Authentication:** Verify API users
5. **Access Logging:** Log all queries

### For Model Protection

1. **Watermarking:** Embed ownership markers
2. **Perturbation:** Add noise to outputs
3. **Diversity Limiting:** Restrict query types
4. **Privacy Defenses:** Apply differential privacy
5. **Monitoring:** Detect extraction attempts

## Related Branches

- **[Branch 15: Training Data Poisoning](branch-15-training-data-poisoning.md)** — Data protection
- **[Branch 20: Output Manipulation](branch-20-output-manipulation.md)** — Output controls
- **[Branch 21: AI Supply Chain](branch-21-model-poisoning.md)** — Model distribution

## References

- [MITRE ATLAS Model Extraction](https://atlas.mitre.org/techniques/AML.T0044)
- [Membership Inference Attacks](https://arxiv.org/abs/1610.05820)
- [Model Inversion](https://arxiv.org/abs/1508.07633)
