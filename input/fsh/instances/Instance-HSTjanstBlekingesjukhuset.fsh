// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: ou=Blekingesjukhuset,o=Region Blekinge,c=SE  (tjänsteinformation på
//     samma LDAP-post som enheten — HSA lagrar inte tjänster som separata objekt)
// businessClassificationCode: 1101  ← Internmedicin (OID 1.2.752.129.2.2.1.3)
//                             1126  ← Kardiologi
// hsaCareType: 01                   ← Öppen vård (OID 1.2.752.129.2.2.1.13)
//              02                   ← Sluten vård
// telephoneHours: 1-5#08:00#16:30
// dropInHours: 1-5#08:00#11:00
// surgeryHours: 1-7#00:00#24:00#Akutmottagning
// surgeryHours: 1-7#08:00#12:30#Halvdag#20261223#20261223
// hsaVpwInformation3: Akutmottagning är öppen dygnet runt alla dagar.
//   (hsaVpwInformation3 = generell "om oss"-text → HealthcareService.comment)
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// FHIR-modell: 1 LDAP-enhet → 1 HealthcareService (i detta enkla fall).
// I komplexa scenarier med flera verksamhetskoder kan man välja att skapa
// separata HealthcareService per businessClassificationCode (ADR-011).
// Här samlas båda koderna i category[verksamhetskod] på en tjänst.
//
// active                            ← true (enheten är aktiv)
// providedBy                        ← Reference(BlekingesjukhusetVardenhet)
//   Obligatorisk (1..1). Anger vilken vårdenhet som tillhandahåller tjänsten.
// category[verksamhetskod]          ← businessClassificationCode
//   1101 "Internmedicin", 1126 "Kardiologi"
//   OID 1.2.752.129.2.2.1.3 (HSA verksamhetskod-kodverk)
//   Dessa koder kan denormaliseras till Encounter.type av VGR (UC-04).
// type[care-type]                   ← hsaCareType
//   01 "Öppen vård", 02 "Sluten vård"
//   OID 1.2.752.129.2.2.1.13
// comment                           ← hsaVpwInformation3 ("om oss"-text på 1177)
// location                          ← Reference(LocationBlekingesjukhuset)
// availability[0] (telefontid)      ← telephoneHours 1-5#08:00#16:30
// availability[1] (drop-in)         ← dropInHours 1-5#08:00#11:00
// availability[2] (öppettid)        ← surgeryHours 1-7#00:00#24:00#Akutmottagning
//   00:00–24:00 → allDay = true; kommentar → extension[comment] (ADR-014)
// availability[3] (avvikande)       ← surgeryHours 1-7#08:00#12:30#Halvdag#20261223#20261223
//   datumintervall → extension[period]
// meta.security[destination-indicator] ← 03 (publik, som enheten)
// ═══════════════════════════════════════════════════════════════════════════════

Instance: HSTjanstBlekingesjukhuset
InstanceOf: HsaHealthcareService
Usage: #example
Title: "Blekingesjukhuset Tjänsteutbud (HealthcareService)"
Description: """
  Exempelinstans för Blekingesjukhusets vårdtjänst med internmedicin och
  kardiologi, öppen- och slutenvård, telefontider och drop-in-tider.

  Demonstrerar: category[verksamhetskod] med flera koder (1101 Internmedicin
  och 1126 Kardiologi), type[care-type] med öppen och sluten vård,
  availability för telefonmottagning (öppettider) och drop-in, comment
  (hsaVpwInformation3 → "om oss"-text) och relationen till Location-resursen.
"""

* id = "hs-tjanst-blekingesjukhuset"

// Publik synlighet: destinationIndicator=03
* meta.security[destination-indicator]
  * system = "urn:oid:1.2.752.29.23.1.11"
  * code = #03
  * display = "Internet/allmänheten"

* active = true

// providedBy obligatorisk (1..1) — anger ansvarig vårdenhet
* providedBy = Reference(BlekingesjukhusetVardenhet)

* name = "Internmedicin och Kardiologi"

// hsaVpwInformation3 → comment ("om oss"-text på 1177 kontaktkort)
* comment = "Akutmottagning är öppen dygnet runt alla dagar. Planerade mottagningar kräver remiss via din vårdcentral."

// ── Verksamhetskoder (category[verksamhetskod]) ───────────────────────────────
// businessClassificationCode: 1101 Internmedicin + 1126 Kardiologi
// Används av VGR för UC-04: Encounter.type ← HealthcareService.category[verksamhetskod]
// Sökning: GET /HealthcareService?organization=Organization/blekingesjukhuset-vardenhet
//          &service-category=urn:oid:1.2.752.129.2.2.1.3|1101
* category[verksamhetskod]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.3"
    * code = #1101
    * display = "Internmedicin"
  * coding[1]
    * system = "urn:oid:1.2.752.129.2.2.1.3"
    * code = #1126
    * display = "Kardiologi"

// ── Vård-/omsorgsform (type[care-type]) ──────────────────────────────────────
// hsaCareType: 01 Öppen vård + 02 Sluten vård
* type[care-type]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.13"
    * code = #01
    * display = "Öppen vård"
  * coding[1]
    * system = "urn:oid:1.2.752.129.2.2.1.13"
    * code = #02
    * display = "Sluten vård"

// ── Koppling till besöksplats ─────────────────────────────────────────────────
* location = Reference(LocationBlekingesjukhuset)

// ── Tillgänglighet (availability) ────────────────────────────────────────────
// R5-modellen: availability.availableTime ersätter R4:s availableTime
// telephoneHours 1-5#08:00#16:30
* availability[0]
  * availableTime[0]
    * daysOfWeek[0] = #mon
    * daysOfWeek[1] = #tue
    * daysOfWeek[2] = #wed
    * daysOfWeek[3] = #thu
    * daysOfWeek[4] = #fri
    * availableStartTime = "08:00:00"
    * availableEndTime = "16:30:00"

// dropInHours 1-5#08:00#11:00
* availability[1]
  * availableTime[0]
    * daysOfWeek[0] = #mon
    * daysOfWeek[1] = #tue
    * daysOfWeek[2] = #wed
    * daysOfWeek[3] = #thu
    * daysOfWeek[4] = #fri
    * availableStartTime = "08:00:00"
    * availableEndTime = "11:00:00"

// surgeryHours 1-7#00:00#24:00#Akutmottagning
// FHIR time tillåter inte 24:00; hela dygnet anges med allDay (ADR-014).
* availability[2]
  * extension[comment].valueString = "Akutmottagning"
  * availableTime[0]
    * daysOfWeek[0] = #mon
    * daysOfWeek[1] = #tue
    * daysOfWeek[2] = #wed
    * daysOfWeek[3] = #thu
    * daysOfWeek[4] = #fri
    * daysOfWeek[5] = #sat
    * daysOfWeek[6] = #sun
    * allDay = true

// surgeryHours 1-7#08:00#12:30#Halvdag#20261223#20261223
// Avvikande öppettid en enskild dag: kommentar och period på egen availability.
* availability[3]
  * extension[comment].valueString = "Halvdag"
  * extension[period].valuePeriod
    * start = "2026-12-23"
    * end = "2026-12-23"
  * availableTime[0]
    * daysOfWeek[0] = #mon
    * daysOfWeek[1] = #tue
    * daysOfWeek[2] = #wed
    * daysOfWeek[3] = #thu
    * daysOfWeek[4] = #fri
    * daysOfWeek[5] = #sat
    * daysOfWeek[6] = #sun
    * availableStartTime = "08:00:00"
    * availableEndTime = "12:30:00"
