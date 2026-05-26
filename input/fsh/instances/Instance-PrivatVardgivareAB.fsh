// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: o=Blekinge Primärvård AB,c=SE
// objectClass: organization
// objectClass: hsaOrganisation
// o: Blekinge Primärvård AB
// hsaIdentity: SE5566778899-BPAB1
// orgNo: 5566778899
// management: 05
// telephoneNumber: 0457-55 66 77
// hsaSwitchboardNumber: 0457-55 66 00
// mail: info@blekingeprimaervard.se
// hsaDirectoryContact: redaktion@blekingeprimaervard.se
// labeledURI: https://www.blekingeprimaervard.test
// postalAddress: Järnvägsgatan 12
// postalCode: 372 35
// l: Ronneby
// c: SE
// startDate: 20100501000000Z
// endDate: (ej satt)
// hsaDestinationIndicator: (ej satt)
// hsaGlnCode: (ej satt)
// unitPrescriptionCode: (ej satt — APK förekommer ej på VG-nivå)
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// identifier[hsa-id].value          ← hsaIdentity (system urn:oid:1.2.752.29.4.19)
// identifier[org-no].value          ← orgNo=5566778899 (system urn:oid:2.5.4.97)
//                                      Obligatorisk för HsaHealthcareProviderOrganization
// identifier[gln]                   ← EJ satt: inget hsaGlnCode i källdata.
//                                      Privata bolag saknar ofta GLN på VG-nivå.
// identifier[apk]                   ← EJ satt: APK (arbetsplatskod) är en enhets-
//                                      attribut, aldrig på VG-nivå. Koden tilldelas
//                                      per vårdenhet (se RonnebyVardcentralVardenhet).
// type[hsa-class]                   ← fast kod #healthcare-provider (VG-profil)
// type[ownership].coding.code       ← management=05 → #05 "Privat"
//                                      Kontrastera med RegionBlekingeVardgivare
//                                      (management=01 "Landsting/region"). Detta
//                                      är ett privatägt aktiebolag.
// active                            ← true (inget hsaArchivedObject/hiddenObject)
// name                              ← o (organisationsnamnet i LDAP-trädet)
// meta.security[destination-indicator]
//   FRÅNVARANDE: Ingen destinationIndicator på VG-nivå — samma princip som
//   RegionBlekingeVardgivare. VGs är inte direkt sökbara poster på 1177
//   Hitta vård. Publicering sker via underliggande enheters destinationIndicator.
// contact[0].telecom[0]             ← telephoneNumber → telecomType=#direct-phone
// contact[0].telecom[1]             ← hsaSwitchboardNumber → telecomType=#switchboard
//                                      Här är direkttelefon (55 66 77) och växel
//                                      (55 66 00) OLIKA nummer (typiskt för bolag
//                                      med separat receptionstelefon).
// contact[0].telecom[2]             ← mail → system=#email (publik e-post)
// contact[0].telecom[3]             ← hsaDirectoryContact → system=#email,
//                                      telecomType=#directory-contact
//                                      Redaktionens kontakt för HSA-innehåll.
// contact[0].telecom[4]             ← labeledURI → system=#url (webbadress)
// contact[1].address                ← postalAddress + postalCode + l (legacy pre-5.2)
//   address.type = #postal
//   address.text                    ← "Järnvägsgatan 12"
//   address.postalCode              ← "372 35"
//   address.city                    ← "Ronneby"
// extension[orgPeriod]              ← startDate=20100501 MEN ingen endDate.
//   UTELÄMNAD: Invariant hsacat-org-period-end kräver Period.end.
//   Bolaget är en pågående organisation utan planerat slutdatum.
// ═══════════════════════════════════════════════════════════════════════════════

Instance: PrivatVardgivareAB
InstanceOf: HsaHealthcareProviderOrganization
Usage: #example
Title: "Blekinge Primärvård AB (Privat Vårdgivare)"
Description: """
  Exempelinstans för Blekinge Primärvård AB — ett privat aktiebolag som
  bedriver primärvård på uppdrag av Region Blekinge.

  Demonstrerar: management=05 (privat ägande), avsaknad av GLN och APK på
  VG-nivå, separat direkttelefon och växelnummer, och frånvaro av
  destinationIndicator (VGs är inte direkt sökbara på 1177 Hitta vård).
  Kontrastera med RegionBlekingeVardgivare (offentlig region, management=01).
"""

* id = "privat-vardgivare-ab"

// Ingen meta.security[destination-indicator] — VG-nivå publiceras ej direkt.

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE5566778899-BPAB1"

// orgNo obligatorisk för HsaHealthcareProviderOrganization (identifier[org-no] 1..1)
* identifier[org-no]
  * system = "urn:oid:2.5.4.97"
  * value = "5566778899"

// identifier[gln] saknas — privata bolag har ofta inte GLN registrerat på VG-nivå.
// identifier[apk] saknas — APK tilldelas per vårdenhet, aldrig på VG.

* active = true

* type[hsa-class]
  * coding[0]
    * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    * code = #healthcare-provider
    * display = "Vårdgivare"

// management=05 → Privat (aktiebolag, enskild firma m.m.)
// Kontrastera med management=01 (Landsting/region) hos RegionBlekingeVardgivare.
* type[ownership]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.14"
    * code = #05
    * display = "Privat"

* name = "Blekinge Primärvård AB"

// ── Kontaktuppgifter ─────────────────────────────────────────────────────────
* contact[0]
  // telephoneNumber → direkttelefon (bolagets huvudnummer, ej växeln)
  * telecom[0]
    * system = #phone
    * value = "0457-55 66 77"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #direct-phone
        * display = "Direkttelefon"
  // hsaSwitchboardNumber → växel (separat nummer, typiskt för bolag)
  * telecom[1]
    * system = #phone
    * value = "0457-55 66 00"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #switchboard
        * display = "Växeltelefon"
  // mail → publik e-post (allmän förfrågningar)
  * telecom[2]
    * system = #email
    * value = "info@blekingeprimaervard.se"
    * use = #work
  // hsaDirectoryContact → e-post för HSA-redaktörer (ej publik slutanvändare)
  * telecom[3]
    * system = #email
    * value = "redaktion@blekingeprimaervard.se"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #directory-contact
        * display = "Innehållsansvarig"
  // labeledURI → bolagets webbplats (.test-domän i exempeldata)
  * telecom[4]
    * system = #url
    * value = "https://www.blekingeprimaervard.test"
    * use = #work

// Postadress (legacy pre-5.2 form: postalAddress + postalCode + l)
* contact[1]
  * address
    * type = #postal
    * text = "Järnvägsgatan 12"
    * postalCode = "372 35"
    * city = "Ronneby"
