// ─── Exempelinstans: Vårdgivare ───────────────────────────────────────────────
// Visar HsaHealthcareProviderOrganization med HSA-id, organisationsnummer,
// destinationIndicator=03 (publik på 1177) och kontaktinformation.

Instance: VardgivareExample
InstanceOf: HsaHealthcareProviderOrganization
Usage: #example
Title: "Exempelvårdgivare AB"
Description: "Exempelinstans för en privat vårdgivare publik på 1177 Hitta vård."

* id = "vardgivare-example"

* identifier[hsa-id]
  * system = "urn:oid:1.2.752.29.4.19"
  * value = "SE2321000016-EXAMPLE1"

* identifier[org-no]
  * system = "urn:oid:2.5.4.97"
  * value = "232100-0016"

* active = true

* type[hsa-class]
  * coding[0]
    * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class"
    * code = #healthcare-provider
    * display = "Vårdgivare"

* type[ownership]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.14"
    * code = #02
    * display = "Privat"

* name = "Exempelvårdgivare AB"

* extension[destinationIndicator]
  * valueCoding
    * system = "urn:oid:1.2.752.29.23.1.11"
    * code = #03
    * display = "Internet/allmänheten"

// Direkttelefon (obligatorisk för publik enhet via hsacat-public-org-telecom)
* contact[0]
  * telecom[0]
    * system = #phone
    * value = "+46812345678"
    * use = #work
    * extension[telecomType]
      * valueCoding
        * system = "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type"
        * code = #direct-phone
        * display = "Direkttelefon"

// Postadress
* contact[1]
  * address
    * type = #postal
    * line[0] = "Box 100"
    * postalCode = "111 22"
    * city = "Stockholm"

// Finansierande region (frivillig, men vanlig i VGR/KIV)
* extension[financingOrganization]
  * valueCoding
    * system = "urn:oid:1.2.752.129.5.1.1"
    * code = #SE2321000016
    * display = "Region Stockholm"
