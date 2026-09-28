# Introduktion - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Introduktion**

## Introduktion

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/ImplementationGuide/inera.se.hsa.katalog | *Version*:0.1.0 |
| Draft as of 2026-09-28 | *Computable Name*:HsaCatalogIG |

# HSA Katalog Implementation Guide

FHIR R5 Implementation Guide för HSA-baserad kataloginformation om organisationer, platser, vårdtjänster och ändpunkter inom svensk vård och omsorg.

| | | | |
| :--- | :--- | :--- | :--- |
| **Version:**0.1.0 (ci-build) | **FHIR:**R5 (5.0.0) | **Status:**Utkast | **Utgivare:**Inera AB / HSA-IG projekt |

-------

## Syfte och scope

Denna IG definierar hur HSA-katalogen (Hälso- och sjukvårdens Adressregister) exponeras som FHIR R5-resurser. Primära användningsfall:

* **EHR-katalogsynk:** Regionala vårdsystem hämtar och cachar organisationsdata från HSA.
* **NPÖ:** Nationell Patientöversikt hämtar vårdenheters arbetsplatskod och hierarki.
* **1177 Hitta vård:** Publika sökfunktioner presenterar publika vårdenheter, adresser och öppettider.
* **Tjänsteadressering:** Tjänsteplattformen (SKLTP) traverserar partOf-kedjor för åtkomstkontroll.

IG:n täcker **inte** persondata (Practitioner/PractitionerRole) i version 1.

-------

## Profiler

| | | |
| :--- | :--- | :--- |
| [HsaCatalogOrganization](StructureDefinition-hsa-catalog-organization.md) | Organization | Basprofil för alla HSA-organisationer |
| [HsaHealthcareProviderOrganization](StructureDefinition-hsa-healthcare-provider-organization.md) | Organization | Vårdgivare (PDL yttre spärr) |
| [HsaHealthcareUnitOrganization](StructureDefinition-hsa-healthcare-unit-organization.md) | Organization | Vårdenhet (PDL inre spärr) |
| [HsaCatalogLocation](StructureDefinition-hsa-catalog-location.md) | Location | Besöksplatser och mottagningslokaler |
| [HsaHealthcareService](StructureDefinition-hsa-healthcare-service.md) | HealthcareService | Vårdtjänster och tjänsteutbud |

-------

## Stödjande sidor

| | |
| :--- | :--- |
| [Designprinciper](design-principles.md) | Arkitekturbeslut, R5-val, profilstrategi |
| [Användningsfall](use-cases.md) | Kravbakgrund per integrationsscenario |
| [Organisationshierarki](organization-hierarchy.md) | partOf-kedja, PDL-spärrnivåer, SKLTP-trädklättring |
| [Klientrendering](client-rendering.md) | Display-konventioner för 1177 och konsumentsystem |
| [Adressövergång](address-transition.md) | HSA 5.2+ strukturerade adresser, övergångsperiod |
| [LDAP → FHIR Mappning](ldap-mapping.md) | Attributtabell: LDAP-attributnamn → FHIR-element, ej mappade attribut |
| [Terminologi](terminology.md) | CodeSystems, OID-tabell, väntande kodverk |
| [REST API](api.md) | SearchParameters, CapabilityStatement, frågemönster |
| [Harmonisering med eHM](ehm-alignment.md) | Mappning mot eHMs Nationell katalog-IG |

-------

## Snabbstart

En publik vårdenhet som ska synas på 1177 Hitta vård behöver minst:

```
Organization (HsaHealthcareUnitOrganization)
  identifier[hsa-id]               // HSA-id
  identifier[org-no]               // Org.nr (om vårdgivare)
  meta.security[destination-ind.]  // Kod 03 = publik
  active = true
  name                             // Enhetsnamn
  type[hsa-class]                  // healthcare-unit
  type[care-level]                 // Administrativ vårdnivå (1..1)
  partOf → HsaHealthcareProvider   // Ansvarig vårdgivare
  contact.telecom[direct-phone]    // Direkttelefon (krävs för publik enhet)

Location (HsaCatalogLocation)
  meta.security[destination-ind.]  // Kod 03 = publik
  address (type=physical)          // Gatuadress + stad (utan postnummer)
  position                         // SWEREF99-koordinater
  managingOrganization             // → Organization ovan

HealthcareService (HsaHealthcareService)
  meta.security[destination-ind.]  // Kod 03 = publik
  providedBy → Organization        // Tillhandahållande enhet
  category[verksamhetskod]         // Verksamhetskod (1..*)
  availability                     // Öppettider

```

Se [Klientrendering](client-rendering.md) för fullständig publiceringschecklista.



## Resource Content

```json
{
  "resourceType" : "ImplementationGuide",
  "id" : "inera.se.hsa.katalog",
  "url" : "https://hsa.inera.se/fhir/ImplementationGuide/inera.se.hsa.katalog",
  "version" : "0.1.0",
  "name" : "HsaCatalogIG",
  "title" : "HSA Katalog Implementation Guide",
  "status" : "draft",
  "date" : "2026-09-28T08:39:43+00:00",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "FHIR R5 Implementation Guide för HSA-baserad kataloginformation om organisationer, platser, vårdtjänster och ändpunkter inom svensk vård och omsorg.\n",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "packageId" : "inera.se.hsa.katalog",
  "license" : "CC0-1.0",
  "fhirVersion" : ["5.0.0"],
  "dependsOn" : [{
    "id" : "hl7tx",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on HL7 Terminology"
    }],
    "uri" : "http://terminology.hl7.org/ImplementationGuide/hl7.terminology",
    "packageId" : "hl7.terminology.r5",
    "version" : "7.4.0"
  },
  {
    "id" : "hl7ext",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on the HL7 Extension Pack"
    }],
    "uri" : "http://hl7.org/fhir/extensions/ImplementationGuide/hl7.fhir.uv.extensions",
    "packageId" : "hl7.fhir.uv.extensions.r5",
    "version" : "5.3.0"
  },
  {
    "id" : "hl7_fhir_r5_core",
    "uri" : "http://hl7.org/fhir/ImplementationGuide/fhir",
    "packageId" : "hl7.fhir.r5.core",
    "version" : "5.0.0"
  }],
  "definition" : {
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-internal-dependency",
      "valueCode" : "hl7.fhir.uv.tools.r5#1.1.2"
    }],
    "resource" : [{
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Organization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Organization-privat-vardgivare-ab.html"
      }],
      "reference" : {
        "reference" : "Organization/privat-vardgivare-ab"
      },
      "name" : "Blekinge Primärvård AB (Privat Vårdgivare)",
      "description" : "Exempelinstans för Blekinge Primärvård AB — ett privat aktiebolag som\nbedriver primärvård på uppdrag av Region Blekinge.\n\nDemonstrerar: management=05 (privat ägande), avsaknad av GLN och APK på\nVG-nivå, separat direkttelefon och växelnummer, och frånvaro av\ndestinationIndicator (VGs är inte direkt sökbara på 1177 Hitta vård).\nKontrastera med RegionBlekingeVardgivare (offentlig region, management=01).",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Location"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Location-location-blekingesjukhuset.html"
      }],
      "reference" : {
        "reference" : "Location/location-blekingesjukhuset"
      },
      "name" : "Blekingesjukhuset (Besöksplats)",
      "description" : "Exempelinstans för Blekingessjukhusets fysiska besöksplats.\nDemonstrerar: strukturerad besöksadress (HSA 5.2+ hsaVisitingAddress),\nSWEREF99-koordinater, Markdown-vägbeskrivning med ## Yttre / ## Inre\nvägbeskrivning-konvention, meta.security[destination-indicator]=03,\noch relationen till Organization via managingOrganization.\n\nKontrastera med LocationRonnebyVardcentral som använder legacy\nstreetAddress (pre-5.2) → address.text.",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Organization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Organization-blekingesjukhuset-vardenhet.html"
      }],
      "reference" : {
        "reference" : "Organization/blekingesjukhuset-vardenhet"
      },
      "name" : "Blekingesjukhuset (Vårdenhet)",
      "description" : "Exempelinstans för Blekingesjukhuset som publik specialiserad vårdenhet under\nRegion Blekinge. Demonstrerar: APK (arbetsplatskod), GLN, alla telekomtyper\ninkl. mobiltelefon, fax och 1177-djuplänk (hsaVpwWebpage), legacy postadress\n(pre-5.2), strukturerad besöksadress i separat Location-resurs,\ndestinationIndicator=03 och partOf → VG-instansen.",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "HealthcareService"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "HealthcareService-hs-tjanst-blekingesjukhuset.html"
      }],
      "reference" : {
        "reference" : "HealthcareService/hs-tjanst-blekingesjukhuset"
      },
      "name" : "Blekingesjukhuset Tjänsteutbud (HealthcareService)",
      "description" : "Exempelinstans för Blekingesjukhusets vårdtjänst med internmedicin och\nkardiologi, öppen- och slutenvård, telefontider och drop-in-tider.\n\nDemonstrerar: category[verksamhetskod] med flera koder (1101 Internmedicin\noch 1126 Kardiologi), type[care-type] med öppen och sluten vård,\navailability för telefonmottagning (öppettider) och drop-in, comment\n(hsaVpwInformation3 → \"om oss\"-text) och relationen till Location-resursen.",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Organization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Organization-hjartmottagningen-vardenhet.html"
      }],
      "reference" : {
        "reference" : "Organization/hjartmottagningen-vardenhet"
      },
      "name" : "Hjärtmottagningen Karlskrona (Vårdenhet)",
      "description" : "Exempelinstans för Hjärtmottagningen Karlskrona — en specialistmottagning\n(kardiologi) organisatoriskt placerad under Blekingesjukhuset i LDAP-trädet,\nmen med partOf direkt till Region Blekinge som ansvarig vårdgivare per\nprofil-kravet partOf only Reference(HsaHealthcareProviderOrganization).\n\nDemonstrerar: orgPeriod med start OCH end (hsacat-org-period-end uppfylld),\ntillfällig information (hsaVpwInformation2 → temporaryNotice),\npatientinformation (hsaVpwInformation4 → patientInfo),\nhsaBusinessType=15 (Mottagning) och den viktiga distinktionen att\nDN-trädpositionen INTE representeras som partOf i FHIR v1.",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-hsa-catalog-location.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/hsa-catalog-location"
      },
      "name" : "HSA Catalog Location",
      "description" : "Profil för platser hämtade ur HSA-katalogen. Representerar fysiska\nbesöksplatser, mottagningar och vårdlokaler.\n\nFysiska platser måste ha besöksadress (gatuadress + stad) och\nen referens till ansvarig organisation. Koordinater (SWEREF99) krävs\nför offentlig publicering på 1177 Hitta vård.\n\n**Synlighet:** Anges via `meta.security[destination-indicator]` med\nsystem `urn:oid:1.2.752.29.23.1.11`, kod 03 = Internet/allmänheten.\n\n**Vägbeskrivning:** Lagras i `description` som Markdown. Konvention:\n- `## Yttre vägbeskrivning` – kollektivtrafik, parkering, hur man hittar till platsen\n- `## Inre vägbeskrivning` – entré, plan, hiss, rum etc.\nKlienter bör rendera description som Markdown.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-hsa-catalog-organization.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/hsa-catalog-organization"
      },
      "name" : "HSA Catalog Organization",
      "description" : "Basprofil för organisationer hämtade ur HSA-katalogen. Täcker\nvårdgivare, vårdenheter och organisatoriska enheter i organisationsträdet.\n\nAlla HSA-organisationer har ett HSA-id, ett namn och information om\npublicerings- och åtkomststatus. Hierarkin representeras via `partOf`.\n\n**Synlighet (destinationIndicator):** Modelleras som `meta.security[destination-indicator]`\nmed system `urn:oid:1.2.752.29.23.1.11`. Kod 03 = Internet/allmänheten.\nKlienter som 1177 Hitta vård bör filtrera på detta fält.\n\n**Tillfällig information:** En enhet med tidsbegränsad status använder\n`extension[orgPeriod]` (organization-period) med start och obligatoriskt end.\nKlienter bör rendera en visuell varningsindikator (t.ex. gul informationsruta)\nnär orgPeriod är satt och `active = true`. Varje klient ansvarar för att\ntexten som ska visas hämtas från ett lämpligt fält (t.ex. Organization.contact\nmed purpose = \"TEMP\" eller IG-sida för klientkonventioner).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CapabilityStatement"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CapabilityStatement-hsa-catalog-server.html"
      }],
      "reference" : {
        "reference" : "CapabilityStatement/hsa-catalog-server"
      },
      "name" : "HSA Central Catalog Server",
      "description" : "Exempel på hur ett centralt HSA-källsystem kan exponera organisationer, platser\noch vårdtjänster som FHIR R5-resurser med läsaccess.\nI detta mönster hanteras datainläsning internt (t.ex. via LDAP) och FHIR-gränssnittet\nanvänds enbart för läsning och sökning av katalogdata.\nDetta är ett möjligt upplägg, inte ett beslutat krav.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-hsa-business-type.html"
      }],
      "reference" : {
        "reference" : "ValueSet/hsa-business-type"
      },
      "name" : "HSA Enhetstyp (hsaBusinessType)",
      "description" : "Enhetstyp för organisation eller enhet i HSA.\nSystem: HSA enhetstyp-kodverk (OID 1.2.752.129.2.2.1.12).\nTypiska värden: sjukhus, vårdcentral, apotek m.fl.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-hsa-financing-organization.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/hsa-financing-organization"
      },
      "name" : "HSA Finansierande region/kommun",
      "description" : "Den eller de regioner/kommuner som finansierar vården vid enheten.\nMappar till LDAP-attributet financingOrganization (OID 1.2.752.129.5.1.1).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-hsa-healthcare-provider-organization.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/hsa-healthcare-provider-organization"
      },
      "name" : "HSA Healthcare Provider Organization",
      "description" : "Profil för organisation markerad som vårdgivare (hsaHealthCareProvider,\nOID 1.2.752.29.6.10) i HSA-katalogen.\n\nRepresenterar den yttre spärrnivån i PDL-sammanhang. Alla vårdenheter\nunder en vårdgivare delar journalspärr på VG-nivå — det är därför\n`partOf` på vårdenhetsprofilen alltid pekar direkt hit.\n\n**Identifierare (minimum 2):**\nProfilen kräver alltid *både* HSA-id och organisationsnummer:\n- `identifier[hsa-id]` (1..1) — systemgenererat, unikt inom HSA.\n- `identifier[org-no]` (1..1) — juridisk identitet; krävs av NPÖ och\n  PDL-infrastrukturen för att koppla journaler till rätt VG (HSACAT-ORG-007).\n- `identifier[apk]` (0..0) — arbetsplatskod är alltid en vårdenhetskod\n  (unitPrescriptionCode i LDAP-schemat) och får aldrig sättas på VG.\n- `identifier[gln]` (0..1) — förekommer på VG som har GLN-registrering.\n\n**Must Support:** Alla MS-flaggor ärvs från `HsaCatalogOrganization` och\nvisas i snapshot-vyn. Denna profil deklarerar enbart restriktioner som\ntillkommer utöver basprofilens definition.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-hsa-healthcare-service.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/hsa-healthcare-service"
      },
      "name" : "HSA Healthcare Service",
      "description" : "Profil för vårdtjänster och tjänsteutbud från HSA-katalogen.\nVerksamhetskod och vård-/omsorgsform är obligatoriska för enheter som\nbedriver vård.\n\nVerksamhetskod (businessClassificationCode) modelleras på `category` i\nenlighet med eHMs Nationell katalog-IG (hvo-business-category-inera).\nVård-/omsorgsform (careType) modelleras på `type` som mer specifik\ntjänsteklassificering.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-hsa-healthcare-unit-organization.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/hsa-healthcare-unit-organization"
      },
      "name" : "HSA Healthcare Unit Organization",
      "description" : "Profil för organisation markerad som vårdenhet (hsaHealthCareUnit,\nOID 1.2.752.29.6.13) i HSA-katalogen.\n\nRepresenterar inre spärrnivå i PDL-sammanhang. Ska alltid ha en\nreferens till överordnad organisation (partOf → HsaHealthcareProviderOrganization).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-hsa-patient-info.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/hsa-patient-info"
      },
      "name" : "HSA Information till patient",
      "description" : "Informationstext riktad till patient som visas på enhetens 1177-sida.\nMappar till LDAP-attributet hsaVpwInformation4.\nKlienter bör rendera som Markdown.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CapabilityStatement"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CapabilityStatement-hsa-client-1177-hitta-vard.html"
      }],
      "reference" : {
        "reference" : "CapabilityStatement/hsa-client-1177-hitta-vard"
      },
      "name" : "HSA Klient – 1177 Hitta vård",
      "description" : "Illustrerar vilka FHIR-förmågor ett system för publik vårdsökning (t.ex. 1177 Hitta vård)\nkan ha nytta av. Exemplet visar möjliga frågemönster för geo-sökning, publik filtrering\noch hämtning av Organization, Location och HealthcareService.\nDetta är ett illustrativt exempel på hur ett sådant scenario kan se ut.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CapabilityStatement"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CapabilityStatement-hsa-client-ehr-sync.html"
      }],
      "reference" : {
        "reference" : "CapabilityStatement/hsa-client-ehr-sync"
      },
      "name" : "HSA Klient – EHR-katalogsynk",
      "description" : "Klientkonformansdeklaration för regionala EHR-system (t.ex. COSMIC, TakeCare)\nsom synkroniserar organisationsdata från HSA till ett lokalt cache.\n\nTäcker två användningsfall:\n- UC-01: EHR-katalogsynk – hämta och cachelagra Organization, Location, HealthcareService\n- UC-04: VGR Encounter.type – slå upp HealthcareService.category[verksamhetskod]\n  för en given vårdenhet vid Encounter-dokumentation\n\nStödjer två synklägen:\n- Fullsynk: hämta alla aktiva resurser paginerat (_count)\n- Inkrementell synk: hämta resurser ändrade efter en given tidpunkt (_lastUpdated)\nNyckelaspekter: _lastUpdated för inkrementell synk, _count för paginering, alla tre resurstyper.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CapabilityStatement"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CapabilityStatement-hsa-client-hierarchy-traversal.html"
      }],
      "reference" : {
        "reference" : "CapabilityStatement/hsa-client-hierarchy-traversal"
      },
      "name" : "HSA Klient – Hierarkitraversering",
      "description" : "Klientkonformansdeklaration för system som traverserar Organization.partOf-kedjan\nför åtkomstkontroll eller hierarkisökning (HSACAT-ORG-006, HSACAT-ORG-015).\n\nPrimära konsumenter i v1:\n- Tjänsteplattformen (SKLTP): bestämmer ansvarig vårdgivare via trädklättring\n- Säkerhetstjänster: prövning av SJF-behörighet längs partOf-kedjan\n\nOBS: Full SKLTP TAK-integration (Endpoint-resurs, logisk adressering) är planerad\nför v2 och täcks inte av denna IG. Det här exemplet illustrerar enbart\nOrganization.partOf-traversering.\n\nFör att scenariot ska fungera behöver servern ha stöd för _include:iterate=Organization:partof\nså att hela hierarkin kan hämtas i ett anrop (se HSACAT-ORG-006).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CapabilityStatement"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CapabilityStatement-hsa-client-npo.html"
      }],
      "reference" : {
        "reference" : "CapabilityStatement/hsa-client-npo"
      },
      "name" : "HSA Klient – Nationell Patientöversikt (NPÖ)",
      "description" : "Illustrerar vilka FHIR-förmågor ett NPÖ-liknande scenario kan ha nytta av.\nExemplet visar hur en vårdenhet kan slås upp via arbetsplatskod (APK) och hur\npartOf-kedjan kan traverseras uppåt för att fastställa ansvarig vårdgivare.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-hsa-telecom-type.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/hsa-telecom-type"
      },
      "name" : "HSA Kontaktvägstyp",
      "description" : "Klassificerar kontaktvägstyp för att skilja direkttelefon från\nväxeltelefon, publik telefon, innehållsansvarig e-post m.fl.\nMappar till LDAP-kontexten (telephoneNumber, hsaSwitchboardNumber etc.).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-hsa-telecom-type-vs.html"
      }],
      "reference" : {
        "reference" : "ValueSet/hsa-telecom-type-vs"
      },
      "name" : "HSA Kontaktvägstyp",
      "description" : "Tillåtna typer av kontaktvägar i HSA.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-hsa-telecom-type.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/hsa-telecom-type"
      },
      "name" : "HSA Kontaktvägstyp",
      "description" : "Klassificering av kontaktvägar (telecom) i HSA för att skilja på\ndirekttelefon, växeltelefon, e-post, m.fl.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-hsa-object-class.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/hsa-object-class"
      },
      "name" : "HSA Objektklassificering",
      "description" : "Klassificering av HSA-objekt baserat på LDAP-objektklasser i HSA-schemat.\nAnvänds för att identifiera om en organisation är vårdgivare, vårdenhet\neller annan organisatorisk enhet, samt för statusmarkering.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "SearchParameter"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "SearchParameter-hsa-org-class.html"
      }],
      "reference" : {
        "reference" : "SearchParameter/hsa-org-class"
      },
      "name" : "HSA Organisationsklass",
      "description" : "Sökning på HSA-objektklassificering (type[hsa-class], CodeSystem HsaObjectClass).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-hsa-organization-type.html"
      }],
      "reference" : {
        "reference" : "ValueSet/hsa-organization-type"
      },
      "name" : "HSA Organisationstyp",
      "description" : "Tillåtna klassificeringar för Organization.type i HSA-profiler.\nKombinerar HSA-objektklasser (vårdgivare/vårdenhet) med enhetstyp-kodverk\n(sjukhus, vårdcentral, apotek).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CapabilityStatement"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CapabilityStatement-hsa-regional-catalog-server.html"
      }],
      "reference" : {
        "reference" : "CapabilityStatement/hsa-regional-catalog-server"
      },
      "name" : "HSA Regional Catalog Server (hypotes)",
      "description" : "Illustrerar ett möjligt mönster för regionala och lokala system som vill\nspegla HSA-data lokalt för förbättrade svarstider och lokal tillgänglighet.\n\nDetta är en hypotes, inte ett beslutad arkitektur. Det är oklart om regionerna\nvill använda detta mönster, och om de gör det kan de ha andra krav på hur\ndatainläsning ska fungera.\n\nEn möjlig utformning: data läses in från LDAP och exponeras som FHIR R5.\nSkrivoperationer (create, update, delete) och transaktionsbuntar kan underlätta\nsynkronisering, men hur det faktiskt ska fungera bör beslutas i dialog med\nberörda regioner.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:extension"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-hsa-temporary-notice.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/hsa-temporary-notice"
      },
      "name" : "HSA Tillfällig information (text)",
      "description" : "Fri text för tillfällig information om enheten, visas som gul informationsruta\npå enhetens kontaktkort på 1177.se. Mappar till LDAP-attributet\nhsaVpwInformation2. Slutdatum hanteras separat via organization-period\n(http://hl7.org/fhir/StructureDefinition/organization-period).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "SearchParameter"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "SearchParameter-hsa-provided-by.html"
      }],
      "reference" : {
        "reference" : "SearchParameter/hsa-provided-by"
      },
      "name" : "HSA Tillhandahållande organisation",
      "description" : "Sökning på HealthcareService.providedBy (tillhandahållande organisation).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-hsa-service-type.html"
      }],
      "reference" : {
        "reference" : "ValueSet/hsa-service-type"
      },
      "name" : "HSA Verksamhetskod (businessClassificationCode)",
      "description" : "Tillåtna verksamhetskoder för HealthcareService.type.\nSystem: HSA verksamhetskod-kodverk (OID 1.2.752.129.2.2.1.3).\nFaktiska kodvärden hämtas från Terminologitjänsten (terminologitjansten.inera.se).\nJämförs med eHMs Nationella vårdtjänster v.1.0.0 (SRC-014).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-hsa-destination-indicator.html"
      }],
      "reference" : {
        "reference" : "ValueSet/hsa-destination-indicator"
      },
      "name" : "HSA Visas för (hsaDestinationIndicator)",
      "description" : "Koder för visningsscope i HSA (hsaDestinationIndicator).\nKod 03 = Internet/allmänheten = publik visning på t.ex. 1177 Hitta vård.\nSystem: OID 1.2.752.29.23.1.11.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-hsa-care-type.html"
      }],
      "reference" : {
        "reference" : "ValueSet/hsa-care-type"
      },
      "name" : "HSA Vård- och omsorgsform (careType)",
      "description" : "Tillåtna koder för vård- och omsorgsform (careType).\nObligatorisk för vårdenheter.\nSystem: OID 1.2.752.129.2.2.1.13.\nKända värden: 01=Öppen vård, 02=Sluten vård, 03=Hemsjukvård, 04=Socialtjänst.",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-hsa-ownership-type.html"
      }],
      "reference" : {
        "reference" : "ValueSet/hsa-ownership-type"
      },
      "name" : "HSA Ägarform",
      "description" : "Tillåtna koder för ägarform (management/regi) på Organization.\nSystem: HSA ägarform-kodverk (OID 1.2.752.129.2.2.1.14).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "SearchParameter"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "SearchParameter-hsa-id.html"
      }],
      "reference" : {
        "reference" : "SearchParameter/hsa-id"
      },
      "name" : "HSA-id",
      "description" : "Sökning på HSA-identitet (hsaIdentity, OID 1.2.752.29.4.19).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "NamingSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "NamingSystem-hsa-identity.html"
      }],
      "reference" : {
        "reference" : "NamingSystem/hsa-identity"
      },
      "name" : "HSA-identitet (HSA-id)",
      "description" : "Unik identifierare för organisationer, enheter, funktioner, uppdrag och\npersoner i HSA-katalogen. Tilldelas automatiskt av HSA-systemet vid skapande\noch ska aldrig ändras. Används som stabil nyckel i nationella e-tjänster\n(NPÖ, Pascal, 1177 Hitta vård m.fl.).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Organization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Organization-arkiverad-enhet.html"
      }],
      "reference" : {
        "reference" : "Organization/arkiverad-enhet"
      },
      "name" : "Medicinmottagning Karlshamn (arkiverad)",
      "description" : "Exempelinstans för en arkiverad (inaktiv) vårdenhet — Medicinmottagning\nKarlshamn — som stängde 2023-12-31 och är markerad med hsaArchivedObject: TRUE\ni LDAP.\n\nDemonstrerar: active = false som FHIR-representation av hsaArchivedObject,\nminimal datauppsättning för arkiverade enheter (identitet + typ + status),\nfrånvaro av destinationIndicator och avsaknad av orgPeriod (se mappningskommentar).\n\nAlla inaktiveringsskäl (hsaArchivedObject, hiddenObject, hsaInaccurateHCP/HCU)\nmappas till active = false — distinktionen görs inte synlig i FHIR v1.",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "NamingSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "NamingSystem-organisation-nummer.html"
      }],
      "reference" : {
        "reference" : "NamingSystem/organisation-nummer"
      },
      "name" : "Organisationsnummer (Sverige)",
      "description" : "Unikt nummer för juridiska personer i Sverige, tilldelat av Skatteverket\neller Bolagsverket. Obligatoriskt för organisationer som representerar\nvårdgivare (hsaHealthCareProvider).",
      "isExample" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Organization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Organization-region-blekinge-vardgivare.html"
      }],
      "reference" : {
        "reference" : "Organization/region-blekinge-vardgivare"
      },
      "name" : "Region Blekinge (Vårdgivare)",
      "description" : "Exempelinstans för Region Blekinge som offentlig regional vårdgivare.\nDemonstrerar: management=01 (landsting/region), GLN-kod, legacy postadress\n(pre-5.2 övergångsform), telekomtyper (direkttelefon = växel, e-post,\ninnehållsansvarig, webbadress) och frånvaro av destinationIndicator på VG-nivå.",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Location"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Location-location-ronneby-vardcentral.html"
      }],
      "reference" : {
        "reference" : "Location/location-ronneby-vardcentral"
      },
      "name" : "Ronneby Vårdcentral (Besöksplats, legacy adress)",
      "description" : "Exempelinstans för Ronneby Vårdcentrals fysiska besöksplats med legacy\nadressformat (pre-HSA 5.2).\n\nDemonstrerar: address.text (ostrukturerat streetAddress-attribut) som\növergångsmönster under migrationsperioden t.o.m. september 2026, jämfört\nmed address.line[] i LocationBlekingesjukhuset (strukturerat 5.2+).\n\nKonsumenter bör kontrollera om address.line är satt för att avgöra vilket\nformat som används — address.text är fallback för ej-migrerade enheter.",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Organization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Organization-ronneby-vardcentral-vardenhet.html"
      }],
      "reference" : {
        "reference" : "Organization/ronneby-vardcentral-vardenhet"
      },
      "name" : "Ronneby Vårdcentral (Vårdenhet, privat utförare)",
      "description" : "Exempelinstans för Ronneby Vårdcentral — en primärvårdsenhet driven av\nBlekinge Primärvård AB (privat) med finansiering från Region Blekinge.\n\nDemonstrerar: careLevel=01 (Primärvård), hsaBusinessType=05 (Vårdcentral),\nfinancingOrganization-extensionen (privat utförare med regionfinansiering),\nAPK-kod, mobiltelefon, patientInfo (hsaVpwInformation4) och legacy\nstreetAddress (besöksadress ej migrerat till 5.2+ hsaVisitingAddress).\nBesöksadressen modelleras i Instance-LocationRonnebyVardcentral.",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"]
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "HealthcareService"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "HealthcareService-hs-tjanst-ronneby-vardcentral.html"
      }],
      "reference" : {
        "reference" : "HealthcareService/hs-tjanst-ronneby-vardcentral"
      },
      "name" : "Ronneby Vårdcentral Tjänsteutbud (HealthcareService)",
      "description" : "Exempelinstans för Ronneby Vårdcentrals vårdtjänst med allmänmedicin,\ntre typer av tillgänglighetsinformation (telefontider, tidig telefontid,\ndrop-in) och alla tre VPW-textfälten.\n\nDemonstrerar: category[verksamhetskod]=1502 (Allmänmedicin), tre separata\navailability-block (telefontider + tidig telefontid + drop-in med selektiva\nveckodagar), comment (hsaVpwInformation3), temporaryNotice (hsaVpwInformation2)\noch patientInfo (hsaVpwInformation4) på HealthcareService-resursen.",
      "isExample" : true,
      "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"]
    }],
    "page" : {
      "sourceUrl" : "toc.html",
      "name" : "toc.html",
      "title" : "Table of Contents",
      "generation" : "html",
      "page" : [{
        "sourceUrl" : "index.html",
        "name" : "index.html",
        "title" : "Introduktion",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "design-principles.html",
        "name" : "design-principles.html",
        "title" : "Designprinciper",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "use-cases.html",
        "name" : "use-cases.html",
        "title" : "Användningsfall",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "profiles.html",
        "name" : "profiles.html",
        "title" : "Profiler",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "terminology.html",
        "name" : "terminology.html",
        "title" : "Terminologi",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "api.html",
        "name" : "api.html",
        "title" : "REST API",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "ehm-alignment.html",
        "name" : "ehm-alignment.html",
        "title" : "Harmonisering med eHM",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "client-rendering.html",
        "name" : "client-rendering.html",
        "title" : "Klientrendering",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "organization-hierarchy.html",
        "name" : "organization-hierarchy.html",
        "title" : "Organisationshierarki",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "address-transition.html",
        "name" : "address-transition.html",
        "title" : "Adressövergång",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "ldap-mapping.html",
        "name" : "ldap-mapping.html",
        "title" : "LDAP → FHIR Mappning",
        "generation" : "markdown"
      },
      {
        "sourceUrl" : "downloads.html",
        "name" : "downloads.html",
        "title" : "Nedladdningar",
        "generation" : "markdown"
      }]
    },
    "parameter" : [{
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "copyrightyear"
      },
      "value" : "2026+"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "releaselabel"
      },
      "value" : "ci-build"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "show-inherited-invariants"
      },
      "value" : "false"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-contact"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-jurisdiction"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-publisher"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-version"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "autoload-resources"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/capabilities"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/examples"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/extensions"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/models"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/operations"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/profiles"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/resources"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/vocabulary"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/maps"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/testing"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "input/history"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-resource"
      },
      "value" : "fsh-generated/resources"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-pages"
      },
      "value" : "template/config"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-pages"
      },
      "value" : "input/images"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-liquid"
      },
      "value" : "template/liquid"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-liquid"
      },
      "value" : "input/liquid"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-qa"
      },
      "value" : "temp/qa"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-temp"
      },
      "value" : "temp/pages"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-output"
      },
      "value" : "output"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/guide-parameter-code",
        "code" : "path-tx-cache"
      },
      "value" : "input-cache/txcache"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-suppressed-warnings"
      },
      "value" : "input/ignoreWarnings.txt"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "path-history"
      },
      "value" : "https://hsa.inera.se/fhir/history.html"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "template-html"
      },
      "value" : "template-page.html"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "template-md"
      },
      "value" : "template-page-md.html"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-context"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-copyright"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-license"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "apply-wg"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "active-tables"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "fmm-definition"
      },
      "value" : "http://hl7.org/fhir/versions.html#maturity"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "propagate-status"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "excludelogbinaryformat"
      },
      "value" : "true"
    },
    {
      "code" : {
        "system" : "http://hl7.org/fhir/tools/CodeSystem/ig-parameters",
        "code" : "tabbed-snapshots"
      },
      "value" : "true"
    }]
  }
}

```
