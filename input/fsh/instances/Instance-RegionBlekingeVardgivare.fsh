// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: o=Region Blekinge,c=SE
// objectClass: organization
// objectClass: hsaOrganisation
// o: Region Blekinge
// hsaIdentity: SE2321000016-BLKNG
// orgNo: 2321000016
// management: 01
// hsaGlnCode: 7350088100003
// telephoneNumber: 0455-73 10 00
// hsaSwitchboardNumber: 0455-73 10 00
// mobile: (ej satt)
// facsimileTelephoneNumber: (ej satt)
// mail: region@regionblekinge.se
// hsaDirectoryContact: redaktion@regionblekinge.se
// labeledURI: https://www.regionblekinge.se
// postalAddress: Box 515
// postalCode: 371 81
// l: Karlskrona
// c: SE
// startDate: 20000101000000Z
// endDate: (ej satt)
// hsaDestinationIndicator: (ej satt)
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// identifier[hsa-id].value          ← hsaIdentity (system urn:oid:1.2.752.29.4.19)
// identifier[org-no].value          ← orgNo (system urn:oid:2.5.4.97)
// identifier[gln].value             ← hsaGlnCode (system urn:oid:1.3.88)
// type[hsa-class]                   ← fast kod #healthcare-provider (alltid för VG-profil)
// type[ownership].coding.code       ← management=01 → #01 display "Landsting/region"
// name                              ← o (organisationsnamnet i LDAP-trädet)
// active                            ← true (inget hsaArchivedObject/hiddenObject)
// meta.security[destination-indicator]
//   FRÅNVARANDE: VGs saknar normalt destinationIndicator; de är inte direkt
//   adresserbara poster på 1177 Hitta vård. Söktjänsten hittar VG indirekt
//   via enheternas publicering.
// contact[0].telecom[0]             ← telephoneNumber → system=#phone, telecomType=#direct-phone
// contact[0].telecom[1]             ← hsaSwitchboardNumber → telecomType=#switchboard
//   OBS: I detta fall är tel och växel samma nummer (vanligt för regioner).
// contact[0].telecom[2]             ← mail → system=#email
// contact[0].telecom[3]             ← hsaDirectoryContact → system=#email,
//                                      telecomType=#directory-contact
//                                      Ej synlig för slutanvändare; används av
//                                      1177-redaktörer för att nå innehållsansvarig.
// contact[0].telecom[4]             ← labeledURI → system=#url
// contact[1].address                ← postalAddress + postalCode + l (legacy pre-5.2 form)
//   address.type = #postal          ← LDAP:postalAddress = postadress (ej besöksadress)
//   address.text                    ← "Box 515" (övergångsform t.o.m. sept 2026;
//                                      normativ form hsaPostalAddress saknas ännu)
//   address.postalCode              ← postalCode = "371 81"
//   address.city                    ← l = "Karlskrona"
// extension[orgPeriod]              ← startDate=20000101 finns MEN endDate saknas.
//   UTELÄMNAD: Invariant hsacat-org-period-end kräver Period.end. En start utan
//   slut är inte meningsfullt för orgPeriod (som är avsedd för tidsbegränsade
//   aktiviteter). Region Blekinge är en permanent organisation; startDate
//   används inte i FHIR-modellen. Jmfr File 3 (Hjärtmottagningen) som har
//   BÅDE start och end → orgPeriod används.
// ═══════════════════════════════════════════════════════════════════════════════

Instance: RegionBlekingeVardgivare
InstanceOf: HsaHealthcareProviderOrganization
Usage: #example
Title: "Region Blekinge (Vårdgivare)"
Description: """
  Exempelinstans för Region Blekinge som offentlig regional vårdgivare.
  Demonstrerar: management=01 (landsting/region), GLN-kod, legacy postadress
  (pre-5.2 övergångsform), telekomtyper (direkttelefon = växel, e-post,
  innehållsansvarig, webbadress) och frånvaro av destinationIndicator på VG-nivå.
"""

* id = "region-blekinge-vardgivare"

// Inget meta.security[destination-indicator] för vårdgivare.
// VGs är inte primärt listade på 1177 Hitta vård — synligheten styrs av
// de underordnade vårdenheternas destinationIndicator.

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-BLKNG"

* identifier[org-no]
  * system = "urn:oid:2.5.4.97"
  * value = "2321000016"

* identifier[gln]
  * system = "urn:oid:1.3.88"
  * value = "7350088100003"

* active = true

* type[hsa-class]
  * coding[0]
    * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    * code = #healthcare-provider
    * display = "Vårdgivare"

// management=01 → Landsting/region (OID 1.2.752.129.2.2.1.14)
* type[ownership]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.14"
    * code = #01
    * display = "Landsting/region"

* name = "Region Blekinge"

// ── Kontaktuppgifter ─────────────────────────────────────────────────────────
* contact[0]
  // telephoneNumber → direkttelefon (och i detta fall identisk med växeln)
  * telecom[0]
    * system = #phone
    * value = "0455-73 10 00"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #direct-phone
        * display = "Direkttelefon"
  // hsaSwitchboardNumber → växeltelefon
  * telecom[1]
    * system = #phone
    * value = "0455-73 10 00"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #switchboard
        * display = "Växeltelefon"
  // mail → e-post (publik)
  * telecom[2]
    * system = #email
    * value = "region@regionblekinge.se"
    * use = #work
  // hsaDirectoryContact → e-post för innehållsansvarig (ej publik slutanvändare)
  * telecom[3]
    * system = #email
    * value = "redaktion@regionblekinge.se"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #directory-contact
        * display = "Innehållsansvarig"
  // labeledURI → webbadress
  * telecom[4]
    * system = #url
    * value = "https://www.regionblekinge.se"
    * use = #work

// Postadress (legacy pre-5.2 form: postalAddress + postalCode + l)
// address.text används som övergångsform t.o.m. sept 2026.
// Normativ form (hsaPostalAddress-attribut i 5.2+) finns inte i källdata ännu.
* contact[1]
  * address
    * type = #postal
    * text = "Box 515"
    * postalCode = "371 81"
    * city = "Karlskrona"
