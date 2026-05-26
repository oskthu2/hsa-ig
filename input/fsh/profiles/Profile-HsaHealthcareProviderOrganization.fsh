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

  Representerar den yttre spärrnivån i PDL-sammanhang. Alla vårdenheter
  under en vårdgivare delar journalspärr på VG-nivå — det är därför
  `partOf` på vårdenhetsprofilen alltid pekar direkt hit.

  **Identifierare (minimum 2):**
  Profilen kräver alltid *både* HSA-id och organisationsnummer:
  - `identifier[hsa-id]` (1..1) — systemgenererat, unikt inom HSA.
  - `identifier[org-no]` (1..1) — juridisk identitet; krävs av NPÖ och
    PDL-infrastrukturen för att koppla journaler till rätt VG (HSACAT-ORG-007).
  - `identifier[apk]` (0..0) — arbetsplatskod är alltid en vårdenhetskod
    (unitPrescriptionCode i LDAP-schemat) och får aldrig sättas på VG.
  - `identifier[gln]` (0..1) — förekommer på VG som har GLN-registrering.

  **Must Support:** Alla MS-flaggor ärvs från `HsaCatalogOrganization` och
  visas i snapshot-vyn. Denna profil deklarerar enbart restriktioner som
  tillkommer utöver basprofilens definition.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"
* ^version = "0.1.0"
* ^status = #draft

// Organisationsnummer är obligatoriskt för vårdgivare (HSACAT-ORG-007)
* identifier[org-no] 1..1

// APK (unitPrescriptionCode) tilldelas per vårdenhet i LDAP-schemat — aldrig på VG-nivå.
* identifier[apk] 0..0

// Typ ska vara healthcare-provider
* type[hsa-class].coding.code = #healthcare-provider (exactly)
* type[hsa-class] 1..1

// Namn alltid obligatoriskt
* name 1..1


// ─── HsaHealthcareUnitOrganization ───────────────────────────────────────────
// Profil för vårdenhet (hsaHealthCareUnit). Representerar inre spärrnivå.
// Krav: HSACAT-ORG-001, 002, 003, 005, 006, 009

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

// partOf är obligatorisk för vårdenhet (HSACAT-ORG-002, HSACAT-ORG-006).
// Mappar till LDAP-attributet hsaResponsibleHealthCareProvider som på
// vårdenhetsobjektet pekar ut ansvarig vårdgivares HSA-id.
// Tjänsteplattformens trädklättring (TAK) traverserar denna kedja uppåt
// (SRC-024/025) – partOf MÅSTE peka direkt på en HsaHealthcareProviderOrganization.
* partOf 1..1
* partOf only Reference(HsaHealthcareProviderOrganization)

// Administrativ vårdnivå obligatorisk för vårdenheter (HSACAT-ORG-009).
// Modelleras som type[care-level]-slice (OID 1.2.752.129.5.1.46).
* type[care-level] 1..1
