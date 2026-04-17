---
branch_number: 18
branch_name: "AI Agent and Orchestration Abuse"
assessment_types: ["Type 2 (if AI)"]
risk_level: "High"
asvs_chapters: ["V8", "V10"]
aisvs_chapters: ["C9", "C10"]
mitre_techniques: ["AML.T0056"]
tags: ["ai", "agents", "orchestration", "tools", "mcp", "autonomous"]
related_branches: [16, 19, 20]
---

# Branch 18: AI Agent and Orchestration Abuse

## At a Glance

| Attribute | Value |
|-----------|-------|
| **Assessment Types** | Type 2 (if AI) |
| **Risk Prevalence** | High |
| **ASVS Chapters** | V8 (Authorization), V10 (OAuth/OIDC) |
| **AISVS Chapters** | C9 (Agentic Action), C10 (MCP Security) |
| **Related Branches** | [Branch 16](branch-16-prompt-injection.md) (Prompt Injection), [Branch 19](branch-19-vector-database.md) (Vector DB), [Branch 20](branch-20-output-manipulation.md) (Output) |

## Business Impact

AI agents with tool access can perform autonomous actions on behalf of users. Compromised or manipulated agents can cause significant damage through unauthorized actions, data deletion, or resource abuse.

**Key Business Risks:**
- Unauthorized autonomous actions
- Privilege escalation via agent delegation
- Tool chain manipulation
- Resource exhaustion via agent loops
- Cross-agent lateral movement

## Attack Tree

```text
Goal: Abuse AI agent capabilities for unauthorized actions
├── 18.1 Agent Credential Compromise
│   ├── Service account theft for AI agents
│   │   └── Technique: AML.T0056 (LLM Meta Prompt Extraction)
│   ├── Token replay attacks on agent authentication
│   │   └── Technique: (No direct ATLAS mapping: credential theft pattern)
│   ├── Privilege escalation via agent delegation
│   │   └── Technique: AML.T0056 (LLM Meta Prompt Extraction)
│   └── Cross-agent lateral movement
│       └── Technique: (No direct ATLAS mapping: cross-agent lateral movement)
└── 18.2 Tool Chain Manipulation
    ├── Malicious tool registration in agent frameworks
    │   └── Technique: AML.T0056 (LLM Meta Prompt Extraction)
    ├── MCP (Model Context Protocol) exploitation
    │   └── Technique: AML.T0056 (LLM Meta Prompt Extraction)
    ├── Agent workflow hijacking
    │   └── Technique: AML.T0056 (LLM Meta Prompt Extraction)
    └── Resource exhaustion via agent loops
        └── Technique: AML.T0056 (LLM Meta Prompt Extraction)
```text

## Sub-Branch Details

### 18.1 Agent Credential Compromise

**Threat Description:** Compromise of credentials used by AI agents for authentication.

**Common Attack Patterns:**
- Service account key theft
- Agent token interception
- Delegation chain exploitation
- Session hijacking

**Business Context:**
- Agents often have broad permissions
- Credential compromise grants agent capabilities
- Delegation chains create complex trust relationships

### 18.2 Tool Chain Manipulation

**Threat Description:** Abuse of tools available to AI agents.

**Common Attack Patterns:**
- Malicious tool registration
- Tool parameter injection
- Workflow hijacking
- Infinite loop creation
- MCP exploitation

**Business Context:**
- Tools extend agent capabilities significantly
- Tool security varies widely
- Agent frameworks may have vulnerabilities

## MITRE ATLAS Mapping

| Technique ID | Technique Name | Sub-Branch | Context |
|--------------|----------------|------------|---------|
| AML.T0056 | LLM Meta Prompt Extraction | 18.1, 18.2 | Tool abuse |
| — | (No direct ATLAS mapping) | 18.1 | Credential theft |
| — | (No direct ATLAS mapping) | 18.1 | Cross-agent movement |

## Assessment Questions

### Agent Permissions

1. Are agent permissions scoped appropriately?
2. Is least privilege enforced for agents?
3. Are agent actions auditable?
4. Is agent delegation controlled?
5. Are agent tokens short-lived?

### Tool Security

1. Are tools vetted before registration?
2. Are tool permissions restricted?
3. Are tool inputs validated?
4. Are tool outputs sanitized?
5. Is MCP security implemented?

### Orchestration

1. Are workflow boundaries enforced?
2. Are loop detection mechanisms in place?
3. Is agent coordination secured?
4. Are resource limits enforced?
5. Is orchestration monitored?

## ASVS Requirements

| Sub-Branch | ASVS Section | Verification |
|------------|--------------|--------------|
| 18.1 | V8.1 | Access control design |
| 18.1 | V10.1 | OAuth/OIDC security |
| 18.2 | V8.2 | Authorization checks |

## AISVS Requirements

| Sub-Branch | AISVS Section | Verification |
|------------|---------------|--------------|
| 18.1 | C9.1 | Agent access control |
| 18.1 | C9.2 | Agent monitoring |
| 18.2 | C10.1 | MCP security |
| 18.2 | C10.2 | Tool validation |

## Indicators of Compromise

**Agent Abuse Indicators:**
- Unusual agent actions
- Tool usage anomalies
- Delegation chain anomalies
- Resource consumption spikes
- Cross-agent access patterns

## Mitigating Requirements

### For Agents

1. **Permission Scoping:** Minimal necessary permissions
2. **Short-Lived Tokens:** Limit token lifetime
3. **Action Auditing:** Log all agent actions
4. **Delegation Control:** Restrict delegation chains
5. **Anomaly Detection:** Monitor for unusual behavior

### For Tools

1. **Vetting:** Validate tools before registration
2. **Permission Restriction:** Least privilege for tools
3. **Input Validation:** Validate tool inputs
4. **Output Sanitization:** Clean tool outputs
5. **MCP Security:** Secure MCP implementation

## Related Branches

- **[Branch 16: Prompt Injection](branch-16-prompt-injection.md)** — Agent manipulation
- **[Branch 19: Vector Database](branch-19-vector-database.md)** — Agent memory
- **[Branch 20: Output Manipulation](branch-20-output-manipulation.md)** — Agent output

## References

- [MITRE ATLAS Agent Security](https://atlas.mitre.org/techniques/AML.T0056)
- [OWASP LLM Agents](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [MCP Security](https://modelcontextprotocol.io/)
