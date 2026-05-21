ValueSet: HsaOrganizationTypeVS
Id: hsa-organization-type
Title: "HSA Organisationstyp"
Description: """
  Tillåtna klassificeringar för Organization.type i HSA-profiler.
  Kombinerar HSA-objektklasser (vårdgivare/vårdenhet) med enhetstyp-kodverk
  (sjukhus, vårdcentral, apotek).
"""
* ^url = "https://hsa.inera.se/fhir/ValueSet/hsa-organization-type"
* ^status = #active
* ^experimental = false
* ^date = "2026-05-20"
* ^jurisdiction = urn:iso:std:iso:3166#SE

// HSA-objektklasser (strukturell klassificering)
* include codes from system HsaObjectClass
    where concept is-a #healthcare-provider
* include codes from system HsaObjectClass
    where concept is-a #healthcare-unit
* include codes from system HsaObjectClass
    where concept is-a #organizational-unit

// Enhetstyp (hsaBusinessType OID 1.2.752.129.2.2.1.12)
* include codes from system urn:oid:1.2.752.129.2.2.1.12


ValueSet: HsaBusinessTypeVS
Id: hsa-business-type
Title: "HSA Enhetstyp (hsaBusinessType)"
Description: """
  Enhetstyp för organisation eller enhet i HSA.
  System: HSA enhetstyp-kodverk (OID 1.2.752.129.2.2.1.12).
  Typiska värden: sjukhus, vårdcentral, apotek m.fl.
"""
* ^url = "https://hsa.inera.se/fhir/ValueSet/hsa-business-type"
* ^status = #active
* ^experimental = false
* ^date = "2026-05-21"
* ^jurisdiction = urn:iso:std:iso:3166#SE
* include codes from system urn:oid:1.2.752.129.2.2.1.12


ValueSet: HsaOwnershipTypeVS
Id: hsa-ownership-type
Title: "HSA Ägarform"
Description: """
  Tillåtna koder för ägarform (management/regi) på Organization.
  System: HSA ägarform-kodverk (OID 1.2.752.129.2.2.1.14).
"""
* ^url = "https://hsa.inera.se/fhir/ValueSet/hsa-ownership-type"
* ^status = #active
* ^experimental = false
* ^date = "2026-05-20"
* ^jurisdiction = urn:iso:std:iso:3166#SE
* include codes from system urn:oid:1.2.752.129.2.2.1.14


ValueSet: HsaDestinationIndicatorVS
Id: hsa-destination-indicator
Title: "HSA Visas för (hsaDestinationIndicator)"
Description: """
  Koder för visningsscope i HSA (hsaDestinationIndicator).
  Kod 03 = Internet/allmänheten = publik visning på t.ex. 1177 Hitta vård.
  System: OID 1.2.752.29.23.1.11.
"""
* ^url = "https://hsa.inera.se/fhir/ValueSet/hsa-destination-indicator"
* ^status = #active
* ^experimental = false
* ^date = "2026-05-20"
* ^jurisdiction = urn:iso:std:iso:3166#SE
* include codes from system urn:oid:1.2.752.29.23.1.11


ValueSet: HsaCareTypeVS
Id: hsa-care-type
Title: "HSA Vård- och omsorgsform (careType)"
Description: """
  Tillåtna koder för vård- och omsorgsform (careType).
  Obligatorisk för vårdenheter.
  System: OID 1.2.752.129.2.2.1.13.
  Kända värden: 01=Öppen vård, 02=Sluten vård, 03=Hemsjukvård, 04=Socialtjänst.
"""
* ^url = "https://hsa.inera.se/fhir/ValueSet/hsa-care-type"
* ^status = #active
* ^experimental = false
* ^date = "2026-05-20"
* ^jurisdiction = urn:iso:std:iso:3166#SE
* include codes from system urn:oid:1.2.752.129.2.2.1.13


ValueSet: HsaServiceTypeVS
Id: hsa-service-type
Title: "HSA Verksamhetskod (businessClassificationCode)"
Description: """
  Tillåtna verksamhetskoder för HealthcareService.type.
  System: HSA verksamhetskod-kodverk (OID 1.2.752.129.2.2.1.3).
  Faktiska kodvärden hämtas från Terminologitjänsten (terminologitjansten.inera.se).
  Jämförs med eHMs Nationella vårdtjänster v.1.0.0 (SRC-014).
"""
* ^url = "https://hsa.inera.se/fhir/ValueSet/hsa-service-type"
* ^status = #active
* ^experimental = false
* ^date = "2026-05-20"
* ^jurisdiction = urn:iso:std:iso:3166#SE
* include codes from system urn:oid:1.2.752.129.2.2.1.3
