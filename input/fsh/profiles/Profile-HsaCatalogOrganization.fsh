// ─── HsaCatalogOrganization ───────────────────────────────────────────────────
// Basprofil för alla organisationer från HSA-katalogen.
// Täcker: HSACAT-ORG-001, 002, 003, 004, 004b, 005, 006, 008, 009, 010, 012, 013

Alias: $orgPeriod = http://hl7.org/fhir/StructureDefinition/organization-period

Profile: HsaCatalogOrganization
Parent: Organization
Id: hsa-catalog-organization
Title: "HSA Catalog Organization"
Description: """
  Basprofil för organisationer hämtade ur HSA-katalogen. Täcker
  vårdgivare, vårdenheter och organisatoriska enheter i organisationsträdet.

  Alla HSA-organisationer har ett HSA-id, ett namn och information om
  publicerings- och åtkomststatus. Hierarkin representeras via `partOf`.

  **Synlighet (destinationIndicator):** Modelleras som `meta.security[destination-indicator]`
  med system `urn:oid:1.2.752.29.23.1.11`. Kod 03 = Internet/allmänheten.
  Klienter som 1177 Hitta vård bör filtrera på detta fält.

  **Tillfällig information:** En enhet med tidsbegränsad status använder
  `extension[orgPeriod]` (organization-period) med start och obligatoriskt end.
  Klienter bör rendera en visuell varningsindikator (t.ex. gul informationsruta)
  när orgPeriod är satt och `active = true`. Varje klient ansvarar för att
  texten som ska visas hämtas från ett lämpligt fält (t.ex. Organization.contact
  med purpose = "TEMP" eller IG-sida för klientkonventioner).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
* ^version = "0.1.0"
* ^status = #draft
* ^experimental = true
* ^date = "2026-05-20"
* ^publisher = "Inera AB / HSA-IG projekt"
* ^jurisdiction = urn:iso:std:iso:3166#SE

// ── Obey invarianter ──────────────────────────────────────────────────────────
* obeys hsacat-org-hsa-id
* obeys hsacat-org-hsa-id-format
* obeys hsacat-provider-orgno
* obeys hsacat-public-org-telecom
* obeys hsacat-org-period-end

// ── Extensions ───────────────────────────────────────────────────────────────
* extension contains
    $orgPeriod named orgPeriod 0..1 MS and
    HsaTemporaryNoticeExtension named temporaryNotice 0..1 MS and
    HsaPatientInfoExtension named patientInfo 0..1 MS and
    HsaFinancingOrganizationExtension named financingOrganization 0..* MS

* extension[temporaryNotice]
  * ^short = "Tillfällig information (hsaVpwInformation2)"
  * ^definition = """
    Fri text som visas som gul informationsruta på 1177. Ska kombineras med
    extension[orgPeriod] (organization-period) som anger giltighetstid.
    Klienter bör rendera visuell varningsindikator när detta fält är satt.
  """

* extension[patientInfo]
  * ^short = "Information till patient (hsaVpwInformation4)"
  * ^definition = "Informationstext riktad direkt till patient. Visas på 1177-sidan. Klienter bör rendera som Markdown."

* extension[orgPeriod]
  * ^short = "Organisationens giltighetsperiod (t.ex. tillfällig enhet)"
  * ^definition = """
    Sätts när enheten är aktiv under en begränsad period. Period.end är obligatoriskt
    (invariant hsacat-org-period-end). Klienter ska rendera en visuell varningsindikator
    när detta fält är satt och `active = true`.
  """
  * value[x] only Period
  * valuePeriod.end 1..1

// ── Synlighet: meta.security (HSACAT-ORG-009) ────────────────────────────────
* meta.security MS
* meta.security ^slicing.discriminator.type = #value
* meta.security ^slicing.discriminator.path = "system"
* meta.security ^slicing.rules = #open
* meta.security ^short = "Åtkomstkontroll och publiceringsscope"

* meta.security contains
    destination-indicator 0..1 MS

* meta.security[destination-indicator]
  * ^short = "Publik synlighet (hsaDestinationIndicator, OID 1.2.752.29.23.1.11)"
  * ^definition = "Kod 03 = Internet/allmänheten. Anger att enheten är synlig på t.ex. 1177 Hitta vård."
  * system = "urn:oid:1.2.752.29.23.1.11" (exactly)
  * code from HsaDestinationIndicatorVS (required)

// ── Identifier: HSA-id (HSACAT-ORG-001) ─────────────────────────────────────
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^short = "Identifierare för HSA-objektet"

* identifier contains
    hsa-id 1..1 MS and
    org-no 0..1 MS and
    apk 0..1 MS and
    gln 0..1 MS

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

// Arbetsplatskod (HSACAT-ORG-012): LDAP-attribut unitPrescriptionCode.
// OID preliminärt 1.2.752.29.4.71 – ska verifieras mot Ineras OID-register (öppen fråga 8).
* identifier[apk]
  * ^short = "Arbetsplatskod (unitPrescriptionCode, NPÖ-relevant)"
  * ^definition = "Arbetsplatskod som NPÖ använder för att identifiera en vårdenhet i GetHealthCareUnitMembers. LDAP: unitPrescriptionCode. OID att bekräfta (HSACAT-ORG-012, öppen fråga 8)."
  * system 1..1
  * system = "urn:oid:1.2.752.29.4.71" (exactly)
  * value 1..1 MS

// GLN-kod (HSACAT-ORG-014): Global Location Number. LDAP-attribut hsaGlnCode.
// Bevaras i testdata (SRC-026). Förekommer på Organisation och Enhet.
* identifier[gln]
  * ^short = "GLN-kod (hsaGlnCode)"
  * ^definition = "Global Location Number (GS1). Används för att identifiera organisationer och platser i logistik- och vårdinformationssystem. LDAP: hsaGlnCode."
  * system 1..1
  * system = "urn:oid:1.3.88" (exactly)
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

// ── Type: klassificering (HSACAT-ORG-005, 009) ───────────────────────────────
* type MS
* type ^slicing.discriminator.type = #value
* type ^slicing.discriminator.path = "coding.system"
* type ^slicing.rules = #open
* type ^short = "Organisationstyp och klassificering"

* type contains
    hsa-class 0..1 MS and
    ownership 0..1 MS and
    care-level 0..1 MS and
    business-type 0..1 MS

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

* type[care-level]
  * ^short = "Administrativ vårdnivå (HSACAT-ORG-009)"
  * ^definition = """
    Kod som anger administrativ specialiseringsnivå i hälso- och sjukvård.
    Obligatorisk (1..1) för vårdenheter (HsaHealthcareUnitOrganization).
    LDAP: careLevel. System: OID 1.2.752.129.5.1.46.
  """
  * coding 1..*
  * coding.system 1..1
  * coding.system = "urn:oid:1.2.752.129.5.1.46" (exactly)
  * coding from urn:oid:1.2.752.129.5.1.46 (required)

* type[business-type]
  * ^short = "Enhetstyp (hsaBusinessType, HSACAT-ORG-015)"
  * ^definition = """
    Anger typ av enhet eller organisation (t.ex. sjukhus, vårdcentral, apotek).
    LDAP: hsaBusinessType. System: OID 1.2.752.129.2.2.1.12.
  """
  * coding 1..*
  * coding.system 1..1
  * coding.system = "urn:oid:1.2.752.129.2.2.1.12" (exactly)
  * coding from HsaBusinessTypeVS (required)

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
* contact.telecom ^definition = """
  Kontaktvägar inklusive telefon, e-post och URL. LDAP-attribut inkluderar:
  telephoneNumber (direkttelefon), hsaSwitchboardNumber (växel),
  mobile (mobil), facsimileTelephoneNumber (fax), mail (e-post),
  hsaDirectoryContact (innehållsansvarig), labeledURI (webbadress),
  hsaVpwWebpage (länk till 1177-kontaktkort, system=#url).
"""
* contact.telecom.extension contains HsaTelecomTypeExtension named telecomType 0..1 MS
* contact.address MS
* contact.address ^short = "Postadress eller besöksadress"
* contact.address.type MS

// ── PartOf: hierarki (HSACAT-ORG-002, 006) ───────────────────────────────────
* partOf MS
* partOf only Reference(HsaCatalogOrganization)
* partOf ^short = "Överordnad organisation i HSA-trädet"
* partOf ^definition = "Referens till överordnad organisation. Obligatorisk för underenheter."
