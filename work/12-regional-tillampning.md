# Regional tillämpning av HSA – implicita krav v0.1

> Extraherat 2026-05-20 från regionala adminhandboken och HSA-guidning för 1177.
> Källa: EK (Region Stockholm), KIV (VGR), Skånekatalogen (Region Skåne), Uppsala HSA-handbok.
> Dessa implicita krav härrör från faktisk tillämpning och är viktiga MustSupport-indikatorer.

## Regionala HSA-implementation

| Region | System | Lokalt gränssnitt → HSA → Konsumenter |
|---|---|---|
| Region Stockholm | EK (Elektroniska Katalogen) | EK Admin → HSA nationell → 1177, NPÖ, SITHS |
| Västra Götalandsregionen | KIV (Katalog i Väst) | KIV Admin → HSA nationell → 1177, Pascal, EHR-system |
| Region Skåne | Skånekatalogen | Skånekatalogen Admin → HSA nationell → 1177 |
| Region Uppsala | Lokalt HSA (Lokatt?) | Lokal admin → HSA nationell → 1177 |

**Mönster:** Alla regioner har ett lokalt administrationsgränssnitt som skriver till HSA. HSA är gemensam informationsmodell. Konsumenter (1177 Hitta vård, Pascal, EHR) läser från HSA.

---

## Obligatoriska fält för publicering på 1177 (nationellt krav via HSA)

Sammanställt från EK och KIV-dokumentation. En enhet syns i 1177 Hitta vård om och bara om:

| # | HSA-attribut | LDAP-namn | Krav | FHIR-kandidat | Krav-id |
|---|---|---|---|---|---|
| 1 | `visas för` = `03` (Internet/allmänhet) | `hsaDestinationIndicator` | SHALL | `meta.security` eller extension (synlighetsregel) | HSACAT-ORG-009 |
| 2 | Egennamn / enhetsnamn | `ou` / `o` | SHALL | `Organization.name` | HSACAT-ORG-003 (täcks) |
| 3 | Besöksadress | `hsaPostalAddress` / `postalAddress` | SHALL | `Location.address` (fysisk plats) | HSACAT-LOC-001 (täcks delvis) |
| 4 | Telefonnummer | `telephoneNumber` | SHALL | `Organization.telecom` eller `HealthcareService.telecom` | HSACAT-ORG-004 (täcks) |
| 5 | Lokalitet (stad) | `l` (localityName) | SHALL | `Organization.address.city` eller `Location.address.city` | Saknas – nytt krav HSACAT-LOC-004 |
| 6 | Geografiska koordinater (SWEREF99 eller RT90) | `hsaSweref99Latitude` / `hsaSweref99Longitude` | SHALL | `Location.position` (lat/long) | Saknas – nytt krav HSACAT-LOC-003 |
| 7 | Verksamhetskod | `businessClassificationCode` | SHOULD / SHALL (regionalt) | `HealthcareService.type` | HSACAT-TERM-001 (täcks) |
| 8 | Vårdform | `careType` | SHALL (för vårdenheter) | `HealthcareService.type` (separat slice) | Saknas – nytt krav HSACAT-SVC-003 |
| 9 | Ägarform | `management` | SHOULD | `Organization.type` eller extension | Saknas – nytt krav HSACAT-ORG-010 |
| 10 | Finansierande organisation | `financingOrganization` | SHOULD (VGR-krav) | `Organization.partOf` eller extension | Saknas – nytt krav HSACAT-ORG-011 |

---

## KIV-specifika iakttagelser (VGR)

- Enhet som skriver till 1177 måste ha **finansierande region** = Västra Götalandsregionen ifyllt
- Verksam hetskod `1519` är specifikt för Ungdomsmottagning (UMO) → detta bekräftar att verksamhetskod har faktiska kodbindningar
- Öppen vård (01), Sluten vård (02), Hemsjukvård (03) är giltiga `careType`-värden → OID `1.2.752.129.2.2.1.13`
- KIV-objekt har alltid HSA-id; id sätts automatiskt vid skapande

## EK-specifika iakttagelser (Region Stockholm)

- HSA-id genereras **automatiskt** vid enhetsskapande → ska inte vara manuellt inmatningsfält i API
- Enheten måste vara markerad `Synlig för: Internet` = `hsaDestinationIndicator = "03"` för 1177
- Kartposition (koordinater) är obligatoriska för publik 1177-visning
- Organisations-ID (PA-system + kostnadsenhet) är regionspecifikt och bör inte normeras i nationellt IG

## Skånekatalogen-iakttagelser

- Samma obligatoriska fält-mönster som EK/KIV för 1177
- Konfirmerar att `besöksadress + koordinater + telefon + visas för 03` är nationellt konsekvent krav

---

## Nya kravkandidater identifierade

| Krav-id | Kravtext (preliminär) | FHIR-uttryck | Källa |
|---|---|---|---|
| HSACAT-LOC-003 | Fysisk Location som ska vara synlig för allmänheten SHALL ha geografiska koordinater | `Location.position` 1..1 when `hsaDestinationIndicator = "03"` | EK + KIV (obligatoriskt för 1177) |
| HSACAT-LOC-004 | Fysisk Location SHALL ha lokalitet (stad/ort) | `Location.address.city` 1..1 vid `mode = 'instance'` | EK (Lokalitet obligatoriskt) |
| HSACAT-SVC-003 | HealthcareService för vårdenhet SHALL ha vård- och omsorgsform (`careType`) | `HealthcareService.type` slice `care-type`; system = `urn:oid:1.2.752.129.2.2.1.13` | KIV (Vårdform obligatorisk) |
| HSACAT-ORG-009 | Organization eller HealthcareService som ska visas publikt SHALL ha `hsaDestinationIndicator = "03"` modellerat | Extension eller `meta.security` tagg; sökbar via API | EK + KIV + nationell HSA-regel för 1177 |
| HSACAT-ORG-010 | Organization SHOULD ha ägarform (regi) | `Organization.type` slice `ownership`; system = `urn:oid:1.2.752.129.2.2.1.14` | EK (Ägarform obligatorisk för 1177) |
| HSACAT-ORG-011 | Vårdenhet med regional finansiering SHOULD ha finansierande region/kommun | Extension med `financingOrganization` OID-referens | KIV (Finansierande organisation obligatorisk i VGR) |

---

## MustSupport-indikatorer från regional tillämpning

Baserat på konsument-markering i HSA-schemat (SRC-001) och regional dokumentation:

| Attribut | 1177 | Pascal | NPÖ | EHR | MustSupport-förslag |
|---|---|---|---|---|---|
| `hsaIdentity` (HSA-id) | Ja | Ja | Ja | Ja | **SHALL MustSupport** |
| `telephoneNumber` (direkttelefon) | Ja | Nej | Nej | Delvis | **SHALL MustSupport** (publik enhet) |
| `businessClassificationCode` | Ja | Delvis | Nej | Ja | **SHOULD MustSupport** |
| `careType` (vårdform) | Ja | Delvis | Nej | Delvis | **SHOULD MustSupport** |
| `hsaDestinationIndicator` (visas för) | Ja | Nej | Nej | Nej | **SHOULD MustSupport** |
| `hsaSweref99Latitude/Longitude` | Ja | Nej | Nej | Nej | **SHOULD MustSupport** (publik) |
| `hsaPostalAddress` (besöksadress) | Ja | Nej | Nej | Delvis | **SHALL MustSupport** (publik) |
| `management` (ägarform) | Ja | Nej | Nej | Nej | **SHOULD MustSupport** |
| `orgNo` (organisationsnummer) | Nej | Ja | Ja | Ja | **SHALL MustSupport** (vårdgivare) |
| `ou` / `o` (namn) | Ja | Ja | Ja | Ja | **SHALL MustSupport** |
| `partOf`-relation | Delvis | Ja | Ja | Ja | **SHALL MustSupport** |
