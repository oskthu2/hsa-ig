// ─── HSA CapabilityStatements ─────────────────────────────────────────────────
// Dessa deklarationer är exempel på hur ett HSA FHIR-API kan se ut.
// De är inte formellt antagna krav och HSA har inga beslutade planer
// på att implementera detta gränssnitt. Deklarationerna illustrerar
// möjliga integrationsmönster och kan användas som utgångspunkt för
// diskussion och vidare specifikation.
//
// Två serverexempel:
//   1. hsa-central-catalog-server  – möjligt centralt källsystem (läsaccess)
//   2. hsa-regional-catalog-server – möjligt regionalt mellanlager (en hypotes)
//
// Fyra klientexempel (illustrerar vilka FHIR-förmågor respektive scenario kan använda):
//   3. hsa-client-1177-hitta-vard  – 1177 Hitta vård
//   4. hsa-client-npo              – Nationell Patientöversikt
//   5. hsa-client-hierarchy-traversal – Hierarkitraversering
//   6. hsa-client-ehr-sync         – EHR-katalogsynk

// ═══════════════════════════════════════════════════════════════════════════════
// 1. HSA Central Catalog Server – exempel på centralt källsystem med läsaccess
// ═══════════════════════════════════════════════════════════════════════════════

Instance: CapabilityStatement-hsa-catalog-server
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Central Catalog Server"
Description: """
  Exempel på hur ett centralt HSA-källsystem kan exponera organisationer, platser
  och vårdtjänster som FHIR R5-resurser med läsaccess.
  I detta mönster hanteras datainläsning internt (t.ex. via LDAP) och FHIR-gränssnittet
  används enbart för läsning och sökning av katalogdata.
  Detta är ett möjligt upplägg, inte ett beslutat krav.
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
* description = "Exempel på serverförmågor för ett centralt HSA-katalog FHIR R5 API med läsaccess."
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
      * documentation = "Geo-sökning (position.latitude/longitude). Förutsätter koordinatstöd på servern."
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
// 2. HSA Regional Catalog Server – hypotes: regionalt mellanlager med läs + skriv
// ═══════════════════════════════════════════════════════════════════════════════

Instance: CapabilityStatement-hsa-regional-catalog-server
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Regional Catalog Server (hypotes)"
Description: """
  Illustrerar ett möjligt mönster för regionala och lokala system som vill
  spegla HSA-data lokalt för förbättrade svarstider och lokal tillgänglighet.

  Detta är en hypotes, inte ett beslutad arkitektur. Det är oklart om regionerna
  vill använda detta mönster, och om de gör det kan de ha andra krav på hur
  datainläsning ska fungera.

  En möjlig utformning: data läses in från LDAP och exponeras som FHIR R5.
  Skrivoperationer (create, update, delete) och transaktionsbuntar kan underlätta
  synkronisering, men hur det faktiskt ska fungera bör beslutas i dialog med
  berörda regioner.
"""

* id = "hsa-regional-catalog-server"
* url = "https://hsa.inera.se/fhir/CapabilityStatement/hsa-regional-catalog-server"
* version = "0.1.0"
* name = "HsaRegionalCatalogServer"
* title = "HSA Regional Catalog Server (hypotes)"
* status = #draft
* experimental = true
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Hypotetiskt exempel på ett regionalt/lokalt mellanlager för HSA-data med stöd för både läsning och skrivning."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json
* format[+] = #xml

* rest[+]
  * mode = #server
  * documentation = """
    En möjlig utformning kombinerar läs-API:et från det centrala exemplet med
    skrivoperationer för att möjliggöra datainläsning från LDAP eller andra källor.
    Transaktionsbuntar kan användas för bulkuppdatering och conditional update
    (PUT by identifier) kan möjliggöra idempotent LDAP→FHIR-synkronisering.
    Hur detta faktiskt ska fungera i regionala system är en öppen fråga.
  """

  * interaction[+]
    * code = #transaction
    * documentation = "Transaction-buntar kan möjliggöra atomär bulkuppdatering vid LDAP-synkronisering."
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
  Illustrerar vilka FHIR-förmågor ett system för publik vårdsökning (t.ex. 1177 Hitta vård)
  kan ha nytta av. Exemplet visar möjliga frågemönster för geo-sökning, publik filtrering
  och hämtning av Organization, Location och HealthcareService.
  Detta är ett illustrativt exempel på hur ett sådant scenario kan se ut.
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
* description = "Illustrativt exempel för 1177 Hitta vård (UC-03): möjliga FHIR-förmågor för geo-sökning, publik filtrering och visning av öppettider."
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
    * documentation = "Hämtar och visar vårdgivare/vårdenheter. Relevanta fält: name, type, active, contact.telecom, contact.address, meta.security."
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
    * documentation = "Geo-sökning och kartvisning. Använder position (SWEREF99), address (fysisk, utan postnummer), description (vägbeskrivning)."
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
    * documentation = "Öppettider, verksamhetskod och VPW-texter (Om oss, information till patient, tillfällig info). Använder availability, category[verksamhetskod], comment, extension[temporaryNotice], extension[patientInfo]."
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
  Illustrerar vilka FHIR-förmågor ett NPÖ-liknande scenario kan ha nytta av.
  Exemplet visar hur en vårdenhet kan slås upp via arbetsplatskod (APK) och hur
  partOf-kedjan kan traverseras uppåt för att fastställa ansvarig vårdgivare.
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
* description = "Illustrativt exempel för NPÖ (UC-02): möjliga förmågor för arbetsplatskodssökning och hierarkihämtning."
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
    Scenariot förutsätter att servern har stöd för _include:iterate (rekursiv hierarkihämtning).
  """

  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * documentation = "Använder identifier[apk] (OID 1.2.752.29.4.71), identifier[hsa-id], partOf, active. Iterativ _include för fullständig partOf-kedja."
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
// 5. Klientkonformans: Hierarkitraversering (partOf-trädklättring)
//    Täcker behov från SKLTP, Säkerhetstjänster och andra system som använder
//    Organization.partOf för åtkomstkontroll eller hierarkisökning.
//    OBS: Full SKLTP TAK Endpoint-profilering är planerad för v2.
// ═══════════════════════════════════════════════════════════════════════════════

Instance: CapabilityStatement-hsa-client-hierarchy-traversal
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Klient – Hierarkitraversering"
Description: """
  Klientkonformansdeklaration för system som traverserar Organization.partOf-kedjan
  för åtkomstkontroll eller hierarkisökning (HSACAT-ORG-006, HSACAT-ORG-015).

  Primära konsumenter i v1:
  - Tjänsteplattformen (SKLTP): bestämmer ansvarig vårdgivare via trädklättring
  - Säkerhetstjänster: prövning av SJF-behörighet längs partOf-kedjan

  OBS: Full SKLTP TAK-integration (Endpoint-resurs, logisk adressering) är planerad
  för v2 och täcks inte av denna IG. Det här exemplet illustrerar enbart
  Organization.partOf-traversering.

  För att scenariot ska fungera behöver servern ha stöd för _include:iterate=Organization:partof
  så att hela hierarkin kan hämtas i ett anrop (se HSACAT-ORG-006).
"""

* id = "hsa-client-hierarchy-traversal"
* url = "https://hsa.inera.se/fhir/CapabilityStatement/hsa-client-hierarchy-traversal"
* version = "0.1.0"
* name = "HsaClientHierarchyTraversal"
* title = "HSA Klient – Hierarkitraversering"
* status = #draft
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Illustrativt exempel för hierarkitraversering via Organization.partOf. Visar möjliga frågemönster för SKLTP-liknande trädklättring; full Endpoint-profilering planeras till v2."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json

* rest[+]
  * mode = #client
  * documentation = """
    System som traverserar partOf-kedjan för åtkomstkontroll använder:
    1. Hämta enhet och fullständig kedja uppåt (SKLTP explicit/hierarkisk behörighet):
       GET /Organization?_id=[id]
         &_include=Organization:partof
         &_include:iterate=Organization:partof
    2. Hämta alla enheter under en vårdgivare (subträdssökning):
       GET /Organization?partof=Organization/[vg-id]
         &_revinclude=Organization:partof
    3. Söka enhet via HSA-id (logisk adress = HSA-id i SKLTP):
       GET /Organization?hsa-id=SE2321000016-ABC1
    Scenariot förutsätter att servern har stöd för _include:iterate så att trädklättringen
    kan terminera korrekt (partOf-kedjan är acyklisk och terminerar i rotnod utan partOf,
    se HSACAT-ORG-015).
  """

  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * documentation = "Använder identifier[hsa-id], type[hsa-class], partOf, active. Iterativ _include möjliggör rekursiv hierarkihämtning (HSACAT-ORG-006)."
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
      * documentation = "Trädklättring: kombinera med _include:iterate=Organization:partof (HSACAT-ORG-006)."
    * searchParam[+]
      * name = "hsa-id"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-id"
      * type = #token
      * documentation = "Logisk adress = HSA-id i SKLTP TAK."
    * searchParam[+]
      * name = "hsa-org-class"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class"
      * type = #token
      * documentation = "Filtrera på healthcare-provider (yttre spärr) eller healthcare-unit (inre spärr)."

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

  Täcker två användningsfall:
  - UC-01: EHR-katalogsynk – hämta och cachelagra Organization, Location, HealthcareService
  - UC-04: VGR Encounter.type – slå upp HealthcareService.category[verksamhetskod]
    för en given vårdenhet vid Encounter-dokumentation

  Stödjer två synklägen:
  - Fullsynk: hämta alla aktiva resurser paginerat (_count)
  - Inkrementell synk: hämta resurser ändrade efter en given tidpunkt (_lastUpdated)
  Nyckelaspekter: _lastUpdated för inkrementell synk, _count för paginering, alla tre resurstyper.
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
* description = "Illustrativt exempel för EHR-katalogsynk (UC-01) och Encounter.type-mappning (UC-04): möjliga förmågor för fullsynk och inkrementell synk av HSA-organisationsdata."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json

* rest[+]
  * mode = #client
  * documentation = """
    UC-01 EHR-katalogsynk använder följande frågemönster:
    Fullsynk (nattlig):
      GET /Organization?active=true&_count=100  (+ paginering via Bundle.link[next])
      GET /Location?_count=100
      GET /HealthcareService?active=true&_count=100
    Inkrementell synk (händelsedriven):
      GET /Organization?_lastUpdated=gt[tidsstämpel]&_count=100
      GET /Location?_lastUpdated=gt[tidsstämpel]&_count=100
      GET /HealthcareService?_lastUpdated=gt[tidsstämpel]&_count=100
    Scenariot förutsätter att servern har stöd för _lastUpdated och korrekt paginering (Bundle.link[next]).

    UC-04 VGR Encounter.type-mappning (on-demand):
      GET /HealthcareService?organization=Organization/[id]&service-category=[verksamhetskod]
    Verksamhetskod (OID 1.2.752.129.2.2.1.3) är tillgänglig direkt på
    HealthcareService.category utan transformation (ADR-011).
  """

  // ── Organization ─────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * documentation = "Använder alla profilerade fält: identifier (hsa-id, org-no, apk), name, type, active, contact, partOf, meta.security."
    * interaction[+].code = #read
    * interaction[+].code = #search-type

    * searchParam[+]
      * name = "_lastUpdated"
      * type = #date
      * documentation = "Möjliggör inkrementell synk baserat på ändringstidpunkt."
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
    * documentation = "Använder address (fysisk), position (SWEREF99), managingOrganization. Synkroniseras parallellt med Organization."
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
    * documentation = "Använder category[verksamhetskod], availability (öppettider), providedBy. Synkroniseras för möjlig Encounter.type-mappning (UC-04)."
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
