# Regional tillämpning av HSA – implicita krav v0.2

> Uppdaterat 2026-05-20. Tillför Region Uppsala LoKatt-instruktion (DocPlusSTYR-35033, v2, 2025-11-17).
> Källa: EK (Region Stockholm), KIV (VGR), Uppsala LoKatt.
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
| öppettider/telefontider | Ja | Nej | Nej | Delvis | **SHOULD MustSupport** (publik) |
| tillfällig information + slutdatum | Ja | Nej | Nej | Nej | **SHOULD MustSupport** (publik) |
| inre/yttre vägbeskrivning | Ja | Nej | Nej | Nej | **MAY** |

---

## Region Uppsala LoKatt – nyckelobservationer (DocPlusSTYR-35033 v2, 2025-11-17)

### Dataflöde bekräftat

```
Heroma (HR-system) ──nattlig sync──► LoKatt (lokal HSA-admin)
                                             │
                                             ▼
                                    HSA nationell katalog
                                             │
                              ┌──────────────┼──────────────┐
                              ▼              ▼              ▼
                           1177          Intranät        Outlook
                       (direkt/fördröjt)  (≤1 dygn)    (≤1 dygn)
```

**Implikation**: HSA är ett aggregerat register, inte en primärkälla. FHIR IG:n måste stödja uppdateringsflöde, versionshantering (`meta.lastUpdated`) och differentiell synkronisering.

### Automatiska vs manuella fält (Enhet)

| Fält | Källa | FHIR-konsekvens |
|---|---|---|
| Enhetsnamn (`ou`) | Automatisk | `Organization.name` — server-managed, ej client-writable |
| HSA-id (`hsaIdentity`) | **Automatisk vid skapande** | Bekräftar: HSA-id är systemgenererat; FHIR `id` ≠ HSA-id |
| Enhetstyp (`hsaBusinessType`) | Manuell (vid omorganisation) | `Organization.type` — client-writable |
| Beskrivning (`description`) | Manuell | `Organization.text` eller extension; visas som "Om oss" på 1177 |
| Öppettider | Manuell | `HealthcareService.availableTime[]` |
| Telefontider | Manuell | `HealthcareService.availableTime[]` (separat slice/typ) |
| Drop-in tider | Manuell | `HealthcareService.availableTime[]` (typ = drop-in) |
| Tillfällig information | Manuell + obligatoriskt slutdatum | Extension med `valueString` + `period.end` |
| Postadress | Manuell | `Organization.address` (type = postal) |
| Besöksadress (utan postnr) | Manuell | `Location.address` (type = physical); postalCode utelämnas |
| Direkttelefon | Manuell | `Organization.telecom` (system=phone, use=work) |
| Växeltelefon | Manuell (ej privata) | `Organization.telecom` (system=phone, use=work + extension för typ) |
| Inre/yttre vägbeskrivning | Manuell | `Location.description` (split inner/outer) eller extension |

### Automatiska vs manuella fält (Person – för referens, ej i scope v1)

| Fält | Källa |
|---|---|
| Personnummer, HSA-id, samtliga namn | Heroma (nattlig sync) |
| E-post | Automatisk |
| Startdatum, slutdatum, chefskod, befattning, närmaste chef | Heroma (automatisk) |
| Direkttelefon, växeltelefon | Manuell |
| Titel | Manuell (optional; annars visas befattning) |
| Besöksadress (om avvikande från enhet) | Manuell; gatuadress + ort, ej postnummer |
| Vårdmedarbetaruppdrag | Hanteras av vårdsystemsamordnare (ej lokal admin) |

### Strukturerade tidsfält – detaljer

HSA stödjer tre typer av tidsfält per enhet:
1. **Öppettider** – när enheten är fysiskt öppen
2. **Telefontider** – när enheten tar telefonsamtal
3. **Drop-in tider** – tider för besök utan tidsbokning (kan ha etikett, max 19 tecken)

**FHIR-modellering**: `HealthcareService.availableTime` med `extension` för typ-distinktion, eller separata `HealthcareService`-resurser per tjänsteform.

### Adressregler (Uppsala-specifika men nationellt relevanta)

- **Postadress**: `751 85` (Region Uppsalas gemensamma postnummer för offentlig vård) — postadress är funktionell, ej fysisk
- **Besöksadress**: gatuadress + ort, **aldrig postnummer** → `Location.address.postalCode` = omit/empty for visit addresses
- Separata `address`-poster i FHIR med `type = postal` resp. `type = physical`

---

## Uppdaterade MustSupport-indikatorer

Tillägg efter Uppsala LoKatt-analys:

| Attribut | MustSupport-förslag | Grund |
|---|---|---|
| öppettider (availableTime) | **SHOULD MustSupport** | Uppsala LoKatt + 1177-publicering |
| telefontider | **SHOULD MustSupport** | Uppsala LoKatt + 1177-publicering |
| drop-in tider | **MAY** | Uppsala LoKatt; regionalt varierande |
| tillfällig information + slutdatum | **SHOULD MustSupport** | Uppsala LoKatt; 1177 kontaktkort |
| postadress (type=postal) | **SHALL MustSupport** | Uppsala LoKatt; separeras från besöksadress |
| besöksadress utan postnr (type=physical) | **SHALL MustSupport** | Uppsala LoKatt; HSACAT-LOC-001 |
| direkttelefon (work) | **SHALL MustSupport** (offentlig) | Uppsala LoKatt; HSACAT-ORG-004 |
| växeltelefon | **SHOULD MustSupport** (offentlig, ej privat) | Uppsala LoKatt; ny distinktion |
| inre vägbeskrivning | **MAY** | Uppsala LoKatt |
| yttre vägbeskrivning | **MAY** | Uppsala LoKatt |
