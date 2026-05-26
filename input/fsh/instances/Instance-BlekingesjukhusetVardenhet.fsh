// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: ou=Blekingesjukhuset,o=Region Blekinge,c=SE
// objectClass: organizationalUnit
// objectClass: hsaUnit
// ou: Blekingesjukhuset
// hsaIdentity: SE2321000016-BSJH01
// hsaResponsibleHealthCareProvider: SE2321000016-BLKNG
// careLevel: 02
// hsaBusinessType: 01
// management: 01
// unitPrescriptionCode: 1301033
// hsaGlnCode: 7350088110002
// hsaDestinationIndicator: 03
// telephoneNumber: 0455-73 17 00
// hsaSwitchboardNumber: 0455-73 10 00
// mobile: 070-123 45 67
// facsimileTelephoneNumber: 0455-73 17 99
// mail: blekingesjukhuset@regionblekinge.se
// hsaDirectoryContact: redaktion.bsj@regionblekinge.se
// labeledURI: https://www.regionblekinge.se/blekingesjukhuset
// hsaVpwWebpage: https://www.1177.test/blekinge/hitta-vard/SE2321000016-BSJH01
// hsaVisitingAddress: Lyckeby 5$$$Karlskrona       (strukturerad 5.2+, $=radbryt)
// l: Karlskrona
// hsaSweRef99Latitude: 56.1890
// hsaSweRef99Longitude: 15.6210
// postalAddress: Lyckeby 5
// postalCode: 371 85
// orgNo: 2321000016
// startDate: 19940101000000Z
// endDate: (ej satt)
// hsaArchivedObject: (ej satt)
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// identifier[hsa-id].value          ← hsaIdentity
// identifier[org-no].value          ← orgNo (sjukhuset delar orgnr med Region Blekinge VG)
// identifier[apk].value             ← unitPrescriptionCode=1301033
//                                      OID 1.2.752.29.4.71 (preliminärt; se HSACAT-ORG-012)
// identifier[gln].value             ← hsaGlnCode=7350088110002
// type[hsa-class]                   ← fast #healthcare-unit (Vårdenhetsprofil)
// type[care-level].coding.code      ← careLevel=02 → #02 "Specialiserad somatisk vård"
//                                      OBLIGATORISK (1..1) för HsaHealthcareUnitOrganization
// type[business-type].coding.code   ← hsaBusinessType=01 → #01 "Sjukhus"
// type[ownership].coding.code       ← management=01 → #01 "Landsting/region"
// active                            ← true
// name                              ← ou
// partOf                            ← hsaResponsibleHealthCareProvider → Reference(RegionBlekingeVardgivare)
//   VIKTIGT: partOf mappar hsaResponsibleHealthCareProvider, INTE DN-positionen
//   i LDAP-trädet. DN visar att sjukhuset hänger under o=Region Blekinge, men
//   partOf pekar på VG-instansen, eftersom profilen kräver
//   partOf only Reference(HsaHealthcareProviderOrganization).
// meta.security[destination-indicator] ← hsaDestinationIndicator=03 → #03
// contact[0].telecom[0]             ← telephoneNumber → telecomType=#direct-phone
// contact[0].telecom[1]             ← hsaSwitchboardNumber → telecomType=#switchboard
// contact[0].telecom[2]             ← mobile → system=#phone, use=#mobile, telecomType=#mobile
// contact[0].telecom[3]             ← facsimileTelephoneNumber → system=#fax
// contact[0].telecom[4]             ← mail → system=#email
// contact[0].telecom[5]             ← hsaDirectoryContact → telecomType=#directory-contact
// contact[0].telecom[6]             ← labeledURI → system=#url
// contact[0].telecom[7]             ← hsaVpwWebpage → system=#url (djuplänk till 1177)
//                                      Anpassad testmiljö-URL i detta exempel.
// contact[1].address                ← postalAddress + postalCode + l (legacy pre-5.2)
//   hsaVisitingAddress              → mappar till Location (se Instance-LocationBlekingesjukhuset)
//   INTE till Organization.contact.address — besöksadresser i HSA 5.2+ är
//   Location-resurser, inte adresser på Organization.
// extension[orgPeriod]              ← startDate=19940101 finns MEN endDate saknas.
//   UTELÄMNAD av samma skäl som VG-filen: invariant hsacat-org-period-end
//   kräver Period.end; startDate utan end gäller ej orgPeriod.
// ═══════════════════════════════════════════════════════════════════════════════

Instance: BlekingesjukhusetVardenhet
InstanceOf: HsaHealthcareUnitOrganization
Usage: #example
Title: "Blekingesjukhuset (Vårdenhet)"
Description: """
  Exempelinstans för Blekingesjukhuset som publik specialiserad vårdenhet under
  Region Blekinge. Demonstrerar: APK (arbetsplatskod), GLN, alla telekomtyper
  inkl. mobiltelefon, fax och 1177-djuplänk (hsaVpwWebpage), legacy postadress
  (pre-5.2), strukturerad besöksadress i separat Location-resurs,
  destinationIndicator=03 och partOf → VG-instansen.
"""

* id = "blekingesjukhuset-vardenhet"

// Publik synlighet: destinationIndicator=03 → Internet/allmänheten
* meta.security[destination-indicator]
  * system = "urn:oid:1.2.752.29.23.1.11"
  * code = #03
  * display = "Internet/allmänheten"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-BSJH01"

* identifier[org-no]
  * system = "urn:oid:2.5.4.97"
  * value = "2321000016"

// Arbetsplatskod (unitPrescriptionCode) — OID preliminärt, bekräftas i HSACAT-ORG-012
* identifier[apk]
  * system = "urn:oid:1.2.752.29.4.71"
  * value = "1301033"

* identifier[gln]
  * system = "urn:oid:1.3.88"
  * value = "7350088110002"

* active = true

* type[hsa-class]
  * coding[0]
    * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    * code = #healthcare-unit
    * display = "Vårdenhet"

// careLevel=02 → Specialiserad somatisk vård (OBLIGATORISK på Vårdenhetsprofilen)
* type[care-level]
  * coding[0]
    * system = "urn:oid:1.2.752.129.5.1.46"
    * code = #02
    * display = "Specialiserad somatisk vård"

// hsaBusinessType=01 → Sjukhus
* type[business-type]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.12"
    * code = #01
    * display = "Sjukhus"

// management=01 → Landsting/region
* type[ownership]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.14"
    * code = #01
    * display = "Landsting/region"

* name = "Blekingesjukhuset"

// hsaResponsibleHealthCareProvider → partOf (HSA-id mappas till FHIR Reference)
* partOf = Reference(RegionBlekingeVardgivare)

// ── Kontaktuppgifter ─────────────────────────────────────────────────────────
* contact[0]
  // telephoneNumber → direkttelefon
  * telecom[0]
    * system = #phone
    * value = "0455-73 17 00"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #direct-phone
        * display = "Direkttelefon"
  // hsaSwitchboardNumber → växel (regionens gemensamma växel)
  * telecom[1]
    * system = #phone
    * value = "0455-73 10 00"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #switchboard
        * display = "Växeltelefon"
  // mobile → mobiltelefon
  * telecom[2]
    * system = #phone
    * value = "070-123 45 67"
    * use = #mobile
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #mobile
        * display = "Mobiltelefon"
  // facsimileTelephoneNumber → fax
  * telecom[3]
    * system = #fax
    * value = "0455-73 17 99"
    * use = #work
  // mail → e-post
  * telecom[4]
    * system = #email
    * value = "blekingesjukhuset@regionblekinge.se"
    * use = #work
  // hsaDirectoryContact → innehållsansvarig e-post (ej publik slutanvändare)
  * telecom[5]
    * system = #email
    * value = "redaktion.bsj@regionblekinge.se"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #directory-contact
        * display = "Innehållsansvarig"
  // labeledURI → webbsida
  * telecom[6]
    * system = #url
    * value = "https://www.regionblekinge.se/blekingesjukhuset"
    * use = #work
  // hsaVpwWebpage → 1177-djuplänk (används av 1177-klienten för kontaktkortsnavigering)
  * telecom[7]
    * system = #url
    * value = "https://www.1177.test/blekinge/hitta-vard/SE2321000016-BSJH01"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #vpw-webpage
        * display = "1177-kontaktkortsadress"

// Postadress (legacy pre-5.2 form)
// Besöksadressen (hsaVisitingAddress) ligger i LocationBlekingesjukhuset — ej här.
* contact[1]
  * address
    * type = #postal
    * text = "Lyckeby 5"
    * postalCode = "371 85"
    * city = "Karlskrona"
