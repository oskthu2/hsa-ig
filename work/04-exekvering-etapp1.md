# Exekvering – Etapp 1 & 2 statusrapport

> Uppdaterad 2026-05-20. Etapp 1 (krav + källor) avslutad. Etapp 2 (kärnmodell) i det närmaste klar.

## Statusöversikt

| Etapp | Mål | Status |
|---|---|---|
| Etapp 1: Krav + källbas | 24 krav källbekräftade, 9 ADR, källkatalog med 19 poster | **Klar** |
| Etapp 2: Kärnmodell FSH | 5 profiler, 6 extensions, 11 invarianter, 2 codesystems, 6 valuesets, 2 namingsystems, 4 exempelinstanser | **Klar – 0 sushi-fel** |
| Etapp 3: Terminologi + sökbarhet | Canonical URIs, SearchParameters, CapabilityStatement, neg. test | **Ej påbörjad** |

---

## Etapp 1 – genomfört

- [x] Agentisk arbetsmiljö etablerad (`docs/`, `work/`, `input/fsh/`, CI-pipeline).
- [x] Initial backlog, källkatalog (19 poster), beslutslogg (9 ADR) och risklogg skapad.
- [x] 24 krav dokumenterade i kravkatalog (work/06-kravkatalog-utkast.md) – 23 källbekräftade, 1 beslutad.
- [x] Källanalys: HSA-schema 5.3 (org + tjänst), AB servicekontrakt 5.0, TKB, regional tillämpning (EK, KIV, Uppsala LoKatt).
- [x] R5 vs R4 ADR beslutad (ADR-008): R5 normativt i v1, R4-bakåtkomp i v2.
- [x] eHM Nationell katalog som jämförelsepunkt ADR-009.
- [x] Kodverkskatalog (work/11-kodverkskatalog.md) med 8 centrala HSA-kodverk och OID:er.
- [x] Regional tillämpningsanalys (work/12-regional-tillampning.md): EK/Stockholm, KIV/VGR, Uppsala LoKatt.

## Etapp 2 – genomfört

### FSH-artefakter (input/fsh/)

| Kategori | Antal | Artefakter |
|---|---|---|
| Profiler | 5 | HsaCatalogOrganization, HsaHealthcareProviderOrganization, HsaHealthcareUnitOrganization, HsaCatalogLocation, HsaHealthcareService |
| Extensions | 6 | hsa-destination-indicator, hsa-administrative-care-level, hsa-financing-organization, hsa-temporary-info, hsa-navigation, hsa-telecom-type |
| Invarianter | 11 | hsacat-org-hsa-id, hsacat-org-hsa-id-format, hsacat-provider-orgno, hsacat-subunit-partof, hsacat-physical-location-*, hsacat-public-location-position, hsacat-digital-service-contact, hsacat-service-provider, hsacat-temporary-info-end-date, hsacat-public-org-telecom |
| CodeSystems | 2 | hsa-object-class, hsa-telecom-type |
| ValueSets | 6 | HsaOrganizationTypeVS, HsaOwnershipTypeVS, HsaDestinationIndicatorVS, HsaCareTypeVS, HsaServiceTypeVS, HsaTelecomTypeVS |
| NamingSystems | 2 | hsa-identity (OID 1.2.752.29.4.19), organisation-nummer (OID 2.5.4.97) |
| Instanser | 4 | VardgivareExample, VardenhetExample, LocationExample, HealthcareServiceExample |

### FHIR R5-korrigeringar (gjorda under Etapp 2)

- `Organization.telecom`/`.address` → `Organization.contact.telecom`/`.address` (R5-flytt till backbone)
- `HealthcareService.availableTime` → `HealthcareService.availability` (R5 Availability-datatype)
- Invarianter uppdaterade: `telecom.where(...)` → `contact.telecom.where(...)`
- Extension `contains`-deklaration tillagd för `HsaAdministrativeCareLevelExtension` i barn-profil
- FHIR id-regel: `"vårdenhet-example"` → `"vardenhet-example"` (ASCII-kravet)

### Sushi-byggresultat

```
Profiles: 5 | Extensions: 6 | ValueSets: 6 | CodeSystems: 2 | Instances: 6 (+2 NamingSystems)
Errors: 0 | Warnings: 0
```

---

## Etapp 3 – nästa steg

### Prioriterade aktiviteter

1. **Terminologitjänsten**: Hämta canonical URI:er för HSA-kodverk (kräver inloggning) – stänger öppen fråga 6.
2. **eHM Excel**: Hämta "Nationella vårdtjänster v.1.0.0" – stänger öppen fråga 7 + ger harmoniseringsmatris för HSACAT-TERM-001.
3. **SearchParameters**: Definiera sökparametrar för HSA-id, org-typ, destinationIndicator, partOf.
4. **CapabilityStatement**: Server (REST, katalogläsning) + klientprofil.
5. **Negativa testinstanser**: Visa vad som bryter mot invarianterna (saknad HSA-id, felformat id, partOf saknas etc.).
6. **IG Publisher grön**: Full terminologivalidering och länkkontroll.

### Inmatning som fortfarande behövs

| Vad | Varför | Var |
|---|---|---|
| Canonical URI per kodverk | ValueSet-URLs i profiler + terminologiserver | Terminologitjänsten (inloggning krävs) |
| Nationella vårdtjänster v.1.0.0 Excel | Harmoniseringsmatris HSACAT-TERM-001 | eHMs samarbetsyta AFI (inloggning krävs) |
| Formell HSA policy/regelverk | Normativa krav på livscykel, kvalitet, ansvar | Beställare/HSA-förvaltning |
