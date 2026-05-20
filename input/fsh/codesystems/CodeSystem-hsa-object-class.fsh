CodeSystem: HsaObjectClass
Id: hsa-object-class
Title: "HSA Objektklassificering"
Description: """
  Klassificering av HSA-objekt baserat på LDAP-objektklasser i HSA-schemat.
  Används för att identifiera om en organisation är vårdgivare, vårdenhet
  eller annan organisatorisk enhet, samt för statusmarkering.
"""
* ^url = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
* ^version = "5.3"
* ^status = #active
* ^experimental = false
* ^date = "2026-03-16"
* ^publisher = "Inera AB / HSA-förvaltning"
* ^jurisdiction = urn:iso:std:iso:3166#SE
* ^caseSensitive = true
* ^content = #complete

// Strukturella vårdklassificeringar (auxiliary object classes i HSA)
* #healthcare-provider
    "Vårdgivare (hsaHealthCareProvider)"
    "Organisation som är markerad som vårdgivare enligt HSA (OID 1.2.752.29.6.10). Representerar yttre spärrnivå i PDL."
* #healthcare-unit
    "Vårdenhet (hsaHealthCareUnit)"
    "Organisation som är markerad som vårdenhet enligt HSA (OID 1.2.752.29.6.13). Representerar inre spärrnivå i PDL."
* #organizational-unit
    "Organisationsenhet"
    "Organisatorisk enhet som varken är vårdgivare eller vårdenhet (LDAP organizationalUnit)."

// Statusmarkeringar
* #hidden
    "Dolt objekt (hiddenObject)"
    "Objektet är dolt och ska inte exponeras i publikt API. Sätts active = false (OID 1.2.752.41.6.107)."
* #archived
    "Arkiverat objekt (hsaArchivedObject)"
    "Objektet är arkiverat. Sätts active = false (OID 1.2.752.29.6.20)."
* #inaccurate-provider
    "Felaktigt utpekad vårdgivare (hsaInaccurateHCP)"
    "Vårdgivaren är felaktigt utpekad (OID 1.2.752.29.6.26)."
* #inaccurate-unit
    "Felaktigt utpekad vårdenhet (hsaInaccurateHCU)"
    "Vårdenheten är felaktigt utpekad (OID 1.2.752.29.6.27)."
* #feigned
    "Fingerat objekt (hsaFeignedDataObject)"
    "Testdata eller fingerat objekt (OID 1.2.752.29.6.25)."
