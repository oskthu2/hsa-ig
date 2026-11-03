# Förslag: mappning av HSA-värden med inbyggt format

Status: Avsnitt 2 och 3 är **beslutade och införda** (ADR-013, ADR-014, 2026-11-03).
Avsnitt 1 är fortfarande ett **förslag** (ADR-015).
Källa: Informationsspecifikation för Katalogtjänst HSA 3.5.1, kap. 11 (SRC-027).

De enkla formatreglerna (HSA-id, organisationsnummer, GLN, telefon, postnummer,
1177-länk och kodformat) är redan införda som invarianter. Det här dokumentet tar upp
tre fall där HSA-värdet inte kan läggas oförändrat i FHIR, utan kräver ett
mappningsbeslut.

---

## 1. SWEREF99-koordinater → `Location.position` (förslag ADR-015)

### Problem

HSA lagrar koordinater som heltal i meter i projektionen **SWEREF99 TM**:

| Attribut | Format | Betydelse |
|---|---|---|
| `hsaSweref99Latitude` | `\d{7}` | Nordlig koordinat (N), t.ex. `6227289` |
| `hsaSweref99Longitude` | `\d{6}` | Östlig koordinat (E), t.ex. `538541` |

FHIR `Location.position.latitude`/`longitude` ska vara **WGS84 i decimalgrader**
(samma som KML). IG:n anger idag att position är "latitud och longitud enligt
SWEREF99 TM", och exemplen påstår att källdata är `hsaSweRef99Latitude: 56.1890`.
Båda är fel: värdet från HSA måste räknas om.

### Förslag

1. Servern räknar om SWEREF99 TM → geografiska koordinater (Gauss–Krüger invers,
   GRS80, medelmeridian 15°, skala 0,9996, falsk östlig 500 000). Skillnaden mellan
   SWEREF99 och WGS84 är under en meter och kan bortses från.
2. Värdet anges med minst 5 decimaler (ungefär 1 m).
3. Originalvärdet bärs inte i FHIR (i linje med ADR-012). Den som behöver SWEREF99 TM
   kan räkna tillbaka.
4. Rättelser i IG:n:
   - `Profile-HsaCatalogLocation.fsh`: `position ^short`/`^definition` → "WGS84 (omräknat från SWEREF99 TM i HSA)".
   - Exempelkommentarerna: `hsaSweRef99Latitude: 56.1890` → `hsaSweref99Latitude: 6227289` osv.
   - Attributnamnet stavas `hsaSweref99Latitude` i specen (litet r), IG:n använder `hsaSweRef99Latitude`.
   - Ny invariant (varning): `position.latitude` mellan 55 och 70, `position.longitude` mellan 10 och 25.
     Fångar både omkastade värden och oomräknade meter.

| Exempel | WGS84 (IG idag) | SWEREF99 TM (N / E) |
|---|---|---|
| Blekingesjukhuset | 56.1890 / 15.6210 | 6227289 / 538541 |
| Hjärtmottagningen | 56.1892 / 15.6215 | 6227311 / 538572 |
| Ronneby vårdcentral | 56.2098 / 15.2791 | 6229465 / 517312 |

---

## 2. `hsaVpwInformation2` med inbäddade datum (beslutad: ADR-013)

### Problem

Tillfällig information kan inledas med visningsperiod:

```
;20201201;20210101;Tillfälligt stängt för underhåll
;20201201;;Tillfälligt stängt för underhåll
;;20210101;Tillfälligt stängt för underhåll
Tillfälligt stängt för underhåll
```

IG:n mappar texten till `extension[temporaryNotice].valueString` och säger att
slutdatum hanteras via `organization-period`. Men:

- Det finns ingen regel för att tolka prefixet. Om det inte tas bort hamnar
  `;20201201;20210101;` i texten som visas för patienten.
- `organization-period` anger **organisationens** giltighetstid. Datumen i
  `hsaVpwInformation2` anger hur länge **meddelandet** ska visas. Det är olika saker:
  en vårdcentral som stänger en vecka för underhåll upphör inte att existera.

### Förslag

1. Gör `HsaTemporaryNoticeExtension` komplex, med två delar:
   - `text` (string, 1..1): texten utan prefix.
   - `period` (Period, 0..1): visningsperiod. `start`/`end` som `date` (ÅÅÅÅ-MM-DD).
     `end` är inklusive.
2. Servern tolkar prefixet `^;(\d{8})?;(\d{8})?;` och tar bort det ur texten.
3. Ändra invarianten `hsacat-temporary-notice-requires-period` så att den gäller
   meddelandets egen `period`, inte `organization-period`. Behåll som varning.
4. `client-rendering.md`: visa den gula rutan när dagens datum ligger inom
   `temporaryNotice.period` (eller när period saknas), oberoende av `organization-period`.

Alternativ: behåll en enkel `valueString` och lägg perioden i `organization-period`
som idag. Enklare, men blandar ihop två olika giltighetstider.

---

## 3. Öppettider och `24:00` (beslutad: ADR-014)

### Problem

`surgeryHours`, `telephoneHours`, `dropInHours` och `visitingHours` har formatet:

```
<FD>-<TD>#<FT>#<TT>[#<kommentar, max 19 tecken>][#<fr.o.m. ÅÅÅÅMMDD>#<t.o.m. ÅÅÅÅMMDD>]
```

Tre saker går inte att mappa direkt till R5 `Availability`:

| HSA | Problem i FHIR |
|---|---|
| `24:00` som sluttid (t.ex. `1-7#00:00#24:00`) | FHIR `time` tillåter bara `00:00:00`–`23:59:59` |
| Kommentar (`Halvdag`, `Provtagning`) | `Availability.availableTime` saknar textfält |
| Datumintervall (avvikande öppettider, t.ex. jul) | R5 `Availability` saknar `period` |

### Förslag

1. `00:00#24:00` → `allDay = true`. Annan sluttid `24:00` → `availableEndTime = "23:59:59"`.
   Klienten visar `23:59:59` som `24:00`.
2. Varje HSA-värde med kommentar eller datumintervall blir en egen
   `availability`-post. Kommentaren och perioden bärs av två små HSA-extensions på
   `Availability`: `hsa-availability-comment` (string) och `hsa-availability-period` (Period).
   Inga standardextensions för detta finns i hl7.fhir.uv.extensions.r5 5.4.0.
3. Ny invariant: `availableEndTime` > `availableStartTime` (HSA kräver att dygnsgränser inte passeras).

---

## Övrigt att följa upp (ej mappningsbeslut)

- `hsaTextTelephoneNumber` och `hsaVideoPhone` valideras i HSA som **e-postadresser**.
  IG:n mappar dem till `telecom` med `system = other`. Överväg `system = email` plus en
  typkod i `HsaTelecomTypeExtension`.
- Strukturerad adress har längdgränser per del: adressat max 64 tecken per rad, gata
  max 35, adressplatsnummer `^\d{1,5}(-\d{1,4})?`, littera max 2 bokstäver, postnummer
  exakt 5 siffror. De kan bli invarianter när det är bestämt hur delarna fördelas på
  `Address.line`.
- Exemplen använder `SE2321000016`, som är Region Stockholms HSA-id-prefix
  (organisationsnummer 232100-0016), för Region Blekinge. Riktlinjerna för testdata
  (SRC-028) kräver riktiga organisationsnummer i testmiljöerna. Byt till ett nummer
  som tydligt är fiktivt, eller till Region Blekinges riktiga.
