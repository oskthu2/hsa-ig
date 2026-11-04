// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: ou=Ronneby Vårdcentral,o=Blekinge Primärvård AB,c=SE
// objectClass: organizationalUnit
// objectClass: hsaUnit
// ou: Ronneby Vårdcentral
// hsaIdentity: SE5566778899-RNBY1
// hsaResponsibleHealthCareProvider: SE5566778899-BPAB1
// careLevel: 01
// hsaBusinessType: 05
// management: 05
// unitPrescriptionCode: 1082040
// hsaDestinationIndicator: 03
// financingOrganization: 232100-0081 (organisationsnummer, inte HSA-id)
// telephoneNumber: +46457556688
// hsaSwitchboardNumber: +46457556600
// mobile: +46729876543
// mail: ronneby@blekingeprimaervard.se
// hsaDirectoryContact: redaktion.ronneby@blekingeprimaervard.se
// hsaVpwWebpage: https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE5566778899-RNBY1
// streetAddress: Järnvägsgatan 14        ← LEGACY pre-5.2 (ej migrerat till hsaVisitingAddress)
// postalAddress: Järnvägsgatan 14
// postalCode: 37235
// l: Ronneby
// hsaSweref99Latitude: 6229465
// hsaSweref99Longitude: 517312
// hsaVpwInformation4: Du kan lista dig hos oss via 1177.se. Vi tar emot
//                     både bokade besök och drop-in.
// startDate: 20100601000000Z
// endDate: (ej satt)
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// identifier[hsa-id].value          ← hsaIdentity
// identifier[org-no]                ← EJ satt: vårdcentralen är en enhet under
//                                      Blekinge Primärvård AB och delar bolagets
//                                      organisationsnummer. Orgno modelleras
//                                      INTE på enhetsnivå om det inte är explicit
//                                      registrerat i LDAP.
// identifier[apk].value             ← unitPrescriptionCode=1082040
//                                      OID 1.2.752.29.4.71 (preliminärt)
// type[hsa-class]                   ← fast #healthcare-unit (Vårdenhetsprofil)
// type[care-level].coding.code      ← careLevel=01 → #01 "Primärvård"
//                                      OBLIGATORISK (1..1) för HsaHealthcareUnitOrganization
// type[business-type].coding.code   ← hsaBusinessType=05 → #05 "Vårdcentral"
// type[ownership].coding.code       ← management=05 → #05 "Privat"
//                                      Enheten drivs av Blekinge Primärvård AB (privat)
//                                      MEN finansieras av Region Blekinge (se nedan).
// active                            ← true
// name                              ← ou
// partOf                            ← hsaResponsibleHealthCareProvider →
//                                      Reference(PrivatVardgivareAB)
// meta.security[destination-indicator] ← hsaDestinationIndicator=03
// extension[financingOrganization]  ← financingOrganization=232100-0081
//   VIKTIG DISTINKTION: Enheten är PRIVAT utförare (management=05) men
//   REGIONFINANSIERAD. Finansierande organisation modelleras som
//   extension[financingOrganization].valueCoding med:
//     system = "urn:oid:1.2.752.129.5.1.1"  (LDAP-OID för financingOrganization)
//     code = "232100-0081"  (organisationsnummer enligt 11.3.13)
//   Detta är ett centralt mönster för privata utförare med LOV/LOV-avtal.
// extension[patientInfo]            ← hsaVpwInformation4
// contact[0].telecom[0]             ← telephoneNumber → telecomType=#direct-phone
// contact[0].telecom[1]             ← hsaSwitchboardNumber → telecomType=#switchboard
// contact[0].telecom[2]             ← mobile → system=#phone, use=#mobile, telecomType=#mobile
// contact[0].telecom[3]             ← mail → system=#email
// contact[0].telecom[4]             ← hsaDirectoryContact → telecomType=#directory-contact
// contact[0].telecom[5]             ← hsaVpwWebpage → system=#url, telecomType=#vpw-webpage
// contact[1].address                ← postalAddress + postalCode + l (legacy pre-5.2)
//   streetAddress (legacy pre-5.2)  → besöksadress modelleras i Location-resursen
//   (Instance-LocationRonnebyVardcentral). Obs: streetAddress ej migrerat till
//   hsaVisitingAddress ännu — detta exemplifieras i Location-filen.
// extension[orgPeriod]              ← startDate=20100601, endDate saknas → UTELÄMNAS.
// ═══════════════════════════════════════════════════════════════════════════════

Instance: RonnebyVardcentralVardenhet
InstanceOf: HsaHealthcareUnitOrganization
Usage: #example
Title: "Ronneby Vårdcentral (Vårdenhet, privat utförare)"
Description: """
  Exempelinstans för Ronneby Vårdcentral — en primärvårdsenhet driven av
  Blekinge Primärvård AB (privat) med finansiering från Region Blekinge.

  Demonstrerar: careLevel=01 (Primärvård), hsaBusinessType=05 (Vårdcentral),
  financingOrganization-extensionen (privat utförare med regionfinansiering),
  APK-kod, mobiltelefon, patientInfo (hsaVpwInformation4) och legacy
  streetAddress (besöksadress ej migrerat till 5.2+ hsaVisitingAddress).
  Besöksadressen modelleras i Instance-LocationRonnebyVardcentral.
"""

* id = "ronneby-vardcentral-vardenhet"

// Publik synlighet: destinationIndicator=03
* meta.security[destination-indicator]
  * system = "urn:oid:1.2.752.29.23.1.11"
  * code = #03
  * display = "Internet/allmänheten"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE5566778899-RNBY1"

// Arbetsplatskod (unitPrescriptionCode) — används av NPÖ
* identifier[apk]
  * system = "urn:oid:1.2.752.29.4.71"
  * value = "1082040"

* active = true

* type[hsa-class]
  * coding[0]
    * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    * code = #healthcare-unit
    * display = "Vårdenhet"

// careLevel=01 → Primärvård (OBLIGATORISK 1..1)
* type[care-level]
  * coding[0]
    * system = "urn:oid:1.2.752.129.5.1.46"
    * code = #01
    * display = "Primärvård"

// hsaBusinessType=05 → Vårdcentral
* type[business-type]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.12"
    * code = #05
    * display = "Vårdcentral"

// management=05 → Privat (drivs av Blekinge Primärvård AB)
* type[ownership]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.14"
    * code = #05
    * display = "Privat"

* name = "Ronneby Vårdcentral"

// partOf → Blekinge Primärvård AB (ansvarig VG per hsaResponsibleHealthCareProvider)
* partOf = Reference(PrivatVardgivareAB)

// ── Finansiering ─────────────────────────────────────────────────────────────
// financingOrganization=232100-0081 (Region Blekinges organisationsnummer) → Region Blekinge finansierar vården
// trots att utföraren är privat. Vanligt mönster för LOV-upphandlade vårdcentraler.
// System = OID för LDAP-attributet financingOrganization (1.2.752.129.5.1.1).
* extension[financingOrganization]
  * valueCoding
    * system = "urn:oid:1.2.752.129.5.1.1"
    * code = #232100-0081
    * display = "Region Blekinge"

// hsaVpwInformation4 → patientInfo (information till listade och potentiella patienter)
* extension[patientInfo]
  * valueString = "Du kan lista dig hos oss via 1177.se. Vi tar emot både bokade besök och drop-in."

// ── Kontaktuppgifter ─────────────────────────────────────────────────────────
* contact[0]
  // telephoneNumber → direkttelefon
  * telecom[0]
    * system = #phone
    * value = "+46457556688"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #direct-phone
        * display = "Direkttelefon"
  // hsaSwitchboardNumber → bolagets gemensamma växel
  * telecom[1]
    * system = #phone
    * value = "+46457556600"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #switchboard
        * display = "Växeltelefon"
  // mobile → mobiltelefon (t.ex. för distriktssköterskan på hembesök)
  * telecom[2]
    * system = #phone
    * value = "+46729876543"
    * use = #mobile
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #mobile
        * display = "Mobiltelefon"
  // mail → publik e-post
  * telecom[3]
    * system = #email
    * value = "ronneby@blekingeprimaervard.se"
    * use = #work
  // hsaDirectoryContact → e-post för HSA-redaktörer
  * telecom[4]
    * system = #email
    * value = "redaktion.ronneby@blekingeprimaervard.se"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #directory-contact
        * display = "Innehållsansvarig"
  // hsaVpwWebpage → 1177-djuplänk
  * telecom[5]
    * system = #url
    * value = "https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE5566778899-RNBY1"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #vpw-webpage
        * display = "1177-kontaktkortsadress"

// Postadress (legacy pre-5.2 form)
// streetAddress (besöksadress) → Location-resursen Instance-LocationRonnebyVardcentral
* contact[1]
  * address
    * type = #postal
    * text = "Järnvägsgatan 14"
    * postalCode = "37235"
    * city = "Ronneby"
