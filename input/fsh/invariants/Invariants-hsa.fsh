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
Expression: "extension.where(url = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-destination-indicator').value.ofType(Coding).code = '03' implies position.exists()"

Invariant: hsacat-digital-service-contact
Description: "En digital HealthcareService SHALL ha telecom eller endpoint."
Severity: #error
Expression: "type.coding.where(code = 'digital').exists() implies (telecom.exists() or endpoint.exists())"

Invariant: hsacat-service-provider
Description: "En HealthcareService SHALL ha providedBy (tillhandahållande organisation)."
Severity: #error
Expression: "providedBy.exists()"

Invariant: hsacat-temporary-info-end-date
Description: "Tillfällig information på en enhet SHALL ha obligatoriskt slutdatum."
Severity: #error
Expression: "extension.where(url = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-info').extension.where(url = 'period').value.ofType(Period).end.exists()"

Invariant: hsacat-public-org-telecom
Description: "En publik organisation (destination indicator 03) SHALL ha direkttelefon."
Severity: #error
Expression: "extension.where(url = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-destination-indicator').value.ofType(Coding).code = '03' implies telecom.where(system = 'phone').exists()"
