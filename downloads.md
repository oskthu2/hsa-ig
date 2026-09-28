# Nedladdningar - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Nedladdningar**

## Nedladdningar

# Nedladdningar

Denna sida samlar nedladdningsbara artefakter från HSA Katalog IG.

-------

## FHIR-paket (npm)

Det rekommenderade sättet att använda IG:n i FHIR-verktyg, validerare och IG-byggare.

| | |
| :--- | :--- |
| `inera.se.hsa.katalog#0.1.0` | Komplett IG-paket med alla profiler, kodverk, exempel och konformansdeklarationer |

```
# Installera med FHIR npm-registret
npm --registry https://packages.simplifier.net install inera.se.hsa.katalog@0.1.0

# Eller med fhir-package-loader
fhir-package-loader install inera.se.hsa.katalog#0.1.0

```

Paketet innehåller alla StructureDefinition-, CodeSystem-, ValueSet-, SearchParameter- och CapabilityStatement-resurser i JSON-format.

-------

## Konformansdeklarationer (CapabilityStatements)

CapabilityStatements i denna IG är illustrativa exempel på möjliga integrationsmönster, inte formellt antagna krav. De kan laddas ner som FHIR JSON och användas som utgångspunkt för egna implementationer.

### Serverexempel

| | | |
| :--- | :--- | :--- |
| [HSA Central Catalog Server](CapabilityStatement-hsa-catalog-server.md) | Möjligt centralt källsystem med läsaccess | [↓ JSON](CapabilityStatement-hsa-catalog-server.json) |
| [HSA Regional Catalog Server](CapabilityStatement-hsa-regional-catalog-server.md) | Hypotetiskt regionalt mellanlager med läs- och skrivsupport | [↓ JSON](CapabilityStatement-hsa-regional-catalog-server.json) |

### Klientexempel

| | | |
| :--- | :--- | :--- |
| [1177 Hitta vård](CapabilityStatement-hsa-client-1177-hitta-vard.md) | UC-03: Möjliga förmågor för publik vårdsökning och geo-sökning | [↓ JSON](CapabilityStatement-hsa-client-1177-hitta-vard.json) |
| [NPÖ](CapabilityStatement-hsa-client-npo.md) | UC-02: Möjliga förmågor för arbetsplatskodssökning och hierarki | [↓ JSON](CapabilityStatement-hsa-client-npo.json) |
| [Hierarkitraversering](CapabilityStatement-hsa-client-hierarchy-traversal.md) | Möjliga förmågor för SKLTP-liknande trädklättring (v1) | [↓ JSON](CapabilityStatement-hsa-client-hierarchy-traversal.json) |
| [EHR-katalogsynk](CapabilityStatement-hsa-client-ehr-sync.md) | UC-01 + UC-04: Möjliga förmågor för katalogsynk och Encounter.type | [↓ JSON](CapabilityStatement-hsa-client-ehr-sync.json) |

-------

## Profiler (StructureDefinitions)

| | | |
| :--- | :--- | :--- |
| [HsaCatalogOrganization](StructureDefinition-hsa-catalog-organization.md) | Organization | [↓ JSON](StructureDefinition-hsa-catalog-organization.json) |
| [HsaHealthcareProviderOrganization](StructureDefinition-hsa-healthcare-provider-organization.md) | Organization | [↓ JSON](StructureDefinition-hsa-healthcare-provider-organization.json) |
| [HsaHealthcareUnitOrganization](StructureDefinition-hsa-healthcare-unit-organization.md) | Organization | [↓ JSON](StructureDefinition-hsa-healthcare-unit-organization.json) |
| [HsaCatalogLocation](StructureDefinition-hsa-catalog-location.md) | Location | [↓ JSON](StructureDefinition-hsa-catalog-location.json) |
| [HsaHealthcareService](StructureDefinition-hsa-healthcare-service.md) | HealthcareService | [↓ JSON](StructureDefinition-hsa-healthcare-service.json) |

### Extensions

| | | |
| :--- | :--- | :--- |
| [HsaFinancingOrganization](StructureDefinition-hsa-financing-organization.md) | Finansierande region/kommun på Organization | [↓ JSON](StructureDefinition-hsa-financing-organization.json) |
| [HsaTelecomType](StructureDefinition-hsa-telecom-type.md) | Typ-kod på ContactPoint (direkttelefon, växel m.fl.) | [↓ JSON](StructureDefinition-hsa-telecom-type.json) |
| [HsaTemporaryNotice](StructureDefinition-hsa-temporary-notice.md) | Tillfällig informationstext (gul ruta på 1177) | [↓ JSON](StructureDefinition-hsa-temporary-notice.json) |
| [HsaPatientInfo](StructureDefinition-hsa-patient-info.md) | Information riktad till patient (1177) | [↓ JSON](StructureDefinition-hsa-patient-info.json) |

-------

## Terminologi

### CodeSystems

| | | |
| :--- | :--- | :--- |
| [HsaObjectClass](CodeSystem-hsa-object-class.md) | `https://hsa.inera.se/fhir/CodeSystem/hsa-object-class` | [↓ JSON](CodeSystem-hsa-object-class.json) |
| [HsaTelecomType](CodeSystem-hsa-telecom-type.md) | `https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type` | [↓ JSON](CodeSystem-hsa-telecom-type.json) |

### ValueSets

| | | |
| :--- | :--- | :--- |
| [HsaOrganizationTypeVS](ValueSet-hsa-organization-type.md) | `Organization.type` | [↓ JSON](ValueSet-hsa-organization-type.json) |
| [HsaBusinessTypeVS](ValueSet-hsa-business-type.md) | `Organization.type[business-type]` | [↓ JSON](ValueSet-hsa-business-type.json) |
| [HsaOwnershipTypeVS](ValueSet-hsa-ownership-type.md) | `Organization.type[ownership]` | [↓ JSON](ValueSet-hsa-ownership-type.json) |
| [HsaDestinationIndicatorVS](ValueSet-hsa-destination-indicator.md) | `meta.security[destination-indicator]` | [↓ JSON](ValueSet-hsa-destination-indicator.json) |
| [HsaCareTypeVS](ValueSet-hsa-care-type.md) | `HealthcareService.type[care-type]` | [↓ JSON](ValueSet-hsa-care-type.json) |
| [HsaServiceTypeVS](ValueSet-hsa-service-type.md) | `HealthcareService.category[verksamhetskod]` | [↓ JSON](ValueSet-hsa-service-type.json) |
| [HsaTelecomTypeVS](ValueSet-hsa-telecom-type.md) | `extension[hsa-telecom-type]` | [↓ JSON](ValueSet-hsa-telecom-type.json) |

-------

## Sökparametrar (SearchParameters)

| | | | |
| :--- | :--- | :--- | :--- |
| [hsa-id](SearchParameter-hsa-id.md) | token | Organization, Location, HealthcareService | [↓ JSON](SearchParameter-hsa-id.json) |
| [hsa-org-class](SearchParameter-hsa-org-class.md) | token | Organization | [↓ JSON](SearchParameter-hsa-org-class.json) |
| [hsa-provided-by](SearchParameter-hsa-provided-by.md) | reference | HealthcareService | [↓ JSON](SearchParameter-hsa-provided-by.json) |

-------

## Exempelinstanser

Exempelbiblioteket täcker ett komplett organisationsträd för Region Blekinge och Blekinge Primärvård AB. Varje instans innehåller LDIF-källdata och mappningskommentarer som förklarar översättningen till FHIR.

### Vårdgivare (HsaHealthcareProviderOrganization)

| | | |
| :--- | :--- | :--- |
| [Region Blekinge](Organization-region-blekinge-vardgivare.md) | Offentlig regional VG, management=01, GLN, legacy postadress | [↓ JSON](Organization-region-blekinge-vardgivare.json) |
| [Blekinge Primärvård AB](Organization-privat-vardgivare-ab.md) | Privat VG, management=05, separat direkttelefon/växel | [↓ JSON](Organization-privat-vardgivare-ab.json) |

### Vårdenheter (HsaHealthcareUnitOrganization)

| | | |
| :--- | :--- | :--- |
| [Blekingesjukhuset](Organization-blekingesjukhuset-vardenhet.md) | Sjukhus, APK, GLN, alla telekomtyper inkl. mobiltelefon och 1177-djuplänk | [↓ JSON](Organization-blekingesjukhuset-vardenhet.json) |
| [Hjärtmottagningen Karlskrona](Organization-hjartmottagningen-vardenhet.md) | orgPeriod (start+end), temporaryNotice, patientInfo, DN-träd vs. partOf | [↓ JSON](Organization-hjartmottagningen-vardenhet.json) |
| [Ronneby Vårdcentral](Organization-ronneby-vardcentral-vardenhet.md) | Primärvård, financingOrganization (privat utförare, regionfinansiering), APK | [↓ JSON](Organization-ronneby-vardcentral-vardenhet.json) |
| [Medicinmottagning Karlshamn](Organization-arkiverad-enhet.md) | Arkiverad enhet, active=false, hsaArchivedObject, minimal datauppsättning | [↓ JSON](Organization-arkiverad-enhet.json) |

### Platser (HsaCatalogLocation)

| | | |
| :--- | :--- | :--- |
| [Blekingesjukhuset besöksplats](Location-location-blekingesjukhuset.md) | Strukturerad 5.2+ hsaVisitingAddress → address.line[], SWEREF99, Markdown-vägbeskrivning | [↓ JSON](Location-location-blekingesjukhuset.json) |
| [Ronneby Vårdcentral besöksplats](Location-location-ronneby-vardcentral.md) | Legacy streetAddress → address.text (pre-5.2 övergångsmönster) | [↓ JSON](Location-location-ronneby-vardcentral.json) |

### Tjänsteutbud (HsaHealthcareService)

| | | |
| :--- | :--- | :--- |
| [Blekingesjukhuset tjänster](HealthcareService-hs-tjanst-blekingesjukhuset.md) | Flera verksamhetskoder (1101+1126), öppen+sluten vård, telefontider och drop-in | [↓ JSON](HealthcareService-hs-tjanst-blekingesjukhuset.json) |
| [Ronneby Vårdcentral tjänster](HealthcareService-hs-tjanst-ronneby-vardcentral.md) | Alla tre VPW-fält (comment/temporaryNotice/patientInfo), tre availability-block | [↓ JSON](HealthcareService-hs-tjanst-ronneby-vardcentral.json) |

-------

## Komplett IG-nedladdning

Den fullständiga IG:n med alla HTML-sidor och artefakter finns som zip-arkiv via IG Publisher-bygget.

| | |
| :--- | :--- |
| Zip-arkiv (full IG) | [full-ig.zip](full-ig.zip) |
| Enbart definitioner (JSON) | [definitions.json.zip](definitions.json.zip) |
| Enbart definitioner (XML) | [definitions.xml.zip](definitions.xml.zip) |
| Enbart exempel (JSON) | [examples.json.zip](examples.json.zip) |

