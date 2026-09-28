# HSA Regional Catalog Server (hypotes) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Regional Catalog Server (hypotes)**

## CapabilityStatement: HSA Regional Catalog Server (hypotes) (Experimental) 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/CapabilityStatement/hsa-regional-catalog-server | *Version*:0.1.0 |
| Draft as of 2026-05-21 | *Computable Name*:HsaRegionalCatalogServer |

 
Hypotetiskt exempel på ett regionalt/lokalt mellanlager för HSA-data med stöd för både läsning och skrivning. 

 [Raw OpenAPI-Swagger Definition file](hsa-regional-catalog-server.openapi.json) | [Download](hsa-regional-catalog-server.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "hsa-regional-catalog-server",
  "url" : "https://hsa.inera.se/fhir/CapabilityStatement/hsa-regional-catalog-server",
  "version" : "0.1.0",
  "name" : "HsaRegionalCatalogServer",
  "title" : "HSA Regional Catalog Server (hypotes)",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-05-21",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Hypotetiskt exempel på ett regionalt/lokalt mellanlager för HSA-data med stöd för både läsning och skrivning.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "kind" : "requirements",
  "fhirVersion" : "5.0.0",
  "format" : ["json", "xml"],
  "rest" : [{
    "mode" : "server",
    "documentation" : "En möjlig utformning kombinerar läs-API:et från det centrala exemplet med\nskrivoperationer för att möjliggöra datainläsning från LDAP eller andra källor.\nTransaktionsbuntar kan användas för bulkuppdatering och conditional update\n(PUT by identifier) kan möjliggöra idempotent LDAP→FHIR-synkronisering.\nHur detta faktiskt ska fungera i regionala system är en öppen fråga.",
    "resource" : [{
      "type" : "Organization",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization",
      "supportedProfile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization",
      "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"],
      "documentation" : "Organisationer – samma läs-API som centralt system plus skrivoperationer för LDAP-synk.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      },
      {
        "code" : "create"
      },
      {
        "code" : "update"
      },
      {
        "code" : "delete"
      }],
      "versioning" : "no-version",
      "readHistory" : false,
      "updateCreate" : true,
      "conditionalCreate" : false,
      "conditionalUpdate" : true,
      "conditionalDelete" : "single",
      "referencePolicy" : ["resolves"],
      "searchInclude" : ["Organization:partof"],
      "searchRevInclude" : ["Organization:partof",
      "Location:organization",
      "HealthcareService:organization"],
      "searchParam" : [{
        "name" : "_id",
        "type" : "token"
      },
      {
        "name" : "_security",
        "type" : "token",
        "documentation" : "Filtrering på destinationIndicator (meta.security)."
      },
      {
        "name" : "_lastUpdated",
        "type" : "date",
        "documentation" : "Inkrementell synk: hämta resurser ändrade efter en given tidpunkt."
      },
      {
        "name" : "identifier",
        "type" : "token"
      },
      {
        "name" : "active",
        "type" : "token"
      },
      {
        "name" : "name",
        "type" : "string"
      },
      {
        "name" : "type",
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
      "documentation" : "Besöksplatser – samma läs-API som centralt system plus skrivoperationer.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      },
      {
        "code" : "create"
      },
      {
        "code" : "update"
      },
      {
        "code" : "delete"
      }],
      "versioning" : "no-version",
      "readHistory" : false,
      "updateCreate" : true,
      "conditionalCreate" : false,
      "conditionalUpdate" : true,
      "conditionalDelete" : "single",
      "searchInclude" : ["Location:organization"],
      "searchParam" : [{
        "name" : "_id",
        "type" : "token"
      },
      {
        "name" : "_security",
        "type" : "token"
      },
      {
        "name" : "_lastUpdated",
        "type" : "date"
      },
      {
        "name" : "identifier",
        "type" : "token"
      },
      {
        "name" : "status",
        "type" : "token"
      },
      {
        "name" : "organization",
        "type" : "reference"
      },
      {
        "name" : "near",
        "type" : "special"
      },
      {
        "name" : "hsa-id",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-id",
        "type" : "token"
      }]
    },
    {
      "type" : "HealthcareService",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service",
      "documentation" : "Vårdtjänster – samma läs-API som centralt system plus skrivoperationer.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      },
      {
        "code" : "create"
      },
      {
        "code" : "update"
      },
      {
        "code" : "delete"
      }],
      "versioning" : "no-version",
      "readHistory" : false,
      "updateCreate" : true,
      "conditionalCreate" : false,
      "conditionalUpdate" : true,
      "conditionalDelete" : "single",
      "searchInclude" : ["HealthcareService:organization", "HealthcareService:location"],
      "searchParam" : [{
        "name" : "_id",
        "type" : "token"
      },
      {
        "name" : "_security",
        "type" : "token"
      },
      {
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
        "name" : "location",
        "type" : "reference"
      },
      {
        "name" : "service-category",
        "type" : "token"
      },
      {
        "name" : "service-type",
        "type" : "token"
      },
      {
        "name" : "hsa-provided-by",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-provided-by",
        "type" : "reference"
      }]
    }],
    "interaction" : [{
      "code" : "transaction",
      "documentation" : "Transaction-buntar kan möjliggöra atomär bulkuppdatering vid LDAP-synkronisering."
    },
    {
      "code" : "batch",
      "documentation" : "Stöd för batchbuntar för icke-atomär bulkläsning/-skrivning."
    }]
  }]
}

```
