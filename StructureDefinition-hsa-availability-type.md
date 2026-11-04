# HSA Tidtyp - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Tidtyp**

## Extension: HSA Tidtyp 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-type | *Version*:0.1.0 |
| Draft as of 2026-11-04 | *Computable Name*:HsaAvailabilityTypeExtension |

Anger vilket HSA-tidsattribut (surgeryHours, telephoneHours, dropInHours, visitingHours) en tillgänglighetspost kommer från. R5 Availability saknar typelement (ADR-016).

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)
* Exempel för denna Extension: [Internmedicin och Kardiologi](HealthcareService-hs-tjanst-blekingesjukhuset.md) and [Allmänmedicin Ronneby Vårdcentral](HealthcareService-hs-tjanst-ronneby-vardcentral.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-availability-type)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-availability-type.csv), [Excel](StructureDefinition-hsa-availability-type.xlsx), [Schematron](StructureDefinition-hsa-availability-type.sch) 

#### Terminologibindningar

#### Begränsningar



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-availability-type",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-type",
  "version" : "0.1.0",
  "name" : "HsaAvailabilityTypeExtension",
  "title" : "HSA Tidtyp",
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
  "description" : "Anger vilket HSA-tidsattribut (surgeryHours, telephoneHours, dropInHours,\nvisitingHours) en tillgänglighetspost kommer från. R5 Availability saknar\ntypelement (ADR-016).",
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
      "short" : "HSA Tidtyp",
      "definition" : "Anger vilket HSA-tidsattribut (surgeryHours, telephoneHours, dropInHours,\nvisitingHours) en tillgänglighetspost kommer från. R5 Availability saknar\ntypelement (ADR-016)."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-type"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "Coding"
      }],
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-availability-type"
      }
    }]
  }
}

```
