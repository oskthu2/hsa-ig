# Plan för IG-sidor v0.1

> Uppdaterad 2026-05-20.

## Grundprincipen: profil vs. sida

| Tillhör **profil (FSH)** | Tillhör **IG-sida (Markdown)** |
|---|---|
| Formella begränsningar (kardinalitet, slices) | Varför en begränsning finns (rationale) |
| FHIRPath-invarianter | Hur klienter ska tolka och rendera data |
| Must-Support-flaggor | Integrationsmönster och frågekedjor |
| Terminologibindningar (required/preferred) | Mappningstabeller (LDAP → FHIR) |
| Element-level `^short` + `^definition` | Juridisk kontext (PDL-grund, OID-register) |
| Metadata (`^url`, `^status`, `^date`) | Migrationsguider (t.ex. adressövergång) |
| | Konformansregler per användningsfall (1177, NPÖ) |
| | Felhanteringsguidans |
| | Presentationskonventioner för UI-klienter |

**Tumregel:** Om det kan uttryckas som en FHIR-constraint → profil. Om det kräver prosa, tabeller eller designmotivering → sida.

---

## Sidkatalog

### Redan registrerade i sushi-config.yaml

| Sida | Fil | Status | Ansvar |
|---|---|---|---|
| Introduktion | `index.md` | ⚠️ Stub | Scope, målgrupp, versionsinformation, snabbnavigering |
| Designprinciper | `design-principles.md` | ❌ Saknas | R5-val, ADR-sammanfattning, profilstrategi, OID-konvention |
| Användningsfall | `use-cases.md` | ❌ Saknas | EHR-katalogsynk, NPÖ, 1177 Hitta vård, VGR Encounter |
| Profiler | `profiles.md` | ❌ Saknas | Profil-katalog, relationsdiagram, hierarki |
| Terminologi | `terminology.md` | ❌ Saknas | CodeSystems, OID-tabell, öppna frågor |
| REST API | `api.md` | ❌ Saknas | SearchParameters, CapabilityStatement, frågemönster |
| Harmonisering med eHM | `ehm-alignment.md` | ❌ Saknas | Mappningstabell, skillnader, R4-guide i v2 |

### Nya sidor att lägga till

| Sida | Fil | Status | Ansvar |
|---|---|---|---|
| Klientrendering | `client-rendering.md` | ✅ Skriven | Renderingskonventioner: gul ruta, Markdown, meta.security, adress |
| Organisationshierarki | `organization-hierarchy.md` | ✅ Skriven | PDL inre/yttre spärr, SKLTP trädklättring, partOf-kedja |
| Adressövergång | `address-transition.md` | ✅ Skriven | HSA 5.2+ strukturerade adresser, övergångsperiod sept 2026 |

---

## Vad varje sida äger

### `client-rendering.md`
Äger: renderingskonventioner som inte kan uttryckas i FSH.
- Hur klienter identifierar publika resurser (`meta.security` kod 03)
- Markdown-konventionen för `Location.description` (yttre/inre vägbeskrivning)
- Visuell varningsindikator (gul ruta) vid `organization-period` + `active=true`
- Adress-rendering: postal vs. physical, postnummer-regel
- Telefonnummer: direkttelefon vs. växel (`HsaTelecomTypeExtension`)
- 1177 Hitta vård: komplett publiceringschecklista (must-support för public scope)
- Öppettider: tre tidtyper (öppet/telefon/drop-in)

### `organization-hierarchy.md`
Äger: semantik och algoritm för hierarkin.
- partOf-kedjans struktur och terminationsvillkor
- PDL §6:3 (yttre spärr = vårdgivare) och §6:4 (inre spärr = vårdenhet)
- SKLTP trädklättring: explicit/hierarkisk/standard-behörighet
- Acyklicitetskrav
- Rekommenderade frågeparametrar (`_include`, `_revinclude`)

### `address-transition.md`
Äger: migrationskontext.
- Vad HSA 5.2 ändrade (strukturerade attribut)
- FHIR-mappning: normativ form (komponenter) vs. övergångsform (text)
- Övergångsperiod: t.o.m. sept 2026
- Konsumentrekommendation: föredra strukturerad form

### `design-principles.md`
Äger: ADR-motiveringar (inte ADR-detaljerna som är i beslutsloggen).
- Varför R5 (ADR-003)
- Varför category för verksamhetskod (ADR-011)
- Varför meta.security istf. extension (ADR-012)
- OID-konvention och kanoniska URLs

### `use-cases.md`
Äger: verksamhetskrav per användningsfall.
- UC-01: EHR-katalogsynk (regionala system, t.ex. COSMIC)
- UC-02: NPÖ GetHealthCareUnitMembers (arbetsplatskod)
- UC-03: 1177 Hitta vård (publik sökning, karta, destinationIndicator)
- UC-04: VGR Encounter.type via HealthcareService.category

### `api.md`
Äger: operativa detaljer.
- SearchParameters (HSA-id, meta-security, partOf, status)
- CapabilityStatement (server/klient)
- Pagination och include-mönster
- Felkoder

### `ehm-alignment.md`
Äger: harmoniseringsmatris.
- eHM Nationell katalog-IG vs. HSA-IG
- category/type-alignment
- Skillnader som kräver transformering

---

## Prioritetsordning för skrivande

| Prioritet | Sida | Motivering |
|---|---|---|
| 1 | `client-rendering.md` | Direkt kundkrav (1177 UI, ADR-012-konsekvenser) |
| 2 | `organization-hierarchy.md` | PDL-stöd, SKLTP-integration |
| 3 | `index.md` | Ingångspunkt för alla läsare |
| 4 | `use-cases.md` | Underlag för kravspårning |
| 5 | `address-transition.md` | Tidsbegränsat (sept 2026) |
| 6 | `design-principles.md` | ADR-summary för granskare |
| 7 | `api.md` | Beror på SearchParameters (ej klara) |
| 8 | `terminology.md` | Beror på OID-bekräftelser (öppna frågor) |
| 9 | `ehm-alignment.md` | Beror på SRC-014 (eHM Excel, öppen fråga 7) |
| 10 | `profiles.md` | Kan genereras delvis av IG Publisher |
