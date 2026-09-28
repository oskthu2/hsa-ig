# HSA Healthcare Provider Organization - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Healthcare Provider Organization**

## Resource Profile: HSA Healthcare Provider Organization 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization | *Version*:0.1.0 |
| Draft as of 2026-09-28 | *Computable Name*:HsaHealthcareProviderOrganization |

 
Profil för organisation markerad som vårdgivare (hsaHealthCareProvider, OID 1.2.752.29.6.10) i HSA-katalogen. 
Representerar den yttre spärrnivån i PDL-sammanhang. Alla vårdenheter under en vårdgivare delar journalspärr på VG-nivå — det är därför `partOf` på vårdenhetsprofilen alltid pekar direkt hit. 
**Identifierare (minimum 2):** Profilen kräver alltid **både** HSA-id och organisationsnummer: 
* `identifier[hsa-id]` (1..1) — systemgenererat, unikt inom HSA.
* `identifier[org-no]` (1..1) — juridisk identitet; krävs av NPÖ och PDL-infrastrukturen för att koppla journaler till rätt VG (HSACAT-ORG-007).
* `identifier[apk]` (0..0) — arbetsplatskod är alltid en vårdenhetskod (unitPrescriptionCode i LDAP-schemat) och får aldrig sättas på VG.
* `identifier[gln]` (0..1) — förekommer på VG som har GLN-registrering.
 
**Must Support:** Alla MS-flaggor ärvs från `HsaCatalogOrganization` och visas i snapshot-vyn. Denna profil deklarerar enbart restriktioner som tillkommer utöver basprofilens definition. 

**Användningar:**

* Referera till denna Profil: [HSA Healthcare Unit Organization](StructureDefinition-hsa-healthcare-unit-organization.md)
* Exempel för denna Profil: [Blekinge Primärvård AB](Organization-privat-vardgivare-ab.md) and [Region Blekinge](Organization-region-blekinge-vardgivare.md)
* CapabilityStatements som använder denna Profil: [HSA Central Catalog Server](CapabilityStatement-hsa-catalog-server.md) and [HSA Regional Catalog Server (hypotes)](CapabilityStatement-hsa-regional-catalog-server.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-healthcare-provider-organization)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-healthcare-provider-organization.csv), [Excel](StructureDefinition-hsa-healthcare-provider-organization.xlsx), [Schematron](StructureDefinition-hsa-healthcare-provider-organization.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-healthcare-provider-organization",
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization",
  "version" : "0.1.0",
  "name" : "HsaHealthcareProviderOrganization",
  "title" : "HSA Healthcare Provider Organization",
  "status" : "draft",
  "date" : "2026-09-28T08:39:43+00:00",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Profil för organisation markerad som vårdgivare (hsaHealthCareProvider,\nOID 1.2.752.29.6.10) i HSA-katalogen.\n\nRepresenterar den yttre spärrnivån i PDL-sammanhang. Alla vårdenheter\nunder en vårdgivare delar journalspärr på VG-nivå — det är därför\n`partOf` på vårdenhetsprofilen alltid pekar direkt hit.\n\n**Identifierare (minimum 2):**\nProfilen kräver alltid *både* HSA-id och organisationsnummer:\n- `identifier[hsa-id]` (1..1) — systemgenererat, unikt inom HSA.\n- `identifier[org-no]` (1..1) — juridisk identitet; krävs av NPÖ och\n  PDL-infrastrukturen för att koppla journaler till rätt VG (HSACAT-ORG-007).\n- `identifier[apk]` (0..0) — arbetsplatskod är alltid en vårdenhetskod\n  (unitPrescriptionCode i LDAP-schemat) och får aldrig sättas på VG.\n- `identifier[gln]` (0..1) — förekommer på VG som har GLN-registrering.\n\n**Must Support:** Alla MS-flaggor ärvs från `HsaCatalogOrganization` och\nvisas i snapshot-vyn. Denna profil deklarerar enbart restriktioner som\ntillkommer utöver basprofilens definition.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "fhirVersion" : "5.0.0",
  "mapping" : [{
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 V2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "interface",
    "uri" : "http://hl7.org/fhir/interface",
    "name" : "Interface Pattern"
  },
  {
    "identity" : "servd",
    "uri" : "http://www.omg.org/spec/ServD/1.0/",
    "name" : "ServD"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Organization",
  "baseDefinition" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Organization",
      "path" : "Organization"
    },
    {
      "id" : "Organization.identifier",
      "path" : "Organization.identifier",
      "min" : 2
    },
    {
      "id" : "Organization.identifier:org-no",
      "path" : "Organization.identifier",
      "sliceName" : "org-no",
      "min" : 1
    },
    {
      "id" : "Organization.identifier:apk",
      "path" : "Organization.identifier",
      "sliceName" : "apk",
      "max" : "0"
    },
    {
      "id" : "Organization.type",
      "path" : "Organization.type",
      "min" : 1
    },
    {
      "id" : "Organization.type:hsa-class",
      "path" : "Organization.type",
      "sliceName" : "hsa-class",
      "min" : 1
    },
    {
      "id" : "Organization.type:hsa-class.coding.code",
      "path" : "Organization.type.coding.code",
      "fixedCode" : "healthcare-provider"
    }]
  }
}

```
