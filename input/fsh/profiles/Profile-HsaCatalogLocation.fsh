// ─── HsaCatalogLocation ──────────────────────────────────────────────────────
// Profil för platser från HSA-katalogen.
// Krav: HSACAT-LOC-001, 002, 003, 004, 005, 006

Profile: HsaCatalogLocation
Parent: Location
Id: hsa-catalog-location
Title: "HSA Catalog Location"
Description: """
  Profil för platser hämtade ur HSA-katalogen. Representerar fysiska
  besöksplatser, mottagningar och vårdlokaler.

  Fysiska platser måste ha besöksadress (gatuadress + stad) och
  en referens till ansvarig organisation. Koordinater (SWEREF99) krävs
  för offentlig publicering på 1177 Hitta vård.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"
* ^version = "0.1.0"
* ^status = #draft
* ^date = "2026-05-20"
* ^publisher = "Inera AB / HSA-IG projekt"
* ^jurisdiction = urn:iso:std:iso:3166#SE

// ── Invarianter ───────────────────────────────────────────────────────────────
* obeys hsacat-physical-location-address
* obeys hsacat-physical-location-city
* obeys hsacat-public-location-position

// ── Extensions ────────────────────────────────────────────────────────────────
* extension contains
    HsaNavigationExtension named navigation 0..1 MS and
    HsaDestinationIndicatorExtension named destinationIndicator 0..1 MS

// ── Identifier: HSA-id ────────────────────────────────────────────────────────
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open

* identifier contains hsa-id 0..1 MS

* identifier[hsa-id]
  * ^short = "HSA-identitet för platsobjektet"
  * system = "urn:oid:1.2.752.29.4.19" (exactly)
  * value 1..1 MS

// ── Status ────────────────────────────────────────────────────────────────────
* status MS
* status ^short = "Aktiv/inaktiv status för platsen"

// ── Name ──────────────────────────────────────────────────────────────────────
* name MS
* name ^short = "Platsens namn"

// ── Mode ─────────────────────────────────────────────────────────────────────
* mode MS
* mode ^short = "instance = fysisk plats"

// ── Address (HSACAT-LOC-001, 004, 005) ───────────────────────────────────────
* address 1..1 MS
* address ^short = "Besöksadress (fysisk)"
* address ^definition = """
  Enhetens besöksadress (typ=physical). Ska aldrig innehålla postnummer
  (Uppsala-regel; postnummer hör till postadress på Organization).
"""
* address.type = #physical (exactly)
* address.line 1..* MS
* address.city 1..1 MS
* address.postalCode 0..0   // Besöksadress ska aldrig ha postnummer

// ── Position (HSACAT-LOC-003) ─────────────────────────────────────────────────
* position MS
* position ^short = "Geografiska koordinater (SWEREF99)"
* position ^definition = """
  Latitud och longitud enligt SWEREF99 TM. Obligatoriskt för platser synliga
  för allmänheten (destination indicator 03) för att synas på karta i 1177.
"""
* position.latitude MS
* position.longitude MS
* position.altitude 0..0

// ── ManagingOrganization (HSACAT-LOC-002) ────────────────────────────────────
* managingOrganization 1..1 MS
* managingOrganization only Reference(HsaCatalogOrganization)
* managingOrganization ^short = "Ansvarig organisation för platsen"
