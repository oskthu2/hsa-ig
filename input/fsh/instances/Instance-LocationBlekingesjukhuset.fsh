// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: ou=Blekingesjukhuset,o=Region Blekinge,c=SE   (samma post som Organization)
// objectClass: organizationalUnit
// objectClass: hsaUnit
// hsaIdentity: SE2321000016-BSJH01
// hsaVisitingAddress: Lyckeby 5$$$Karlskrona
//   (strukturerad 5.2+-form; $=radbrytning; tom rad=ingen entré/plan i detta fall)
// l: Karlskrona
// hsaSweRef99Latitude: 56.1890
// hsaSweRef99Longitude: 15.6210
// hsaPublicTelephoneHours: Måndag-Fredag 08:00-16:30 (öppettider för reception)
// hsaDropinHours: Måndag-Fredag 08:00-11:00 (akutmottagning)
// hsaVpwNavigation: ## Yttre vägbeskrivning\nFrån centrum: Kör mot Lyckeby
//   längs E22. Ta av mot sjukhuset vid trafikljusen.\n\nBuss 1 och 5 stannar
//   vid hållplatsen Blekingesjukhuset.\n\n## Inre vägbeskrivning\nHuvudentré
//   mot Lyckeby 5. Akutmottagning separat ingång på norra sidan.
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// identifier[hsa-id].value          ← hsaIdentity (samma HSA-id som enheten)
//   Platsen och organisationen delar HSA-id i detta fall — LDAP modellerar
//   inte besöksplats separat från enheten. FHIR separerar dem i Location (plats)
//   och Organization (juridisk enhet).
// status                            ← active (enheten är aktiv → platsen är aktiv)
// name                              ← ou (enhetens namn används som platsnamn)
// mode = #instance                  ← alltid för fysiska platser
// address.type = #physical          ← alltid för besöksadress
// address.line[0]                   ← hsaVisitingAddress, del 1 = "Lyckeby 5"
// address.line[1]                   ← hsaVisitingAddress, del 2 = tom (ej satt)
//   (HSA 5.2+ hsaVisitingAddress separerar gatuadress, entré/plan, tillägg
//   och ort med $-tecken. Tom del utelämnas.)
// address.city                      ← hsaVisitingAddress, sista del = "Karlskrona"
// address.postalCode                ← 0..0 (Uppsala-regel: besöksadress saknar postnummer)
// position.latitude                 ← hsaSweRef99Latitude = 56.1890
// position.longitude                ← hsaSweRef99Longitude = 15.6210
// description                       ← hsaVpwNavigation (Markdown-formaterad vägbeskrivning)
//   Renderas med ## Yttre vägbeskrivning / ## Inre vägbeskrivning-konvention.
// managingOrganization              ← Reference(BlekingesjukhusetVardenhet)
// meta.security[destination-indicator] ← hsaDestinationIndicator=03 (ärvs från enhet)
//
// STRUKTURERAD ADRESS (HSA 5.2+):
//   hsaVisitingAddress format: del1$del2$del3$ort
//   del1 = gatuadress: "Lyckeby 5"
//   del2 = ingång/plan: "" (tom — sjukhuset har ingen specifik ingångshänvisning här)
//   del3 = tillägg: "" (tom)
//   ort: "Karlskrona"
//   Kontrastera med Instance-LocationRonnebyVardcentral (legacy streetAddress →
//   address.text) som visar pre-5.2 övergångsmönstret.
// ═══════════════════════════════════════════════════════════════════════════════

Instance: LocationBlekingesjukhuset
InstanceOf: HsaCatalogLocation
Usage: #example
Title: "Blekingesjukhuset (Besöksplats)"
Description: """
  Exempelinstans för Blekingessjukhusets fysiska besöksplats.
  Demonstrerar: strukturerad besöksadress (HSA 5.2+ hsaVisitingAddress),
  SWEREF99-koordinater, Markdown-vägbeskrivning med ## Yttre / ## Inre
  vägbeskrivning-konvention, meta.security[destination-indicator]=03,
  och relationen till Organization via managingOrganization.

  Kontrastera med LocationRonnebyVardcentral som använder legacy
  streetAddress (pre-5.2) → address.text.
"""

* id = "location-blekingesjukhuset"

// Publik synlighet: destinationIndicator=03 (ärvs logiskt från enheten)
* meta.security[destination-indicator]
  * system = "urn:oid:1.2.752.29.23.1.11"
  * code = #03
  * display = "Internet/allmänheten"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-BSJH01"

* status = #active

* name = "Blekingesjukhuset"

* mode = #instance

// ── Besöksadress (strukturerad HSA 5.2+) ─────────────────────────────────────
// hsaVisitingAddress: "Lyckeby 5$$$Karlskrona"
// Del 1 (gatuadress) → address.line[0]
// Del 2+3 (ingång/tillägg) → tomma, utelämnas
// Sista del (ort) → address.city
// address.postalCode = 0..0 (Uppsala-regel: besöksadress har aldrig postnummer)
* address
  * type = #physical
  * line[0] = "Lyckeby 5"
  * city = "Karlskrona"
  // Obs: postalCode saknas avsiktligt — besöksadress har inga postnummer per
  // Uppsala-regeln. Postnumret 371 85 hör till postadress på Organization.

// ── Koordinater (SWEREF99) ────────────────────────────────────────────────────
// hsaSweRef99Latitude / hsaSweRef99Longitude → position.latitude / longitude
// Obligatorisk för publika platser (destinationIndicator=03) för kartvisning på 1177.
* position
  * latitude = 56.189
  * longitude = 15.621

// ── Vägbeskrivning (Markdown) ─────────────────────────────────────────────────
// hsaVpwNavigation → description (renderas som Markdown av klienter)
// Konvention: ## Yttre vägbeskrivning (kollektivtrafik, parkering, bil)
//             ## Inre vägbeskrivning (entré, plan, hiss)
* description = """## Yttre vägbeskrivning
Från centrum: Kör mot Lyckeby längs E22. Ta av mot sjukhuset vid trafikljusen vid rondellen Lyckeby.

Parkering finns vid huvudentrén (avgiftsbelagd). Handikapp-parkering närmast entrén.

Buss linje 1 och 5 stannar vid hållplatsen Blekingesjukhuset (100 m från entrén).

## Inre vägbeskrivning
Huvudentré mot Lyckeby 5 — receptionen finns direkt till höger vid entrén.

Akutmottagning: separat ingång på norra sidan av byggnaden (skyltad).

Hjärtmottagningen: Byggnad B, Plan 4 (t.o.m. dec 2027 pga renovering). Ta hissen vid huvudentrén."""

// ── Ansvarig organisation ─────────────────────────────────────────────────────
* managingOrganization = Reference(BlekingesjukhusetVardenhet)
