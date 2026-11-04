# HSA Kommentar till öppettid - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Kommentar till öppettid**

## Extension: HSA Kommentar till öppettid 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-comment | *Version*:0.1.0 |
| Draft as of 2026-11-04 | *Computable Name*:HsaAvailabilityCommentExtension |

Kommentaren i ett tidsattribut (surgeryHours, telephoneHours, dropInHours, visitingHours), t.ex. `Provtagning` i `2-5#08:00#12:15#Provtagning`. Max 19 tecken (Informationsspecifikation HSA 11.3.101).

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)
* Exempel för denna Extension: [Internmedicin och Kardiologi](HealthcareService-hs-tjanst-blekingesjukhuset.md) and [Allmänmedicin Ronneby Vårdcentral](HealthcareService-hs-tjanst-ronneby-vardcentral.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-availability-comment)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-availability-comment.csv), [Excel](StructureDefinition-hsa-availability-comment.xlsx), [Schematron](StructureDefinition-hsa-availability-comment.sch) 

#### Begränsningar



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-availability-comment",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-comment",
  "version" : "0.1.0",
  "name" : "HsaAvailabilityCommentExtension",
  "title" : "HSA Kommentar till öppettid",
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
  "description" : "Kommentaren i ett tidsattribut (surgeryHours, telephoneHours, dropInHours,\nvisitingHours), t.ex. `Provtagning` i `2-5#08:00#12:15#Provtagning`.\nMax 19 tecken (Informationsspecifikation HSA 11.3.101).",
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
    "expression" : "Availability"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "HSA Kommentar till öppettid",
      "definition" : "Kommentaren i ett tidsattribut (surgeryHours, telephoneHours, dropInHours,\nvisitingHours), t.ex. `Provtagning` i `2-5#08:00#12:15#Provtagning`.\nMax 19 tecken (Informationsspecifikation HSA 11.3.101).",
      "constraint" : [{
        "key" : "hsacat-availability-comment-length",
        "severity" : "error",
        "human" : "Kommentaren i ett tidsattribut är högst 19 tecken (Informationsspecifikation HSA 11.3.101).",
        "expression" : "value.ofType(string).all(length() <= 19)",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-comment"
      }]
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-comment"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "string"
      }]
    }]
  }
}

```
