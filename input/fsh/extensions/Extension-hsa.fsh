// ─── HSA-SPECIFIKA EXTENSIONS ────────────────────────────────────────────────
// Endast extensions som saknar standard-FHIR-alternativ.
//
// BORTTAGNA (ersatta av standard-FHIR-mekanismer, ADR-012):
//   HsaDestinationIndicatorExtension → meta.security
//   HsaAdministrativeCareLevelExtension → Organization.type[care-level]
//   HsaNavigationExtension → Location.description (Markdown)
//   HsaTemporaryInfoExtension (komplex) → organization-period + HsaTemporaryNoticeExtension

Extension: HsaFinancingOrganizationExtension
Id: hsa-financing-organization
Title: "HSA Finansierande region/kommun"
Description: """
  Den eller de regioner/kommuner som finansierar vården vid enheten.
  Mappar till LDAP-attributet financingOrganization (OID 1.2.752.129.5.1.1).
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
Title: "HSA Tillfällig information (text)"
Description: """
  Fri text för tillfällig information om enheten, visas som gul informationsruta
  på enhetens kontaktkort på 1177.se. Mappar till LDAP-attributet
  hsaVpwInformation2. Slutdatum hanteras separat via organization-period
  (http://hl7.org/fhir/StructureDefinition/organization-period).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice"
* ^context[+].type = #element
* ^context[=].expression = "Organization"
* ^context[+].type = #element
* ^context[=].expression = "HealthcareService"
* value[x] only string


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
