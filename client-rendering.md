# Klientrendering - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Klientrendering**

## Klientrendering

# Klientrendering och presentationskonventioner

Denna sida beskriver hur klienter som konsumerar HSA-IG-resurser förväntas presentera data för slutanvändare. Reglerna på denna sida är implementationsriktlinjer — de normativa FHIR-begränsningarna finns i respektive profil. Primär målgrupp är konsumentsystem som 1177 Hitta vård, regionala vårdsystem och NPÖ.

-------

## Publik synlighet: meta.security[destination-indicator]

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

## Tillfällig information: organization-period och varningsindikator

En organisation eller enhet som är aktiv under en tidsbegränsad period, t.ex. en sommarmottagning eller ett tillfälligt utökat servicerbjudande, kan ha `extension[orgPeriod]` satt (`http://hl7.org/fhir/StructureDefinition/organization-period`).

### Renderingsregel

Om `Organization.extension[orgPeriod]` är satt OCH `Organization.active = true`:

1. **Visa en visuell varningsindikator**— t.ex. en gul informationsruta med varningssymbol (⚠) ovanför eller i anslutning till enhetens kontaktkort.
1. Rutan bör innehålla: periodens slutdatum (`period.end`) och eventuell text om vad den tidsbegränsade statusen innebär.
1. Text som ska visas i rutan hämtas från det fält klienten valt att mappa till (se nedan).

### Textinnehåll i varningsrutan

HSA-IG lägger ingen normativ begränsning på vilket fält som bär varningsrutetexten — det är en presentationsfråga för respektive konsument. Rekommenderade alternativ:

| | |
| :--- | :--- |
| `Organization.contact`med purpose`TEMP` | Rekommenderat för maskinläsbarhet |
| `HealthcareService.comment` | Fungerar för tjänstenivå |
| Fritext utanför FHIR-resursen (CMS/redaktionellt) | Sista utväg; riskerar inkonsistens |

### Exempel på instans (Organization med tillfällig period)

```
{
  "resourceType": "Organization",
  "active": true,
  "extension": [{
    "url": "http://hl7.org/fhir/StructureDefinition/organization-period",
    "valuePeriod": {
      "start": "2026-06-01",
      "end": "2026-08-31"
    }
  }]
}

```

Klienten läser `extension.valuePeriod.end` och renderar varningsrutan tills detta datum passerat.

-------

## Vägbeskrivning: Location.description som Markdown

Yttre och inre vägbeskrivning lagras i `Location.description` som fritext med Markdown-formatering.

### Konventionella rubriker

```
## Yttre vägbeskrivning
Kollektivtrafik, parkering och hur man hittar till byggnaden.

## Inre vägbeskrivning
Entré, hiss, plan och rum.

```

Klienter SKA rendera detta fält som Markdown (CommonMark). Klienter som inte stödjer Markdown bör visa fältet som oformaterad text, men ska inte presentera Markdown-syntaxen synlig för slutanvändaren.

**Rubrikerna är en konvention, inte ett normativt krav** — klienter bör inte förutsätta att rubrikerna alltid finns, utan rendera all text i `description`-fältet som Markdown oavsett struktur.

-------

## Adressrendering

HSA-IG skiljer på besöksadress och postadress. Distinktionen är central för korrekt visning.

| | | | |
| :--- | :--- | :--- | :--- |
| Postadress | `Organization.contact.address` | `postal` | Alltid med |
| Besöksadress | `Location.address` | `physical` | Aldrig (Uppsala-regel) |

### Uppsala-regeln

Besöksadresser (fysisk adress, `type = physical`) ska **aldrig** innehålla postnummer. Postnumret hör till postadressen på `Organization`. Profilen begränsar `Location.address.postalCode` till 0..0.

**Skäl:** Postnumret för en besöksadress matchar sällan postutdelningsadressen och vilseleder GPS-system och posthantering. Se HSACAT-LOC-005.

### Adressövergång (t.o.m. sept 2026)

HSA 5.2 introducerade strukturerade adressattribut. Under övergångsperioden kan konsumenter möta legacy-attribut (`postalAddress`, `streetAddress`) mappade till `Address.text`. Se [Adressövergång](address-transition.md) för detaljer.

**Konsumentrekommendation:** Föredra strukturerade komponenter (`Address.line`, `.city`, `.postalCode`) framför `.text`. Klienter bör hantera båda formerna.

-------

## Telefonnummer och kontaktvägar

`Organization.contact.telecom` bär kontaktuppgifter. Typen anges via `HsaTelecomTypeExtension` (system `https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type`).

| | | |
| :--- | :--- | :--- |
| `direct-phone` | Direkttelefon | 1 (primär) |
| `switchboard` | Växel | 2 |
| `mobile` | Mobiltelefon | 3 |
| `fax` | Telefax | 4 (ofta dold för konsumenter) |
| `directory-contact` | Innehållsansvarig e-post | Admingränssnitt |

**Klientregel:** Klienter för allmänheten (t.ex. 1177) bör visa direkttelefon som primär kontaktväg och växeltelefon som sekundär. E-post av typen `directory-contact` visas normalt inte för slutanvändare.

-------

## Öppettider

`HealthcareService.availability.availableTime` bär öppettider per veckodag. HSA-katalogen har tre tidtyper som bör presenteras tydligt och separerade:

| | | |
| :--- | :--- | :--- |
| Öppethållning | Fysiska besök | Öppettider |
| Telefontid | Tillgänglighet per telefon | Telefontider |
| Drop-in | Besök utan bokning | Drop-in |

Separata `HealthcareService`-instanser (eller separata `availability`-element) används för att bära olika tidtyper. Klienter bör gruppera och etikettera dessa tydligt i UI.

-------

## 1177-specifika textfält

HSA exponerar flera textfält som enbart riktar sig mot 1177-presentationslagret (`hsaVpw`-attributen). Alla lagras som fritext och bör renderas som Markdown av klienter.

| | | | |
| :--- | :--- | :--- | :--- |
| `extension[temporaryNotice]`(Organization/HealthcareService) | `hsaVpwInformation2` | Gul informationsruta med ⚠-symbol | MAY; kombineras med`extension[orgPeriod]` |
| `extension[patientInfo]`(Organization/HealthcareService) | `hsaVpwInformation4` | Informationsruta riktad till patient | MAY |
| `HealthcareService.comment` | `hsaVpwInformation1` | "Mer om oss"-sektion | MAY |
| `Organization.contact.telecom`(system=#url) | `hsaVpwWebpage` | Länk till 1177-kontaktkort | MAY |

**Renderingsregler för gul ruta:** Visa `extension[temporaryNotice]` som gul informationsruta med varningsikon (⚠) när **båda** villkoren uppfylls: `extension[orgPeriod]` är satt OCH `active = true`. Visa slutdatum från `orgPeriod.valuePeriod.end`. Dölj rutan automatiskt efter slutdatum.

**URL till 1177-kontaktkort** bör visas som klickbar länk och kan användas för djuplänkning från externa system till enhetens 1177-sida.

-------

## 1177 Hitta vård: publiceringschecklista

En resurs som ska synas på 1177 Hitta vård ska uppfylla samtliga punkter nedan. Klienter bör validera dessa fält innan publicering och varna användaren om något saknas.

| | | | |
| :--- | :--- | :--- | :--- |
| 1 | Publik visibilitetsflagga | `meta.security`kod`03` | SHALL |
| 2 | Enhetsnamn | `Organization.name` | SHALL |
| 3 | Besöksadress (gatuadress) | `Location.address.line` | SHALL |
| 4 | Besöksadress (stad) | `Location.address.city` | SHALL |
| 5 | Direkttelefon | `Organization.contact.telecom[direct-phone]` | SHALL |
| 6 | Kartkoordinater (SWEREF99) | `Location.position` | SHALL (publik) |
| 7 | Verksamhetskod | `HealthcareService.category[verksamhetskod]` | SHOULD |
| 8 | Vård-/omsorgsform | `HealthcareService.type[care-type]` | SHOULD |
| 9 | Öppettider | `HealthcareService.availability` | SHOULD |
| 10 | Vägbeskrivning | `Location.description` | MAY |
| 11 | Ägarform | `Organization.type[ownership]` | MAY |

Fält märkta SHALL för publik visning är normativt krävda för alla resurser med `meta.security` kod `03`. SHALL-krav valideras av invarianterna `hsacat-public-org-telecom` (profil) och `hsacat-public-location-position` (profil).

