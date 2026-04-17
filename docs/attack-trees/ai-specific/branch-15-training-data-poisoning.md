---
branch_number: 15
branch_name: "AI Training Data Poisoning"
assessment_types: ["Type 2 (if AI)", "Type 3 (if AI)"]
risk_level: "High"
asvs_chapters: []
aisvs_chapters: ["C1"]
mitre_techniques: ["AML.T0043", "AML.T0054"]
tags: ["ai", "training-data", "poisoning", "data-integrity", "supply-chain"]
related_branches: [1, 4, 21]
---

# Branch 15: AI Training Data Poisoning

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 (if AI), Type 3 (if AI) |
| **Risk Prevalence** | High |
| **ASVS Chapters** | N/A |
| **AISVS Chapters** | C1 (Training Data Integrity) |
| **Related Branches** | [Branch 1](../standard/branch-01-vendor-infrastructure.md) (Vendor), [Branch 4](../standard/branch-04-business-disruption.md) (Disruption), [Branch 21](branch-21-model-poisoning.md) (AI Supply Chain) |

## Business Impact

Training data poisoning corrupts the fundamental learning material for AI models. Poisoned data can cause models to learn incorrect behaviors, produce biased outputs, or contain backdoors that activate under specific conditions.

**Key Business Risks:**
- Model behavior manipulation through poisoned training data
- Backdoor insertion for adversarial control
- Bias amplification affecting fairness
- Data quality degradation
- Supply chain attacks on training data providers

## Attack Tree

```text
Goal: Poison AI training data to manipulate model behavior
├── 15.1 Data Source Compromise
│   ├── Malicious data injection into training datasets
│   │   └── Technique: AML.T0043 (Craft Adversarial Data)
│   ├── Compromised data labeling services
│   │   └── Technique: AML.T0043 (Craft Adversarial Data)
│   ├── Data drift manipulation affecting model behavior
│   │   └── Technique: AML.T0054 (Poison Training Data)
│   └── Supply chain attacks on training data providers
│       └── Technique: AML.T0043 (Craft Adversarial Data)
└── 15.2 Label Integrity Attacks
    ├── Label flipping to corrupt model training
    │   └── Technique: AML.T0054 (Poison Training Data)
    ├── Backdoor insertion via poisoned samples
    │   └── Technique: AML.T0054 (Poison Training Data)
    ├── Data quality degradation through noise injection
    │   └── Technique: AML.T0043 (Craft Adversarial Data)
    └── Annotation service compromise
        └── Technique: AML.T0043 (Craft Adversarial Data)
```text

## Sub-Branch Details

### 15.1 Data Source Compromise

**Threat Description:** Injection of malicious data at the source of training datasets.

**Common Attack Patterns:**
- Injection of crafted adversarial examples
- Compromise of crowdsourcing platforms for labeling
- Manipulation of data collection pipelines
- Third-party dataset poisoning

**Business Context:**
- Training datasets are often aggregated from multiple sources
- Data provenance is difficult to verify
- Open-source datasets are particularly vulnerable

### 15.2 Label Integrity Attacks

**Threat Description:** Manipulation of data labels to corrupt the learning process.

**Common Attack Patterns:**
- Label flipping (changing correct labels)
- Backdoor pattern insertion
- Targeted poisoning of specific classes
- Annotation quality degradation

**Business Context:**
- Labels are critical supervision signals
- Subtle poisoning can be hard to detect
- Can create selective backdoors for adversarial activation

## MITRE ATLAS Mapping

| Technique ID | Technique Name | Sub-Branch | Context |
|--------------|----------------|------------|---------|
| AML.T0043 | Craft Adversarial Data | 15.1, 15.2 | Adversarial sample creation |
| AML.T0054 | Poison Training Data | 15.1, 15.2 | Training set manipulation |

## Assessment Questions

### Data Sources

1. What are the sources of training data?
2. Is data provenance tracked?
3. Are third-party datasets vetted?
4. Is data collection infrastructure secured?
5. Are data access controls implemented?

### Labeling Process

1. How are data labels validated?
2. Is annotation quality monitored?
3. Are labeling services secured?
4. Is there multi-annotator validation?
5. Are label distributions monitored?

### Data Quality

1. Is data quality assessed before training?
2. Are anomaly detection mechanisms in place?
3. Is data drift monitored?
4. Are training datasets version controlled?
5. Is data lineage maintained?

## AISVS Requirements

| Sub-Branch | AISVS Section | Verification |
|------------|---------------|--------------|
| 15.1 | C1.1 | Training data sourcing |
| 15.1 | C1.2 | Data provenance |
| 15.2 | C1.3 | Label integrity |
| 15.2 | C1.4 | Data validation |

## Indicators of Compromise

**Data Poisoning Indicators:**
- Unusual data distribution shifts
- Anomalous training sample patterns
- Unexpected model behavior changes
- Data source security incidents
- Label quality anomalies

## Mitigating Requirements

### For Data Sources

1. **Source Verification:** Validate data sources
2. **Provenance Tracking:** Maintain data lineage
3. **Supply Chain Security:** Vet third-party data
4. **Access Controls:** Restrict data modification
5. **Regular Audits:** Review data sources

### For Labeling

1. **Multi-Validation:** Multiple annotators per sample
2. **Quality Metrics:** Track annotation quality
3. **Consensus Mechanisms:** Resolve label conflicts
4. **Adversarial Detection:** Detect suspicious patterns
5. **Secure Infrastructure:** Protect labeling systems

## Related Branches

- **[Branch 1: Vendor Infrastructure](../standard/branch-01-vendor-infrastructure.md)** — Data source vendor risks
- **[Branch 4: Business Disruption](../standard/branch-04-business-disruption.md)** — Data availability
- **[Branch 21: AI Supply Chain](branch-21-model-poisoning.md)** — Supply chain poisoning

## References

- [MITRE ATLAS Training Data Poisoning](https://atlas.mitre.org/techniques/AML.T0054)
- [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework)
- [OWASP AISVS](https://github.com/OWASP/AISVS/)
