// ═══════════════════════════════════════════════════════════════════════════════
// LDAP-KÄLLDATA (LDIF-format)
// ───────────────────────────────────────────────────────────────────────────────
// dn: ou=Ronneby Vårdcentral,o=Blekinge Primärvård AB,c=SE
// objectClass: organizationalUnit
// objectClass: hsaUnit
// hsaIdentity: SE5566778899-RNBY1
// streetAddress: Järnvägsgatan 14   ← LEGACY pre-5.2 (ej migrerat till hsaVisitingAddress)
//   (hsaVisitingAddress saknas — enheten har INTE uppdaterats till 5.2+ ännu)
// l: Ronneby
// hsaSweRef99Latitude: 56.2098
// hsaSweRef99Longitude: 15.2791
// hsaVpwNavigation: Centralt läge i Ronneby, 200 m från järnvägsstationen.
//   Parkering bakom fastigheten, ingång Järnvägsgatan 14.
//
// ═══════════════════════════════════════════════════════════════════════════════
// FHIR → LDAP MAPPNING
// ───────────────────────────────────────────────────────────────────────────────
// identifier[hsa-id].value          ← hsaIdentity
// status                            ← active
// mode = #instance                  ← fysisk plats
// address.type = #physical          ← besöksadress
// address.text                      ← streetAddress = "Järnvägsgatan 14"
//
//   LEGACY PRE-5.2 MAPPNING:
//   Enheten har inte migrerat till HSA 5.2+ och saknar hsaVisitingAddress.
//   Källdata innehåller bara det gamla streetAddress-attributet.
//   Övergångsperioden pågår t.o.m. september 2026.
//
//   Pre-5.2 streetAddress →  address.text  (ostrukturerad textsträng)
//   Post-5.2 hsaVisitingAddress → address.line[] + address.city (strukturerad)
//
//   Konsumenter (t.ex. 1177 Hitta vård) bör hantera BÅDA formerna under
//   övergångsperioden:
//     if address.line is not empty → strukturerad (5.2+)
//     else if address.text is not empty → ostrukturerad (pre-5.2)
//
//   Kontrastera med Instance-LocationBlekingesjukhuset som visar 5.2+
//   strukturerad adress med address.line[].
//
// address.city                      ← l = "Ronneby"
//   OBS: I legacy-form sätts city från l-attributet separat, trots att det
//   INTE finns i hsaVisitingAddress-strukturen. Gatuadressen i streetAddress
//   innehåller normalt INTE orten — den anges i l-attributet.
// address.postalCode                ← 0..0 (Uppsala-regel: besöksadress saknar postnummer)
// position.latitude                 ← hsaSweRef99Latitude = 56.2098
// position.longitude                ← hsaSweRef99Longitude = 15.2791
// description                       ← hsaVpwNavigation (ej Markdown-rubrikstruktur
//                                      i detta exempel — äldre data utan rubriker)
// managingOrganization              ← Reference(RonnebyVardcentralVardenhet)
// meta.security[destination-indicator] ← hsaDestinationIndicator=03 (ärvs från enhet)
// ═══════════════════════════════════════════════════════════════════════════════

Instance: LocationRonnebyVardcentral
InstanceOf: HsaCatalogLocation
Usage: #example
Title: "Ronneby Vårdcentral (Besöksplats, legacy adress)"
Description: """
  Exempelinstans för Ronneby Vårdcentrals fysiska besöksplats med legacy
  adressformat (pre-HSA 5.2).

  Demonstrerar: address.text (ostrukturerat streetAddress-attribut) som
  övergångsmönster under migrationsperioden t.o.m. september 2026, jämfört
  med address.line[] i LocationBlekingesjukhuset (strukturerat 5.2+).

  Konsumenter bör kontrollera om address.line är satt för att avgöra vilket
  format som används — address.text är fallback för ej-migrerade enheter.
"""

* id = "location-ronneby-vardcentral"

// Publik synlighet: destinationIndicator=03
* meta.security[destination-indicator]
  * system = "urn:oid:1.2.752.29.23.1.11"
  * code = #03
  * display = "Internet/allmänheten"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE5566778899-RNBY1"

* status = #active

* name = "Ronneby Vårdcentral"

* mode = #instance

// ── Besöksadress (legacy pre-5.2: streetAddress → address.text) ──────────────
// streetAddress = "Järnvägsgatan 14" → address.text (ostrukturerat)
// city hämtas från l-attributet = "Ronneby"
// Kontrastera med LocationBlekingesjukhuset: address.line[0] = "Lyckeby 5"
* address
  * type = #physical
  * text = "Järnvägsgatan 14"
  * city = "Ronneby"
  // Obs: postalCode saknas avsiktligt — besöksadress har aldrig postnummer
  // (Uppsala-regel). Postnumret 372 35 hör till postadress på Organization.

// ── Koordinater (SWEREF99) ────────────────────────────────────────────────────
* position
  * latitude = 56.2098
  * longitude = 15.2791

// ── Vägbeskrivning ────────────────────────────────────────────────────────────
// Äldre data utan Markdown-rubrikstruktur — description är en enkel textsträng.
// Klienter bör hantera description utan garanterad Markdown-struktur.
* description = "Centralt läge i Ronneby, 200 m från järnvägsstationen. Parkering bakom fastigheten, ingång från Järnvägsgatan 14."

// ── Ansvarig organisation ─────────────────────────────────────────────────────
* managingOrganization = Reference(RonnebyVardcentralVardenhet)
