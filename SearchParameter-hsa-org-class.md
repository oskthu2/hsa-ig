# HSA Organisationsklass - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Organisationsklass**

## SearchParameter: HSA Organisationsklass 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/SearchParameter/hsa-org-class | *Version*:0.1.0 |
| Active as of 2026-05-21 | *Computable Name*:HsaOrgClass |

 
Sökning på HSA-objektklassificering. Filtrerar på type.coding med system = 'https://hsa.inera.se/fhir/CodeSystem/hsa-object-class'. 



## Resource Content

```json
{
  "resourceType" : "SearchParameter",
  "id" : "hsa-org-class",
  "url" : "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class",
  "version" : "0.1.0",
  "name" : "HsaOrgClass",
  "title" : "HSA Organisationsklass",
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
  "description" : "Sökning på HSA-objektklassificering. Filtrerar på type.coding med system = 'https://hsa.inera.se/fhir/CodeSystem/hsa-object-class'.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "code" : "hsa-org-class",
  "base" : ["Organization"],
  "type" : "token",
  "expression" : "type.coding.where(system = 'https://hsa.inera.se/fhir/CodeSystem/hsa-object-class')",
  "multipleOr" : true,
  "multipleAnd" : false
}

```
