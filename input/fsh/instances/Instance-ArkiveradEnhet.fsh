// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: ou=Medicinmottagning Karlshamn,ou=Blekingesjukhuset,o=Region Blekinge,c=SE
// objectClass: organizationalUnit
// objectClass: hsaUnit
// ou: Medicinmottagning Karlshamn
// hsaIdentity: SE2321000016-ARKV1
// hsaResponsibleHealthCareProvider: SE2321000016-BLKNG
// careLevel: 02
// hsaArchivedObject: TRUE
// startDate: 20050101000000Z
// endDate: 20231231000000Z
//
// (Alla övriga attribut borttagna eller tomma — arkiverade enheter behåller
//  bara identitet, datum och objektklass.)
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// identifier[hsa-id].value          ← hsaIdentity
// type[hsa-class]                   ← fast #healthcare-unit (Vårdenhetsprofil)
// type[care-level].coding.code      ← careLevel=02 → #02 "Specialiserad somatisk vård"
//                                      OBLIGATORISK (1..1) för HsaHealthcareUnitOrganization
//                                      ÄVEN för inaktiva enheter — profilkravet gäller alltid.
// active                            ← FALSE ← hsaArchivedObject: TRUE
//   INAKTIVERINGSLOGIK:
//   HSA har flera mekanismer för att dölja/inaktivera objekt:
//     hsaArchivedObject: TRUE   → active = false (permanent arkivering)
//     hiddenObject: TRUE        → active = false (dold men ej arkiverad)
//     hsaInaccurateHCP/HCU: TRUE → active = false (felaktigt utpekad)
//   ALLA dessa mappas till active = false i FHIR-modellen. Det finns ingen
//   separat FHIR-mekanism för att skilja "arkiverad" från "dold" — distinktionen
//   finns i LDAP men abstraheras bort i FHIR för enhetlig konsumentlogik.
// name                              ← ou
// partOf                            ← hsaResponsibleHealthCareProvider →
//                                      Reference(RegionBlekingeVardgivare)
// meta.security[destination-indicator]
//   FRÅNVARANDE: Inaktiva enheter saknar normalt destinationIndicator.
//   Även om koden tekniskt hade funnits i LDAP bör den inte användas för
//   inaktiva/arkiverade objekt — de ska inte visas i sökresultat.
// extension[orgPeriod]
//   UTELÄMNAS trots att startDate OCH endDate finns i LDAP.
//   Motivering: extension[orgPeriod] är avsedd för AKTIVA enheter med
//   känd giltighetstid (t.ex. tillfällig lokal, se HjartmottagningenVardenhet).
//   För arkiverade enheter (active=false) kommuniceras livscykelslut via
//   active-flaggan, INTE via orgPeriod. Att sätta orgPeriod på en inaktiv
//   enhet vore missvisande och skulle kräva en extra invariantanalys.
//   Tidpunkterna bevaras dock implicit: en konsument som behöver datum
//   kan söka i historiska versioner via FHIR-historikmekanismen.
// ═══════════════════════════════════════════════════════════════════════════════

Instance: ArkiveradEnhet
InstanceOf: HsaHealthcareUnitOrganization
Usage: #example
Title: "Medicinmottagning Karlshamn (arkiverad)"
Description: """
  Exempelinstans för en arkiverad (inaktiv) vårdenhet — Medicinmottagning
  Karlshamn — som stängde 2023-12-31 och är markerad med hsaArchivedObject: TRUE
  i LDAP.

  Demonstrerar: active = false som FHIR-representation av hsaArchivedObject,
  minimal datauppsättning för arkiverade enheter (identitet + typ + status),
  frånvaro av destinationIndicator och avsaknad av orgPeriod (se mappningskommentar).

  Alla inaktiveringsskäl (hsaArchivedObject, hiddenObject, hsaInaccurateHCP/HCU)
  mappas till active = false — distinktionen görs inte synlig i FHIR v1.
"""

* id = "arkiverad-enhet"

// Ingen meta.security[destination-indicator] — inaktiva enheter ska inte visas
// i sökresultat och saknar normalt destinationIndicator i LDAP.

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-ARKV1"

// active = false ← hsaArchivedObject: TRUE
// Alla varianter av inaktivering i HSA (archived, hidden, inaccurate) → active = false
* active = false

* type[hsa-class]
  * coding[0]
    * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    * code = #healthcare-unit
    * display = "Vårdenhet"

// careLevel=02 krävs 1..1 per HsaHealthcareUnitOrganization-profilen,
// även för inaktiva/arkiverade enheter. Profilkravet gäller oavsett active-status.
* type[care-level]
  * coding[0]
    * system = "urn:oid:1.2.752.129.5.1.46"
    * code = #02
    * display = "Specialiserad somatisk vård"

// management satt i LDAP men utelämnas här — arkiverade enheter behåller
// minsta möjliga attributuppsättning (identitet + typ + status + hierarki).

* name = "Medicinmottagning Karlshamn"

// partOf → Region Blekinge VG (hsaResponsibleHealthCareProvider bevaras även
// för arkiverade enheter för att bevara den historiska hierarkins spårbarhet).
* partOf = Reference(RegionBlekingeVardgivare)

// OBS: Inga kontaktuppgifter, adress, öppettider eller VPW-information.
// Arkiverade enheter har tömts på operativa attribut i LDAP — endast
// identitet och klassificering bevaras för historisk spårbarhet.
