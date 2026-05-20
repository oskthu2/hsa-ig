// ─── HsaHealthcareProviderOrganization ───────────────────────────────────────
// Profil för vårdgivare (hsaHealthCareProvider).
// Krav: HSACAT-ORG-001, 003, 007, 008

Profile: HsaHealthcareProviderOrganization
Parent: HsaCatalogOrganization
Id: hsa-healthcare-provider-organization
Title: "HSA Healthcare Provider Organization"
Description: """
  Profil för organisation markerad som vårdgivare (hsaHealthCareProvider,
  OID 1.2.752.29.6.10) i HSA-katalogen.

  Representerar yttre spärrnivå i PDL-sammanhang.
  Ska ha organisationsnummer (HSACAT-ORG-007).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"
* ^version = "0.1.0"
* ^status = #draft

// Organisationsnummer är obligatoriskt för vårdgivare (HSACAT-ORG-007)
* identifier[org-no] 1..1

// Typ ska vara healthcare-provider
* type[hsa-class].coding.code = #healthcare-provider (exactly)
* type[hsa-class] 1..1

// Namn alltid obligatoriskt
* name 1..1


// ─── HsaHealthcareUnitOrganization ───────────────────────────────────────────
// Profil för vårdenhet (hsaHealthCareUnit). Representerar inre spärrnivå.
// Krav: HSACAT-ORG-001, 002, 003, 005, 006

Profile: HsaHealthcareUnitOrganization
Parent: HsaCatalogOrganization
Id: hsa-healthcare-unit-organization
Title: "HSA Healthcare Unit Organization"
Description: """
  Profil för organisation markerad som vårdenhet (hsaHealthCareUnit,
  OID 1.2.752.29.6.13) i HSA-katalogen.

  Representerar inre spärrnivå i PDL-sammanhang. Ska alltid ha en
  referens till överordnad organisation (partOf → HsaHealthcareProviderOrganization).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"
* ^version = "0.1.0"
* ^status = #draft

* obeys hsacat-subunit-partof

// Typ ska vara healthcare-unit
* type[hsa-class].coding.code = #healthcare-unit (exactly)
* type[hsa-class] 1..1

// partOf är obligatorisk för vårdenhet
* partOf 1..1
* partOf only Reference(HsaHealthcareProviderOrganization)

// Administrativ vårdnivå (SHOULD) – deklareras här eftersom basprofilens
// extension-contains inte inkluderar denna extension.
* extension contains HsaAdministrativeCareLevelExtension named adminCareLevel 0..1 MS
