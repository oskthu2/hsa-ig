# HSA Klient – Hierarkitraversering - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Klient – Hierarkitraversering**

## CapabilityStatement: HSA Klient – Hierarkitraversering 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-hierarchy-traversal | *Version*:0.1.0 |
| Draft as of 2026-05-21 | *Computable Name*:HsaClientHierarchyTraversal |

 
Illustrativt exempel för hierarkitraversering via Organization.partOf. Visar möjliga frågemönster för SKLTP-liknande trädklättring; full Endpoint-profilering planeras till v2. 

 [Raw OpenAPI-Swagger Definition file](hsa-client-hierarchy-traversal.openapi.json) | [Download](hsa-client-hierarchy-traversal.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "hsa-client-hierarchy-traversal",
  "url" : "https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-hierarchy-traversal",
  "version" : "0.1.0",
  "name" : "HsaClientHierarchyTraversal",
  "title" : "HSA Klient – Hierarkitraversering",
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
  "description" : "Illustrativt exempel för hierarkitraversering via Organization.partOf. Visar möjliga frågemönster för SKLTP-liknande trädklättring; full Endpoint-profilering planeras till v2.",
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
    "documentation" : "System som traverserar partOf-kedjan för åtkomstkontroll använder:\n1. Hämta enhet och fullständig kedja uppåt (SKLTP explicit/hierarkisk behörighet):\n   GET /Organization?_id=[id]\n     &_include=Organization:partof\n     &_include:iterate=Organization:partof\n2. Hämta alla enheter under en vårdgivare (subträdssökning):\n   GET /Organization?partof=Organization/[vg-id]\n     &_revinclude=Organization:partof\n3. Söka enhet via HSA-id (logisk adress = HSA-id i SKLTP):\n   GET /Organization?hsa-id=SE2321000016-ABC1\nScenariot förutsätter att servern har stöd för _include:iterate så att trädklättringen\nkan terminera korrekt (partOf-kedjan är acyklisk och terminerar i rotnod utan partOf,\nse HSACAT-ORG-015).",
    "resource" : [{
      "type" : "Organization",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization",
      "documentation" : "Använder identifier[hsa-id], type[hsa-class], partOf, active. Iterativ _include möjliggör rekursiv hierarkihämtning (HSACAT-ORG-006).",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "searchInclude" : ["Organization:partof"],
      "searchRevInclude" : ["Organization:partof"],
      "searchParam" : [{
        "name" : "_id",
        "type" : "token"
      },
      {
        "name" : "active",
        "type" : "token"
      },
      {
        "name" : "partof",
        "type" : "reference",
        "documentation" : "Trädklättring: kombinera med _include:iterate=Organization:partof (HSACAT-ORG-006)."
      },
      {
        "name" : "hsa-id",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-id",
        "type" : "token",
        "documentation" : "Logisk adress = HSA-id i SKLTP TAK."
      },
      {
        "name" : "hsa-org-class",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class",
        "type" : "token",
        "documentation" : "Filtrera på healthcare-provider (yttre spärr) eller healthcare-unit (inre spärr)."
      }]
    }]
  }]
}

```
