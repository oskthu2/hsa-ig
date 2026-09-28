# HSA Klient – EHR-katalogsynk - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Klient – EHR-katalogsynk**

## CapabilityStatement: HSA Klient – EHR-katalogsynk 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-ehr-sync | *Version*:0.1.0 |
| Draft as of 2026-05-21 | *Computable Name*:HsaClientEhrSync |

 
Illustrativt exempel för EHR-katalogsynk (UC-01) och Encounter.type-mappning (UC-04): möjliga förmågor för fullsynk och inkrementell synk av HSA-organisationsdata. 

 [Raw OpenAPI-Swagger Definition file](hsa-client-ehr-sync.openapi.json) | [Download](hsa-client-ehr-sync.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "hsa-client-ehr-sync",
  "url" : "https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-ehr-sync",
  "version" : "0.1.0",
  "name" : "HsaClientEhrSync",
  "title" : "HSA Klient – EHR-katalogsynk",
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
  "description" : "Illustrativt exempel för EHR-katalogsynk (UC-01) och Encounter.type-mappning (UC-04): möjliga förmågor för fullsynk och inkrementell synk av HSA-organisationsdata.",
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
    "documentation" : "UC-01 EHR-katalogsynk använder följande frågemönster:\nFullsynk (nattlig):\n  GET /Organization?active=true&_count=100  (+ paginering via Bundle.link[next])\n  GET /Location?_count=100\n  GET /HealthcareService?active=true&_count=100\nInkrementell synk (händelsedriven):\n  GET /Organization?_lastUpdated=gt[tidsstämpel]&_count=100\n  GET /Location?_lastUpdated=gt[tidsstämpel]&_count=100\n  GET /HealthcareService?_lastUpdated=gt[tidsstämpel]&_count=100\nScenariot förutsätter att servern har stöd för _lastUpdated och korrekt paginering (Bundle.link[next]).\n\nUC-04 VGR Encounter.type-mappning (on-demand):\n  GET /HealthcareService?organization=Organization/[id]&service-category=[verksamhetskod]\nVerksamhetskod (OID 1.2.752.129.2.2.1.3) är tillgänglig direkt på\nHealthcareService.category utan transformation (ADR-011).",
    "resource" : [{
      "type" : "Organization",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization",
      "documentation" : "Använder alla profilerade fält: identifier (hsa-id, org-no, apk), name, type, active, contact, partOf, meta.security.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchInclude" : ["Organization:partof"],
      "searchParam" : [{
        "name" : "_lastUpdated",
        "type" : "date",
        "documentation" : "Möjliggör inkrementell synk baserat på ändringstidpunkt."
      },
      {
        "name" : "active",
        "type" : "token"
      },
      {
        "name" : "identifier",
        "type" : "token"
      },
      {
        "name" : "hsa-org-class",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class",
        "type" : "token"
      }]
    },
    {
      "type" : "Location",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location",
      "documentation" : "Använder address (fysisk), position (SWEREF99), managingOrganization. Synkroniseras parallellt med Organization.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchParam" : [{
        "name" : "_lastUpdated",
        "type" : "date"
      },
      {
        "name" : "organization",
        "type" : "reference"
      }]
    },
    {
      "type" : "HealthcareService",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service",
      "documentation" : "Använder category[verksamhetskod], availability (öppettider), providedBy. Synkroniseras för möjlig Encounter.type-mappning (UC-04).",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchParam" : [{
        "name" : "_lastUpdated",
        "type" : "date"
      },
      {
        "name" : "active",
        "type" : "token"
      },
      {
        "name" : "organization",
        "type" : "reference"
      },
      {
        "name" : "service-category",
        "type" : "token"
      }]
    }]
  }]
}

```
