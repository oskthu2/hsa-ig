# HSA Tillfällig information - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Tillfällig information**

## Extension: HSA Tillfällig information 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice | *Version*:0.1.0 |
| Draft as of 2026-11-04 | *Computable Name*:HsaTemporaryNoticeExtension |

Tillfällig information om enheten, visas som gul informationsruta på enhetens kontaktkort på 1177.se. Mappar till LDAP-attributet hsaVpwInformation2.

I HSA kan texten inledas med visningsperiod: `;ÅÅÅÅMMDD;ÅÅÅÅMMDD;text` (Informationsspecifikation HSA 11.3.72). Servern tolkar prefixet, lägger datumen i `period` och resten i `text`. Perioden gäller meddelandet, inte organisationen; organisationens giltighetstid ligger i organization-period (startDate/endDate).

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
  "title" : "HSA Tillfällig information",
  "status" : "draft",
  "date" : "2026-11-04T14:57:21+00:00",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Tillfällig information om enheten, visas som gul informationsruta på enhetens\nkontaktkort på 1177.se. Mappar till LDAP-attributet hsaVpwInformation2.\n\nI HSA kan texten inledas med visningsperiod: `;ÅÅÅÅMMDD;ÅÅÅÅMMDD;text`\n(Informationsspecifikation HSA 11.3.72). Servern tolkar prefixet, lägger\ndatumen i `period` och resten i `text`. Perioden gäller meddelandet, inte\norganisationen; organisationens giltighetstid ligger i organization-period\n(startDate/endDate).",
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
      "short" : "HSA Tillfällig information",
      "definition" : "Tillfällig information om enheten, visas som gul informationsruta på enhetens\nkontaktkort på 1177.se. Mappar till LDAP-attributet hsaVpwInformation2.\n\nI HSA kan texten inledas med visningsperiod: `;ÅÅÅÅMMDD;ÅÅÅÅMMDD;text`\n(Informationsspecifikation HSA 11.3.72). Servern tolkar prefixet, lägger\ndatumen i `period` och resten i `text`. Perioden gäller meddelandet, inte\norganisationen; organisationens giltighetstid ligger i organization-period\n(startDate/endDate).",
      "constraint" : [{
        "key" : "hsacat-temporary-notice-no-prefix",
        "severity" : "warning",
        "human" : "Datumprefixet ;ÅÅÅÅMMDD;ÅÅÅÅMMDD; i hsaVpwInformation2 ska tolkas till period och tas bort ur texten (ADR-013).",
        "expression" : "extension('text').value.ofType(string).all(startsWith(';').not())",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice"
      }]
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "min" : 1
    },
    {
      "id" : "Extension.extension:text",
      "path" : "Extension.extension",
      "sliceName" : "text",
      "short" : "Informationstexten, utan datumprefix",
      "min" : 1,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Extension.extension:text.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:text.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "text"
    },
    {
      "id" : "Extension.extension:text.value[x]",
      "path" : "Extension.extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "Extension.extension:period",
      "path" : "Extension.extension",
      "sliceName" : "period",
      "short" : "Visningsperiod (datumprefixet i hsaVpwInformation2)",
      "definition" : "Period då informationen ska visas. `start` och `end` anges som datum\n(ÅÅÅÅ-MM-DD) och båda är inklusive. Saknas `end` visas informationen tills\nvidare; saknas `start` visas den direkt.",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Extension.extension:period.extension",
      "path" : "Extension.extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.extension:period.url",
      "path" : "Extension.extension.url",
      "fixedUri" : "period"
    },
    {
      "id" : "Extension.extension:period.value[x]",
      "path" : "Extension.extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "Period"
      }]
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "max" : "0"
    }]
  }
}

```
