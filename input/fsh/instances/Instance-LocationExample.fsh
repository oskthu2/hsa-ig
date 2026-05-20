// ─── Exempelinstans: Plats (Location) ────────────────────────────────────────
// Visar HsaCatalogLocation med besöksadress, SWEREF99-koordinater och
// vägbeskrivning i description (Markdown). Platsen är publik (meta.security 03)
// vilket kräver position (koordinater) per hsacat-public-location-position.

Instance: LocationExample
InstanceOf: HsaCatalogLocation
Usage: #example
Title: "Exempelmottagningens besöksadress"
Description: "Exempelplats med SWEREF99-koordinater, Markdown-vägbeskrivning och besöksadress utan postnummer."

* id = "location-example"

// Publik synlighet via meta.security
* meta.security[destination-indicator]
  * system = "urn:oid:1.2.752.29.23.1.11"
  * code = #03
  * display = "Internet/allmänheten"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-EXAMPLE3"

* status = #active

* name = "Exempelmottagningen, plan 3"

* mode = #instance

// Vägbeskrivning som Markdown med standardiserade rubriker (ADR-012).
// Klienter bör rendera detta fält som Markdown.
* description = """## Yttre vägbeskrivning
Tunnelbana röd linje, station Hälsoplanen (3 min gångväg). Buss 42, hållplats Hälsogatan.

## Inre vägbeskrivning
Gå in genom huvudentrén, hiss eller trappa till plan 3. Mottagningen till vänster."""

* address
  * type = #physical
  * line[0] = "Hälsogatan 1"
  * line[+] = "Plan 3"
  * city = "Stockholm"
  // postalCode utelämnas avsiktligt (Uppsala-regel: besöksadress ska ej ha postnummer)

// SWEREF99 TM-koordinater (latitud/longitud i grader)
* position
  * latitude = 59.334591
  * longitude = 18.063240

* managingOrganization = Reference(VardenhetExample)
