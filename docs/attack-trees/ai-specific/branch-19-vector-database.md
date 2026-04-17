---
branch_number: 19
branch_name: "AI Vector Database and Embedding Attacks"
assessment_types: ["Type 2 (if AI)", "Type 3 (if AI)"]
risk_level: "Medium"
asvs_chapters: ["V11", "V14"]
aisvs_chapters: ["C8"]
mitre_techniques: ["AML.T0053", "AML.T0055", "AML.T0062"]
tags: ["ai", "vector-database", "embeddings", "rag", "retrieval"]
related_branches: [16, 18, 20]
---

# Branch 19: AI Vector Database and Embedding Attacks

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 (if AI), Type 3 (if AI) |
| **Risk Prevalence** | Medium |
| **ASVS Chapters** | V11 (Cryptography), V14 (Data Protection) |
| **AISVS Chapters** | C8 (Memory and Embeddings) |
| **Related Branches** | [Branch 16](branch-16-prompt-injection.md) (Prompt Injection), [Branch 18](branch-18-agent-abuse.md) (Agents), [Branch 20](branch-20-output-manipulation.md) (Output) |

## Business Impact

Vector databases store embeddings that represent knowledge for RAG systems. Attacks on vector stores can manipulate AI behavior by controlling what information is retrieved, potentially leading to data exposure or malicious content injection.

**Key Business Risks:**
- Unauthorized access to embedding stores
- Vector poisoning affecting retrieval
- Similarity search manipulation
- Embedding extraction for data reconstruction
- Knowledge base corruption

## Attack Tree

```text
Goal: Compromise vector databases to manipulate AI behavior
├── 19.1 Vector Store Compromise
│   ├── Unauthorized access to embedding stores
│   │   └── Technique: AML.T0053 (AI Agent Tool Invocation)
│   ├── Vector poisoning in RAG pipelines
│   │   └── Technique: AML.T0053 (AI Agent Tool Invocation)
│   ├── Similarity search manipulation
│   │   └── Technique: AML.T0055 (Unsecured Credentials)
│   └── Embedding extraction for data reconstruction
│       └── Technique: AML.T0062 (Discover LLM Hallucinations)
└── 19.2 RAG Pipeline Exploitation
    ├── Context injection via poisoned embeddings
    │   └── Technique: AML.T0053 (AI Agent Tool Invocation)
    ├── Source document manipulation
    │   └── Technique: AML.T0053 (AI Agent Tool Invocation)
    ├── Retrieval manipulation affecting model outputs
    │   └── Technique: AML.T0053 (AI Agent Tool Invocation)
    └── Knowledge base corruption
        └── Technique: AML.T0053 (AI Agent Tool Invocation)
```text

## Sub-Branch Details

### 19.1 Vector Store Compromise

**Threat Description:** Attacks targeting the vector database itself.

**Common Attack Patterns:**
- Direct database access exploitation
- Vector insertion/modification
- Similarity search manipulation
- Embedding extraction

**Business Context:**
- Vector stores contain encoded knowledge
- Direct access enables knowledge manipulation
- Embeddings may encode sensitive information

### 19.2 RAG Pipeline Exploitation

**Threat Description:** Attacks on the Retrieval-Augmented Generation pipeline.

**Common Attack Patterns:**
- Document poisoning
- Context injection
- Retrieval ranking manipulation
- Source attribution attacks

**Business Context:**
- RAG systems rely on retrieved context
- Manipulated context affects model outputs
- Source verification is critical

## MITRE ATLAS Mapping

| Technique ID | Technique Name | Sub-Branch | Context |
|--------------|----------------|------------|---------|
| AML.T0053 | AI Agent Tool Invocation | 19.1, 19.2 | Vector manipulation |
| AML.T0055 | Unsecured Credentials | 19.1 | Embedding extraction |
| AML.T0062 | Discover LLM Hallucinations | 19.1 | Store exploitation |

## Assessment Questions

### Vector Store Security

1. Is vector store access controlled?
2. Are embeddings encrypted at rest?
3. Is vector insertion authorized?
4. Is similarity search protected?
5. Are queries monitored?

### RAG Security

1. Are source documents validated?
2. Is context verified before use?
3. Is retrieval logged?
4. Are source attributions accurate?
5. Is knowledge base integrity checked?

### Embedding Protection

1. Is embedding extraction limited?
2. Are sensitive embeddings protected?
3. Is embedding quality monitored?
4. Are embeddings anonymized?
5. Is embedding provenance tracked?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 19.1 | V11.1 | Cryptographic protection |
| 19.1 | V14.1 | Data classification |
| 19.2 | V14.2 | Data integrity |

## AISVS Requirements

| Sub-Branch | AISVS Section | Verification |
|------------|---------------|--------------|
| 19.1 | C8.1 | Embedding protection |
| 19.1 | C8.2 | Vector store security |
| 19.2 | C8.3 | RAG security |

## Indicators of Compromise

**Vector Store Indicators:**
- Unusual vector access patterns
- Vector modification attempts
- Similarity query anomalies
- Embedding extraction attempts
- Knowledge base drift

## Mitigating Requirements

### For Vector Stores

1. **Access Control:** Restrict vector store access
2. **Encryption:** Encrypt embeddings at rest
3. **Insertion Control:** Authorize vector insertion
4. **Query Monitoring:** Monitor similarity searches
5. **Anomaly Detection:** Detect unusual patterns

### For RAG

1. **Document Validation:** Verify source documents
2. **Context Verification:** Validate retrieved context
3. **Source Attribution:** Accurate source tracking
4. **Integrity Checks:** Verify knowledge base
5. **Retrieval Logging:** Log all retrievals

## Related Branches

- **[Branch 16: Prompt Injection](branch-16-prompt-injection.md)** — Context manipulation
- **[Branch 18: AI Agent Abuse](branch-18-agent-abuse.md)** — Agent RAG usage
- **[Branch 20: Output Manipulation](branch-20-output-manipulation.md)** — RAG output

## References

- [MITRE ATLAS Adversarial Input](https://atlas.mitre.org/techniques/AML.T0053)
- [OWASP AISVS](https://github.com/OWASP/AISVS/)
- [Vector Database Security](https://www.pinecone.io/learn/)
