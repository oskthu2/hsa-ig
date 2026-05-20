// ─── HsaHealthcareService ────────────────────────────────────────────────────
// Krav: HSACAT-SVC-001, 002, 003, 004, 005; HSACAT-TERM-001

Profile: HsaHealthcareService
Parent: HealthcareService
Id: hsa-healthcare-service
Title: "HSA Healthcare Service"
Description: """
  Profil för vårdtjänster och tjänsteutbud från HSA-katalogen.
  Verksamhetskod och vård-/omsorgsform är obligatoriska för enheter som
  bedriver vård.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"
* ^version = "0.1.0"
* ^status = #draft
* ^date = "2026-05-20"
* ^publisher = "Inera AB / HSA-IG projekt"
* ^jurisdiction = urn:iso:std:iso:3166#SE

* obeys hsacat-service-provider
* obeys hsacat-digital-service-contact

* extension contains
    HsaDestinationIndicatorExtension named destinationIndicator 0..1 MS and
    HsaTemporaryInfoExtension named temporaryInfo 0..1 MS

* active 1..1 MS

* providedBy 1..1 MS
* providedBy only Reference(HsaCatalogOrganization)
* providedBy ^short = "Tillhandahållande organisation (obligatorisk)"

* category MS

* type MS
* type ^slicing.discriminator.type = #value
* type ^slicing.discriminator.path = "coding.system"
* type ^slicing.rules = #open

* type contains
    service-type 0..* MS and
    care-type    0..* MS

* type[service-type]
  * ^short = "Verksamhetskod (HSACAT-TERM-001)"
  * coding 1..*
  * coding.system = "urn:oid:1.2.752.129.2.2.1.3" (exactly)
  * coding from HsaServiceTypeVS (required)

* type[care-type]
  * ^short = "Vård- och omsorgsform (HSACAT-SVC-003)"
  * coding 1..*
  * coding.system = "urn:oid:1.2.752.129.2.2.1.13" (exactly)
  * coding from HsaCareTypeVS (required)

* name MS
* comment MS
* comment ^short = "Beskrivning ('Om oss' på 1177)"

* location MS
* location only Reference(HsaCatalogLocation)

// I R5 ersattes telecom av contact (ExtendedContactDetail) och availableTime
// av availability (Availability-datatypen).
* contact MS
* contact ^short = "Kontaktuppgifter för tjänsten"

* availability MS
* availability ^short = "Tillgänglighet / öppettider"
* availability.availableTime MS
* availability.availableTime ^short = "Öppettider per veckodag"

* endpoint MS
