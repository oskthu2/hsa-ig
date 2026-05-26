// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: ou=Blekingesjukhuset,o=Region Blekinge,c=SE  (tjänsteinformation på
//     samma LDAP-post som enheten — HSA lagrar inte tjänster som separata objekt)
// businessClassificationCode: 1101  ← Internmedicin (OID 1.2.752.129.2.2.1.3)
//                             1126  ← Kardiologi
// hsaCareType: 01                   ← Öppen vård (OID 1.2.752.129.2.2.1.13)
//              02                   ← Sluten vård
// hsaPublicTelephoneHours:
//   Måndag-Fredag 08:00-16:30
// hsaDropinHours:
//   Måndag-Fredag 08:00-11:00
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
// availability[0] (öppettider)      ← hsaPublicTelephoneHours
//   Mån-Fre 08:00-16:30 (telefonmottagning)
// availability[1] (drop-in)         ← hsaDropinHours
//   Mån-Fre 08:00-11:00
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
// hsaPublicTelephoneHours: Mån-Fre 08:00-16:30 (telefonmottagning)
* availability[0]
  * availableTime[0]
    * daysOfWeek[0] = #mon
    * daysOfWeek[1] = #tue
    * daysOfWeek[2] = #wed
    * daysOfWeek[3] = #thu
    * daysOfWeek[4] = #fri
    * availableStartTime = "08:00:00"
    * availableEndTime = "16:30:00"

// hsaDropinHours: Mån-Fre 08:00-11:00 (drop-in)
* availability[1]
  * availableTime[0]
    * daysOfWeek[0] = #mon
    * daysOfWeek[1] = #tue
    * daysOfWeek[2] = #wed
    * daysOfWeek[3] = #thu
    * daysOfWeek[4] = #fri
    * availableStartTime = "08:00:00"
    * availableEndTime = "11:00:00"
