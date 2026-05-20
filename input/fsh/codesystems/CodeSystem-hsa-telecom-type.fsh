CodeSystem: HsaTelecomType
Id: hsa-telecom-type
Title: "HSA Kontaktvägstyp"
Description: """
  Klassificering av kontaktvägar (telecom) i HSA för att skilja på
  direkttelefon, växeltelefon, e-post, m.fl.
"""
* ^url = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
* ^status = #active
* ^experimental = false
* ^date = "2026-05-20"
* ^publisher = "Inera AB / HSA-förvaltning"
* ^jurisdiction = urn:iso:std:iso:3166#SE
* ^caseSensitive = true
* ^content = #complete

* #direct-phone    "Direkttelefon"    "Direkt telefonnummer till enheten (telephoneNumber)."
* #switchboard     "Växeltelefon"     "Växeltelefonnummer (obligatoriskt för offentliga enheter)."
* #public-phone    "Publik telefon"   "Telefonnummer avsett för allmänheten (hsaPublicTelephone)."
* #fax             "Telefax"          "Faxnummer."
* #email           "E-post"           "E-postadress (mail/rfc822Mailbox)."
* #directory-contact "Innehållsansvarig e-post" "Funktionsbrevlåda för innehållsfrågor (hsaDirectoryContact)."
