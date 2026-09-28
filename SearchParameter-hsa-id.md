# HSA-id - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA-id**

## SearchParameter: HSA-id 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/SearchParameter/hsa-id | *Version*:0.1.0 |
| Active as of 2026-05-21 | *Computable Name*:HsaId |

 
Sökning på HSA-id-identifieraren (system = urn:oid:1.2.752.29.4.19). 



## Resource Content

```json
{
  "resourceType" : "SearchParameter",
  "id" : "hsa-id",
  "url" : "https://hsa.inera.se/fhir/SearchParameter/hsa-id",
  "version" : "0.1.0",
  "name" : "HsaId",
  "title" : "HSA-id",
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
  "description" : "Sökning på HSA-id-identifieraren (system = urn:oid:1.2.752.29.4.19).",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "code" : "hsa-id",
  "base" : ["Organization", "Location", "HealthcareService"],
  "type" : "token",
  "expression" : "identifier.where(system = 'urn:oid:1.2.752.29.4.19').value",
  "multipleOr" : true,
  "multipleAnd" : false
}

```
