// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: ou=Ronneby Vårdcentral,o=Blekinge Primärvård AB,c=SE
// businessClassificationCode: 1502  ← Allmänmedicin (OID 1.2.752.129.2.2.1.3)
// hsaCareType: 01                   ← Öppen vård (OID 1.2.752.129.2.2.1.13)
// hsaPublicTelephoneHours:
//   Måndag-Fredag 08:00-17:00
// hsaTelephoneHours:
//   Måndag-Fredag 07:30-08:00 (tidig telefonid; listas separat)
// hsaDropinHours:
//   Måndag 13:00-16:00
//   Onsdag 13:00-16:00
// hsaVpwInformation2: Telefonköerna är kortast tidigt på morgonen (07:30-08:00).
//   (hsaVpwInformation2 → tillfällig information/råd, gul ruta på 1177)
// hsaVpwInformation3: Vi är din fasta läkarkontakt för allmänmedicin och
//   förebyggande vård i Ronneby. Listning görs via 1177.se.
//   (hsaVpwInformation3 → comment på HealthcareService)
// hsaVpwInformation4: Du kan lista dig hos oss via 1177.se. Vi tar emot
//   både bokade besök och drop-in.
//   (hsaVpwInformation4 → patientInfo på HealthcareService)
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// active                            ← true
// providedBy                        ← Reference(RonnebyVardcentralVardenhet)
// category[verksamhetskod]          ← businessClassificationCode=1502 "Allmänmedicin"
//   OID 1.2.752.129.2.2.1.3
// type[care-type]                   ← hsaCareType=01 "Öppen vård"
//   OID 1.2.752.129.2.2.1.13
// comment                           ← hsaVpwInformation3 ("om oss"-text)
// extension[temporaryNotice]        ← hsaVpwInformation2 (gul informationsruta)
// extension[patientInfo]            ← hsaVpwInformation4 (patientinformation)
// location                          ← Reference(LocationRonnebyVardcentral)
// availability[0]                   ← hsaPublicTelephoneHours: Mån-Fre 08:00-17:00
//   Telefontider (ordinarie kontorsdagar)
// availability[1]                   ← hsaTelephoneHours: Mån-Fre 07:30-08:00
//   Tidig telefontid (listas som separat tillgänglighetsblock)
// availability[2]                   ← hsaDropinHours: Mån+Ons 13:00-16:00
//   Drop-in (ej alla dagar — modelleras med specifika dagar)
//
// ALLA TRE TEXTFÄLTEN:
//   hsaVpwInformation2 → extension[temporaryNotice] (gul ruta, tillfällig)
//   hsaVpwInformation3 → comment (stabil "om oss"-text)
//   hsaVpwInformation4 → extension[patientInfo] (patientspecifik info)
//   Jämför med Instance-HSTjanstBlekingesjukhuset som bara visar comment.
// ═══════════════════════════════════════════════════════════════════════════════

Instance: HSTjanstRonnebyVardcentral
InstanceOf: HsaHealthcareService
Usage: #example
Title: "Ronneby Vårdcentral Tjänsteutbud (HealthcareService)"
Description: """
  Exempelinstans för Ronneby Vårdcentrals vårdtjänst med allmänmedicin,
  tre typer av tillgänglighetsinformation (telefontider, tidig telefontid,
  drop-in) och alla tre VPW-textfälten.

  Demonstrerar: category[verksamhetskod]=1502 (Allmänmedicin), tre separata
  availability-block (telefontider + tidig telefontid + drop-in med selektiva
  veckodagar), comment (hsaVpwInformation3), temporaryNotice (hsaVpwInformation2)
  och patientInfo (hsaVpwInformation4) på HealthcareService-resursen.
"""

* id = "hs-tjanst-ronneby-vardcentral"

// Publik synlighet: destinationIndicator=03
* meta.security[destination-indicator]
  * system = "urn:oid:1.2.752.29.23.1.11"
  * code = #03
  * display = "Internet/allmänheten"

* active = true

* providedBy = Reference(RonnebyVardcentralVardenhet)

* name = "Allmänmedicin Ronneby Vårdcentral"

// ── VPW-textfält ─────────────────────────────────────────────────────────────
// hsaVpwInformation3 → comment ("om oss", stabil beskrivning av enheten)
* comment = "Vi är din fasta läkarkontakt för allmänmedicin och förebyggande vård i Ronneby. Listning görs via 1177.se."

// hsaVpwInformation2 → temporaryNotice (gul informationsruta på 1177, tillfällig)
* extension[temporaryNotice]
  * valueString = "Telefonköerna är kortast tidigt på morgonen (07:30-08:00). Ring gärna vid öppning för snabbare svar."

// hsaVpwInformation4 → patientInfo (information till patient, kan vara Markdown)
* extension[patientInfo]
  * valueString = "Du kan lista dig hos oss via 1177.se. Vi tar emot både bokade besök och drop-in."

// ── Verksamhetskod (category[verksamhetskod]) ─────────────────────────────────
// businessClassificationCode=1502 "Allmänmedicin"
// Sökning: GET /HealthcareService?service-category=urn:oid:1.2.752.129.2.2.1.3|1502
* category[verksamhetskod]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.3"
    * code = #1502
    * display = "Allmänmedicin"

// ── Vård-/omsorgsform (type[care-type]) ──────────────────────────────────────
// hsaCareType=01 "Öppen vård" (primärvård är alltid öppenvård)
* type[care-type]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.13"
    * code = #01
    * display = "Öppen vård"

// ── Koppling till besöksplats ─────────────────────────────────────────────────
* location = Reference(LocationRonnebyVardcentral)

// ── Tillgänglighet (tre block) ────────────────────────────────────────────────
// Block 1: hsaPublicTelephoneHours — Ordinarie telefontider (Mån-Fre 08:00-17:00)
* availability[0]
  * availableTime[0]
    * daysOfWeek[0] = #mon
    * daysOfWeek[1] = #tue
    * daysOfWeek[2] = #wed
    * daysOfWeek[3] = #thu
    * daysOfWeek[4] = #fri
    * availableStartTime = "08:00:00"
    * availableEndTime = "17:00:00"

// Block 2: hsaTelephoneHours — Tidig telefontid (Mån-Fre 07:30-08:00)
// Listas som separat availability för att klienter ska kunna rendera
// "tidig telefontid" som en distinkt visningskategori.
* availability[1]
  * availableTime[0]
    * daysOfWeek[0] = #mon
    * daysOfWeek[1] = #tue
    * daysOfWeek[2] = #wed
    * daysOfWeek[3] = #thu
    * daysOfWeek[4] = #fri
    * availableStartTime = "07:30:00"
    * availableEndTime = "08:00:00"

// Block 3: hsaDropinHours — Drop-in (Mån 13:00-16:00 + Ons 13:00-16:00)
// Selektiva veckodagar — modelleras med specifika days-of-week-poster.
// Drop-in erbjuds ej alla dagar; varje dag med drop-in representeras separat.
* availability[2]
  * availableTime[0]
    * daysOfWeek[0] = #mon
    * availableStartTime = "13:00:00"
    * availableEndTime = "16:00:00"
  * availableTime[1]
    * daysOfWeek[0] = #wed
    * availableStartTime = "13:00:00"
    * availableEndTime = "16:00:00"
