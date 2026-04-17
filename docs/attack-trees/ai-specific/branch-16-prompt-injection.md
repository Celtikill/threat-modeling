---
branch_number: 16
branch_name: "AI Prompt Injection and Input Manipulation"
assessment_types: ["Type 2 (if AI)", "Type 3 (if AI)"]
risk_level: "High"
asvs_chapters: ["V1", "V2"]
aisvs_chapters: ["C2"]
mitre_techniques: ["AML.T0051", "AML.T0054", "AML.T0057"]
tags: ["ai", "llm", "prompt-injection", "jailbreak", "rag"]
related_branches: [6, 18, 19, 20]
---

# Branch 16: AI Prompt Injection and Input Manipulation

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 (if AI), Type 3 (if AI, if exposing LLM) |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V1 (Architecture), V2 (Validation) |
| **AISVS Chapters** | C2 (User Input Validation) |
| **Related Branches** | [Branch 6](../standard/branch-06-application-layer.md) (App Layer), [Branch 18](branch-18-agent-abuse.md) (Agents), [Branch 19](branch-19-vector-database.md) (Vector DB), [Branch 20](branch-20-output-manipulation.md) (Output) |

## Business Impact

Prompt injection attacks manipulate AI systems through crafted inputs, potentially causing unauthorized actions, information disclosure, or bypass of safety controls. This is a critical vulnerability in LLM-based systems.

**Key Business Risks:**
- System prompt extraction revealing instructions
- Instruction override attacks
- Context manipulation for bypass
- Multi-turn conversation poisoning
- Malicious content injection via RAG

## Attack Tree

```text
Goal: Manipulate AI system through crafted inputs
├── 16.1 Direct Prompt Injection
│   ├── System prompt extraction via jailbreaks
│   │   └── Technique: AML.T0051 (LLM Prompt Injection)
│   ├── Instruction override attacks
│   │   └── Technique: AML.T0051 (LLM Prompt Injection)
│   ├── Context manipulation to bypass safety filters
│   │   └── Technique: AML.T0054 (LLM Jailbreak)
│   └── Multi-turn conversation poisoning
│       └── Technique: AML.T0051 (LLM Prompt Injection)
└── 16.2 Indirect Prompt Injection
    ├── Malicious content in external data sources (RAG)
    │   └── Technique: AML.T0057 (LLM Data Leakage)
    ├── Compromised tool outputs influencing model behavior
    │   └── Technique: AML.T0051 (LLM Prompt Injection)
    ├── Document-based injection attacks
    │   └── Technique: AML.T0051 (LLM Prompt Injection)
    └── Code execution via generated content
        └── Technique: AML.T0054 (LLM Jailbreak)
```text

## Sub-Branch Details

### 16.1 Direct Prompt Injection

**Threat Description:** Direct manipulation of AI through user-provided prompts.

**Common Attack Patterns:**
- "Ignore previous instructions" attacks
- System prompt extraction
- Role-playing attacks
- Encoding-based bypass (base64, etc.)
- Delimiter confusion attacks

**Business Context:**
- Direct injection is the most common LLM attack
- Can reveal system prompts containing sensitive information
- May bypass safety controls entirely

### 16.2 Indirect Prompt Injection

**Threat Description:** Injection via external data sources processed by the AI.

**Common Attack Patterns:**
- Malicious content in RAG documents
- Poisoned web content retrieval
- Email/document-based injection
- Tool output manipulation

**Business Context:**
- RAG systems process untrusted content
- Indirect injection is harder to detect
- Can persist across conversations

## MITRE ATLAS Mapping

| Technique ID | Technique Name | Sub-Branch | Context |
|--------------|----------------|------------|---------|
| AML.T0051 | LLM Prompt Injection | 16.1, 16.2 | Direct and indirect injection |
| AML.T0054 | LLM Jailbreak | 16.1 | Safety bypass |
| AML.T0057 | LLM Data Leakage | 16.2 | RAG-based attacks |

## Assessment Questions

### Input Validation

1. Is user input validated before processing?
2. Are prompt boundaries clearly defined?
3. Is system prompt isolation maintained?
4. Are delimiters protected from manipulation?
5. Is input length limited appropriately?

### Safety Controls

1. Are safety filters implemented?
2. Is output filtering applied?
3. Are harmful content categories defined?
4. Is filter bypass detectable?
5. Are safety controls tested regularly?

### RAG Security

1. Are RAG documents sanitized?
2. Is document provenance tracked?
3. Are malicious documents detectable?
4. Is retrieval isolated from execution?
5. Are tool outputs validated?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 16.1 | V1.5 | Input validation architecture |
| 16.1 | V2.1 | Input validation |
| 16.2 | V5.1 | File upload security |

## AISVS Requirements

| Sub-Branch | AISVS Section | Verification |
|------------|---------------|--------------|
| 16.1 | C2.1 | Input validation |
| 16.1 | C2.2 | Prompt injection prevention |
| 16.2 | C2.3 | External content validation |

## Indicators of Compromise

**Prompt Injection Indicators:**
- Attempts to extract system prompts
- Instruction override attempts
- Delimiter manipulation
- Encoding-based bypass attempts
- Multi-turn manipulation patterns

## Mitigating Requirements

### For Direct Injection

1. **Input Validation:** Strict prompt validation
2. **System Prompt Protection:** Isolate system instructions
3. **Output Filtering:** Filter harmful outputs
4. **Rate Limiting:** Prevent abuse
5. **Monitoring:** Alert on injection attempts

### For Indirect Injection

1. **Content Sanitization:** Clean RAG documents
2. **Document Validation:** Verify document integrity
3. **Tool Output Validation:** Validate tool results
4. **Isolation:** Separate retrieval from generation
5. **Provenance Tracking:** Track content sources

## Related Branches

- **[Branch 6: Application Layer](../standard/branch-06-application-layer.md)** — Input validation
- **[Branch 18: AI Agent Abuse](branch-18-agent-abuse.md)** — Agent-based attacks
- **[Branch 19: Vector Database](branch-19-vector-database.md)** — RAG security
- **[Branch 20: Output Manipulation](branch-20-output-manipulation.md)** — Output controls

## References

- [OWASP Top 10 for LLM](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [MITRE ATLAS Prompt Injection](https://atlas.mitre.org/techniques/AML.T0051)
- [Prompt Injection Paper](https://arxiv.org/abs/2302.12173)
