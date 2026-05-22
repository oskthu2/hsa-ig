// ─── HSA CapabilityStatements ─────────────────────────────────────────────────
// Två serverkonformansdeklarationer:
//   1. hsa-central-catalog-server  – HSA:s egna källsystem (läsaccess)
//   2. hsa-regional-catalog-server – Regionala mellanlagringsservrar (läs + skriv)
//
// Fyra klientkonformansdeklarationer (beskriver vad klienten förväntar sig av servern):
//   3. hsa-client-1177-hitta-vard  – 1177 Hitta vård (geo-sökning, publik filtrering)
//   4. hsa-client-npo              – Nationell Patientöversikt (arbetsplatskod, hierarki)
//   5. hsa-client-skltp            – SKLTP / Säkerhetstjänster (trädklättring)
//   6. hsa-client-ehr-sync         – EHR-katalogsynk (batchhämtning, inkrementell synk)

// ═══════════════════════════════════════════════════════════════════════════════
// 1. HSA Central Catalog Server – källsystem, läsaccess
// ═══════════════════════════════════════════════════════════════════════════════

Instance: CapabilityStatement-hsa-catalog-server
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Central Catalog Server"
Description: """
  Konformansdeklaration för HSA:s centrala källsystem.
  Exponerar organisationer, platser och vårdtjänster ur HSA-katalogen som FHIR R5-resurser.
  Skrivoperationer (create/update/delete) är inte i scope – data tas emot via LDAP-synk internt.
"""

* id = "hsa-catalog-server"
* url = "https://hsa.inera.se/fhir/CapabilityStatement/hsa-catalog-server"
* version = "0.1.0"
* name = "HsaCatalogServer"
* title = "HSA Central Catalog Server"
* status = #draft
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Serverkonformans för HSA-katalog FHIR R5 API – centralt källsystem."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json
* format[+] = #xml

* rest[+]
  * mode = #server
  * documentation = """
    Läs- och sök-API för HSA-katalogen.
    Publik synlighet filtreras via _security-parametern (destination indicator 03).
    Skrivoperationer stöds inte på detta gränssnitt.
  """

  // ── Organization ─────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * supportedProfile[+] = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"
    * supportedProfile[+] = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"
    * documentation = "Organisationer i HSA-katalogen: vårdgivare, vårdenheter och organisatoriska enheter."
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * readHistory = false
    * updateCreate = false
    * conditionalCreate = false
    * conditionalUpdate = false
    * conditionalDelete = #not-supported
    * referencePolicy[+] = #resolves

    * searchParam[+]
      * name = "_id"
      * type = #token
      * documentation = "Sökning på resurens FHIR-id."
    * searchParam[+]
      * name = "_security"
      * type = #token
      * documentation = "Filtrering på meta.security. Använd `urn:oid:1.2.752.29.23.1.11|03` för publika resurser."
    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
      * documentation = "Filtrering på senaste ändringsdatum (för inkrementell synk)."
    * searchParam[+]
      * name = "identifier"
      * type = #token
      * documentation = "Sökning på valfri identifierare. Prefix: `urn:oid:1.2.752.29.4.19|SE...` för HSA-id."
    * searchParam[+]
      * name = "active"
      * type = #token
      * documentation = "Filtrera på aktiv/inaktiv status."
    * searchParam[+]
      * name = "name"
      * type = #string
      * documentation = "Sökning på organisationsnamn (prefix-match)."
    * searchParam[+]
      * name = "type"
      * type = #token
      * documentation = "Sökning på organisationstyp."
    * searchParam[+]
      * name = "partof"
      * type = #reference
      * documentation = "Sökning på överordnad organisation. Stödjer `_include:iterate` för hierarkisökning."
    * searchParam[+]
      * name = "hsa-id"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-id"
      * type = #token
      * documentation = "Kortform för sökning på HSA-id (system urn:oid:1.2.752.29.4.19)."
    * searchParam[+]
      * name = "hsa-org-class"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class"
      * type = #token
      * documentation = "Sökning på HSA-objektklass (healthcare-provider, healthcare-unit, organizational-unit)."

    * searchInclude[+] = "Organization:partof"
    * searchRevInclude[+] = "Organization:partof"
    * searchRevInclude[+] = "Location:organization"
    * searchRevInclude[+] = "HealthcareService:organization"

  // ── Location ─────────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Location
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"
    * documentation = "Fysiska besöksplatser och mottagningslokaler i HSA-katalogen."
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * readHistory = false
    * updateCreate = false
    * conditionalCreate = false
    * conditionalUpdate = false
    * conditionalDelete = #not-supported

    * searchParam[+]
      * name = "_id"
      * type = #token
    * searchParam[+]
      * name = "_security"
      * type = #token
      * documentation = "Filtrering på destinationIndicator (meta.security)."
    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
    * searchParam[+]
      * name = "identifier"
      * type = #token
    * searchParam[+]
      * name = "status"
      * type = #token
    * searchParam[+]
      * name = "organization"
      * type = #reference
      * documentation = "Filtrering på ansvarig organisation (managingOrganization)."
    * searchParam[+]
      * name = "near"
      * type = #special
      * documentation = "Geo-sökning (position.latitude/longitude). Kräver koordinatstöd på servern."
    * searchParam[+]
      * name = "hsa-id"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-id"
      * type = #token

    * searchInclude[+] = "Location:organization"

  // ── HealthcareService ─────────────────────────────────────────────────────────
  * resource[+]
    * type = #HealthcareService
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"
    * documentation = "Vårdtjänster och tjänsteutbud kopplade till HSA-enheter."
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * readHistory = false
    * updateCreate = false
    * conditionalCreate = false
    * conditionalUpdate = false
    * conditionalDelete = #not-supported

    * searchParam[+]
      * name = "_id"
      * type = #token
    * searchParam[+]
      * name = "_security"
      * type = #token
      * documentation = "Filtrering på destinationIndicator (meta.security)."
    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "organization"
      * type = #reference
      * documentation = "Filtrering på tillhandahållande organisation (providedBy)."
    * searchParam[+]
      * name = "location"
      * type = #reference
      * documentation = "Filtrering på kopplad plats."
    * searchParam[+]
      * name = "service-category"
      * type = #token
      * documentation = "Sökning på verksamhetskod (system urn:oid:1.2.752.129.2.2.1.3)."
    * searchParam[+]
      * name = "service-type"
      * type = #token
      * documentation = "Sökning på vård-/omsorgsform (system urn:oid:1.2.752.129.2.2.1.13)."
    * searchParam[+]
      * name = "hsa-provided-by"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-provided-by"
      * type = #reference

    * searchInclude[+] = "HealthcareService:organization"
    * searchInclude[+] = "HealthcareService:location"


// ═══════════════════════════════════════════════════════════════════════════════
// 2. HSA Regional Catalog Server – mellanlagringsserver (läs + skriv)
// ═══════════════════════════════════════════════════════════════════════════════

Instance: CapabilityStatement-hsa-regional-catalog-server
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Regional Catalog Server"
Description: """
  Konformansdeklaration för regionala och lokala mellanlagringsservrar.
  Dessa servrar speglar HSA-data lokalt för att förbättra svarstider och tillgänglighet.
  Data kan ha laddats via LDAP-synk (ej FHIR) och exponeras sedan som FHIR R5.
  Till skillnad från det centrala HSA-systemet stöder dessa servrar skrivoperationer
  (create, update, delete) och transaktionsbuntar för bulkuppdatering.
"""

* id = "hsa-regional-catalog-server"
* url = "https://hsa.inera.se/fhir/CapabilityStatement/hsa-regional-catalog-server"
* version = "0.1.0"
* name = "HsaRegionalCatalogServer"
* title = "HSA Regional Catalog Server"
* status = #draft
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Serverkonformans för regionala/lokala HSA-mellanlagringsservrar med stöd för LDAP-synkronisering."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json
* format[+] = #xml

* rest[+]
  * mode = #server
  * documentation = """
    Läs- och sök-API kompatibelt med det centrala HSA-systemet, kompletterat med
    skrivoperationer för LDAP-baserad datainläsning.
    Stödjer transaction-buntar för atomär bulkuppdatering vid LDAP-synkronisering.
    Conditional update (PUT by identifier) möjliggör idempotent LDAP→FHIR-synk.
  """

  * interaction[+]
    * code = #transaction
    * documentation = "Stöd för transaction-buntar för atomär bulkuppdatering (LDAP-synk)."
  * interaction[+]
    * code = #batch
    * documentation = "Stöd för batchbuntar för icke-atomär bulkläsning/-skrivning."

  // ── Organization ─────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * supportedProfile[+] = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"
    * supportedProfile[+] = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"
    * documentation = "Organisationer – samma läs-API som centralt system plus skrivoperationer för LDAP-synk."
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * versioning = #no-version
    * readHistory = false
    * updateCreate = true
    * conditionalCreate = false
    * conditionalUpdate = true
    * conditionalDelete = #single
    * referencePolicy[+] = #resolves

    * searchParam[+]
      * name = "_id"
      * type = #token
    * searchParam[+]
      * name = "_security"
      * type = #token
      * documentation = "Filtrering på destinationIndicator (meta.security)."
    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
      * documentation = "Inkrementell synk: hämta resurser ändrade efter en given tidpunkt."
    * searchParam[+]
      * name = "identifier"
      * type = #token
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "name"
      * type = #string
    * searchParam[+]
      * name = "type"
      * type = #token
    * searchParam[+]
      * name = "partof"
      * type = #reference
    * searchParam[+]
      * name = "hsa-id"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-id"
      * type = #token
    * searchParam[+]
      * name = "hsa-org-class"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class"
      * type = #token

    * searchInclude[+] = "Organization:partof"
    * searchRevInclude[+] = "Organization:partof"
    * searchRevInclude[+] = "Location:organization"
    * searchRevInclude[+] = "HealthcareService:organization"

  // ── Location ─────────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Location
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"
    * documentation = "Besöksplatser – samma läs-API som centralt system plus skrivoperationer."
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * versioning = #no-version
    * readHistory = false
    * updateCreate = true
    * conditionalCreate = false
    * conditionalUpdate = true
    * conditionalDelete = #single

    * searchParam[+]
      * name = "_id"
      * type = #token
    * searchParam[+]
      * name = "_security"
      * type = #token
    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
    * searchParam[+]
      * name = "identifier"
      * type = #token
    * searchParam[+]
      * name = "status"
      * type = #token
    * searchParam[+]
      * name = "organization"
      * type = #reference
    * searchParam[+]
      * name = "near"
      * type = #special
    * searchParam[+]
      * name = "hsa-id"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-id"
      * type = #token

    * searchInclude[+] = "Location:organization"

  // ── HealthcareService ─────────────────────────────────────────────────────────
  * resource[+]
    * type = #HealthcareService
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"
    * documentation = "Vårdtjänster – samma läs-API som centralt system plus skrivoperationer."
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * interaction[+].code = #create
    * interaction[+].code = #update
    * interaction[+].code = #delete
    * versioning = #no-version
    * readHistory = false
    * updateCreate = true
    * conditionalCreate = false
    * conditionalUpdate = true
    * conditionalDelete = #single

    * searchParam[+]
      * name = "_id"
      * type = #token
    * searchParam[+]
      * name = "_security"
      * type = #token
    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "organization"
      * type = #reference
    * searchParam[+]
      * name = "location"
      * type = #reference
    * searchParam[+]
      * name = "service-category"
      * type = #token
    * searchParam[+]
      * name = "service-type"
      * type = #token
    * searchParam[+]
      * name = "hsa-provided-by"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-provided-by"
      * type = #reference

    * searchInclude[+] = "HealthcareService:organization"
    * searchInclude[+] = "HealthcareService:location"


// ═══════════════════════════════════════════════════════════════════════════════
// 3. Klientkonformans: 1177 Hitta vård
// ═══════════════════════════════════════════════════════════════════════════════

Instance: CapabilityStatement-hsa-client-1177-hitta-vard
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Klient – 1177 Hitta vård"
Description: """
  Klientkonformansdeklaration för 1177 Hitta vård.
  Dokumenterar vilka FHIR-förmågor servern måste stödja för att 1177-integrationen ska fungera.
  Nyckelkrav: geo-sökning (near), publik filtrering (_security kod 03), hämtning av
  Organization + Location + HealthcareService i ett anrop via _include/_revinclude.
"""

* id = "hsa-client-1177-hitta-vard"
* url = "https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-1177-hitta-vard"
* version = "0.1.0"
* name = "HsaClient1177HittaVard"
* title = "HSA Klient – 1177 Hitta vård"
* status = #draft
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Klientkonformans för 1177 Hitta vård (UC-03): geo-sökning, publik filtrering, visning av öppettider och kontaktuppgifter."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json

* rest[+]
  * mode = #client
  * documentation = """
    1177 Hitta vård använder följande frågemönster:
    1. Geo-sökning: GET /Location?near=[lat]|[lon]|[radius]|km&_security=...03
       med _revinclude=HealthcareService:location&_revinclude=Organization:organization
    2. Namnssökning: GET /Organization?name=[prefix]&hsa-org-class=healthcare-unit&_security=...03
    3. Hämta detaljer: GET /Organization/[id] + separata anrop för Location och HealthcareService
    Alla anrop filtreras på _security=urn:oid:1.2.752.29.23.1.11|03 (publika resurser).
  """

  // ── Organization ─────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * documentation = "Hämtar och visar vårdgivare/vårdenheter. Kräver name, type, active, contact.telecom, contact.address, meta.security."
    * interaction[+].code = #read
    * interaction[+].code = #search-type

    * searchParam[+]
      * name = "_security"
      * type = #token
    * searchParam[+]
      * name = "name"
      * type = #string
      * documentation = "Namnssökning för fritextsök i 1177."
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "hsa-org-class"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class"
      * type = #token
      * documentation = "Filtrera på healthcare-unit för vårdenhetssökning."
    * searchParam[+]
      * name = "partof"
      * type = #reference

    * searchInclude[+] = "Organization:partof"
    * searchRevInclude[+] = "Location:organization"
    * searchRevInclude[+] = "HealthcareService:organization"

  // ── Location ─────────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Location
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"
    * documentation = "Geo-sökning och kartvisning. Kräver position (SWEREF99), address (fysisk, utan postnummer), description (vägbeskrivning)."
    * interaction[+].code = #read
    * interaction[+].code = #search-type

    * searchParam[+]
      * name = "_security"
      * type = #token
    * searchParam[+]
      * name = "near"
      * type = #special
      * documentation = "Geo-sökning är primärt frågemönster för kartvisning."
    * searchParam[+]
      * name = "organization"
      * type = #reference

    * searchInclude[+] = "Location:organization"

  // ── HealthcareService ─────────────────────────────────────────────────────────
  * resource[+]
    * type = #HealthcareService
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"
    * documentation = "Öppettider, verksamhetskod och VPW-texter (Om oss, information till patient, tillfällig info). Kräver availability, category[verksamhetskod], comment, extension[temporaryNotice], extension[patientInfo]."
    * interaction[+].code = #read
    * interaction[+].code = #search-type

    * searchParam[+]
      * name = "_security"
      * type = #token
    * searchParam[+]
      * name = "organization"
      * type = #reference
    * searchParam[+]
      * name = "service-category"
      * type = #token
      * documentation = "Filtrera på verksamhetskod (OID 1.2.752.129.2.2.1.3)."

    * searchInclude[+] = "HealthcareService:organization"
    * searchInclude[+] = "HealthcareService:location"


// ═══════════════════════════════════════════════════════════════════════════════
// 4. Klientkonformans: Nationell Patientöversikt (NPÖ)
// ═══════════════════════════════════════════════════════════════════════════════

Instance: CapabilityStatement-hsa-client-npo
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Klient – Nationell Patientöversikt (NPÖ)"
Description: """
  Klientkonformansdeklaration för NPÖ.
  NPÖ slår upp vårdenhet via arbetsplatskod (APK) och traverserar partOf-kedjan
  uppåt för att fastställa vilken vårdgivare som ansvarar.
  Nyckelkrav: sökning på identifier[apk], _include:iterate för hierarkihämtning.
"""

* id = "hsa-client-npo"
* url = "https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-npo"
* version = "0.1.0"
* name = "HsaClientNpo"
* title = "HSA Klient – Nationell Patientöversikt (NPÖ)"
* status = #draft
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Klientkonformans för NPÖ (UC-02): arbetsplatskodssökning och hierarkihämtning."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json

* rest[+]
  * mode = #client
  * documentation = """
    NPÖ använder följande frågemönster:
    1. Slå upp vårdenhet via APK:
       GET /Organization?identifier=urn:oid:1.2.752.29.4.71|[apk-kod]
    2. Hämta partOf-kedja uppåt:
       GET /Organization?_id=[id]&_include=Organization:partof&_include:iterate=Organization:partof
    Kräver att servern stödjer _include:iterate (rekursiv hierarkihämtning).
  """

  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * documentation = "Kräver: identifier[apk] (OID 1.2.752.29.4.71), identifier[hsa-id], partOf, active. Iterativ _include för fullständig partOf-kedja."
    * interaction[+].code = #read
    * interaction[+].code = #search-type

    * searchParam[+]
      * name = "_id"
      * type = #token
    * searchParam[+]
      * name = "identifier"
      * type = #token
      * documentation = "Sökning på APK (urn:oid:1.2.752.29.4.71|[kod]) och HSA-id (urn:oid:1.2.752.29.4.19|SE...)."
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "partof"
      * type = #reference
    * searchParam[+]
      * name = "hsa-id"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-id"
      * type = #token

    * searchInclude[+] = "Organization:partof"


// ═══════════════════════════════════════════════════════════════════════════════
// 5. Klientkonformans: SKLTP / Säkerhetstjänster (trädklättring)
// ═══════════════════════════════════════════════════════════════════════════════

Instance: CapabilityStatement-hsa-client-skltp
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Klient – SKLTP / Säkerhetstjänster"
Description: """
  Klientkonformansdeklaration för Tjänsteplattformen (SKLTP) och Säkerhetstjänster.
  Dessa system traverserar partOf-kedjan för åtkomstkontroll: givet en vårdenhet
  bestäms ansvarig vårdgivare genom att följa partOf uppåt (trädklättring).
  Nyckelkrav: _include:iterate, sökning på hsa-id och type[hsa-class].
"""

* id = "hsa-client-skltp"
* url = "https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-skltp"
* version = "0.1.0"
* name = "HsaClientSkltp"
* title = "HSA Klient – SKLTP / Säkerhetstjänster"
* status = #draft
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Klientkonformans för SKLTP/säkerhetstjänster: hierarkisk trädklättring via partOf för åtkomstkontroll."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json

* rest[+]
  * mode = #client
  * documentation = """
    SKLTP/säkerhetstjänster använder följande frågemönster:
    1. Hämta enhet och fullständig kedja uppåt:
       GET /Organization?_id=[id]&_include=Organization:partof&_include:iterate=Organization:partof
    2. Hämta alla enheter under en vårdgivare:
       GET /Organization?partof=Organization/[vg-id]&_revinclude=Organization:partof
    3. Söka enhet via HSA-id:
       GET /Organization?hsa-id=SE2321000016-ABC1
    Kräver stöd för _include:iterate och hsa-org-class-parameter.
  """

  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * documentation = "Kräver: identifier[hsa-id], type[hsa-class], partOf, active. Iterativ _include för rekursiv hierarkihämtning."
    * interaction[+].code = #read
    * interaction[+].code = #search-type

    * searchParam[+]
      * name = "_id"
      * type = #token
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "partof"
      * type = #reference
      * documentation = "Trädklättring: kombinera med _include:iterate=Organization:partof."
    * searchParam[+]
      * name = "hsa-id"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-id"
      * type = #token
    * searchParam[+]
      * name = "hsa-org-class"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class"
      * type = #token
      * documentation = "Filtrera på healthcare-provider eller healthcare-unit."

    * searchInclude[+] = "Organization:partof"
    * searchRevInclude[+] = "Organization:partof"


// ═══════════════════════════════════════════════════════════════════════════════
// 6. Klientkonformans: EHR-katalogsynk
// ═══════════════════════════════════════════════════════════════════════════════

Instance: CapabilityStatement-hsa-client-ehr-sync
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Klient – EHR-katalogsynk"
Description: """
  Klientkonformansdeklaration för regionala EHR-system (t.ex. COSMIC, TakeCare)
  som synkroniserar organisationsdata från HSA till ett lokalt cache.
  Stödjer två synklägen:
  - Fullsynk: hämta alla aktiva resurser paginerat (_count)
  - Inkrementell synk: hämta resurser ändrade efter en given tidpunkt (_lastUpdated)
  Nyckelkrav: _lastUpdated, _count (paginering), alla tre resurstyper.
"""

* id = "hsa-client-ehr-sync"
* url = "https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-ehr-sync"
* version = "0.1.0"
* name = "HsaClientEhrSync"
* title = "HSA Klient – EHR-katalogsynk"
* status = #draft
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Klientkonformans för EHR-katalogsynk (UC-01): fullsynk och inkrementell synk av HSA-organisationsdata."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json

* rest[+]
  * mode = #client
  * documentation = """
    EHR-katalogsynk använder följande frågemönster:
    Fullsynk (nattlig):
      GET /Organization?active=true&_count=100  (+ paginering via Bundle.link[next])
      GET /Location?_count=100
      GET /HealthcareService?active=true&_count=100
    Inkrementell synk (händelsedriven):
      GET /Organization?_lastUpdated=gt[tidsstämpel]&_count=100
      GET /Location?_lastUpdated=gt[tidsstämpel]&_count=100
      GET /HealthcareService?_lastUpdated=gt[tidsstämpel]&_count=100
    Kräver att servern stödjer _lastUpdated och korrekt paginering (Bundle.link[next]).
  """

  // ── Organization ─────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * documentation = "Kräver alla profilerade fält: identifier (hsa-id, org-no, apk), name, type, active, contact, partOf, meta.security."
    * interaction[+].code = #read
    * interaction[+].code = #search-type

    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
      * documentation = "Nödvändigt för inkrementell synk."
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "identifier"
      * type = #token
    * searchParam[+]
      * name = "hsa-org-class"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class"
      * type = #token

    * searchInclude[+] = "Organization:partof"

  // ── Location ─────────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Location
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"
    * documentation = "Kräver: address (fysisk), position (SWEREF99), managingOrganization. Synkroniseras parallellt med Organization."
    * interaction[+].code = #read
    * interaction[+].code = #search-type

    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
    * searchParam[+]
      * name = "organization"
      * type = #reference

  // ── HealthcareService ─────────────────────────────────────────────────────────
  * resource[+]
    * type = #HealthcareService
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"
    * documentation = "Kräver: category[verksamhetskod], availability (öppettider), providedBy. Synkroniseras för Encounter.type-mappning (UC-04)."
    * interaction[+].code = #read
    * interaction[+].code = #search-type

    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
    * searchParam[+]
      * name = "active"
      * type = #token
    * searchParam[+]
      * name = "organization"
      * type = #reference
    * searchParam[+]
      * name = "service-category"
      * type = #token
