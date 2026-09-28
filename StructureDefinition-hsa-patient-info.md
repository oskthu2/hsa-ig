# HSA Information till patient - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Information till patient**

## Extension: HSA Information till patient 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info | *Version*:0.1.0 |
| Draft as of 2026-09-28 | *Computable Name*:HsaPatientInfoExtension |

Informationstext riktad till patient som visas på enhetens 1177-sida. Mappar till LDAP-attributet hsaVpwInformation4. Klienter bör rendera som Markdown.

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [HSA Catalog Organization](StructureDefinition-hsa-catalog-organization.md) and [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)
* Exempel för denna Extension: [Allmänmedicin Ronneby Vårdcentral](HealthcareService-hs-tjanst-ronneby-vardcentral.md), [Hjärtmottagningen Karlskrona](Organization-hjartmottagningen-vardenhet.md) and [Ronneby Vårdcentral](Organization-ronneby-vardcentral-vardenhet.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-patient-info)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-patient-info.csv), [Excel](StructureDefinition-hsa-patient-info.xlsx), [Schematron](StructureDefinition-hsa-patient-info.sch) 

#### Begränsningar



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-patient-info",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info",
  "version" : "0.1.0",
  "name" : "HsaPatientInfoExtension",
  "title" : "HSA Information till patient",
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
  "description" : "Informationstext riktad till patient som visas på enhetens 1177-sida.\nMappar till LDAP-attributet hsaVpwInformation4.\nKlienter bör rendera som Markdown.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "fhirVersion" : "5.0.0",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [{
    "type" : "element",
    "expression" : "Organization"
  },
  {
    "type" : "element",
    "expression" : "HealthcareService"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "HSA Information till patient",
      "definition" : "Informationstext riktad till patient som visas på enhetens 1177-sida.\nMappar till LDAP-attributet hsaVpwInformation4.\nKlienter bör rendera som Markdown."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "string"
      }]
    }]
  }
}

```
