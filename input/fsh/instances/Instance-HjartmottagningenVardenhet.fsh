// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: ou=Hjärtmottagningen Karlskrona,ou=Blekingesjukhuset,o=Region Blekinge,c=SE
// objectClass: organizationalUnit
// objectClass: hsaUnit
// ou: Hjärtmottagningen Karlskrona
// hsaIdentity: SE2321000016-HJRT01
// hsaResponsibleHealthCareProvider: SE2321000016-BLKNG
// careLevel: 02
// hsaBusinessType: 15
// management: 01
// hsaDestinationIndicator: 03
// telephoneNumber: 0455-73 48 00
// hsaSwitchboardNumber: 0455-73 10 00
// mail: hjartvard@regionblekinge.se
// hsaDirectoryContact: redaktion.hjart@regionblekinge.se
// hsaVpwWebpage: https://www.1177.test/blekinge/hitta-vard/SE2321000016-HJRT01
// hsaVisitingAddress: Lyckeby 5$Ingång B$Plan 4$Karlskrona
// l: Karlskrona
// hsaSweRef99Latitude: 56.1892
// hsaSweRef99Longitude: 15.6215
// postalAddress: Lyckeby 5
// postalCode: 371 85
// startDate: 20060301000000Z
// endDate: 20280101000000Z
// hsaVpwInformation2: Tillfällig lokal under renovering. Vi finns nu i byggnad B,
//                     plan 4 t.o.m. 31 december 2027.
// hsaVpwInformation4: Ta med aktuell medicinlista och remiss till ditt besök.
//                     Kontakta oss i god tid om du behöver avboka.
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// identifier[hsa-id].value          ← hsaIdentity
// identifier[org-no]                ← EJ satt: mottagningar under sjukhus har
//                                      normalt inte eget orgNo i LDAP; ärvs ej i FHIR.
// type[hsa-class]                   ← fast #healthcare-unit (Vårdenhetsprofil)
// type[care-level].coding.code      ← careLevel=02 → #02 "Specialiserad somatisk vård"
//                                      OBLIGATORISK (1..1) för HsaHealthcareUnitOrganization
// type[business-type].coding.code   ← hsaBusinessType=15 → #15 "Mottagning"
// type[ownership].coding.code       ← management=01 → #01 "Landsting/region"
// active                            ← true (hsaArchivedObject ej satt; endDate i
//                                      framtiden innebär inte inaktivering i dag)
// name                              ← ou
// partOf                            ← hsaResponsibleHealthCareProvider → Reference(RegionBlekingeVardgivare)
//
//   VIKTIGT – DN-träd vs. partOf:
//   DN-trädet visar att Hjärtmottagningen är organisatoriskt placerad UNDER
//   ou=Blekingesjukhuset. Men i FHIR pekar partOf ALLTID på den ansvariga
//   VÅRDGIVAREN (hsaResponsibleHealthCareProvider = SE2321000016-BLKNG),
//   INTE på sjukhuset. Profilen kräver:
//     partOf only Reference(HsaHealthcareProviderOrganization)
//   Blekingesjukhuset är en HsaHealthcareUnitOrganization, inte en
//   HsaHealthcareProviderOrganization — det vore ett profilell. Den
//   hierarkiska positionen i LDAP-trädet representeras inte som partOf i v1.
//   I en framtida version kan en ny slice (t.ex. partOfUnit) läggas till
//   för att modellera enhetshierarkin, men detta är utanför scope för IG v1.
//
// meta.security[destination-indicator] ← hsaDestinationIndicator=03
// contact[0].telecom[0]             ← telephoneNumber → telecomType=#direct-phone
// contact[0].telecom[1]             ← hsaSwitchboardNumber → telecomType=#switchboard
// contact[0].telecom[2]             ← mail → system=#email
// contact[0].telecom[3]             ← hsaDirectoryContact → telecomType=#directory-contact
// contact[0].telecom[4]             ← hsaVpwWebpage → system=#url, telecomType=#vpw-webpage
// contact[1].address                ← postalAddress + postalCode + l (legacy pre-5.2)
//   hsaVisitingAddress              → mappar till Location (ej satt här; se Location-fil)
// extension[orgPeriod]              ← startDate=20060301 + endDate=20280101
//   ANVÄNDS: Både start OCH end finns → invariant hsacat-org-period-end uppfylld.
//   Jämför med BlekingesjukhusetVardenhet (ingen endDate → orgPeriod utelämnas).
//   orgPeriod indikerar att enheten är tidsbegränsad/tillfällig, t.ex. pga.
//   planerat verksamhetsslut eller omorganisation.
// extension[temporaryNotice]        ← hsaVpwInformation2 (gul informationsruta på 1177)
// extension[patientInfo]            ← hsaVpwInformation4 (patientinformation på 1177)
// ═══════════════════════════════════════════════════════════════════════════════

Instance: HjartmottagningenVardenhet
InstanceOf: HsaHealthcareUnitOrganization
Usage: #example
Title: "Hjärtmottagningen Karlskrona (Vårdenhet)"
Description: """
  Exempelinstans för Hjärtmottagningen Karlskrona — en specialistmottagning
  (kardiologi) organisatoriskt placerad under Blekingesjukhuset i LDAP-trädet,
  men med partOf direkt till Region Blekinge som ansvarig vårdgivare per
  profil-kravet partOf only Reference(HsaHealthcareProviderOrganization).

  Demonstrerar: orgPeriod med start OCH end (hsacat-org-period-end uppfylld),
  tillfällig information (hsaVpwInformation2 → temporaryNotice),
  patientinformation (hsaVpwInformation4 → patientInfo),
  hsaBusinessType=15 (Mottagning) och den viktiga distinktionen att
  DN-trädpositionen INTE representeras som partOf i FHIR v1.
"""

* id = "hjartmottagningen-vardenhet"

// Publik synlighet: destinationIndicator=03
* meta.security[destination-indicator]
  * system = "urn:oid:1.2.752.29.23.1.11"
  * code = #03
  * display = "Internet/allmänheten"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-HJRT01"

// Obs: identifier[org-no] saknas — mottagningen har inte eget organisationsnummer.
// Profilkravet identifier[org-no] 1..1 gäller HsaHealthcareProviderOrganization,
// inte HsaHealthcareUnitOrganization (0..1).

* active = true

* type[hsa-class]
  * coding[0]
    * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    * code = #healthcare-unit
    * display = "Vårdenhet"

// careLevel=02 → Specialiserad somatisk vård (OBLIGATORISK 1..1)
* type[care-level]
  * coding[0]
    * system = "urn:oid:1.2.752.129.5.1.46"
    * code = #02
    * display = "Specialiserad somatisk vård"

// hsaBusinessType=15 → Mottagning
* type[business-type]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.12"
    * code = #15
    * display = "Mottagning"

// management=01 → Landsting/region
* type[ownership]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.14"
    * code = #01
    * display = "Landsting/region"

* name = "Hjärtmottagningen Karlskrona"

// partOf → hsaResponsibleHealthCareProvider (SE2321000016-BLKNG = Region Blekinge VG)
// Inte till Blekingesjukhuset — se mappningskommentarer ovan.
* partOf = Reference(RegionBlekingeVardgivare)

// ── Tillfällig status och patientinformation ─────────────────────────────────
// orgPeriod: startDate=20060301, endDate=20280101 → båda är satta → korrekt per
// invariant hsacat-org-period-end (Period.end 1..1 i orgPeriod-slicen).
// Klienter bör rendera en visuell varningsindikator (gul ruta) när orgPeriod
// är satt och active = true, kombinerat med temporaryNotice-texten.
* extension[orgPeriod]
  * valuePeriod
    * start = "2006-03-01"
    * end = "2028-01-01"

// hsaVpwInformation2 → temporaryNotice (visas som gul informationsruta på 1177)
* extension[temporaryNotice]
  * valueString = "Tillfällig lokal under renovering. Vi finns nu i byggnad B, plan 4 t.o.m. 31 december 2027."

// hsaVpwInformation4 → patientInfo (patientinformation, renderas som Markdown)
* extension[patientInfo]
  * valueString = "Ta med aktuell medicinlista och remiss till ditt besök. Kontakta oss i god tid om du behöver avboka."

// ── Kontaktuppgifter ─────────────────────────────────────────────────────────
* contact[0]
  // telephoneNumber → direkttelefon
  * telecom[0]
    * system = #phone
    * value = "0455-73 48 00"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #direct-phone
        * display = "Direkttelefon"
  // hsaSwitchboardNumber → regionens gemensamma växel
  * telecom[1]
    * system = #phone
    * value = "0455-73 10 00"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #switchboard
        * display = "Växeltelefon"
  // mail → publik e-post
  * telecom[2]
    * system = #email
    * value = "hjartvard@regionblekinge.se"
    * use = #work
  // hsaDirectoryContact → e-post för innehållsansvarig (ej publik slutanvändare)
  * telecom[3]
    * system = #email
    * value = "redaktion.hjart@regionblekinge.se"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #directory-contact
        * display = "Innehållsansvarig"
  // hsaVpwWebpage → 1177-djuplänk
  * telecom[4]
    * system = #url
    * value = "https://www.1177.test/blekinge/hitta-vard/SE2321000016-HJRT01"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #vpw-webpage
        * display = "1177-kontaktkortsadress"

// Postadress (legacy pre-5.2 form)
// Besöksadressen (hsaVisitingAddress: Lyckeby 5, Ingång B, Plan 4, Karlskrona)
// är modellerad i en separat Location-resurs (ej skapad här).
* contact[1]
  * address
    * type = #postal
    * text = "Lyckeby 5"
    * postalCode = "371 85"
    * city = "Karlskrona"
