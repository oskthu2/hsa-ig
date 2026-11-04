# HSA Klient – Nationell Patientöversikt (NPÖ) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Klient – Nationell Patientöversikt (NPÖ)**

## CapabilityStatement: HSA Klient – Nationell Patientöversikt (NPÖ) 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-npo | *Version*:0.1.0 |
| Draft as of 2026-05-21 | *Computable Name*:HsaClientNpo |

 
Illustrativt exempel för NPÖ (UC-02): möjliga förmågor för arbetsplatskodssökning och hierarkihämtning. 

 [Raw OpenAPI-Swagger Definition file](hsa-client-npo.openapi.json) | [Download](hsa-client-npo.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "hsa-client-npo",
  "url" : "https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-npo",
  "version" : "0.1.0",
  "name" : "HsaClientNpo",
  "title" : "HSA Klient – Nationell Patientöversikt (NPÖ)",
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
  "description" : "Illustrativt exempel för NPÖ (UC-02): möjliga förmågor för arbetsplatskodssökning och hierarkihämtning.",
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
    "documentation" : "NPÖ använder följande frågemönster:\n1. Slå upp vårdenhet via APK:\n   GET /Organization?identifier=urn:oid:1.2.752.29.4.71|[apk-kod]\n2. Hämta partOf-kedja uppåt:\n   GET /Organization?_id=[id]&_include=Organization:partof&_include:iterate=Organization:partof\nScenariot förutsätter att servern har stöd för _include:iterate (rekursiv hierarkihämtning).",
    "resource" : [{
      "type" : "Organization",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization",
      "documentation" : "Använder identifier[apk] (OID 1.2.752.29.4.71), identifier[hsa-id], partOf, active. Iterativ _include för fullständig partOf-kedja.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchInclude" : ["Organization:partof"],
      "searchParam" : [{
        "name" : "_id",
        "type" : "token"
      },
      {
        "name" : "identifier",
        "type" : "token",
        "documentation" : "Sökning på APK (urn:oid:1.2.752.29.4.71|[kod]) och HSA-id (urn:oid:1.2.752.29.4.19|SE...)."
      },
      {
        "name" : "active",
        "type" : "token"
      },
      {
        "name" : "partof",
        "type" : "reference"
      },
      {
        "name" : "hsa-id",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-id",
        "type" : "token"
      }]
    }]
  }]
}

```
