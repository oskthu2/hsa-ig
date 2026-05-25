# Nedladdningar

Denna sida samlar nedladdningsbara artefakter från HSA Katalog IG.

---

## FHIR-paket (npm)

Det rekommenderade sättet att använda IG:n i FHIR-verktyg, validerare och IG-byggare.

| Paket | Beskrivning |
|---|---|
| `inera.se.hsa.katalog#0.1.0` | Komplett IG-paket med alla profiler, kodverk, exempel och konformansdeklarationer |

```
# Installera med FHIR npm-registret
npm --registry https://packages.simplifier.net install inera.se.hsa.katalog@0.1.0

# Eller med fhir-package-loader
fhir-package-loader install inera.se.hsa.katalog#0.1.0
```

Paketet innehåller alla StructureDefinition-, CodeSystem-, ValueSet-, SearchParameter- och CapabilityStatement-resurser i JSON-format.

---

## Konformansdeklarationer (CapabilityStatements)

CapabilityStatements i denna IG är illustrativa exempel på möjliga integrationsmönster,
inte formellt antagna krav. De kan laddas ner som FHIR JSON och användas som
utgångspunkt för egna implementationer.

### Serverexempel

| Artefakt | Illustrerar | JSON |
|---|---|---|
| [HSA Central Catalog Server](CapabilityStatement-hsa-catalog-server.html) | Möjligt centralt källsystem med läsaccess | [↓ JSON](CapabilityStatement-hsa-catalog-server.json) |
| [HSA Regional Catalog Server](CapabilityStatement-hsa-regional-catalog-server.html) | Hypotetiskt regionalt mellanlager med läs- och skrivsupport | [↓ JSON](CapabilityStatement-hsa-regional-catalog-server.json) |

### Klientexempel

| Artefakt | Illustrerar | JSON |
|---|---|---|
| [1177 Hitta vård](CapabilityStatement-hsa-client-1177-hitta-vard.html) | UC-03: Möjliga förmågor för publik vårdsökning och geo-sökning | [↓ JSON](CapabilityStatement-hsa-client-1177-hitta-vard.json) |
| [NPÖ](CapabilityStatement-hsa-client-npo.html) | UC-02: Möjliga förmågor för arbetsplatskodssökning och hierarki | [↓ JSON](CapabilityStatement-hsa-client-npo.json) |
| [Hierarkitraversering](CapabilityStatement-hsa-client-hierarchy-traversal.html) | Möjliga förmågor för SKLTP-liknande trädklättring (v1) | [↓ JSON](CapabilityStatement-hsa-client-hierarchy-traversal.json) |
| [EHR-katalogsynk](CapabilityStatement-hsa-client-ehr-sync.html) | UC-01 + UC-04: Möjliga förmågor för katalogsynk och Encounter.type | [↓ JSON](CapabilityStatement-hsa-client-ehr-sync.json) |

---

## Profiler (StructureDefinitions)

| Profil | Resurs | JSON |
|---|---|---|
| [HsaCatalogOrganization](StructureDefinition-hsa-catalog-organization.html) | Organization | [↓ JSON](StructureDefinition-hsa-catalog-organization.json) |
| [HsaHealthcareProviderOrganization](StructureDefinition-hsa-healthcare-provider-organization.html) | Organization | [↓ JSON](StructureDefinition-hsa-healthcare-provider-organization.json) |
| [HsaHealthcareUnitOrganization](StructureDefinition-hsa-healthcare-unit-organization.html) | Organization | [↓ JSON](StructureDefinition-hsa-healthcare-unit-organization.json) |
| [HsaCatalogLocation](StructureDefinition-hsa-catalog-location.html) | Location | [↓ JSON](StructureDefinition-hsa-catalog-location.json) |
| [HsaHealthcareService](StructureDefinition-hsa-healthcare-service.html) | HealthcareService | [↓ JSON](StructureDefinition-hsa-healthcare-service.json) |

### Extensions

| Extension | Användning | JSON |
|---|---|---|
| [HsaFinancingOrganization](StructureDefinition-hsa-financing-organization.html) | Finansierande region/kommun på Organization | [↓ JSON](StructureDefinition-hsa-financing-organization.json) |
| [HsaTelecomType](StructureDefinition-hsa-telecom-type.html) | Typ-kod på ContactPoint (direkttelefon, växel m.fl.) | [↓ JSON](StructureDefinition-hsa-telecom-type.json) |
| [HsaTemporaryNotice](StructureDefinition-hsa-temporary-notice.html) | Tillfällig informationstext (gul ruta på 1177) | [↓ JSON](StructureDefinition-hsa-temporary-notice.json) |
| [HsaPatientInfo](StructureDefinition-hsa-patient-info.html) | Information riktad till patient (1177) | [↓ JSON](StructureDefinition-hsa-patient-info.json) |

---

## Terminologi

### CodeSystems

| CodeSystem | OID / URI | JSON |
|---|---|---|
| [HsaObjectClass](CodeSystem-hsa-object-class.html) | `https://hsa.inera.se/fhir/CodeSystem/hsa-object-class` | [↓ JSON](CodeSystem-hsa-object-class.json) |
| [HsaTelecomType](CodeSystem-hsa-telecom-type.html) | `https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type` | [↓ JSON](CodeSystem-hsa-telecom-type.json) |

### ValueSets

| ValueSet | Binder till | JSON |
|---|---|---|
| [HsaOrganizationTypeVS](ValueSet-hsa-organization-type.html) | `Organization.type` | [↓ JSON](ValueSet-hsa-organization-type.json) |
| [HsaBusinessTypeVS](ValueSet-hsa-business-type.html) | `Organization.type[business-type]` | [↓ JSON](ValueSet-hsa-business-type.json) |
| [HsaOwnershipTypeVS](ValueSet-hsa-ownership-type.html) | `Organization.type[ownership]` | [↓ JSON](ValueSet-hsa-ownership-type.json) |
| [HsaDestinationIndicatorVS](ValueSet-hsa-destination-indicator.html) | `meta.security[destination-indicator]` | [↓ JSON](ValueSet-hsa-destination-indicator.json) |
| [HsaCareTypeVS](ValueSet-hsa-care-type.html) | `HealthcareService.type[care-type]` | [↓ JSON](ValueSet-hsa-care-type.json) |
| [HsaServiceTypeVS](ValueSet-hsa-service-type.html) | `HealthcareService.category[verksamhetskod]` | [↓ JSON](ValueSet-hsa-service-type.json) |
| [HsaTelecomTypeVS](ValueSet-hsa-telecom-type.html) | `extension[hsa-telecom-type]` | [↓ JSON](ValueSet-hsa-telecom-type.json) |

---

## Sökparametrar (SearchParameters)

| SearchParameter | Typ | Resurs | JSON |
|---|---|---|---|
| [hsa-id](SearchParameter-hsa-id.html) | token | Organization, Location, HealthcareService | [↓ JSON](SearchParameter-hsa-id.json) |
| [hsa-org-class](SearchParameter-hsa-org-class.html) | token | Organization | [↓ JSON](SearchParameter-hsa-org-class.json) |
| [hsa-provided-by](SearchParameter-hsa-provided-by.html) | reference | HealthcareService | [↓ JSON](SearchParameter-hsa-provided-by.json) |

---

## Exempelinstanser

Exempel för validering och integrationstestning.

| Instans | Profil | JSON |
|---|---|---|
| [VardgivareExample](Organization-VardgivareExample.html) | HsaHealthcareProviderOrganization | [↓ JSON](Organization-VardgivareExample.json) |
| [VardenhetExample](Organization-VardenhetExample.html) | HsaHealthcareUnitOrganization | [↓ JSON](Organization-VardenhetExample.json) |
| [LocationExample](Location-LocationExample.html) | HsaCatalogLocation | [↓ JSON](Location-LocationExample.json) |
| [HealthcareServiceExample](HealthcareService-HealthcareServiceExample.html) | HsaHealthcareService | [↓ JSON](HealthcareService-HealthcareServiceExample.json) |

---

## Komplett IG-nedladdning

Den fullständiga IG:n med alla HTML-sidor och artefakter finns som zip-arkiv via IG Publisher-bygget.

| Format | Länk |
|---|---|
| Zip-arkiv (full IG) | [full-ig.zip](full-ig.zip) |
| Enbart definitioner (JSON) | [definitions.json.zip](definitions.json.zip) |
| Enbart definitioner (XML) | [definitions.xml.zip](definitions.xml.zip) |
| Enbart exempel (JSON) | [examples.json.zip](examples.json.zip) |
