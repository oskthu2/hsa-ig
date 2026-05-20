# Kravspårningstabell v0.1

| Krav-id | Status | Källa (SRC) | Beslut (ADR) | Risk (RSK) | Primärt FHIR-uttryck | Nästa steg |
|---|---|---|---|---|---|---|
| HSACAT-ORG-001 | Verifierad | SRC-006, SRC-007 | ADR-003, ADR-005 | - | `Organization.identifier` (HSA-id slice) | Fastställ exakt URI/OID |
| HSACAT-ORG-005 | Utkast | SRC-006 (behöver komplettering) | ADR-002, ADR-003 | RSK-002 | `Organization.type`/extension för nivåklass | Verifiera nivåkodverk |
| HSACAT-ORG-006 | Utkast | SRC-006 (behöver komplettering) | ADR-002, ADR-006 | RSK-001 | `Organization.partOf` + sökbar hierarki | Definiera traverseringskrav |
| HSACAT-LOC-002 | Utkast | SRC-006, SRC-007 | ADR-003 | - | `Location.managingOrganization` | Validera kardinalitet |
| HSACAT-SVC-001 | Utkast | SRC-006 (behöver komplettering) | ADR-003, ADR-006 | - | `HealthcareService.providedBy` | Verifiera mot tillämpningskälla |
