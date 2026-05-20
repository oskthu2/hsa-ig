// ─── HsaCatalogOrganization ───────────────────────────────────────────────────
// Basprofil för alla organisationer från HSA-katalogen.
// Täcker: HSACAT-ORG-001, 002, 003, 004, 004b, 005, 006, 008, 009, 010, 012, 013

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
    org-no 0..1 MS and
    apk 0..1 MS

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

// Arbetsplatskod (HSACAT-ORG-012): används av NPÖ GetHealthCareUnitMembers.
// OID preliminärt 1.2.752.29.4.71 – ska verifieras mot Ineras OID-register (öppen fråga 8).
* identifier[apk]
  * ^short = "Arbetsplatskod (NPÖ-relevant)"
  * ^definition = "Arbetsplatskod som NPÖ använder för att identifiera en vårdenhet i GetHealthCareUnitMembers. OID att bekräfta (HSACAT-ORG-012, öppen fråga 8)."
  * system 1..1
  * system = "urn:oid:1.2.752.29.4.71" (exactly)
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

// ── Contact: kontaktvägar och adress (HSACAT-ORG-004, 004b, LOC-005, ORG-013) ──
// I FHIR R5 finns inte telecom/address direkt på Organization; de ligger
// under contact-backbonen. Varje contact-post kan ha purpose, telecom och address.
//
// Adressövergång (ADR-010, HSACAT-ORG-013):
// HSA 5.2+ introducerade strukturerade adressattribut (hsaPostalAddress,
// hsaVisitingAddress) som ersätter legacy (postalAddress, streetAddress).
// Övergångsperiod gäller t.o.m. sept 2026; normativ form är strukturerade
// komponenter (Address.line / .city / .postalCode). Legacy-data mappas till
// Address.text under övergångsperioden.
* contact MS
* contact ^short = "Kontaktinformation (telefon, adress m.m.)"
* contact ^definition = """
  Kontaktuppgifter för organisationen. Använd extension HsaTelecomTypeExtension
  på contact.telecom för att klassificera kontaktvägstypen
  (direkttelefon, växel, e-post, innehållsansvarig m.fl.).
"""
* contact.telecom MS
* contact.telecom ^short = "Kontaktvägar"
* contact.telecom.extension contains HsaTelecomTypeExtension named telecomType 0..1 MS
* contact.address MS
* contact.address ^short = "Postadress eller besöksadress"
* contact.address.type MS

// ── PartOf: hierarki (HSACAT-ORG-002, 006) ───────────────────────────────────
* partOf MS
* partOf only Reference(HsaCatalogOrganization)
* partOf ^short = "Överordnad organisation i HSA-trädet"
* partOf ^definition = "Referens till överordnad organisation. Obligatorisk för underenheter."
