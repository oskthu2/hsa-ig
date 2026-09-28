# Artifacts Summary - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Artifacts Summary**

## Artifacts Summary

This page provides a list of the FHIR artifacts defined as part of this implementation guide.

### Behavior: Capability Statements 

The following artifacts define the specific capabilities that different types of systems are expected to have in order to comply with this implementation guide. Systems conforming to this implementation guide are expected to declare conformance to one or more of the following capability statements.

| | |
| :--- | :--- |
| [HSA Central Catalog Server](CapabilityStatement-hsa-catalog-server.md) | Exempel på hur ett centralt HSA-källsystem kan exponera organisationer, platser och vårdtjänster som FHIR R5-resurser med läsaccess. I detta mönster hanteras datainläsning internt (t.ex. via LDAP) och FHIR-gränssnittet används enbart för läsning och sökning av katalogdata. Detta är ett möjligt upplägg, inte ett beslutat krav. |
| [HSA Klient – 1177 Hitta vård](CapabilityStatement-hsa-client-1177-hitta-vard.md) | Illustrerar vilka FHIR-förmågor ett system för publik vårdsökning (t.ex. 1177 Hitta vård) kan ha nytta av. Exemplet visar möjliga frågemönster för geo-sökning, publik filtrering och hämtning av Organization, Location och HealthcareService. Detta är ett illustrativt exempel på hur ett sådant scenario kan se ut. |
| [HSA Klient – EHR-katalogsynk](CapabilityStatement-hsa-client-ehr-sync.md) | Klientkonformansdeklaration för regionala EHR-system (t.ex. COSMIC, TakeCare) som synkroniserar organisationsdata från HSA till ett lokalt cache.Täcker två användningsfall:* UC-01: EHR-katalogsynk – hämta och cachelagra Organization, Location, HealthcareService
* UC-04: VGR Encounter.type – slå upp HealthcareService.category[verksamhetskod] för en given vårdenhet vid Encounter-dokumentation
Stödjer två synklägen:* Fullsynk: hämta alla aktiva resurser paginerat (_count)
* Inkrementell synk: hämta resurser ändrade efter en given tidpunkt (_lastUpdated) Nyckelaspekter: _lastUpdated för inkrementell synk, _count för paginering, alla tre resurstyper.
 |
| [HSA Klient – Hierarkitraversering](CapabilityStatement-hsa-client-hierarchy-traversal.md) | Klientkonformansdeklaration för system som traverserar Organization.partOf-kedjan för åtkomstkontroll eller hierarkisökning (HSACAT-ORG-006, HSACAT-ORG-015).Primära konsumenter i v1:* Tjänsteplattformen (SKLTP): bestämmer ansvarig vårdgivare via trädklättring
* Säkerhetstjänster: prövning av SJF-behörighet längs partOf-kedjan
OBS: Full SKLTP TAK-integration (Endpoint-resurs, logisk adressering) är planerad för v2 och täcks inte av denna IG. Det här exemplet illustrerar enbart Organization.partOf-traversering.För att scenariot ska fungera behöver servern ha stöd för _include:iterate=Organization:partof så att hela hierarkin kan hämtas i ett anrop (se HSACAT-ORG-006). |
| [HSA Klient – Nationell Patientöversikt (NPÖ)](CapabilityStatement-hsa-client-npo.md) | Illustrerar vilka FHIR-förmågor ett NPÖ-liknande scenario kan ha nytta av. Exemplet visar hur en vårdenhet kan slås upp via arbetsplatskod (APK) och hur partOf-kedjan kan traverseras uppåt för att fastställa ansvarig vårdgivare. |
| [HSA Regional Catalog Server (hypotes)](CapabilityStatement-hsa-regional-catalog-server.md) | Illustrerar ett möjligt mönster för regionala och lokala system som vill spegla HSA-data lokalt för förbättrade svarstider och lokal tillgänglighet.Detta är en hypotes, inte ett beslutad arkitektur. Det är oklart om regionerna vill använda detta mönster, och om de gör det kan de ha andra krav på hur datainläsning ska fungera.En möjlig utformning: data läses in från LDAP och exponeras som FHIR R5. Skrivoperationer (create, update, delete) och transaktionsbuntar kan underlätta synkronisering, men hur det faktiskt ska fungera bör beslutas i dialog med berörda regioner. |

### Behavior: Search Parameters 

These define the properties by which a RESTful server can be searched. They can also be used for sorting and including related resources.

| | |
| :--- | :--- |
| [HSA Organisationsklass](SearchParameter-hsa-org-class.md) | Sökning på HSA-objektklassificering (type[hsa-class], CodeSystem HsaObjectClass). |
| [HSA Tillhandahållande organisation](SearchParameter-hsa-provided-by.md) | Sökning på HealthcareService.providedBy (tillhandahållande organisation). |
| [HSA-id](SearchParameter-hsa-id.md) | Sökning på HSA-identitet (hsaIdentity, OID 1.2.752.29.4.19). |

### Structures: Resource Profiles 

These define constraints on FHIR resources for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [HSA Catalog Location](StructureDefinition-hsa-catalog-location.md) | Profil för platser hämtade ur HSA-katalogen. Representerar fysiska besöksplatser, mottagningar och vårdlokaler.Fysiska platser måste ha besöksadress (gatuadress + stad) och en referens till ansvarig organisation. Koordinater (SWEREF99) krävs för offentlig publicering på 1177 Hitta vård.**Synlighet:** Anges via `meta.security[destination-indicator]` med system `urn:oid:1.2.752.29.23.1.11`, kod 03 = Internet/allmänheten.**Vägbeskrivning:** Lagras i `description` som Markdown. Konvention:* `## Yttre vägbeskrivning` – kollektivtrafik, parkering, hur man hittar till platsen
* `## Inre vägbeskrivning` – entré, plan, hiss, rum etc. Klienter bör rendera description som Markdown.
 |
| [HSA Catalog Organization](StructureDefinition-hsa-catalog-organization.md) | Basprofil för organisationer hämtade ur HSA-katalogen. Täcker vårdgivare, vårdenheter och organisatoriska enheter i organisationsträdet.Alla HSA-organisationer har ett HSA-id, ett namn och information om publicerings- och åtkomststatus. Hierarkin representeras via `partOf`.**Synlighet (destinationIndicator):** Modelleras som `meta.security[destination-indicator]` med system `urn:oid:1.2.752.29.23.1.11`. Kod 03 = Internet/allmänheten. Klienter som 1177 Hitta vård bör filtrera på detta fält.**Tillfällig information:** En enhet med tidsbegränsad status använder `extension[orgPeriod]` (organization-period) med start och obligatoriskt end. Klienter bör rendera en visuell varningsindikator (t.ex. gul informationsruta) när orgPeriod är satt och `active = true`. Varje klient ansvarar för att texten som ska visas hämtas från ett lämpligt fält (t.ex. Organization.contact med purpose = "TEMP" eller IG-sida för klientkonventioner). |
| [HSA Healthcare Provider Organization](StructureDefinition-hsa-healthcare-provider-organization.md) | Profil för organisation markerad som vårdgivare (hsaHealthCareProvider, OID 1.2.752.29.6.10) i HSA-katalogen.Representerar den yttre spärrnivån i PDL-sammanhang. Alla vårdenheter under en vårdgivare delar journalspärr på VG-nivå — det är därför `partOf` på vårdenhetsprofilen alltid pekar direkt hit.**Identifierare (minimum 2):** Profilen kräver alltid **både** HSA-id och organisationsnummer:* `identifier[hsa-id]` (1..1) — systemgenererat, unikt inom HSA.
* `identifier[org-no]` (1..1) — juridisk identitet; krävs av NPÖ och PDL-infrastrukturen för att koppla journaler till rätt VG (HSACAT-ORG-007).
* `identifier[apk]` (0..0) — arbetsplatskod är alltid en vårdenhetskod (unitPrescriptionCode i LDAP-schemat) och får aldrig sättas på VG.
* `identifier[gln]` (0..1) — förekommer på VG som har GLN-registrering.
**Must Support:** Alla MS-flaggor ärvs från `HsaCatalogOrganization` och visas i snapshot-vyn. Denna profil deklarerar enbart restriktioner som tillkommer utöver basprofilens definition. |
| [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md) | Profil för vårdtjänster och tjänsteutbud från HSA-katalogen. Verksamhetskod och vård-/omsorgsform är obligatoriska för enheter som bedriver vård.Verksamhetskod (businessClassificationCode) modelleras på `category` i enlighet med eHMs Nationell katalog-IG (hvo-business-category-inera). Vård-/omsorgsform (careType) modelleras på `type` som mer specifik tjänsteklassificering. |
| [HSA Healthcare Unit Organization](StructureDefinition-hsa-healthcare-unit-organization.md) | Profil för organisation markerad som vårdenhet (hsaHealthCareUnit, OID 1.2.752.29.6.13) i HSA-katalogen.Representerar inre spärrnivå i PDL-sammanhang. Ska alltid ha en referens till överordnad organisation (partOf → HsaHealthcareProviderOrganization). |

### Structures: Extension Definitions 

These define constraints on FHIR data types for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [HSA Finansierande region/kommun](StructureDefinition-hsa-financing-organization.md) | Den eller de regioner/kommuner som finansierar vården vid enheten. Mappar till LDAP-attributet financingOrganization (OID 1.2.752.129.5.1.1). |
| [HSA Information till patient](StructureDefinition-hsa-patient-info.md) | Informationstext riktad till patient som visas på enhetens 1177-sida. Mappar till LDAP-attributet hsaVpwInformation4. Klienter bör rendera som Markdown. |
| [HSA Kontaktvägstyp](StructureDefinition-hsa-telecom-type.md) | Klassificerar kontaktvägstyp för att skilja direkttelefon från växeltelefon, publik telefon, innehållsansvarig e-post m.fl. Mappar till LDAP-kontexten (telephoneNumber, hsaSwitchboardNumber etc.). |
| [HSA Tillfällig information (text)](StructureDefinition-hsa-temporary-notice.md) | Fri text för tillfällig information om enheten, visas som gul informationsruta på enhetens kontaktkort på 1177.se. Mappar till LDAP-attributet hsaVpwInformation2. Slutdatum hanteras separat via organization-period (http://hl7.org/fhir/StructureDefinition/organization-period). |

### Terminology: Value Sets 

These define sets of codes used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [HSA Enhetstyp (hsaBusinessType)](ValueSet-hsa-business-type.md) | Enhetstyp för organisation eller enhet i HSA. System: HSA enhetstyp-kodverk (OID 1.2.752.129.2.2.1.12). Typiska värden: sjukhus, vårdcentral, apotek m.fl. |
| [HSA Kontaktvägstyp](ValueSet-hsa-telecom-type-vs.md) | Tillåtna typer av kontaktvägar i HSA. |
| [HSA Organisationstyp](ValueSet-hsa-organization-type.md) | Tillåtna klassificeringar för Organization.type i HSA-profiler. Kombinerar HSA-objektklasser (vårdgivare/vårdenhet) med enhetstyp-kodverk (sjukhus, vårdcentral, apotek). |
| [HSA Verksamhetskod (businessClassificationCode)](ValueSet-hsa-service-type.md) | Tillåtna verksamhetskoder för HealthcareService.type. System: HSA verksamhetskod-kodverk (OID 1.2.752.129.2.2.1.3). Faktiska kodvärden hämtas från Terminologitjänsten (terminologitjansten.inera.se). Jämförs med eHMs Nationella vårdtjänster v.1.0.0 (SRC-014). |
| [HSA Visas för (hsaDestinationIndicator)](ValueSet-hsa-destination-indicator.md) | Koder för visningsscope i HSA (hsaDestinationIndicator). Kod 03 = Internet/allmänheten = publik visning på t.ex. 1177 Hitta vård. System: OID 1.2.752.29.23.1.11. |
| [HSA Vård- och omsorgsform (careType)](ValueSet-hsa-care-type.md) | Tillåtna koder för vård- och omsorgsform (careType). Obligatorisk för vårdenheter. System: OID 1.2.752.129.2.2.1.13. Kända värden: 01=Öppen vård, 02=Sluten vård, 03=Hemsjukvård, 04=Socialtjänst. |
| [HSA Ägarform](ValueSet-hsa-ownership-type.md) | Tillåtna koder för ägarform (management/regi) på Organization. System: HSA ägarform-kodverk (OID 1.2.752.129.2.2.1.14). |

### Terminology: Code Systems 

These define new code systems used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [HSA Kontaktvägstyp](CodeSystem-hsa-telecom-type.md) | Klassificering av kontaktvägar (telecom) i HSA för att skilja på direkttelefon, växeltelefon, e-post, m.fl. |
| [HSA Objektklassificering](CodeSystem-hsa-object-class.md) | Klassificering av HSA-objekt baserat på LDAP-objektklasser i HSA-schemat. Används för att identifiera om en organisation är vårdgivare, vårdenhet eller annan organisatorisk enhet, samt för statusmarkering. |

### Terminology: Naming Systems 

These define identifier and/or code system identities used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [HSA-identitet (HSA-id)](NamingSystem-hsa-identity.md) | Unik identifierare för organisationer, enheter, funktioner, uppdrag och personer i HSA-katalogen. Tilldelas automatiskt av HSA-systemet vid skapande och ska aldrig ändras. Används som stabil nyckel i nationella e-tjänster (NPÖ, Pascal, 1177 Hitta vård m.fl.). |
| [Organisationsnummer (Sverige)](NamingSystem-organisation-nummer.md) | Unikt nummer för juridiska personer i Sverige, tilldelat av Skatteverket eller Bolagsverket. Obligatoriskt för organisationer som representerar vårdgivare (hsaHealthCareProvider). |

### Example: Example Instances 

These are example instances that show what data produced and consumed by systems conforming with this implementation guide might look like.

| | |
| :--- | :--- |
| [Blekinge Primärvård AB (Privat Vårdgivare)](Organization-privat-vardgivare-ab.md) | Exempelinstans för Blekinge Primärvård AB — ett privat aktiebolag som bedriver primärvård på uppdrag av Region Blekinge.Demonstrerar: management=05 (privat ägande), avsaknad av GLN och APK på VG-nivå, separat direkttelefon och växelnummer, och frånvaro av destinationIndicator (VGs är inte direkt sökbara på 1177 Hitta vård). Kontrastera med RegionBlekingeVardgivare (offentlig region, management=01). |
| [Blekingesjukhuset (Besöksplats)](Location-location-blekingesjukhuset.md) | Exempelinstans för Blekingessjukhusets fysiska besöksplats. Demonstrerar: strukturerad besöksadress (HSA 5.2+ hsaVisitingAddress), SWEREF99-koordinater, Markdown-vägbeskrivning med ## Yttre / ## Inre vägbeskrivning-konvention, meta.security[destination-indicator]=03, och relationen till Organization via managingOrganization.Kontrastera med LocationRonnebyVardcentral som använder legacy streetAddress (pre-5.2) → address.text. |
| [Blekingesjukhuset (Vårdenhet)](Organization-blekingesjukhuset-vardenhet.md) | Exempelinstans för Blekingesjukhuset som publik specialiserad vårdenhet under Region Blekinge. Demonstrerar: APK (arbetsplatskod), GLN, alla telekomtyper inkl. mobiltelefon, fax och 1177-djuplänk (hsaVpwWebpage), legacy postadress (pre-5.2), strukturerad besöksadress i separat Location-resurs, destinationIndicator=03 och partOf → VG-instansen. |
| [Blekingesjukhuset Tjänsteutbud (HealthcareService)](HealthcareService-hs-tjanst-blekingesjukhuset.md) | Exempelinstans för Blekingesjukhusets vårdtjänst med internmedicin och kardiologi, öppen- och slutenvård, telefontider och drop-in-tider.Demonstrerar: category[verksamhetskod] med flera koder (1101 Internmedicin och 1126 Kardiologi), type[care-type] med öppen och sluten vård, availability för telefonmottagning (öppettider) och drop-in, comment (hsaVpwInformation3 → "om oss"-text) och relationen till Location-resursen. |
| [Hjärtmottagningen Karlskrona (Vårdenhet)](Organization-hjartmottagningen-vardenhet.md) | Exempelinstans för Hjärtmottagningen Karlskrona — en specialistmottagning (kardiologi) organisatoriskt placerad under Blekingesjukhuset i LDAP-trädet, men med partOf direkt till Region Blekinge som ansvarig vårdgivare per profil-kravet partOf only Reference(HsaHealthcareProviderOrganization).Demonstrerar: orgPeriod med start OCH end (hsacat-org-period-end uppfylld), tillfällig information (hsaVpwInformation2 → temporaryNotice), patientinformation (hsaVpwInformation4 → patientInfo), hsaBusinessType=15 (Mottagning) och den viktiga distinktionen att DN-trädpositionen INTE representeras som partOf i FHIR v1. |
| [Medicinmottagning Karlshamn (arkiverad)](Organization-arkiverad-enhet.md) | Exempelinstans för en arkiverad (inaktiv) vårdenhet — Medicinmottagning Karlshamn — som stängde 2023-12-31 och är markerad med hsaArchivedObject: TRUE i LDAP.Demonstrerar: active = false som FHIR-representation av hsaArchivedObject, minimal datauppsättning för arkiverade enheter (identitet + typ + status), frånvaro av destinationIndicator och avsaknad av orgPeriod (se mappningskommentar).Alla inaktiveringsskäl (hsaArchivedObject, hiddenObject, hsaInaccurateHCP/HCU) mappas till active = false — distinktionen görs inte synlig i FHIR v1. |
| [Region Blekinge (Vårdgivare)](Organization-region-blekinge-vardgivare.md) | Exempelinstans för Region Blekinge som offentlig regional vårdgivare. Demonstrerar: management=01 (landsting/region), GLN-kod, legacy postadress (pre-5.2 övergångsform), telekomtyper (direkttelefon = växel, e-post, innehållsansvarig, webbadress) och frånvaro av destinationIndicator på VG-nivå. |
| [Ronneby Vårdcentral (Besöksplats, legacy adress)](Location-location-ronneby-vardcentral.md) | Exempelinstans för Ronneby Vårdcentrals fysiska besöksplats med legacy adressformat (pre-HSA 5.2).Demonstrerar: address.text (ostrukturerat streetAddress-attribut) som övergångsmönster under migrationsperioden t.o.m. september 2026, jämfört med address.line[] i LocationBlekingesjukhuset (strukturerat 5.2+).Konsumenter bör kontrollera om address.line är satt för att avgöra vilket format som används — address.text är fallback för ej-migrerade enheter. |
| [Ronneby Vårdcentral (Vårdenhet, privat utförare)](Organization-ronneby-vardcentral-vardenhet.md) | Exempelinstans för Ronneby Vårdcentral — en primärvårdsenhet driven av Blekinge Primärvård AB (privat) med finansiering från Region Blekinge.Demonstrerar: careLevel=01 (Primärvård), hsaBusinessType=05 (Vårdcentral), financingOrganization-extensionen (privat utförare med regionfinansiering), APK-kod, mobiltelefon, patientInfo (hsaVpwInformation4) och legacy streetAddress (besöksadress ej migrerat till 5.2+ hsaVisitingAddress). Besöksadressen modelleras i Instance-LocationRonnebyVardcentral. |
| [Ronneby Vårdcentral Tjänsteutbud (HealthcareService)](HealthcareService-hs-tjanst-ronneby-vardcentral.md) | Exempelinstans för Ronneby Vårdcentrals vårdtjänst med allmänmedicin, tre typer av tillgänglighetsinformation (telefontider, tidig telefontid, drop-in) och alla tre VPW-textfälten.Demonstrerar: category[verksamhetskod]=1502 (Allmänmedicin), tre separata availability-block (telefontider + tidig telefontid + drop-in med selektiva veckodagar), comment (hsaVpwInformation3), temporaryNotice (hsaVpwInformation2) och patientInfo (hsaVpwInformation4) på HealthcareService-resursen. |

