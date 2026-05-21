// ─── HSA SearchParameters ────────────────────────────────────────────────────
// Definierar sökparametrar utöver FHIR R5:s standardparametrar.
//
// Standard-parametrar som INTE definieras här men deklareras i
// CapabilityStatement (räcker att referera dem):
//   _id, _security, identifier, active, name, type, partof, organization,
//   _include, _revinclude
//
// Tre custom-parametrar motiveras av HSA-specifika system-OID:er
// och vanliga frågemönster:

// ── 1. hsa-id ────────────────────────────────────────────────────────────────
// Sökning enbart på HSA-id (system urn:oid:1.2.752.29.4.19).
// Kompletterar standard-identifier (som kräver systemprefix i query-strängen)
// med en kortare form: GET /Organization?hsa-id=SE2321000016-ABC1

Instance: SearchParameter-hsa-id
InstanceOf: SearchParameter
Usage: #definition
Title: "HSA-id"
Description: "Sökning på HSA-identitet (hsaIdentity, OID 1.2.752.29.4.19)."

* id = "hsa-id"
* url = "https://hsa.inera.se/fhir/SearchParameter/hsa-id"
* version = "0.1.0"
* name = "HsaId"
* status = #active
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Sökning på HSA-id-identifieraren (system = urn:oid:1.2.752.29.4.19)."
* code = #hsa-id
* base[+] = #Organization
* base[+] = #Location
* base[+] = #HealthcareService
* type = #token
* expression = "identifier.where(system = 'urn:oid:1.2.752.29.4.19').value"
* multipleOr = true
* multipleAnd = false


// ── 2. hsa-org-class ─────────────────────────────────────────────────────────
// Sökning på HSA-objektklassificering (vårdgivare, vårdenhet, org.enhet).
// Underlättar filtrering utan att behöva ange fullt system-prefix i type-parametern.
// GET /Organization?hsa-org-class=healthcare-unit

Instance: SearchParameter-hsa-org-class
InstanceOf: SearchParameter
Usage: #definition
Title: "HSA Organisationsklass"
Description: "Sökning på HSA-objektklassificering (type[hsa-class], CodeSystem HsaObjectClass)."

* id = "hsa-org-class"
* url = "https://hsa.inera.se/fhir/SearchParameter/hsa-org-class"
* version = "0.1.0"
* name = "HsaOrgClass"
* status = #active
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Sökning på HSA-objektklassificering. Filtrerar på type.coding med system = 'https://hsa.inera.se/fhir/CodeSystem/hsa-object-class'."
* code = #hsa-org-class
* base[+] = #Organization
* type = #token
* expression = "type.coding.where(system = 'https://hsa.inera.se/fhir/CodeSystem/hsa-object-class')"
* multipleOr = true
* multipleAnd = false


// ── 3. hsa-provided-by ───────────────────────────────────────────────────────
// Sökning på HealthcareService.providedBy (referens till tillhandahållande org).
// Basresursen har standard-parametern "organization" men den kräver referens-URL;
// denna parameter tillåter sökning på Organization-id direkt.
// GET /HealthcareService?hsa-provided-by=Organization/vardenhet-example

Instance: SearchParameter-hsa-provided-by
InstanceOf: SearchParameter
Usage: #definition
Title: "HSA Tillhandahållande organisation"
Description: "Sökning på HealthcareService.providedBy (tillhandahållande organisation)."

* id = "hsa-provided-by"
* url = "https://hsa.inera.se/fhir/SearchParameter/hsa-provided-by"
* version = "0.1.0"
* name = "HsaProvidedBy"
* status = #active
* experimental = false
* date = "2026-05-21"
* publisher = "Inera AB / HSA-IG projekt"
* description = "Filtrera HealthcareService på providedBy-referens (tillhandahållande organisation)."
* code = #hsa-provided-by
* base[+] = #HealthcareService
* type = #reference
* expression = "HealthcareService.providedBy"
* target[+] = #Organization
* multipleOr = true
* multipleAnd = false
