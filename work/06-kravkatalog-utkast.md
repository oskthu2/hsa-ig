# Kravkatalog – utkast v0.1

> Obs: Detta är ett exekverbart utkast. Samtliga krav måste verifieras mot primärkällor innan status sätts till Normativ.

| Krav-id | Kravtext | FHIR-uttryck (kandidat) | Källa | Status |
|---|---|---|---|---|
| HSACAT-ORG-001 | Organization som representerar vårdgivare SHALL ha HSA-id | `Organization.identifier` slice `hsa-id` 1..1 | Saknas (P1) | Utkast |
| HSACAT-ORG-002 | Organization under annan organisation SHALL ha `partOf` | `Organization.partOf` 1..1 vid underenhet | Saknas (P1/P2) | Utkast |
| HSACAT-ORG-003 | Externt publicerad Organization SHALL ha namn | `Organization.name` 1..1 | Saknas (P1/P2) | Utkast |
| HSACAT-ORG-004 | Externt publicerad Organization SHALL ha kontaktväg | `Organization.telecom` 1..* | Saknas (P1/P2) | Utkast |
| HSACAT-ORG-005 | Organisationsnoder som används för åtkomstbeslut SHALL ha nivåklassificering enligt beslutad modell | `Organization.type`/extension för nivåklassificering (R5-profil) | ADR-002 + Saknas (P1/P2) | Utkast |
| HSACAT-ORG-006 | Organisationsstruktur för inre och yttre spärr SHALL vara traverserbar i träd | `Organization.partOf` och sökning för hierarki | ADR-002 + Saknas (P1/P2) | Utkast |
| HSACAT-LOC-001 | Fysisk Location SHALL ha adress | Invariant: fysisk => `address.exists()` | Saknas (P1) | Utkast |
| HSACAT-LOC-002 | Location SHALL peka ut ansvarig organisation | `Location.managingOrganization` 1..1 | Saknas (P1/P2) | Utkast |
| HSACAT-SVC-001 | HealthcareService SHALL peka ut tillhandahållare | `HealthcareService.providedBy` 1..1 | Saknas (P1/P2) | Utkast |
| HSACAT-SVC-002 | Digital HealthcareService SHALL ha telecom eller endpoint | Invariant: digital => `telecom.exists() or endpoint.exists()` | Saknas (P1/P2) | Utkast |
| HSACAT-TERM-001 | Verksamhetskod SHALL bindas till specificerat ValueSet | Required binding på valt element | Saknas (P1) | Utkast |

## Aktiva frågor att stänga

1. Vilken exakt URI/OID gäller för HSA-id i målkontraktet?
2. Ska publiceringsstatus modelleras explicit i v1?
3. Är person + uppdrag i scope för första release?
4. Vilken exakt nivåklassificering ska användas för åtkomstbeslut (inre/yttre spärr)?
