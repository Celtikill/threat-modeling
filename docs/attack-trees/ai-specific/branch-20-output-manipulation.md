---
branch_number: 20
branch_name: "AI Output Manipulation and Jailbreaks"
assessment_types: ["Type 2 (if AI)", "Type 3 (if AI)"]
risk_level: "High"
asvs_chapters: ["V3"]
aisvs_chapters: ["C7", "C11"]
mitre_techniques: ["AML.T0051", "AML.T0054", "AML.T0063"]
tags: ["ai", "output-manipulation", "jailbreak", "safety", "filter-bypass"]
related_branches: [16, 17, 18]
---

# Branch 20: AI Output Manipulation and Jailbreaks

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 (if AI), Type 3 (if AI) |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V3 (Web Frontend Security) |
| **AISVS Chapters** | C7 (Model Behavior), C11 (Adversarial Robustness) |
| **Related Branches** | [Branch 16](branch-16-prompt-injection.md) (Prompt Injection), [Branch 17](branch-17-model-extraction.md) (Model Extraction), [Branch 18](branch-18-agent-abuse.md) (Agents) |

## Business Impact

Output manipulation attacks cause AI systems to produce unintended, harmful, or restricted content. Jailbreaks bypass safety controls, potentially enabling misuse of AI systems for malicious purposes.

**Key Business Risks:**
- Generation of harmful content
- Safety filter bypass
- Hallucination amplification
- Toxic output generation
- Confidence manipulation

## Attack Tree

```text
Goal: Manipulate AI outputs to bypass safety controls
├── 20.1 Safety Filter Bypass
│   ├── Jailbreak prompts circumventing guardrails
│   │   └── Technique: AML.T0054 (LLM Jailbreak)
│   ├── Encoding-based filter evasion
│   │   └── Technique: AML.T0051 (LLM Prompt Injection)
│   ├── Multi-language attack vectors
│   │   └── Technique: AML.T0054 (LLM Jailbreak)
│   └── Implicit harmful content generation
│       └── Technique: AML.T0063 (Discover AI Model Outputs)
└── 20.2 Output Integrity Attacks
    ├── Hallucination amplification
    │   └── Technique: AML.T0054 (LLM Jailbreak)
    ├── Confidence score manipulation
    │   └── Technique: AML.T0063 (Discover AI Model Outputs)
    ├── Watermark removal or forgery
    │   └── Technique: AML.T0063 (Discover AI Model Outputs)
    └── Toxicity score evasion
        └── Technique: AML.T0054 (LLM Jailbreak)
```text

## Sub-Branch Details

### 20.1 Safety Filter Bypass

**Threat Description:** Techniques to bypass AI safety controls and content filters.

**Common Attack Patterns:**
- "DAN" (Do Anything Now) jailbreaks
- Role-playing attacks
- Encoding-based bypass (base64, rot13)
- Translation-based evasion
- Persona adoption

**Business Context:**
- Safety filters protect against harmful outputs
- Bypasses can enable misuse
- Public jailbreaks spread quickly

### 20.2 Output Integrity Attacks

**Threat Description:** Manipulation of output characteristics and quality.

**Common Attack Patterns:**
- Prompting for increased hallucinations
- Confidence score manipulation
- Watermark removal
- Toxicity evasion

**Business Context:**
- Output quality affects trust
- Manipulated outputs can mislead users
- Integrity is critical for reliability

## MITRE ATLAS Mapping

| Technique ID | Technique Name | Sub-Branch | Context |
|--------------|----------------|------------|---------|
| AML.T0051 | LLM Prompt Injection | 20.1 | Filter evasion |
| AML.T0054 | LLM Jailbreak | 20.1, 20.2 | Safety bypass |
| AML.T0063 | Discover AI Model Outputs | 20.2 | Output manipulation |

## Assessment Questions

### Safety Controls

1. Are safety filters implemented?
2. Is output filtering comprehensive?
3. Are jailbreak attempts detected?
4. Is filter bypass monitored?
5. Are safety controls regularly tested?

### Output Validation

1. Is output quality monitored?
2. Are hallucinations detected?
3. Is toxicity measured?
4. Is confidence calibrated?
5. Is output audited?

### User Protection

1. Are harmful outputs blocked?
2. Is user warning implemented?
3. Are safety explanations provided?
4. Is escalation possible?
5. Is misuse reported?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 20.1 | V3.1 | Output encoding |
| 20.1 | V3.2 | Content security |

## AISVS Requirements

| Sub-Branch | AISVS Section | Verification |
|------------|---------------|--------------|
| 20.1 | C7.1 | Model behavior control |
| 20.1 | C11.1 | Adversarial robustness |
| 20.2 | C7.2 | Output quality |
| 20.2 | C11.2 | Safety testing |

## Indicators of Compromise

**Safety Bypass Indicators:**
- Jailbreak pattern detection
- Encoding-based input attempts
- Multi-language inputs
- Role-playing attempts
- Filter trigger evasion

## Mitigating Requirements

### For Safety

1. **Layered Filters:** Multiple safety layers
2. **Pattern Detection:** Detect jailbreak attempts
3. **Input Sanitization:** Clean inputs
4. **Output Filtering:** Filter harmful content
5. **Monitoring:** Alert on bypass attempts

### For Output Quality

1. **Hallucination Detection:** Identify false outputs
2. **Confidence Calibration:** Accurate confidence
3. **Toxicity Scoring:** Measure harmful content
4. **Watermarking:** Embed ownership
5. **Quality Metrics:** Track output quality

## Related Branches

- **[Branch 16: Prompt Injection](branch-16-prompt-injection.md)** — Input manipulation
- **[Branch 17: Model Extraction](branch-17-model-extraction.md)** — Model behavior
- **[Branch 18: AI Agent Abuse](branch-18-agent-abuse.md)** — Agent outputs

## References

- [MITRE ATLAS Jailbreak](https://atlas.mitre.org/techniques/AML.T0054)
- [OWASP LLM Security](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [AI Safety](https://www.anthropic.com/safety)
