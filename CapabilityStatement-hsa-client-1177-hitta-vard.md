# HSA Klient – 1177 Hitta vård - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Klient – 1177 Hitta vård**

## CapabilityStatement: HSA Klient – 1177 Hitta vård 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-1177-hitta-vard | *Version*:0.1.0 |
| Draft as of 2026-05-21 | *Computable Name*:HsaClient1177HittaVard |

 
Illustrativt exempel för 1177 Hitta vård (UC-03): möjliga FHIR-förmågor för geo-sökning, publik filtrering och visning av öppettider. 

 [Raw OpenAPI-Swagger Definition file](hsa-client-1177-hitta-vard.openapi.json) | [Download](hsa-client-1177-hitta-vard.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "hsa-client-1177-hitta-vard",
  "url" : "https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-1177-hitta-vard",
  "version" : "0.1.0",
  "name" : "HsaClient1177HittaVard",
  "title" : "HSA Klient – 1177 Hitta vård",
  "status" : "draft",
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
  "description" : "Illustrativt exempel för 1177 Hitta vård (UC-03): möjliga FHIR-förmågor för geo-sökning, publik filtrering och visning av öppettider.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "kind" : "requirements",
  "fhirVersion" : "5.0.0",
  "format" : ["json"],
  "rest" : [{
    "mode" : "client",
    "documentation" : "1177 Hitta vård använder följande frågemönster:\n1. Geo-sökning: GET /Location?near=[lat]|[lon]|[radius]|km&_security=...03\n   med _revinclude=HealthcareService:location&_revinclude=Organization:organization\n2. Namnssökning: GET /Organization?name=[prefix]&hsa-org-class=healthcare-unit&_security=...03\n3. Hämta detaljer: GET /Organization/[id] + separata anrop för Location och HealthcareService\nAlla anrop filtreras på _security=urn:oid:1.2.752.29.23.1.11|03 (publika resurser).",
    "resource" : [{
      "type" : "Organization",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization",
      "documentation" : "Hämtar och visar vårdgivare/vårdenheter. Relevanta fält: name, type, active, contact.telecom, contact.address, meta.security.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchInclude" : ["Organization:partof"],
      "searchRevInclude" : ["Location:organization", "HealthcareService:organization"],
      "searchParam" : [{
        "name" : "_security",
        "type" : "token"
      },
      {
        "name" : "name",
        "type" : "string",
        "documentation" : "Namnssökning för fritextsök i 1177."
      },
      {
        "name" : "active",
        "type" : "token"
      },
      {
        "name" : "hsa-org-class",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class",
        "type" : "token",
        "documentation" : "Filtrera på healthcare-unit för vårdenhetssökning."
      },
      {
        "name" : "partof",
        "type" : "reference"
      }]
    },
    {
      "type" : "Location",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location",
      "documentation" : "Geo-sökning och kartvisning. Använder position (SWEREF99), address (fysisk, utan postnummer), description (vägbeskrivning).",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchInclude" : ["Location:organization"],
      "searchParam" : [{
        "name" : "_security",
        "type" : "token"
      },
      {
        "name" : "near",
        "type" : "special",
        "documentation" : "Geo-sökning är primärt frågemönster för kartvisning."
      },
      {
        "name" : "organization",
        "type" : "reference"
      }]
    },
    {
      "type" : "HealthcareService",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service",
      "documentation" : "Öppettider, verksamhetskod och VPW-texter (Om oss, information till patient, tillfällig info). Använder availability, category[verksamhetskod], comment, extension[temporaryNotice], extension[patientInfo].",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchInclude" : ["HealthcareService:organization", "HealthcareService:location"],
      "searchParam" : [{
        "name" : "_security",
        "type" : "token"
      },
      {
        "name" : "organization",
        "type" : "reference"
      },
      {
        "name" : "service-category",
        "type" : "token",
        "documentation" : "Filtrera på verksamhetskod (OID 1.2.752.129.2.2.1.3)."
      }]
    }]
  }]
}

```
