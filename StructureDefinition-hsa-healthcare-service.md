# HSA Healthcare Service - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Healthcare Service**

## Resource Profile: HSA Healthcare Service 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service | *Version*:0.1.0 |
| Draft as of 2026-05-20 | *Computable Name*:HsaHealthcareService |

 
Profil för vårdtjänster och tjänsteutbud från HSA-katalogen. Verksamhetskod och vård-/omsorgsform är obligatoriska för enheter som bedriver vård. 
Verksamhetskod (businessClassificationCode) modelleras på `category` i enlighet med eHMs Nationell katalog-IG (hvo-business-category-inera). Vård-/omsorgsform (careType) modelleras på `type` som mer specifik tjänsteklassificering. 

**Användningar:**

* Exempel för denna Profil: [Internmedicin och Kardiologi](HealthcareService-hs-tjanst-blekingesjukhuset.md) and [Allmänmedicin Ronneby Vårdcentral](HealthcareService-hs-tjanst-ronneby-vardcentral.md)
* CapabilityStatements som använder denna Profil: [HSA Central Catalog Server](CapabilityStatement-hsa-catalog-server.md), [HSA Klient – 1177 Hitta vård](CapabilityStatement-hsa-client-1177-hitta-vard.md), [HSA Klient – EHR-katalogsynk](CapabilityStatement-hsa-client-ehr-sync.md) and [HSA Regional Catalog Server (hypotes)](CapabilityStatement-hsa-regional-catalog-server.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-healthcare-service)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-healthcare-service.csv), [Excel](StructureDefinition-hsa-healthcare-service.xlsx), [Schematron](StructureDefinition-hsa-healthcare-service.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-healthcare-service",
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service",
  "version" : "0.1.0",
  "name" : "HsaHealthcareService",
  "title" : "HSA Healthcare Service",
  "status" : "draft",
  "date" : "2026-05-20",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Profil för vårdtjänster och tjänsteutbud från HSA-katalogen.\nVerksamhetskod och vård-/omsorgsform är obligatoriska för enheter som\nbedriver vård.\n\nVerksamhetskod (businessClassificationCode) modelleras på `category` i\nenlighet med eHMs Nationell katalog-IG (hvo-business-category-inera).\nVård-/omsorgsform (careType) modelleras på `type` som mer specifik\ntjänsteklassificering.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "fhirVersion" : "5.0.0",
  "mapping" : [{
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "interface",
    "uri" : "http://hl7.org/fhir/interface",
    "name" : "Interface Pattern"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "HealthcareService",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/HealthcareService",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "HealthcareService",
      "path" : "HealthcareService",
      "constraint" : [{
        "key" : "hsacat-service-provider",
        "severity" : "error",
        "human" : "En HealthcareService SHALL ha providedBy (tillhandahållande organisation).",
        "expression" : "providedBy.exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"
      },
      {
        "key" : "hsacat-digital-service-contact",
        "severity" : "error",
        "human" : "En digital HealthcareService SHALL ha telecom eller endpoint.",
        "expression" : "type.coding.where(code = 'digital').exists() implies (contact.telecom.exists() or endpoint.exists())",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"
      }]
    },
    {
      "id" : "HealthcareService.meta.security",
      "path" : "HealthcareService.meta.security",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "system"
        }],
        "rules" : "open"
      },
      "short" : "Åtkomstkontroll och publiceringsscope",
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.meta.security:destination-indicator",
      "path" : "HealthcareService.meta.security",
      "sliceName" : "destination-indicator",
      "short" : "Publik synlighet (hsaDestinationIndicator, OID 1.2.752.29.23.1.11)",
      "definition" : "Kod 03 = Internet/allmänheten. Anger att tjänsten är synlig på t.ex. 1177 Hitta vård.",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.meta.security:destination-indicator.system",
      "path" : "HealthcareService.meta.security.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.29.23.1.11"
    },
    {
      "id" : "HealthcareService.meta.security:destination-indicator.code",
      "path" : "HealthcareService.meta.security.code",
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-destination-indicator"
      }
    },
    {
      "id" : "HealthcareService.extension",
      "path" : "HealthcareService.extension",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "url"
        }],
        "ordered" : false,
        "rules" : "open"
      }
    },
    {
      "id" : "HealthcareService.extension:temporaryNotice",
      "path" : "HealthcareService.extension",
      "sliceName" : "temporaryNotice",
      "short" : "Tillfällig information (hsaVpwInformation2)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.extension:patientInfo",
      "path" : "HealthcareService.extension",
      "sliceName" : "patientInfo",
      "short" : "Information till patient (hsaVpwInformation4)",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.active",
      "path" : "HealthcareService.active",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.providedBy",
      "path" : "HealthcareService.providedBy",
      "short" : "Tillhandahållande organisation (obligatorisk)",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.category",
      "path" : "HealthcareService.category",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "coding.system"
        }],
        "rules" : "open"
      },
      "short" : "Verksamhetskod och eventuell nationell tjänstekategori",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.category:verksamhetskod",
      "path" : "HealthcareService.category",
      "sliceName" : "verksamhetskod",
      "short" : "Verksamhetskod (businessClassificationCode, HSACAT-TERM-001)",
      "definition" : "HSA verksamhetskod (OID 1.2.752.129.2.2.1.3). Bred klassificering av\nvilken typ av vård/omsorg som bedrivs. Aligns med eHMs hvo-business-\ncategory-inera (required binding). Kan denormaliseras till Encounter.type\nav konsumenter som VGR.",
      "min" : 1,
      "max" : "*",
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.category:verksamhetskod.coding",
      "path" : "HealthcareService.category.coding",
      "min" : 1,
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-service-type"
      }
    },
    {
      "id" : "HealthcareService.category:verksamhetskod.coding.system",
      "path" : "HealthcareService.category.coding.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.129.2.2.1.3"
    },
    {
      "id" : "HealthcareService.type",
      "path" : "HealthcareService.type",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "coding.system"
        }],
        "rules" : "open"
      },
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.type:care-type",
      "path" : "HealthcareService.type",
      "sliceName" : "care-type",
      "short" : "Vård- och omsorgsform (careType, HSACAT-SVC-003)",
      "min" : 0,
      "max" : "*",
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.type:care-type.coding",
      "path" : "HealthcareService.type.coding",
      "min" : 1,
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-care-type"
      }
    },
    {
      "id" : "HealthcareService.type:care-type.coding.system",
      "path" : "HealthcareService.type.coding.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.129.2.2.1.13"
    },
    {
      "id" : "HealthcareService.location",
      "path" : "HealthcareService.location",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.name",
      "path" : "HealthcareService.name",
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.comment",
      "path" : "HealthcareService.comment",
      "short" : "Beskrivning ('Om oss' på 1177)",
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.contact",
      "path" : "HealthcareService.contact",
      "short" : "Kontaktuppgifter för tjänsten",
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.availability",
      "path" : "HealthcareService.availability",
      "short" : "Tillgänglighet / öppettider",
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.availability.availableTime",
      "path" : "HealthcareService.availability.availableTime",
      "short" : "Öppettider per veckodag",
      "mustSupport" : true
    },
    {
      "id" : "HealthcareService.endpoint",
      "path" : "HealthcareService.endpoint",
      "mustSupport" : true
    }]
  }
}

```
