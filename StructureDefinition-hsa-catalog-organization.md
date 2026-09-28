# HSA Catalog Organization - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Catalog Organization**

## Resource Profile: HSA Catalog Organization ( Experimental ) 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization | *Version*:0.1.0 |
| Draft as of 2026-05-20 | *Computable Name*:HsaCatalogOrganization |

 
Basprofil för organisationer hämtade ur HSA-katalogen. Täcker vårdgivare, vårdenheter och organisatoriska enheter i organisationsträdet. 
Alla HSA-organisationer har ett HSA-id, ett namn och information om publicerings- och åtkomststatus. Hierarkin representeras via `partOf`. 
**Synlighet (destinationIndicator):** Modelleras som `meta.security[destination-indicator]` med system `urn:oid:1.2.752.29.23.1.11`. Kod 03 = Internet/allmänheten. Klienter som 1177 Hitta vård bör filtrera på detta fält. 
**Tillfällig information:** En enhet med tidsbegränsad status använder `extension[orgPeriod]` (organization-period) med start och obligatoriskt end. Klienter bör rendera en visuell varningsindikator (t.ex. gul informationsruta) när orgPeriod är satt och `active = true`. Varje klient ansvarar för att texten som ska visas hämtas från ett lämpligt fält (t.ex. Organization.contact med purpose = "TEMP" eller IG-sida för klientkonventioner). 

**Användningar:**

* Härledd från denna Profil: [HSA Healthcare Provider Organization](StructureDefinition-hsa-healthcare-provider-organization.md) and [HSA Healthcare Unit Organization](StructureDefinition-hsa-healthcare-unit-organization.md)
* Referera till denna Profil: [HSA Catalog Location](StructureDefinition-hsa-catalog-location.md), [HSA Catalog Organization](StructureDefinition-hsa-catalog-organization.md) and [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)
* CapabilityStatements som använder denna Profil: [HSA Central Catalog Server](CapabilityStatement-hsa-catalog-server.md), [HSA Klient – 1177 Hitta vård](CapabilityStatement-hsa-client-1177-hitta-vard.md), [HSA Klient – EHR-katalogsynk](CapabilityStatement-hsa-client-ehr-sync.md), [HSA Klient – Hierarkitraversering](CapabilityStatement-hsa-client-hierarchy-traversal.md)... Show 2 more, [HSA Klient – Nationell Patientöversikt (NPÖ)](CapabilityStatement-hsa-client-npo.md) and [HSA Regional Catalog Server (hypotes)](CapabilityStatement-hsa-regional-catalog-server.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-catalog-organization)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-catalog-organization.csv), [Excel](StructureDefinition-hsa-catalog-organization.xlsx), [Schematron](StructureDefinition-hsa-catalog-organization.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-catalog-organization",
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization",
  "version" : "0.1.0",
  "name" : "HsaCatalogOrganization",
  "title" : "HSA Catalog Organization",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-05-20",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Basprofil för organisationer hämtade ur HSA-katalogen. Täcker\nvårdgivare, vårdenheter och organisatoriska enheter i organisationsträdet.\n\nAlla HSA-organisationer har ett HSA-id, ett namn och information om\npublicerings- och åtkomststatus. Hierarkin representeras via `partOf`.\n\n**Synlighet (destinationIndicator):** Modelleras som `meta.security[destination-indicator]`\nmed system `urn:oid:1.2.752.29.23.1.11`. Kod 03 = Internet/allmänheten.\nKlienter som 1177 Hitta vård bör filtrera på detta fält.\n\n**Tillfällig information:** En enhet med tidsbegränsad status använder\n`extension[orgPeriod]` (organization-period) med start och obligatoriskt end.\nKlienter bör rendera en visuell varningsindikator (t.ex. gul informationsruta)\nnär orgPeriod är satt och `active = true`. Varje klient ansvarar för att\ntexten som ska visas hämtas från ett lämpligt fält (t.ex. Organization.contact\nmed purpose = \"TEMP\" eller IG-sida för klientkonventioner).",
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
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 V2 Mapping"
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
  },
  {
    "identity" : "servd",
    "uri" : "http://www.omg.org/spec/ServD/1.0/",
    "name" : "ServD"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Organization",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Organization",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Organization",
      "path" : "Organization",
      "constraint" : [{
        "key" : "hsacat-org-hsa-id",
        "severity" : "error",
        "human" : "En organisation från HSA SHALL ha HSA-id (urn:oid:1.2.752.29.4.19).",
        "expression" : "identifier.where(system = 'urn:oid:1.2.752.29.4.19').exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
      },
      {
        "key" : "hsacat-org-hsa-id-format",
        "severity" : "warning",
        "human" : "HSA-id ska följa formatet SE<org-nr>-<suffix> eller SE<personnr>-<suffix>.",
        "expression" : "identifier.where(system = 'urn:oid:1.2.752.29.4.19').value.matches('^SE[0-9]+-[A-Z0-9]+$')",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
      },
      {
        "key" : "hsacat-provider-orgno",
        "severity" : "error",
        "human" : "En organisation markerad som vårdgivare (healthcare-provider) SHALL ha organisationsnummer.",
        "expression" : "type.coding.where(system = 'https://hsa.inera.se/fhir/CodeSystem/hsa-object-class' and code = 'healthcare-provider').exists() implies identifier.where(system = 'urn:oid:2.5.4.97').exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
      },
      {
        "key" : "hsacat-public-org-telecom",
        "severity" : "error",
        "human" : "En publik organisation (destination indicator 03) SHALL ha direkttelefon.",
        "expression" : "meta.security.where(system = 'urn:oid:1.2.752.29.23.1.11' and code = '03').exists() implies contact.telecom.where(system = 'phone').exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
      },
      {
        "key" : "hsacat-org-period-end",
        "severity" : "error",
        "human" : "Om organization-period är satt SHALL end-datum anges (tillfällig enhet måste ha klart slutdatum).",
        "expression" : "extension.where(url = 'http://hl7.org/fhir/StructureDefinition/organization-period').exists() implies extension.where(url = 'http://hl7.org/fhir/StructureDefinition/organization-period').value.ofType(Period).end.exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
      },
      {
        "key" : "hsacat-inactive-not-public",
        "severity" : "error",
        "human" : "En inaktiv organisation (active = false) får inte ha destinationIndicator 03 (publik synlighet).",
        "expression" : "active = false implies meta.security.where(system = 'urn:oid:1.2.752.29.23.1.11' and code = '03').exists().not()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
      },
      {
        "key" : "hsacat-temporary-notice-requires-period",
        "severity" : "warning",
        "human" : "Om temporaryNotice (hsaVpwInformation2) är satt bör organization-period också vara satt — klienter förlitar sig på period.end för att veta när den gula informationsrutan ska döljas.",
        "expression" : "extension.where(url = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice').exists() implies extension.where(url = 'http://hl7.org/fhir/StructureDefinition/organization-period').exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
      }]
    },
    {
      "id" : "Organization.meta.security",
      "path" : "Organization.meta.security",
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
      "id" : "Organization.meta.security:destination-indicator",
      "path" : "Organization.meta.security",
      "sliceName" : "destination-indicator",
      "short" : "Publik synlighet (hsaDestinationIndicator, OID 1.2.752.29.23.1.11)",
      "definition" : "Kod 03 = Internet/allmänheten. Anger att enheten är synlig på t.ex. 1177 Hitta vård.",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Organization.meta.security:destination-indicator.system",
      "path" : "Organization.meta.security.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.29.23.1.11"
    },
    {
      "id" : "Organization.meta.security:destination-indicator.code",
      "path" : "Organization.meta.security.code",
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-destination-indicator"
      }
    },
    {
      "id" : "Organization.extension",
      "path" : "Organization.extension",
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
      "id" : "Organization.extension:orgPeriod",
      "path" : "Organization.extension",
      "sliceName" : "orgPeriod",
      "short" : "Organisationens giltighetsperiod (t.ex. tillfällig enhet)",
      "definition" : "Sätts när enheten är aktiv under en begränsad period. Period.end är obligatoriskt\n(invariant hsacat-org-period-end). Klienter ska rendera en visuell varningsindikator\nnär detta fält är satt och `active = true`.",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["http://hl7.org/fhir/StructureDefinition/organization-period"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Organization.extension:orgPeriod.value[x].end",
      "path" : "Organization.extension.value[x].end",
      "min" : 1
    },
    {
      "id" : "Organization.extension:temporaryNotice",
      "path" : "Organization.extension",
      "sliceName" : "temporaryNotice",
      "short" : "Tillfällig information (hsaVpwInformation2)",
      "definition" : "Fri text som visas som gul informationsruta på 1177. Ska kombineras med\nextension[orgPeriod] (organization-period) som anger giltighetstid.\nKlienter bör rendera visuell varningsindikator när detta fält är satt.",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Organization.extension:patientInfo",
      "path" : "Organization.extension",
      "sliceName" : "patientInfo",
      "short" : "Information till patient (hsaVpwInformation4)",
      "definition" : "Informationstext riktad direkt till patient. Visas på 1177-sidan. Klienter bör rendera som Markdown.",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Organization.extension:financingOrganization",
      "path" : "Organization.extension",
      "sliceName" : "financingOrganization",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-financing-organization"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Organization.identifier",
      "path" : "Organization.identifier",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "system"
        }],
        "rules" : "open"
      },
      "short" : "Identifierare för HSA-objektet",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Organization.identifier:hsa-id",
      "path" : "Organization.identifier",
      "sliceName" : "hsa-id",
      "short" : "HSA-identitet",
      "definition" : "Unikt, systemgenererat HSA-id. Tilldelas automatiskt vid skapande. Aldrig manuellt satt.",
      "min" : 1,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Organization.identifier:hsa-id.system",
      "path" : "Organization.identifier.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.29.4.19"
    },
    {
      "id" : "Organization.identifier:hsa-id.value",
      "path" : "Organization.identifier.value",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Organization.identifier:org-no",
      "path" : "Organization.identifier",
      "sliceName" : "org-no",
      "short" : "Organisationsnummer",
      "definition" : "Organisationsnummer (obligatoriskt för vårdgivare, se hsacat-provider-orgno).",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Organization.identifier:org-no.system",
      "path" : "Organization.identifier.system",
      "min" : 1,
      "fixedUri" : "urn:oid:2.5.4.97"
    },
    {
      "id" : "Organization.identifier:org-no.value",
      "path" : "Organization.identifier.value",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Organization.identifier:apk",
      "path" : "Organization.identifier",
      "sliceName" : "apk",
      "short" : "Arbetsplatskod (unitPrescriptionCode, NPÖ-relevant)",
      "definition" : "Arbetsplatskod som NPÖ använder för att identifiera en vårdenhet i GetHealthCareUnitMembers. LDAP: unitPrescriptionCode. OID att bekräfta (HSACAT-ORG-012, öppen fråga 8).",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Organization.identifier:apk.system",
      "path" : "Organization.identifier.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.29.4.71"
    },
    {
      "id" : "Organization.identifier:apk.value",
      "path" : "Organization.identifier.value",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Organization.identifier:gln",
      "path" : "Organization.identifier",
      "sliceName" : "gln",
      "short" : "GLN-kod (hsaGlnCode)",
      "definition" : "Global Location Number (GS1). Används för att identifiera organisationer och platser i logistik- och vårdinformationssystem. LDAP: hsaGlnCode.",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Organization.identifier:gln.system",
      "path" : "Organization.identifier.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.3.88"
    },
    {
      "id" : "Organization.identifier:gln.value",
      "path" : "Organization.identifier.value",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Organization.active",
      "path" : "Organization.active",
      "short" : "Publiceringsstatus",
      "definition" : "true = aktiv och synlig; false = dolt (hiddenObject), arkiverat (hsaArchivedObject)\neller felaktigt utpekad (hsaInaccurateHCP/HCU). Sätts av HSA-systemet.",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Organization.type",
      "path" : "Organization.type",
      "slicing" : {
        "discriminator" : [{
          "type" : "value",
          "path" : "coding.system"
        }],
        "rules" : "open"
      },
      "short" : "Organisationstyp och klassificering",
      "mustSupport" : true
    },
    {
      "id" : "Organization.type:hsa-class",
      "path" : "Organization.type",
      "sliceName" : "hsa-class",
      "short" : "HSA-objektklassificering (vårdgivare/vårdenhet/org.enhet)",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Organization.type:hsa-class.coding",
      "path" : "Organization.type.coding",
      "min" : 1,
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-organization-type"
      }
    },
    {
      "id" : "Organization.type:hsa-class.coding.system",
      "path" : "Organization.type.coding.system",
      "min" : 1,
      "fixedUri" : "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    },
    {
      "id" : "Organization.type:hsa-class.coding.code",
      "path" : "Organization.type.coding.code",
      "min" : 1
    },
    {
      "id" : "Organization.type:ownership",
      "path" : "Organization.type",
      "sliceName" : "ownership",
      "short" : "Ägarform (management/regi)",
      "definition" : "Anger i vilken regi verksamheten bedrivs (HSACAT-ORG-010).",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Organization.type:ownership.coding",
      "path" : "Organization.type.coding",
      "min" : 1,
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-ownership-type"
      }
    },
    {
      "id" : "Organization.type:ownership.coding.system",
      "path" : "Organization.type.coding.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.129.2.2.1.14"
    },
    {
      "id" : "Organization.type:care-level",
      "path" : "Organization.type",
      "sliceName" : "care-level",
      "short" : "Administrativ vårdnivå (HSACAT-ORG-009)",
      "definition" : "Kod som anger administrativ specialiseringsnivå i hälso- och sjukvård.\nObligatorisk (1..1) för vårdenheter (HsaHealthcareUnitOrganization).\nLDAP: careLevel. System: OID 1.2.752.129.5.1.46.",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Organization.type:care-level.coding",
      "path" : "Organization.type.coding",
      "min" : 1,
      "binding" : {
        "strength" : "required",
        "valueSet" : "urn:oid:1.2.752.129.5.1.46"
      }
    },
    {
      "id" : "Organization.type:care-level.coding.system",
      "path" : "Organization.type.coding.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.129.5.1.46"
    },
    {
      "id" : "Organization.type:business-type",
      "path" : "Organization.type",
      "sliceName" : "business-type",
      "short" : "Enhetstyp (hsaBusinessType, HSACAT-ORG-015)",
      "definition" : "Anger typ av enhet eller organisation (t.ex. sjukhus, vårdcentral, apotek).\nLDAP: hsaBusinessType. System: OID 1.2.752.129.2.2.1.12.",
      "min" : 0,
      "max" : "1",
      "mustSupport" : true
    },
    {
      "id" : "Organization.type:business-type.coding",
      "path" : "Organization.type.coding",
      "min" : 1,
      "binding" : {
        "strength" : "required",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-business-type"
      }
    },
    {
      "id" : "Organization.type:business-type.coding.system",
      "path" : "Organization.type.coding.system",
      "min" : 1,
      "fixedUri" : "urn:oid:1.2.752.129.2.2.1.12"
    },
    {
      "id" : "Organization.name",
      "path" : "Organization.name",
      "short" : "Enhetsnamn / organisationsnamn",
      "definition" : "Hämtas automatiskt från HSA (ou eller o). Ej manuellt redigerbart via API.",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Organization.contact",
      "path" : "Organization.contact",
      "short" : "Kontaktinformation (telefon, adress m.m.)",
      "definition" : "Kontaktuppgifter för organisationen. Använd extension HsaTelecomTypeExtension\npå contact.telecom för att klassificera kontaktvägstypen\n(direkttelefon, växel, e-post, innehållsansvarig m.fl.).",
      "mustSupport" : true
    },
    {
      "id" : "Organization.contact.telecom",
      "path" : "Organization.contact.telecom",
      "short" : "Kontaktvägar",
      "definition" : "Kontaktvägar inklusive telefon, e-post och URL. LDAP-attribut inkluderar:\ntelephoneNumber (direkttelefon), hsaSwitchboardNumber (växel),\nmobile (mobil), facsimileTelephoneNumber (fax), mail (e-post),\nhsaDirectoryContact (innehållsansvarig), labeledURI (webbadress),\nhsaVpwWebpage (länk till 1177-kontaktkort, system=#url).",
      "mustSupport" : true
    },
    {
      "id" : "Organization.contact.telecom.extension:telecomType",
      "path" : "Organization.contact.telecom.extension",
      "sliceName" : "telecomType",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "Extension",
        "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Organization.contact.address",
      "path" : "Organization.contact.address",
      "short" : "Postadress eller besöksadress",
      "mustSupport" : true
    },
    {
      "id" : "Organization.contact.address.type",
      "path" : "Organization.contact.address.type",
      "mustSupport" : true
    },
    {
      "id" : "Organization.partOf",
      "path" : "Organization.partOf",
      "short" : "Överordnad organisation i HSA-trädet",
      "definition" : "Referens till överordnad organisation. Obligatorisk för underenheter.",
      "type" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-hierarchy",
          "valueBoolean" : true
        }],
        "code" : "Reference",
        "targetProfile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"]
      }],
      "mustSupport" : true
    }]
  }
}

```
