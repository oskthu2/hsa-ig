// ─── Exempelinstans: Vårdenhet ────────────────────────────────────────────────
// Visar HsaHealthcareUnitOrganization med partOf → VardgivareExample,
// administrativ vårdnivå (type[care-level]) och tillfällig period (orgPeriod).

Instance: VardenhetExample
InstanceOf: HsaHealthcareUnitOrganization
Usage: #example
Title: "Exempelmottagningen"
Description: "Exempelinstans för en vårdenhet (mottagning) under en vårdgivare."

* id = "vardenhet-example"

// Publik synlighet via meta.security
* meta.security[destination-indicator]
  * system = "urn:oid:1.2.752.29.23.1.11"
  * code = #03
  * display = "Internet/allmänheten"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-EXAMPLE2"

* active = true

* type[hsa-class]
  * coding[0]
    * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    * code = #healthcare-unit
    * display = "Vårdenhet"

// Administrativ vårdnivå (obligatorisk för vårdenheter, HSACAT-ORG-009)
* type[care-level]
  * coding[0]
    * system = "urn:oid:1.2.752.129.5.1.46"
    * code = #01
    * display = "Primärvård"

* name = "Exempelmottagningen"

* partOf = Reference(VardgivareExample)

// Tillfällig information: period (obligatoriskt slutdatum) + notistext.
// Klienter bör rendera gul informationsruta när orgPeriod + temporaryNotice är satt och active = true.
* extension[orgPeriod]
  * valuePeriod
    * start = "2026-06-01"
    * end = "2026-08-31"

* extension[temporaryNotice]
  * valueString = "Vi har tillfälligt stängt fredagar under sommaren 2026."

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
