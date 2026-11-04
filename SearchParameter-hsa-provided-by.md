# HSA Tillhandahållande organisation - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Tillhandahållande organisation**

## SearchParameter: HSA Tillhandahållande organisation 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/SearchParameter/hsa-provided-by | *Version*:0.1.0 |
| Active as of 2026-05-21 | *Computable Name*:HsaProvidedBy |

 
Filtrera HealthcareService på providedBy-referens (tillhandahållande organisation). 



## Resource Content

```json
{
  "resourceType" : "SearchParameter",
  "id" : "hsa-provided-by",
  "url" : "https://hsa.inera.se/fhir/SearchParameter/hsa-provided-by",
  "version" : "0.1.0",
  "name" : "HsaProvidedBy",
  "title" : "HSA Tillhandahållande organisation",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-05-21",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Filtrera HealthcareService på providedBy-referens (tillhandahållande organisation).",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "code" : "hsa-provided-by",
  "base" : ["HealthcareService"],
  "type" : "reference",
  "expression" : "HealthcareService.providedBy",
  "target" : ["Organization"],
  "multipleOr" : true,
  "multipleAnd" : false
}

```
