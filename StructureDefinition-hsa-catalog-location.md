# HSA Catalog Location - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Catalog Location**

## Resource Profile: HSA Catalog Location 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location | *Version*:0.1.0 |
| Draft as of 2026-05-20 | *Computable Name*:HsaCatalogLocation |

 
Profil för platser hämtade ur HSA-katalogen. Representerar fysiska besöksplatser, mottagningar och vårdlokaler. 
Fysiska platser måste ha besöksadress (gatuadress + stad) och en referens till ansvarig organisation. Koordinater (SWEREF99) krävs för offentlig publicering på 1177 Hitta vård. 
**Synlighet:** Anges via `meta.security[destination-indicator]` med system `urn:oid:1.2.752.29.23.1.11`, kod 03 = Internet/allmänheten. 
**Vägbeskrivning:** Lagras i `description` som Markdown. Konvention: 
* `## Yttre vägbeskrivning` – kollektivtrafik, parkering, hur man hittar till platsen
* `## Inre vägbeskrivning` – entré, plan, hiss, rum etc. Klienter bör rendera description som Markdown.
 

**Användningar:**

* Referera till denna Profil: [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)
* Exempel för denna Profil: [Blekingesjukhuset](Location-location-blekingesjukhuset.md) and [Ronneby Vårdcentral](Location-location-ronneby-vardcentral.md)
* CapabilityStatements som använder denna Profil: [HSA Central Catalog Server](CapabilityStatement-hsa-catalog-server.md), [HSA Klient – 1177 Hitta vård](CapabilityStatement-hsa-client-1177-hitta-vard.md), [HSA Klient – EHR-katalogsynk](CapabilityStatement-hsa-client-ehr-sync.md) and [HSA Regional Catalog Server (hypotes)](CapabilityStatement-hsa-regional-catalog-server.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-catalog-location)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-catalog-location.csv), [Excel](StructureDefinition-hsa-catalog-location.xlsx), [Schematron](StructureDefinition-hsa-catalog-location.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-catalog-location",
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location",
  "version" : "0.1.0",
  "name" : "HsaCatalogLocation",
  "title" : "HSA Catalog Location",
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
  "description" : "Profil för platser hämtade ur HSA-katalogen. Representerar fysiska\nbesöksplatser, mottagningar och vårdlokaler.\n\nFysiska platser måste ha besöksadress (gatuadress + stad) och\nen referens till ansvarig organisation. Koordinater (SWEREF99) krävs\nför offentlig publicering på 1177 Hitta vård.\n\n**Synlighet:** Anges via `meta.security[destination-indicator]` med\nsystem `urn:oid:1.2.752.29.23.1.11`, kod 03 = Internet/allmänheten.\n\n**Vägbeskrivning:** Lagras i `description` som Markdown. Konvention:\n- `## Yttre vägbeskrivning` – kollektivtrafik, parkering, hur man hittar till platsen\n- `## Inre vägbeskrivning` – entré, plan, hiss, rum etc.\nKlienter bör rendera description som Markdown.",
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
  "type" : "Location",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Location",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Location",
      "path" : "Location",
      "constraint" : [{
        "key" : "hsacat-physical-location-address",
        "severity" : "error",
        "human" : "En fysisk plats (mode = instance) SHALL ha besöksadress.",
        "expression" : "mode = 'instance' implies address.where(type = 'physical' or type = 'both').exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"
      },
      {
        "key" : "hsacat-physical-location-city",
        "severity" : "error",
        "human" : "En fysisk plats SHALL ha lokalitet (address.city).",
        "expression" : "mode = 'instance' implies address.where(type = 'physical' or type = 'both').city.exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"
      },
      {
        "key" : "hsacat-public-location-position",
        "severity" : "warning",
        "human" : "En fysisk plats som är publik (destination indicator 03) SHOULD ha geografiska koordinater.",
        "expression" : "meta.security.where(system = 'urn:oid:1.2.752.29.23.1.11' and code = '03').exists() implies position.exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"
      }]
    },
    {
      "id" : "Location.meta.security",
      "path" : "Location.meta.security",
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
      "id" : "Location.meta.security:destination-indicator",
      "path" : "Location.meta.security",
      "sliceName" : "destination-indicator",
      "short" : "Publik synlighet (hsaDestinationIndicator, OID 1.2.752.29.23.1.11)",
      "definition" : "Kod 03 = Internet/allmänheten. Anger att platsen är synlig på t.ex. 1177 Hitta vård.",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Location.meta.security:destination-indicator.system",
      "path" : "Location.meta.security.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.29.23.1.11"
    },
    {
      "id" : "Location.meta.security:destination-indicator.code",
      "path" : "Location.meta.security.code",
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-destination-indicator"
      }
    },
    {
      "id" : "Location.identifier",
      "path" : "Location.identifier",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "system"
        }],
        "rules" : "open"
      },
      "mustSupport" : true
    },
    {
      "id" : "Location.identifier:hsa-id",
      "path" : "Location.identifier",
      "sliceName" : "hsa-id",
      "short" : "HSA-identitet för platsobjektet",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Location.identifier:hsa-id.system",
      "path" : "Location.identifier.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.29.4.19"
    },
    {
      "id" : "Location.identifier:hsa-id.value",
      "path" : "Location.identifier.value",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Location.status",
      "path" : "Location.status",
      "short" : "Aktiv/inaktiv status för platsen",
      "mustSupport" : true
    },
    {
      "id" : "Location.name",
      "path" : "Location.name",
      "short" : "Platsens namn",
      "mustSupport" : true
    },
    {
      "id" : "Location.description",
      "path" : "Location.description",
      "short" : "Vägbeskrivning och beskrivning av platsen (Markdown)",
      "definition" : "Fritext-beskrivning med yttre och inre vägbeskrivning. Klienter bör rendera\nsom Markdown. Rekommenderade rubriker: `## Yttre vägbeskrivning` och\n`## Inre vägbeskrivning`.",
      "mustSupport" : true
    },
    {
      "id" : "Location.mode",
      "path" : "Location.mode",
      "short" : "instance = fysisk plats",
      "mustSupport" : true
    },
    {
      "id" : "Location.address",
      "path" : "Location.address",
      "short" : "Besöksadress (fysisk)",
      "definition" : "Enhetens besöksadress (typ=physical). Ska aldrig innehålla postnummer\n(Uppsala-regel; postnummer hör till postadress på Organization).",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Location.address.type",
      "path" : "Location.address.type",
      "fixedCode" : "physical"
    },
    {
      "id" : "Location.address.line",
      "path" : "Location.address.line",
      "mustSupport" : true
    },
    {
      "id" : "Location.address.city",
      "path" : "Location.address.city",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Location.address.postalCode",
      "path" : "Location.address.postalCode",
      "max" : "0"
    },
    {
      "id" : "Location.position",
      "path" : "Location.position",
      "short" : "Geografiska koordinater (SWEREF99)",
      "definition" : "Latitud och longitud enligt SWEREF99 TM. Obligatoriskt för platser synliga\nför allmänheten (destination indicator 03) för att synas på karta i 1177.",
      "mustSupport" : true
    },
    {
      "id" : "Location.position.longitude",
      "path" : "Location.position.longitude",
      "mustSupport" : true
    },
    {
      "id" : "Location.position.latitude",
      "path" : "Location.position.latitude",
      "mustSupport" : true
    },
    {
      "id" : "Location.position.altitude",
      "path" : "Location.position.altitude",
      "max" : "0"
    },
    {
      "id" : "Location.managingOrganization",
      "path" : "Location.managingOrganization",
      "short" : "Ansvarig organisation för platsen",
      "min" : 1,
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"]
      }],
      "mustSupport" : true
    }]
  }
}

```
