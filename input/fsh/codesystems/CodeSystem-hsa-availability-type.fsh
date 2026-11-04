CodeSystem: HsaAvailabilityType
Id: hsa-availability-type
Title: "HSA Tidtyp"
Description: """
  Anger vilket HSA-tidsattribut en tillgänglighetspost (Availability) kommer
  från, så att klienter kan skilja öppettider, telefontider, drop-in och
  besökstider åt (ADR-016).
"""
* ^url = "https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type"
* ^status = #active
* ^experimental = false
* ^date = "2026-11-04"
* ^publisher = "Inera AB / HSA-förvaltning"
* ^jurisdiction = urn:iso:std:iso:3166#SE
* ^caseSensitive = true
* ^content = #complete

* #surgery-hours   "Öppettider"               "Tider då enheten tar emot besök (surgeryHours)."
* #telephone-hours "Telefontider"             "Tider då enheten svarar i telefon (telephoneHours)."
* #drop-in-hours   "Drop-in"                  "Tider för besök utan tidsbokning (dropInHours)."
* #visiting-hours  "Besökstider för anhöriga" "Tider då anhöriga får besöka patienter (visitingHours)."
