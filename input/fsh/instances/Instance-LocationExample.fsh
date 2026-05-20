// ─── Exempelinstans: Plats (Location) ────────────────────────────────────────
// Visar HsaCatalogLocation med besöksadress, SWEREF99-koordinater och
// vägbeskrivning. Platsen är publik (destinationIndicator=03) vilket
// kräver position (koordinater) per hsacat-public-location-position.

Instance: LocationExample
InstanceOf: HsaCatalogLocation
Usage: #example
Title: "Exempelmottagningens besöksadress"
Description: "Exempelplats med SWEREF99-koordinater, vägbeskrivning och besöksadress utan postnummer."

* id = "location-example"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-EXAMPLE3"

* status = #active

* name = "Exempelmottagningen, plan 3"

* mode = #instance

* address
  * type = #physical
  * line[0] = "Hälsogatan 1"
  * line[+] = "Plan 3"
  * city = "Stockholm"
  // postalCode utelämnas avsiktligt (Uppsala-regel: besöksadress ska ej ha postnummer)

// SWEREF99 TM-koordinater (latitud/longitud i grader)
// Koordinater för Stockholms innerstad som exempeldata
* position
  * latitude = 59.334591
  * longitude = 18.063240

* managingOrganization = Reference(VardenhetExample)

* extension[destinationIndicator]
  * valueCoding
    * system = "urn:oid:1.2.752.29.23.1.11"
    * code = #03
    * display = "Internet/allmänheten"

// Yttre vägbeskrivning (hur man hittar hit med kollektivtrafik)
* extension[navigation]
  * extension[outer]
    * valueString = "Tunnelbana röd linje, station Hälsoplanen (3 min gångväg). Buss 42, hållplats Hälsogatan."
  * extension[inner]
    * valueString = "Gå in genom huvudentrén, hiss eller trappa till plan 3. Mottagningen till vänster."
