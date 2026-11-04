// ─── HSA-SPECIFIKA EXTENSIONS ────────────────────────────────────────────────
// Endast extensions som saknar standard-FHIR-alternativ.
//
// BORTTAGNA (ersatta av standard-FHIR-mekanismer, ADR-012):
//   HsaDestinationIndicatorExtension → meta.security
//   HsaAdministrativeCareLevelExtension → Organization.type[care-level]
//   HsaNavigationExtension → Location.description (Markdown)
//   HsaTemporaryInfoExtension (komplex) → organization-period + HsaTemporaryNoticeExtension
//   (HsaTemporaryNoticeExtension är sedan ADR-013 komplex med text + visningsperiod)

Extension: HsaFinancingOrganizationExtension
Id: hsa-financing-organization
Title: "HSA Finansierande region/kommun"
Description: """
  Den eller de regioner/kommuner som finansierar vården vid enheten.
  Mappar till LDAP-attributet financingOrganization (OID 1.2.752.129.5.1.1).
  Koden är den finansierande organisationens organisationsnummer, t.ex.
  232100-0081 (Informationsspecifikation HSA 11.3.13), inte ett HSA-id.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-financing-organization"
* ^context[+].type = #element
* ^context[=].expression = "Organization"
* value[x] only Coding
* valueCoding from urn:oid:1.2.752.129.5.1.1 (preferred)


Extension: HsaTelecomTypeExtension
Id: hsa-telecom-type
Title: "HSA Kontaktvägstyp"
Description: """
  Klassificerar kontaktvägstyp för att skilja direkttelefon från
  växeltelefon, publik telefon, innehållsansvarig e-post m.fl.
  Mappar till LDAP-kontexten (telephoneNumber, hsaSwitchboardNumber etc.).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type"
* ^context[+].type = #element
* ^context[=].expression = "ContactPoint"
* value[x] only Coding
* valueCoding from HsaTelecomTypeVS (extensible)


Extension: HsaTemporaryNoticeExtension
Id: hsa-temporary-notice
Title: "HSA Tillfällig information"
Description: """
  Tillfällig information om enheten, visas som gul informationsruta på enhetens
  kontaktkort på 1177.se. Mappar till LDAP-attributet hsaVpwInformation2.

  I HSA kan texten inledas med visningsperiod: `;ÅÅÅÅMMDD;ÅÅÅÅMMDD;text`
  (Informationsspecifikation HSA 11.3.72). Servern tolkar prefixet, lägger
  datumen i `period` och resten i `text`. Perioden gäller meddelandet, inte
  organisationen; organisationens giltighetstid ligger i organization-period
  (startDate/endDate).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice"
* ^context[+].type = #element
* ^context[=].expression = "Organization"
* ^context[+].type = #element
* ^context[=].expression = "HealthcareService"
* obeys hsacat-temporary-notice-no-prefix
* extension contains
    text 1..1 MS and
    period 0..1 MS
* extension[text]
  * ^short = "Informationstexten, utan datumprefix"
  * value[x] 1..1
  * value[x] only string
* extension[period]
  * ^short = "Visningsperiod (datumprefixet i hsaVpwInformation2)"
  * ^definition = """
    Period då informationen ska visas. `start` och `end` anges som datum
    (ÅÅÅÅ-MM-DD) och båda är inklusive. Saknas `end` visas informationen tills
    vidare; saknas `start` visas den direkt.
  """
  * value[x] 1..1
  * value[x] only Period
* value[x] 0..0


Extension: HsaAvailabilityTypeExtension
Id: hsa-availability-type
Title: "HSA Tidtyp"
Description: """
  Anger vilket HSA-tidsattribut (surgeryHours, telephoneHours, dropInHours,
  visitingHours) en tillgänglighetspost kommer från. R5 Availability saknar
  typelement (ADR-016).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-type"
* ^context[+].type = #element
* ^context[=].expression = "Availability"
* value[x] 1..1
* value[x] only Coding
* valueCoding from HsaAvailabilityTypeVS (required)


Extension: HsaAvailabilityCommentExtension
Id: hsa-availability-comment
Title: "HSA Kommentar till öppettid"
Description: """
  Kommentaren i ett tidsattribut (surgeryHours, telephoneHours, dropInHours,
  visitingHours), t.ex. `Provtagning` i `2-5#08:00#12:15#Provtagning`.
  Max 19 tecken (Informationsspecifikation HSA 11.3.101).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-comment"
* ^context[+].type = #element
* ^context[=].expression = "Availability"
* obeys hsacat-availability-comment-length
* value[x] 1..1
* value[x] only string


Extension: HsaAvailabilityPeriodExtension
Id: hsa-availability-period
Title: "HSA Giltighetsperiod för öppettid"
Description: """
  Datumintervallet i ett tidsattribut, t.ex. `20261223#20261223` i
  `1-7#08:00#12:30#Halvdag#20261223#20261223`. Används för avvikande
  öppettider. Saknas `end` gäller tiden tills vidare. R5 Availability saknar
  eget periodelement och hl7.fhir.uv.extensions.r5 har ingen motsvarighet.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-period"
* ^context[+].type = #element
* ^context[=].expression = "Availability"
* value[x] 1..1
* value[x] only Period


Extension: HsaPatientInfoExtension
Id: hsa-patient-info
Title: "HSA Information till patient"
Description: """
  Informationstext riktad till patient som visas på enhetens 1177-sida.
  Mappar till LDAP-attributet hsaVpwInformation4.
  Klienter bör rendera som Markdown.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info"
* ^context[+].type = #element
* ^context[=].expression = "Organization"
* ^context[+].type = #element
* ^context[=].expression = "HealthcareService"
* value[x] only string
