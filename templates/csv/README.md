# CSV Templates: Structured Data Source of Truth

These CSV templates support a **structured data first** workflow for threat modeling assessments. Populate these files during analysis, then reference them when drafting markdown deliverables.

---

## Workflow

```
Phase 1: Analysis (populate CSVs)
    Attack tree analysis → threats.csv
    Evidence review → findings.csv
    Control mapping → requirements.csv

Phase 2: Drafting (reference CSVs)
    Create markdown files using CSV data
    Copy/paste table rows into markdown

Phase 3: Validation
    Use consolidation tools to verify alignment
    Discrepancies flag documentation drift
```

---

## Templates

| Template | Use When | Output Location |
|----------|----------|-----------------|
| `threats-template.csv` | After attack tree analysis | `data/threats.csv` |
| `findings-template.csv` | During evidence review | `data/findings.csv` |
| `requirements-template.csv` | During control selection | `data/requirements.csv` |

---

## File Naming Convention

```
assessment/
├── data/                           # Structured source of truth
│   ├── threats.csv
│   ├── findings.csv
│   └── requirements.csv
└── deliverables/                   # Drafted from CSV data
    ├── {system}-threat-model.md
    ├── {system}-supporting-analysis.md
    └── {system}-requirements.md
```

---

## Column Reference

### threats.csv

| Column | Description | Example |
|--------|-------------|---------|
| `Threat_ID` | Unique identifier (T-XXX) | T-001 |
| `Category` | ATT&CK-style category | Initial Access |
| `Description` | Clear threat scenario | Attacker exploits vulnerable dependency... |
| `Likelihood` | Attack tree derived | High |
| `Impact` | Business/technical impact | Critical |
| `Risk_Level` | Combined risk rating | Critical |
| `MITRE_TECHNIQUE` | ATT&CK technique ID/name | T1190 - Exploit Public-Facing Application |
| `Prerequisites` | Conditions required for threat | Public endpoint exposed to internet |
| `Prerequisites_Validated` | Confirmed in environment? | Yes |
| `Evidence_From_Code_Review` | Finding ID + location that validates threat | F-003: src/auth/handlers.py:45 - SQL injection confirms T-007 |
| `Source_Discovery` | Where threat was first identified | Phase 2B code review - novel vector |
| `Notes` | Additional context | See attack tree Branch 3.2 |

### findings.csv

| Column | Description | Example |
|--------|-------------|---------|
| `Finding_ID` | Unique identifier (F-XXX) | F-001 |
| `Source_Location` | Code/evidence location | src/api/handlers.py:89 |
| `Threat_Ref` | Related Threat_ID(s) | T-001 |
| `Threat_Alignment_Type` | How finding relates to threat | Reinforces / Novel / Expands |
| `Description` | What was found | SQL injection via string concatenation |
| `Severity` | Finding severity | High |
| `Status` | Current state | Open |
| `Evidence_Location` | Where evidence is stored | See Section 4.2 or `/evidence/tls-scan/` |
| `Responsible_Party` | Who fixes it | Platform Engineering |
| `Due_Date` | Target remediation date | 2025-06-01 |
| `Notes` | Additional context | Elevates V6.1 to Required; see T-007 evidence |

### requirements.csv

| Column | Description | Example |
|--------|-------------|---------|
| `Req_ID` | Unique identifier (V.X.X or custom) | V6.1 |
| `Description` | Requirement statement | All access MUST use SSO with MFA... |
| `SSR_Ref` | SSR/ASVS reference | V6.3.1 |
| `Threat_Ref` | Threat(s) this mitigates | T-001, T-013 |
| `Priority` | Required/Recommended/Optional | Required |
| `Verification_Method` | How to verify | SSO configuration review |
| `Category` | SSR/ASVS category | Authentication |
| `Phase` | Implementation phase | Phase 1 |
| `Implementation_Status` | Current state | In Progress |

---

## Baseline + Delta Pattern

For change assessments against existing baselines:

```
data/
├── threats.csv                    # Current threat catalog
├── threats-baseline.csv          # Frozen baseline (optional)
├── findings.csv
├── requirements.csv              # Current requirements
└── requirements-baseline.csv     # Frozen baseline (optional)
```

Delta assessments populate the non-baseline CSVs with only new/changed items.

---

## Phase 2B Feedback Loop Workflow

For Type 2 (Internal Application) assessments, code review findings populate CSVs with architectural evidence:

### Finding → Threat Alignment

```
Code Review Discovery
    │
    ├──► Maps to existing threat ─────┐
    │   (Reinforces risk rating)       │
    │                                  ▼
    ├──► Novel attack vector ───────► Update threats.csv
    │   (Creates new threat)           │ Add Evidence_From_Code_Review
    │                                  │ Document Source_Discovery
    │                                  ▼
    └──► Attack surface expansion ───► Update findings.csv
        (Undocumented component)       │ Set Threat_Alignment_Type
                                       │ Link to Threat_Ref
                                       ▼
                                  Update requirements.csv
                                  (Elevate or add requirements)
```

### Workflow Steps

**Step 1: Code Review Discovery**
- Identify vulnerability or security-relevant pattern
- Determine novelty: Is this vector already in the attack tree?

**Step 2: Threat Alignment**
- **Reinforces existing:** Add evidence to `Evidence_From_Code_Review`
- **Novel vector:** Add new threat row; mark `Source_Discovery`
- **Expands surface:** Add finding with `Threat_Alignment_Type = Expands`

**Step 3: Requirement Impact**
- Update `requirements.csv` Priority (elevate) or add new row

**Step 4: Inline Documentation**
- All updates occur during sprint (no pause)
- Populate Supporting Analysis "Phase 2B Code Review Discoveries" section

See [Internal Feedback Loops](../../docs/internal-feedback-loops.md) for complete guidance.

---

## Validation

After drafting markdown deliverables, run validation to check alignment:

```bash
# Verify CSV content matches markdown tables
python3 scripts/validate-csv-alignment.py data/ deliverables/

# Generate consolidated view
python3 scripts/consolidate-requirements.py assessment/ -o summary.csv
```

---

*These templates support the threat modeling framework documented in /docs/SOP.md*
