// ─── HSA-SPECIFIKA EXTENSIONS ────────────────────────────────────────────────
// Endast extensions som saknar standard-FHIR-alternativ.
//
// BORTTAGNA (ersatta av standard-FHIR-mekanismer):
//   HsaDestinationIndicatorExtension → meta.security (Coding-array)
//   HsaAdministrativeCareLevelExtension → Organization.type[care-level] (slice)
//   HsaNavigationExtension → Location.description (Markdown-konvention)
//   HsaTemporaryInfoExtension → organization-period HL7-extension + active/text

Extension: HsaFinancingOrganizationExtension
Id: hsa-financing-organization
Title: "HSA Finansierande region/kommun"
Description: """
  Den eller de regioner/kommuner som finansierar vården vid enheten.
  Obligatorisk i VGR (KIV) för enheter med regionavtal.
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
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type"
* ^context[+].type = #element
* ^context[=].expression = "ContactPoint"
* value[x] only Coding
* valueCoding from HsaTelecomTypeVS (extensible)
