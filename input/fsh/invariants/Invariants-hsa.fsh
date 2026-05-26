// ─── HSA INVARIANTER ─────────────────────────────────────────────────────────
// Alla maskinkontrollerbara krav uttryckta som FHIRPath-invarianter.

Invariant: hsacat-org-hsa-id
Description: "En organisation från HSA SHALL ha HSA-id (urn:oid:1.2.752.29.4.19)."
Severity: #error
Expression: "identifier.where(system = 'urn:oid:1.2.752.29.4.19').exists()"

Invariant: hsacat-org-hsa-id-format
Description: "HSA-id ska följa formatet SE<org-nr>-<suffix> eller SE<personnr>-<suffix>."
Severity: #warning
Expression: "identifier.where(system = 'urn:oid:1.2.752.29.4.19').value.matches('^SE[0-9]+-[A-Z0-9]+$')"

Invariant: hsacat-provider-orgno
Description: "En organisation markerad som vårdgivare (healthcare-provider) SHALL ha organisationsnummer."
Severity: #error
Expression: "type.coding.where(system = 'https://hsa.inera.se/fhir/CodeSystem/hsa-object-class' and code = 'healthcare-provider').exists() implies identifier.where(system = 'urn:oid:2.5.4.97').exists()"

Invariant: hsacat-subunit-partof
Description: "En organisationsenhet under en annan organisation SHALL ha partOf ifyllt."
Severity: #error
Expression: "type.coding.where(code = 'organizational-unit' or code = 'healthcare-unit').exists() implies partOf.exists()"

Invariant: hsacat-physical-location-address
Description: "En fysisk plats (mode = instance) SHALL ha besöksadress."
Severity: #error
Expression: "mode = 'instance' implies address.where(type = 'physical' or type = 'both').exists()"

Invariant: hsacat-physical-location-city
Description: "En fysisk plats SHALL ha lokalitet (address.city)."
Severity: #error
Expression: "mode = 'instance' implies address.where(type = 'physical' or type = 'both').city.exists()"

Invariant: hsacat-public-location-position
Description: "En fysisk plats som är publik (destination indicator 03) SHOULD ha geografiska koordinater."
Severity: #warning
Expression: "meta.security.where(system = 'urn:oid:1.2.752.29.23.1.11' and code = '03').exists() implies position.exists()"

Invariant: hsacat-digital-service-contact
Description: "En digital HealthcareService SHALL ha telecom eller endpoint."
Severity: #error
Expression: "type.coding.where(code = 'digital').exists() implies (contact.telecom.exists() or endpoint.exists())"

Invariant: hsacat-service-provider
Description: "En HealthcareService SHALL ha providedBy (tillhandahållande organisation)."
Severity: #error
Expression: "providedBy.exists()"

Invariant: hsacat-org-period-end
Description: "Om organization-period är satt SHALL end-datum anges (tillfällig enhet måste ha klart slutdatum)."
Severity: #error
Expression: "extension.where(url = 'http://hl7.org/fhir/StructureDefinition/organization-period').exists() implies extension.where(url = 'http://hl7.org/fhir/StructureDefinition/organization-period').value.ofType(Period).end.exists()"

Invariant: hsacat-public-org-telecom
Description: "En publik organisation (destination indicator 03) SHALL ha direkttelefon."
Severity: #error
Expression: "meta.security.where(system = 'urn:oid:1.2.752.29.23.1.11' and code = '03').exists() implies contact.telecom.where(system = 'phone').exists()"

Invariant: hsacat-inactive-not-public
Description: "En inaktiv organisation (active = false) får inte ha destinationIndicator 03 (publik synlighet)."
Severity: #error
Expression: "active = false implies meta.security.where(system = 'urn:oid:1.2.752.29.23.1.11' and code = '03').exists().not()"

Invariant: hsacat-temporary-notice-requires-period
Description: "Om temporaryNotice (hsaVpwInformation2) är satt bör organization-period också vara satt — klienter förlitar sig på period.end för att veta när den gula informationsrutan ska döljas."
Severity: #warning
Expression: "extension.where(url = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice').exists() implies extension.where(url = 'http://hl7.org/fhir/StructureDefinition/organization-period').exists()"
