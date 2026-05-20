// ─── Exempelinstans: Vårdenhet ────────────────────────────────────────────────
// Visar HsaHealthcareUnitOrganization med partOf → VardgivareExample,
// administrativ vårdnivå och tillfällig information.

Instance: VardenhetExample
InstanceOf: HsaHealthcareUnitOrganization
Usage: #example
Title: "Exempelmottagningen"
Description: "Exempelinstans för en vårdenhet (mottagning) under en vårdgivare."

* id = "vårdenhet-example"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-EXAMPLE2"

* active = true

* type[hsa-class]
  * coding[0]
    * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    * code = #healthcare-unit
    * display = "Vårdenhet"

* name = "Exempelmottagningen"

* partOf = Reference(VardgivareExample)

* extension[destinationIndicator]
  * valueCoding
    * system = "urn:oid:1.2.752.29.23.1.11"
    * code = #03
    * display = "Internet/allmänheten"

// Administrativ vårdnivå (obligatorisk för vårdenheter per HSACAT-ORG-009)
* extension[HsaAdministrativeCareLevelExtension]
  * valueCoding
    * system = "urn:oid:1.2.752.129.5.1.46"
    * code = #01
    * display = "Primärvård"

// Tillfällig information med obligatoriskt slutdatum
* extension[temporaryInfo]
  * extension[text]
    * valueString = "Vi har tillfälligt stängt fredagar under sommaren 2026."
  * extension[period]
    * valuePeriod
      * start = "2026-06-01"
      * end = "2026-08-31"

// Direkttelefon
* contact[0]
  * telecom[0]
    * system = #phone
    * value = "+46812345679"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #direct-phone
        * display = "Direkttelefon"
  * telecom[1]
    * system = #phone
    * value = "+46800000000"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #switchboard
        * display = "Växeltelefon"
  * telecom[2]
    * system = #email
    * value = "mottagning@example.se"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #directory-contact
        * display = "Innehållsansvarig"
