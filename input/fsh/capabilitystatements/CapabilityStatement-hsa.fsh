// ─── HSA CapabilityStatement ──────────────────────────────────────────────────
// Deklarerar vad en HSA-IG-konform server SKA stödja.
// Baseras på FHIR R5.

Instance: CapabilityStatement-hsa-server
InstanceOf: CapabilityStatement
Usage: #definition
Title: "HSA Katalog Server"
Description: """
  Konformansdeklaration för en HSA-IG-konform serverimplementation.
  Servern exponerar organisationer, platser och vårdtjänster ur HSA-katalogen
  som FHIR R5-resurser.
"""

* id = "hsa-catalog-server"
* url = "https://hsa.inera.se/fhir/CapabilityStatement/hsa-catalog-server"
* version = "0.1.0"
* name = "HsaCatalogServer"
* title = "HSA Katalog Server"
* status = #draft
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Serverkonformans för HSA-katalog FHIR R5 API."
* kind = #requirements
* fhirVersion = #5.0.0
* format[+] = #json
* format[+] = #xml

* rest[+]
  * mode = #server
  * documentation = """
    Servern implementerar ett läs- och sök-API för HSA-katalogen.
    Skrivoperationer (create/update/delete) är inte i scope för v1.
    Publik synlighet filtreras via _security-parametern (destination indicator 03).
  """

  // ── Organization ─────────────────────────────────────────────────────────────
  * resource[+]
    * type = #Organization
    * profile = "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization"
    * supportedProfile[+] = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"
    * supportedProfile[+] = "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"
    * documentation = "Organisationer i HSA-katalogen. Inkluderar vårdgivare, vårdenheter och organisatoriska enheter."
    * interaction[+].code = #read
    * interaction[+].code = #search-type
    * versioning = #no-version
    * readHistory = false
    * updateCreate = false
    * conditionalCreate = false
    * conditionalUpdate = false
    * conditionalDelete = #not-supported
    * referencePolicy[+] = #resolves

    // SHALL: basala sökparametrar
    * searchParam[+]
      * name = "_id"
      * type = #token
      * documentation = "Sökning på resurens FHIR-id."
    * searchParam[+]
      * name = "_security"
      * type = #token
      * documentation = "Filtrering på meta.security. Använd `_security=urn:oid:1.2.752.29.23.1.11|03` för att hämta publika resurser (destinationIndicator)."
    * searchParam[+]
      * name = "identifier"
      * type = #token
      * documentation = "Sökning på valfri identifierare. Använd systemprefix: `identifier=urn:oid:1.2.752.29.4.19|SE...` för HSA-id."
    * searchParam[+]
      * name = "active"
      * type = #token
      * documentation = "Filtrering på aktiv/inaktiv status."
    * searchParam[+]
      * name = "name"
      * type = #string
      * documentation = "Sökning på organisationsnamn (prefix-match)."
    * searchParam[+]
      * name = "type"
      * type = #token
      * documentation = "Sökning på organisationstyp. Använd systemprefix: `type=https://hsa.inera.se/fhir/CodeSystem/hsa-object-class|healthcare-unit`."
    * searchParam[+]
      * name = "partof"
      * type = #reference
      * documentation = "Sökning på överordnad organisation (partOf-referens). Stödjer hierarkisökning. Kombinera med `_include=Organization:partof`."

    // SHOULD: HSA-specifika parametrar
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

    // _include
    * searchInclude[+] = "Organization:partof"
    * searchRevInclude[+] = "Organization:partof"
    * searchRevInclude[+] = "Location:organization"
    * searchRevInclude[+] = "HealthcareService:organization"

  // ── Location ──────────────────────────────────────────────────────────────────
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
      * documentation = "Sökning på verksamhetskod (category[verksamhetskod], system urn:oid:1.2.752.129.2.2.1.3)."
    * searchParam[+]
      * name = "service-type"
      * type = #token
      * documentation = "Sökning på vård-/omsorgsform (type[care-type], system urn:oid:1.2.752.129.2.2.1.13)."
    * searchParam[+]
      * name = "hsa-provided-by"
      * definition = "https://hsa.inera.se/fhir/SearchParameter/hsa-provided-by"
      * type = #reference

    * searchInclude[+] = "HealthcareService:organization"
    * searchInclude[+] = "HealthcareService:location"
