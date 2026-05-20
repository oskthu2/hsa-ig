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

  Verksamhetskod (businessClassificationCode) modelleras på `category` i
  enlighet med eHMs Nationell katalog-IG (hvo-business-category-inera).
  Vård-/omsorgsform (careType) modelleras på `type` som mer specifik
  tjänsteklassificering.
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

// ── Verksamhetskod på category (HSACAT-TERM-001) ─────────────────────────────
// Verksamhetskod är en bred verksamhetsklassificering (Allmänmedicin, Psykiatri
// etc.) och hör semantiskt hemma på .category. Aligns med eHMs hvo-business-
// category-inera. Konsumenter (t.ex. VGR Encounter.type) kan referera detta
// värde direkt från category-elementet via Encounter.serviceType → HealthcareService.
* category 1..* MS
* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "coding.system"
* category ^slicing.rules = #open
* category ^short = "Verksamhetskod och eventuell nationell tjänstekategori"

* category contains
    verksamhetskod 1..* MS

* category[verksamhetskod]
  * ^short = "Verksamhetskod (businessClassificationCode, HSACAT-TERM-001)"
  * ^definition = """
    HSA verksamhetskod (OID 1.2.752.129.2.2.1.3). Bred klassificering av
    vilken typ av vård/omsorg som bedrivs. Aligns med eHMs hvo-business-
    category-inera (required binding). Kan denormaliseras till Encounter.type
    av konsumenter som VGR.
  """
  * coding 1..*
  * coding.system = "urn:oid:1.2.752.129.2.2.1.3" (exactly)
  * coding from HsaServiceTypeVS (required)

// ── Vård-/omsorgsform på type (HSACAT-SVC-003) ───────────────────────────────
// careType är en mer specifik klassificering (Öppenvård, Sluten vård,
// Hemsjukvård) och hör hemma på .type.
* type MS
* type ^slicing.discriminator.type = #value
* type ^slicing.discriminator.path = "coding.system"
* type ^slicing.rules = #open

* type contains
    care-type 0..* MS

* type[care-type]
  * ^short = "Vård- och omsorgsform (careType, HSACAT-SVC-003)"
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
