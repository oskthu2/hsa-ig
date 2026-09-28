# Organisationsnummer (Sverige) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Organisationsnummer (Sverige)**

## NamingSystem: Organisationsnummer (Sverige) 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/NamingSystem/organisation-nummer | *Version*:0.1.0 |
| Active as of 2026-05-20 | *Computable Name*:OrganisationsnummerSE |

 
Unikt nummer för juridiska personer i Sverige, tilldelat av Skatteverket eller Bolagsverket. Obligatoriskt för organisationer som representerar vårdgivare (hsaHealthCareProvider). 



## Resource Content

```json
{
  "resourceType" : "NamingSystem",
  "id" : "organisation-nummer",
  "url" : "https://hsa.inera.se/fhir/NamingSystem/organisation-nummer",
  "version" : "0.1.0",
  "name" : "OrganisationsnummerSE",
  "title" : "Organisationsnummer (Sverige)",
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
  "description" : "Unikt nummer för juridiska personer i Sverige, tilldelat av Skatteverket\neller Bolagsverket. Obligatoriskt för organisationer som representerar\nvårdgivare (hsaHealthCareProvider).",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "uniqueId" : [{
    "type" : "oid",
    "value" : "2.5.4.97",
    "preferred" : true
  },
  {
    "type" : "uri",
    "value" : "urn:oid:2.5.4.97"
  }]
}

```
