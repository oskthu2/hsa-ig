# Klientrendering - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Klientrendering**

## Klientrendering

### Klientrendering och presentationskonventioner

Denna sida beskriver hur klienter som konsumerar HSA-IG-resurser förväntas presentera data för slutanvändare. Reglerna på denna sida är implementationsriktlinjer — de normativa FHIR-begränsningarna finns i respektive profil. Primär målgrupp är konsumentsystem som 1177 Hitta vård, regionala vårdsystem och NPÖ.

-------

#### Publik synlighet: meta.security[destination-indicator]

`hsaDestinationIndicator` anger vilket publiceringsscope en resurs har. Det modelleras som ett Coding-element i `meta.security` med system `urn:oid:1.2.752.29.23.1.11`.

| | | |
| :--- | :--- | :--- |
| `01` | Interna system | Vårdsystem med legitimering |
| `02` | Samverkan | Andra HSA-anslutna system |
| `03` | Internet/allmänheten | 1177 Hitta vård, publika API:er |

**Klientregel:** Klienter som publicerar data för allmänheten (t.ex. 1177) SKA filtrera sökresultat på `meta.security.code = '03'` och system `urn:oid:1.2.752.29.23.1.11`. Resurser utan denna kod ska inte visas.

Sökning via SearchParameter (se [REST API](api.md)):

```
GET /Organization?_security=urn:oid:1.2.752.29.23.1.11|03

```

-------

#### Tillfällig information: extension[temporaryNotice] och varningsindikator

Tillfällig information (`hsaVpwInformation2`) bärs av `extension[temporaryNotice]` på Organization och HealthcareService. Extensionen har två delar (ADR-013):

| | |
| :--- | :--- |
| `text` | Texten som visas, utan datumprefix |
| `period` | Visningsperiod tolkad ur prefixet`;ÅÅÅÅMMDD;ÅÅÅÅMMDD;`i HSA.`start`och`end`är datum och inklusive |

Visningsperioden gäller meddelandet. Organisationens egen giltighetstid (`startDate`/`endDate`) ligger i `extension[orgPeriod]` (organization-period) och styr inte informationsrutan.

##### Renderingsregel

Visa `temporaryNotice.text` som en gul informationsruta med varningssymbol (⚠) i anslutning till kontaktkortet när:

1. resursen har`active = true`, och
1. dagens datum ligger inom`temporaryNotice.period`. Saknas`start`gäller perioden från idag; saknas`end`gäller den tills vidare. Saknas hela perioden visas rutan tills informationen tas bort i HSA.

Dölj rutan automatiskt dagen efter `period.end`.

##### Exempel

HSA-värdet `;20260901;20271231;Tillfällig lokal under renovering. Vi finns nu i byggnad B, plan 4.` blir:

```
{
  "url": "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice",
  "extension": [
    { "url": "text", "valueString": "Tillfällig lokal under renovering. Vi finns nu i byggnad B, plan 4." },
    { "url": "period", "valuePeriod": { "start": "2026-09-01", "end": "2027-12-31" } }
  ]
}

```

-------

#### Vägbeskrivning: Location.description som Markdown

Yttre och inre vägbeskrivning lagras i `Location.description` som fritext med Markdown-formatering.

##### Konventionella rubriker

```
## Yttre vägbeskrivning
Kollektivtrafik, parkering och hur man hittar till byggnaden.

## Inre vägbeskrivning
Entré, hiss, plan och rum.

```

Klienter SKA rendera detta fält som Markdown (CommonMark). Klienter som inte stödjer Markdown bör visa fältet som oformaterad text, men ska inte presentera Markdown-syntaxen synlig för slutanvändaren.

**Rubrikerna är en konvention, inte ett normativt krav** — klienter bör inte förutsätta att rubrikerna alltid finns, utan rendera all text i `description`-fältet som Markdown oavsett struktur.

-------

#### Adressrendering

HSA-IG skiljer på besöksadress och postadress. Distinktionen är central för korrekt visning.

| | | | |
| :--- | :--- | :--- | :--- |
| Postadress | `Organization.contact.address` | `postal` | Alltid med |
| Besöksadress | `Location.address` | `physical` | Aldrig (Uppsala-regel) |

##### Uppsala-regeln

Besöksadresser (fysisk adress, `type = physical`) ska **aldrig** innehålla postnummer. Postnumret hör till postadressen på `Organization`. Profilen begränsar `Location.address.postalCode` till 0..0.

**Skäl:** Postnumret för en besöksadress matchar sällan postutdelningsadressen och vilseleder GPS-system och posthantering. Se HSACAT-LOC-005.

##### Adressövergång (t.o.m. sept 2026)

HSA 5.2 introducerade strukturerade adressattribut. Under övergångsperioden kan konsumenter möta legacy-attribut (`postalAddress`, `streetAddress`) mappade till `Address.text`. Se [Adressövergång](address-transition.md) för detaljer.

**Konsumentrekommendation:** Föredra strukturerade komponenter (`Address.line`, `.city`, `.postalCode`) framför `.text`. Klienter bör hantera båda formerna.

-------

#### Telefonnummer och kontaktvägar

`Organization.contact.telecom` bär kontaktuppgifter. Typen anges via `HsaTelecomTypeExtension` (system `https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type`).

| | | |
| :--- | :--- | :--- |
| `direct-phone` | Direkttelefon | 1 (primär) |
| `switchboard` | Växel | 2 |
| `mobile` | Mobiltelefon | 3 |
| `fax` | Telefax | 4 (ofta dold för konsumenter) |
| `directory-contact` | Innehållsansvarig e-post | Admingränssnitt |

**Klientregel:** Klienter för allmänheten (t.ex. 1177) bör visa direkttelefon som primär kontaktväg och växeltelefon som sekundär. E-post av typen `directory-contact` visas normalt inte för slutanvändare.

**Nummerformat:** Telefon- och faxnummer levereras i HSA:s lagringsformat, utan mellanslag och bindestreck och normalt med landsprefix, t.ex. `+46455731700` (invariant `hsacat-phone-format`). Endast nummer som inte kan ringas från utlandet (`020…`, `0771…`, `11…`) saknar `+`. Klienten ansvarar för att formatera numret för visning, t.ex. `0455-73 17 00`, och kan använda det oformaterade värdet direkt i `tel:`-länkar.

-------

#### Öppettider

`HealthcareService.availability.availableTime` bär öppettider per veckodag. Varje `availability`-post anger sin tidtyp i `extension[availabilityType]` (system `https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type`, ADR-016). Klienter grupperar posterna på tidtypen och etiketterar dem tydligt:

| | | |
| :--- | :--- | :--- |
| `surgery-hours` | `surgeryHours` | Öppettider |
| `telephone-hours` | `telephoneHours` | Telefontider |
| `drop-in-hours` | `dropInHours` | Drop-in |
| `visiting-hours` | `visitingHours` | Besökstider för anhöriga |

Klienter ska inte gissa tidtypen utifrån postens ordning eller klockslag.

##### Kommentarer, avvikande tider och dygnet runt

| | |
| :--- | :--- |
| `availableTime.allDay = true` | "Dygnet runt" (HSA`00:00–24:00`) |
| `availableEndTime = "23:59:59"` | Visa som`24:00` |
| `availability.extension[comment]` | Visa kommentaren bredvid tiderna, t.ex. "08:00–12:30 Halvdag" |
| `availability.extension[period]` | Visa tiderna bara för datum inom perioden |

HSA registrerar avvikande tider genom att dela upp perioderna så att de inte överlappar: de ordinarie tiderna får ett t.o.m.-datum, den avvikande tiden en egen period och de ordinarie tiderna ett nytt fr.o.m.-datum. Klienten behöver därför bara filtrera på period, inte avgöra vilken post som gäller före en annan.

-------

#### 1177-specifika textfält

HSA exponerar flera textfält som enbart riktar sig mot 1177-presentationslagret (`hsaVpw`-attributen). Alla lagras som fritext och bör renderas som Markdown av klienter.

| | | | |
| :--- | :--- | :--- | :--- |
| `extension[temporaryNotice]`(Organization/HealthcareService) | `hsaVpwInformation2` | Gul informationsruta med ⚠-symbol | MAY; egen visningsperiod i`period` |
| `extension[patientInfo]`(Organization/HealthcareService) | `hsaVpwInformation4` | Informationsruta riktad till patient | MAY |
| `HealthcareService.comment` | `hsaVpwInformation1` | "Mer om oss"-sektion | MAY |
| `Organization.contact.telecom`(system=#url) | `hsaVpwWebpage` | Länk till 1177-kontaktkort | MAY |

**Renderingsregler för gul ruta:** Se avsnittet om tillfällig information ovan.

**URL till 1177-kontaktkort** bör visas som klickbar länk och kan användas för djuplänkning från externa system till enhetens 1177-sida.

-------

#### 1177 Hitta vård: publiceringschecklista

En resurs som ska synas på 1177 Hitta vård ska uppfylla samtliga punkter nedan. Klienter bör validera dessa fält innan publicering och varna användaren om något saknas.

| | | | |
| :--- | :--- | :--- | :--- |
| 1 | Publik visibilitetsflagga | `meta.security`kod`03` | SHALL |
| 2 | Enhetsnamn | `Organization.name` | SHALL |
| 3 | Besöksadress (gatuadress) | `Location.address.line` | SHALL |
| 4 | Besöksadress (stad) | `Location.address.city` | SHALL |
| 5 | Direkttelefon | `Organization.contact.telecom[direct-phone]` | SHALL |
| 6 | Kartkoordinater (WGS84) | `Location.position` | SHALL (publik) |
| 7 | Verksamhetskod | `HealthcareService.category[verksamhetskod]` | SHOULD |
| 8 | Vård-/omsorgsform | `HealthcareService.type[care-type]` | SHOULD |
| 9 | Öppettider | `HealthcareService.availability` | SHOULD |
| 10 | Vägbeskrivning | `Location.description` | MAY |
| 11 | Ägarform | `Organization.type[ownership]` | MAY |

Fält märkta SHALL för publik visning är normativt krävda för alla resurser med `meta.security` kod `03`. SHALL-krav valideras av invarianterna `hsacat-public-org-telecom` (profil) och `hsacat-public-location-position` (profil).

