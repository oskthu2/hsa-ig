# HSA-identitet (HSA-id) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA-identitet (HSA-id)**

## NamingSystem: HSA-identitet (HSA-id) 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/NamingSystem/hsa-identity | *Version*:0.1.0 |
| Active as of 2026-05-20 | *Computable Name*:HsaIdentity |

 
Unik identifierare för organisationer, enheter, funktioner, uppdrag och personer i HSA-katalogen. Tilldelas automatiskt av HSA-systemet vid skapande och ska aldrig ändras. Används som stabil nyckel i nationella e-tjänster (NPÖ, Pascal, 1177 Hitta vård m.fl.). 



## Resource Content

```json
{
  "resourceType" : "NamingSystem",
  "id" : "hsa-identity",
  "url" : "https://hsa.inera.se/fhir/NamingSystem/hsa-identity",
  "version" : "0.1.0",
  "name" : "HsaIdentity",
  "title" : "HSA-identitet (HSA-id)",
  "status" : "active",
  "kind" : "identifier",
  "date" : "2026-05-20",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Unik identifierare för organisationer, enheter, funktioner, uppdrag och\npersoner i HSA-katalogen. Tilldelas automatiskt av HSA-systemet vid skapande\noch ska aldrig ändras. Används som stabil nyckel i nationella e-tjänster\n(NPÖ, Pascal, 1177 Hitta vård m.fl.).",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "uniqueId" : [{
    "type" : "oid",
    "value" : "1.2.752.29.4.19",
    "preferred" : true
  },
  {
    "type" : "uri",
    "value" : "urn:oid:1.2.752.29.4.19"
  }]
}

```
