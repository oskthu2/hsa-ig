// ─── HsaCatalogOrganization ───────────────────────────────────────────────────
// Basprofil för alla organisationer från HSA-katalogen.
// Täcker: HSACAT-ORG-001, 002, 003, 004, 004b, 005, 006, 008, 009, 010

Profile: HsaCatalogOrganization
Parent: Organization
Id: hsa-catalog-organization
Title: "HSA Catalog Organization"
Description: """
  Basprofil för organisationer hämtade ur HSA-katalogen. Täcker
  vårdgivare, vårdenheter och organisatoriska enheter i organisationsträdet.

  Alla HSA-organisationer har ett HSA-id, ett namn och information om
  publicerings- och åtkomststatus. Hierarkin representeras via `partOf`.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^date = "2026-05-20"
* ^publisher = "Inera AB / HSA-IG projekt"
* ^jurisdiction = urn:iso:std:iso:3166#SE

// ── Obey invariants ──────────────────────────────────────────────────────────
* obeys hsacat-org-hsa-id
* obeys hsacat-org-hsa-id-format
* obeys hsacat-provider-orgno
* obeys hsacat-public-org-telecom

// ── Extensions ───────────────────────────────────────────────────────────────
* extension contains
    HsaDestinationIndicatorExtension named destinationIndicator 0..1 MS and
    HsaTemporaryInfoExtension named temporaryInfo 0..1 MS and
    HsaFinancingOrganizationExtension named financingOrganization 0..* MS

// ── Identifier: HSA-id (HSACAT-ORG-001) ─────────────────────────────────────
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^short = "Identifierare för HSA-objektet"

* identifier contains
    hsa-id 1..1 MS and
    org-no 0..1 MS

* identifier[hsa-id]
  * ^short = "HSA-identitet"
  * ^definition = "Unikt, systemgenererat HSA-id. Tilldelas automatiskt vid skapande. Aldrig manuellt satt."
  * system 1..1
  * system = "urn:oid:1.2.752.29.4.19" (exactly)
  * value 1..1 MS

* identifier[org-no]
  * ^short = "Organisationsnummer"
  * ^definition = "Organisationsnummer (obligatoriskt för vårdgivare, se hsacat-provider-orgno)."
  * system 1..1
  * system = "urn:oid:2.5.4.97" (exactly)
  * value 1..1 MS

// ── Active: publiceringsstatus (HSACAT-ORG-008) ───────────────────────────────
* active 1..1 MS
* active ^short = "Publiceringsstatus"
* active ^definition = """
  true = aktiv och synlig; false = dolt (hiddenObject), arkiverat (hsaArchivedObject)
  eller felaktigt utpekad (hsaInaccurateHCP/HCU). Sätts av HSA-systemet.
"""

// ── Name (HSACAT-ORG-003) ────────────────────────────────────────────────────
* name 1..1 MS
* name ^short = "Enhetsnamn / organisationsnamn"
* name ^definition = "Hämtas automatiskt från HSA (ou eller o). Ej manuellt redigerbart via API."

// ── Type: klassificering (HSACAT-ORG-005) ────────────────────────────────────
* type MS
* type ^slicing.discriminator.type = #value
* type ^slicing.discriminator.path = "coding.system"
* type ^slicing.rules = #open
* type ^short = "Organisationstyp och klassificering"

* type contains
    hsa-class 0..1 MS and
    ownership 0..1 MS

* type[hsa-class]
  * ^short = "HSA-objektklassificering (vårdgivare/vårdenhet/org.enhet)"
  * coding 1..*
  * coding.system 1..1
  * coding.system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class" (exactly)
  * coding.code 1..1
  * coding from HsaOrganizationTypeVS (required)

* type[ownership]
  * ^short = "Ägarform (management/regi)"
  * ^definition = "Anger i vilken regi verksamheten bedrivs (HSACAT-ORG-010)."
  * coding 1..*
  * coding.system 1..1
  * coding.system = "urn:oid:1.2.752.129.2.2.1.14" (exactly)
  * coding from HsaOwnershipTypeVS (required)

// ── Telecom: kontaktvägar (HSACAT-ORG-004, 004b) ────────────────────────────
* telecom MS
* telecom ^slicing.discriminator[0].type = #value
* telecom ^slicing.discriminator[=].path = "system"
* telecom ^slicing.discriminator[+].type = #value
* telecom ^slicing.discriminator[=].path = "extension('https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type').value.ofType(Coding).code"
* telecom ^slicing.rules = #open
* telecom ^short = "Kontaktvägar (telefon, e-post m.m.)"

* telecom contains
    direct-phone 0..1 MS and
    switchboard   0..1 MS and
    email         0..1 MS and
    directory-contact 0..1 MS

* telecom[direct-phone]
  * ^short = "Direkttelefon (obligatorisk för publik enhet)"
  * system = #phone (exactly)
  * value 1..1
  * extension[HsaTelecomTypeExtension].valueCoding = HsaTelecomType#direct-phone

* telecom[switchboard]
  * ^short = "Växeltelefon (obligatorisk för offentlig enhet, ej privata)"
  * system = #phone (exactly)
  * value 1..1
  * extension[HsaTelecomTypeExtension].valueCoding = HsaTelecomType#switchboard

* telecom[email]
  * ^short = "E-postadress"
  * system = #email (exactly)
  * value 1..1

* telecom[directory-contact]
  * ^short = "Innehållsansvarigs e-post (hsaDirectoryContact)"
  * system = #email (exactly)
  * value 1..1
  * extension[HsaTelecomTypeExtension].valueCoding = HsaTelecomType#directory-contact

// ── Address (HSACAT-LOC-005) ─────────────────────────────────────────────────
* address MS
* address ^slicing.discriminator.type = #value
* address ^slicing.discriminator.path = "type"
* address ^slicing.rules = #open

* address contains
    postal 0..1 MS and
    physical 0..1 MS

* address[postal]
  * ^short = "Postadress"
  * type = #postal (exactly)
  * line 0..*
  * postalCode 0..1
  * city 0..1

* address[physical]
  * ^short = "Besöksadress (utan postnummer)"
  * type = #physical (exactly)
  * line 1..*
  * city 1..1
  * postalCode 0..0   // Besöksadress ska aldrig ha postnummer (Uppsala-regel)

// ── PartOf: hierarki (HSACAT-ORG-002, 006) ───────────────────────────────────
* partOf MS
* partOf only Reference(HsaCatalogOrganization)
* partOf ^short = "Överordnad organisation i HSA-trädet"
* partOf ^definition = "Referens till överordnad organisation. Obligatorisk för underenheter."
