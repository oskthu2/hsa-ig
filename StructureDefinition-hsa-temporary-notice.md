# HSA Tillfällig information (text) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Tillfällig information (text)**

## Extension: HSA Tillfällig information (text) 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice | *Version*:0.1.0 |
| Draft as of 2026-09-28 | *Computable Name*:HsaTemporaryNoticeExtension |

Fri text för tillfällig information om enheten, visas som gul informationsruta på enhetens kontaktkort på 1177.se. Mappar till LDAP-attributet hsaVpwInformation2. Slutdatum hanteras separat via organization-period (http://hl7.org/fhir/StructureDefinition/organization-period).

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [HSA Catalog Organization](StructureDefinition-hsa-catalog-organization.md) and [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)
* Exempel för denna Extension: [Allmänmedicin Ronneby Vårdcentral](HealthcareService-hs-tjanst-ronneby-vardcentral.md) and [Hjärtmottagningen Karlskrona](Organization-hjartmottagningen-vardenhet.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-temporary-notice)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-temporary-notice.csv), [Excel](StructureDefinition-hsa-temporary-notice.xlsx), [Schematron](StructureDefinition-hsa-temporary-notice.sch) 

#### Begränsningar



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-temporary-notice",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice",
  "version" : "0.1.0",
  "name" : "HsaTemporaryNoticeExtension",
  "title" : "HSA Tillfällig information (text)",
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
  "description" : "Fri text för tillfällig information om enheten, visas som gul informationsruta\npå enhetens kontaktkort på 1177.se. Mappar till LDAP-attributet\nhsaVpwInformation2. Slutdatum hanteras separat via organization-period\n(http://hl7.org/fhir/StructureDefinition/organization-period).",
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
      "short" : "HSA Tillfällig information (text)",
      "definition" : "Fri text för tillfällig information om enheten, visas som gul informationsruta\npå enhetens kontaktkort på 1177.se. Mappar till LDAP-attributet\nhsaVpwInformation2. Slutdatum hanteras separat via organization-period\n(http://hl7.org/fhir/StructureDefinition/organization-period)."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice"
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
