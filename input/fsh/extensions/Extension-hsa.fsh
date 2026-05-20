// ─── HSA-SPECIFIKA EXTENSIONS ────────────────────────────────────────────────

Extension: HsaDestinationIndicatorExtension
Id: hsa-destination-indicator
Title: "HSA Visas för (hsaDestinationIndicator)"
Description: """
  Anger vilka konsumenter som får se information om objektet.
  Kod 03 = Internet/allmänheten = publik visning (t.ex. 1177 Hitta vård).
  Mappar till LDAP-attributet hsaDestinationIndicator (OID 1.2.752.29.23.1.11).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-destination-indicator"
* ^context[+].type = #element
* ^context[=].expression = "Organization"
* ^context[+].type = #element
* ^context[=].expression = "HealthcareService"
* ^context[+].type = #element
* ^context[=].expression = "Location"
* value[x] only Coding
* valueCoding from HsaDestinationIndicatorVS (required)


Extension: HsaAdministrativeCareLevelExtension
Id: hsa-administrative-care-level
Title: "HSA Administrativ vårdnivå"
Description: """
  Kod som anger nivå av specialisering i hälso- och sjukvård (administrativ
  vårdnivå). Obligatorisk för vårdenheter. OID 1.2.752.129.5.1.46.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-administrative-care-level"
* ^context[+].type = #element
* ^context[=].expression = "Organization"
* value[x] only Coding
* valueCoding from urn:oid:1.2.752.129.5.1.46 (required)


Extension: HsaFinancingOrganizationExtension
Id: hsa-financing-organization
Title: "HSA Finansierande region/kommun"
Description: """
  Den eller de regioner/kommuner som finansierar vården vid enheten.
  Obligatorisk i VGR (KIV) för enheter med regionavtal.
  Mappar till LDAP-attributet financingOrganization (OID 1.2.752.129.5.1.1).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-financing-organization"
* ^context[+].type = #element
* ^context[=].expression = "Organization"
* value[x] only Coding
* valueCoding from urn:oid:1.2.752.129.5.1.1 (preferred)


Extension: HsaTemporaryInfoExtension
Id: hsa-temporary-info
Title: "HSA Tillfällig information"
Description: """
  Tillfällig information som visas på enhetens kontaktkort på 1177.se.
  Visas under enhetsnamn och besöksadress som gul informationsruta.
  Slutdatum är obligatoriskt; informationen rensas automatiskt vid passerat datum.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-info"
* ^context[+].type = #element
* ^context[=].expression = "Organization"
* ^context[+].type = #element
* ^context[=].expression = "HealthcareService"
* extension contains
    text 1..1 and
    period 1..1
* extension[text].value[x] only string
* extension[period].value[x] only Period
* extension[period].valuePeriod.end 1..1


Extension: HsaNavigationExtension
Id: hsa-navigation
Title: "HSA Vägbeskrivning (inre/yttre)"
Description: """
  Yttre vägbeskrivning (hur man hittar till platsen) och inre vägbeskrivning
  (plan, våning etc.).
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-navigation"
* ^context[+].type = #element
* ^context[=].expression = "Location"
* extension contains
    outer 0..1 and
    inner 0..1
* extension[outer].value[x] only string
* extension[inner].value[x] only string


Extension: HsaTelecomTypeExtension
Id: hsa-telecom-type
Title: "HSA Kontaktvägstyp"
Description: """
  Klassificerar kontaktvägstyp för att skilja direkttelefon från
  växeltelefon, publik telefon, innehållsansvarig e-post m.fl.
"""
* ^url = "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type"
* ^context[+].type = #element
* ^context[=].expression = "ContactPoint"
* value[x] only Coding
* valueCoding from HsaTelecomTypeVS (extensible)
