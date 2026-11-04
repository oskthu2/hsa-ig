// ─── HSA INVARIANTER ─────────────────────────────────────────────────────────
// Alla maskinkontrollerbara krav uttryckta som FHIRPath-invarianter.

Invariant: hsacat-org-hsa-id
Description: "En organisation från HSA SHALL ha HSA-id (urn:oid:1.2.752.29.4.19)."
Severity: #error
Expression: "identifier.where(system = 'urn:oid:1.2.752.29.4.19').exists()"

// ─── FORMATREGLER ENLIGT HSA:S VITLISTNING ──────────────────────────────────
// Källa: Informationsspecifikation för Katalogtjänst HSA 3.5.1, kap. 11
// (SRC-027). Specens reguljära uttryck är skrivna för Java och matchar hela
// strängen; här är de ankrade med ^…$ och omskrivna utan lookahead och
// backslash-escapes så att de fungerar i alla FHIRPath-motorer.

Invariant: hsacat-hsa-id-format
Description: "HSA-id består av 1–31 tecken: siffror, bokstäver a–z/A–Z och bindestreck (Informationsspecifikation HSA 11.10.5)."
Severity: #error
Expression: "identifier.where(system = 'urn:oid:1.2.752.29.4.19').all(value.matches('^[a-zA-Z0-9-]{1,31}$'))"

Invariant: hsacat-orgno-format
Description: "Organisationsnummer, även finansierande organisation, anges som sex siffror, bindestreck och fyra siffror, t.ex. 232100-0081 (orgNo 11.3.88, financingOrganization 11.3.13)."
Severity: #error
Expression: "identifier.where(system = 'urn:oid:2.5.4.97').all(value.matches('^[0-9]{6}-[0-9]{4}$')) and extension('https://hsa.inera.se/fhir/StructureDefinition/hsa-financing-organization').value.ofType(Coding).all(code.matches('^[0-9]{6}-[0-9]{4}$'))"

Invariant: hsacat-gln-format
Description: "GLN-kod består av exakt 13 siffror (hsaGlnCode, Informationsspecifikation HSA 11.3.37)."
Severity: #error
Expression: "identifier.where(system = 'urn:oid:1.3.88').all(value.matches('^[0-9]{13}$'))"

Invariant: hsacat-phone-format
Description: "Telefon- och faxnummer lagras utan mellanslag och bindestreck och inleds med +, 11, 020 eller 0771, t.ex. +46455731700 (Informationsspecifikation HSA 11.3.103). Formatering för visning är klientens ansvar."
Severity: #error
Expression: "contact.telecom.where(system = 'phone' or system = 'fax').all(value.matches('^([+][0-9]{1,31}|11[0-9]{0,30}|020[0-9]{0,29}|0771[0-9]{0,28})$'))"

Invariant: hsacat-postal-code-format
Description: "Postnummer lagras utan mellanslag, t.ex. 37185 (postalCode 11.3.95; strukturerad adress kräver exakt fem siffror)."
Severity: #error
Expression: "contact.address.postalCode.all(matches('^[a-zA-Z0-9]+$'))"

Invariant: hsacat-vpw-webpage-format
Description: "Länk till 1177-kontaktkort (hsaVpwWebPage) har formen https://www.1177.se/Hitta-vard/Kontakt/?hsaid=<HSA-id> och pekar på objektets eget HSA-id (Informationsspecifikation HSA 11.3.75)."
Severity: #error
Expression: "contact.telecom.where(extension('https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type').value.ofType(Coding).code = 'vpw-webpage').all(value.matches('^https?://www[.]1177[.]se/Hitta-vard/Kontakt/[?]hsaid=[a-zA-Z0-9-]{1,31}$') and value.endsWith('hsaid=' + %resource.identifier.where(system = 'urn:oid:1.2.752.29.4.19').value.first()))"

Invariant: hsacat-destination-indicator-format
Description: "Kod för hsaDestinationIndicator består av två siffror (Informationsspecifikation HSA 11.3.32)."
Severity: #error
Expression: "meta.security.where(system = 'urn:oid:1.2.752.29.23.1.11').all(code.matches('^[0-9]{2}$'))"

Invariant: hsacat-business-type-format
Description: "Enhetstyp (hsaBusinessType) anges med två siffror (Informationsspecifikation HSA 11.3.28)."
Severity: #error
Expression: "type.coding.where(system = 'urn:oid:1.2.752.129.2.2.1.12').all(code.matches('^[0-9]{2}$'))"

Invariant: hsacat-service-code-format
Description: "Verksamhetskod (businessClassificationCode) anges med fyra siffror och vård- och omsorgsform (careType) med två siffror (Informationsspecifikation HSA 11.3.3 och 11.3.5)."
Severity: #error
Expression: "category.coding.where(system = 'urn:oid:1.2.752.129.2.2.1.3').all(code.matches('^[0-9]{4}$')) and type.coding.where(system = 'urn:oid:1.2.752.129.2.2.1.13').all(code.matches('^[0-9]{2}$'))"

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
Description: "Tillfällig information (hsaVpwInformation2) bör ha en egen visningsperiod så att klienter vet när den gula informationsrutan ska döljas (ADR-013)."
Severity: #warning
Expression: "extension('https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice').all(extension('period').exists())"

Invariant: hsacat-temporary-notice-no-prefix
Description: "Datumprefixet ;ÅÅÅÅMMDD;ÅÅÅÅMMDD; i hsaVpwInformation2 ska tolkas till period och tas bort ur texten (ADR-013)."
Severity: #warning
Expression: "extension('text').value.ofType(string).all(startsWith(';').not())"

Invariant: hsacat-availability-comment-length
Description: "Kommentaren i ett tidsattribut är högst 19 tecken (Informationsspecifikation HSA 11.3.101)."
Severity: #error
Expression: "value.ofType(string).all(length() <= 19)"

Invariant: hsacat-availability-time-order
Description: "Sluttid ska vara senare än starttid; HSA tillåter inte att dygnsgränsen passeras (ADR-014)."
Severity: #error
Expression: "availability.availableTime.all((availableStartTime.exists() and availableEndTime.exists()) implies availableStartTime < availableEndTime)"

Invariant: hsacat-availability-allday-no-times
Description: "En öppettid med allDay = true (00:00–24:00 i HSA) anger inga klockslag (ADR-014)."
Severity: #error
Expression: "availability.availableTime.all(allDay.where($this = true).exists() implies (availableStartTime.empty() and availableEndTime.empty()))"

Invariant: hsacat-position-sweden
Description: "Position anges i WGS84 decimalgrader inom Sverige (latitud 55–70, longitud 10–25). Fångar oomräknade SWEREF99 TM-meter och omkastade koordinater (ADR-015)."
Severity: #warning
Expression: "position.exists() implies (position.latitude >= 55 and position.latitude <= 70 and position.longitude >= 10 and position.longitude <= 25)"
