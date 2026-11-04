# HSA Giltighetsperiod för öppettid - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Giltighetsperiod för öppettid**

## Extension: HSA Giltighetsperiod för öppettid 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-period | *Version*:0.1.0 |
| Draft as of 2026-11-04 | *Computable Name*:HsaAvailabilityPeriodExtension |

Datumintervallet i ett tidsattribut, t.ex. `20261223#20261223` i `1-7#08:00#12:30#Halvdag#20261223#20261223`. Används för avvikande öppettider. Saknas `end` gäller tiden tills vidare. R5 Availability saknar eget periodelement och hl7.fhir.uv.extensions.r5 har ingen motsvarighet.

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)
* Exempel för denna Extension: [Internmedicin och Kardiologi](HealthcareService-hs-tjanst-blekingesjukhuset.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-availability-period)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-availability-period.csv), [Excel](StructureDefinition-hsa-availability-period.xlsx), [Schematron](StructureDefinition-hsa-availability-period.sch) 

#### Begränsningar



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-availability-period",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-period",
  "version" : "0.1.0",
  "name" : "HsaAvailabilityPeriodExtension",
  "title" : "HSA Giltighetsperiod för öppettid",
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
  "description" : "Datumintervallet i ett tidsattribut, t.ex. `20261223#20261223` i\n`1-7#08:00#12:30#Halvdag#20261223#20261223`. Används för avvikande\nöppettider. Saknas `end` gäller tiden tills vidare. R5 Availability saknar\neget periodelement och hl7.fhir.uv.extensions.r5 har ingen motsvarighet.",
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
      "short" : "HSA Giltighetsperiod för öppettid",
      "definition" : "Datumintervallet i ett tidsattribut, t.ex. `20261223#20261223` i\n`1-7#08:00#12:30#Halvdag#20261223#20261223`. Används för avvikande\nöppettider. Saknas `end` gäller tiden tills vidare. R5 Availability saknar\neget periodelement och hl7.fhir.uv.extensions.r5 har ingen motsvarighet."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-period"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "min" : 1,
      "type" : [{
        "code" : "Period"
      }]
    }]
  }
}

```
