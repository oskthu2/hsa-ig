# HSA Central Catalog Server - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Central Catalog Server**

## CapabilityStatement: HSA Central Catalog Server 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/CapabilityStatement/hsa-catalog-server | *Version*:0.1.0 |
| Draft as of 2026-05-21 | *Computable Name*:HsaCatalogServer |

 
Exempel på serverförmågor för ett centralt HSA-katalog FHIR R5 API med läsaccess. 

 [Raw OpenAPI-Swagger Definition file](hsa-catalog-server.openapi.json) | [Download](hsa-catalog-server.openapi.json) 



## Resource Content

```json
{
  "resourceType" : "CapabilityStatement",
  "id" : "hsa-catalog-server",
  "url" : "https://hsa.inera.se/fhir/CapabilityStatement/hsa-catalog-server",
  "version" : "0.1.0",
  "name" : "HsaCatalogServer",
  "title" : "HSA Central Catalog Server",
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
  "description" : "Exempel på serverförmågor för ett centralt HSA-katalog FHIR R5 API med läsaccess.",
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
    "documentation" : "Läs- och sök-API för HSA-katalogen.\nPublik synlighet filtreras via _security-parametern (destination indicator 03).\nSkrivoperationer stöds inte på detta gränssnitt.",
    "resource" : [{
      "type" : "Organization",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization",
      "supportedProfile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization",
      "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"],
      "documentation" : "Organisationer i HSA-katalogen: vårdgivare, vårdenheter och organisatoriska enheter.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "versioning" : "no-version",
      "readHistory" : false,
      "updateCreate" : false,
      "conditionalCreate" : false,
      "conditionalUpdate" : false,
      "conditionalDelete" : "not-supported",
      "referencePolicy" : ["resolves"],
      "searchInclude" : ["Organization:partof"],
      "searchRevInclude" : ["Organization:partof",
      "Location:organization",
      "HealthcareService:organization"],
      "searchParam" : [{
        "name" : "_id",
        "type" : "token",
        "documentation" : "Sökning på resurens FHIR-id."
      },
      {
        "name" : "_security",
        "type" : "token",
        "documentation" : "Filtrering på meta.security. Använd `urn:oid:1.2.752.29.23.1.11|03` för publika resurser."
      },
      {
        "name" : "_lastUpdated",
        "type" : "date",
        "documentation" : "Filtrering på senaste ändringsdatum (för inkrementell synk)."
      },
      {
        "name" : "identifier",
        "type" : "token",
        "documentation" : "Sökning på valfri identifierare. Prefix: `urn:oid:1.2.752.29.4.19|SE...` för HSA-id."
      },
      {
        "name" : "active",
        "type" : "token",
        "documentation" : "Filtrera på aktiv/inaktiv status."
      },
      {
        "name" : "name",
        "type" : "string",
        "documentation" : "Sökning på organisationsnamn (prefix-match)."
      },
      {
        "name" : "type",
        "type" : "token",
        "documentation" : "Sökning på organisationstyp."
      },
      {
        "name" : "partof",
        "type" : "reference",
        "documentation" : "Sökning på överordnad organisation. Stödjer `_include:iterate` för hierarkisökning."
      },
      {
        "name" : "hsa-id",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-id",
        "type" : "token",
        "documentation" : "Kortform för sökning på HSA-id (system urn:oid:1.2.752.29.4.19)."
      },
      {
        "name" : "hsa-org-class",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class",
        "type" : "token",
        "documentation" : "Sökning på HSA-objektklass (healthcare-provider, healthcare-unit, organizational-unit)."
      }]
    },
    {
      "type" : "Location",
      "profile" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location",
      "documentation" : "Fysiska besöksplatser och mottagningslokaler i HSA-katalogen.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "versioning" : "no-version",
      "readHistory" : false,
      "updateCreate" : false,
      "conditionalCreate" : false,
      "conditionalUpdate" : false,
      "conditionalDelete" : "not-supported",
      "searchInclude" : ["Location:organization"],
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
        "type" : "reference",
        "documentation" : "Filtrering på ansvarig organisation (managingOrganization)."
      },
      {
        "name" : "near",
        "type" : "special",
        "documentation" : "Geo-sökning (position.latitude/longitude). Förutsätter koordinatstöd på servern."
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
      "documentation" : "Vårdtjänster och tjänsteutbud kopplade till HSA-enheter.",
      "interaction" : [{
        "code" : "read"
      },
      {
        "code" : "search-type"
      }],
      "versioning" : "no-version",
      "readHistory" : false,
      "updateCreate" : false,
      "conditionalCreate" : false,
      "conditionalUpdate" : false,
      "conditionalDelete" : "not-supported",
      "searchInclude" : ["HealthcareService:organization", "HealthcareService:location"],
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
        "type" : "date"
      },
      {
        "name" : "active",
        "type" : "token"
      },
      {
        "name" : "organization",
        "type" : "reference",
        "documentation" : "Filtrering på tillhandahållande organisation (providedBy)."
      },
      {
        "name" : "location",
        "type" : "reference",
        "documentation" : "Filtrering på kopplad plats."
      },
      {
        "name" : "service-category",
        "type" : "token",
        "documentation" : "Sökning på verksamhetskod (system urn:oid:1.2.752.129.2.2.1.3)."
      },
      {
        "name" : "service-type",
        "type" : "token",
        "documentation" : "Sökning på vård-/omsorgsform (system urn:oid:1.2.752.129.2.2.1.13)."
      },
      {
        "name" : "hsa-provided-by",
        "definition" : "https://hsa.inera.se/fhir/SearchParameter/hsa-provided-by",
        "type" : "reference"
      }]
    }]
  }]
}

```
