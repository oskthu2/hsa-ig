# Blekinge Primärvård AB (Privat Vårdgivare) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Blekinge Primärvård AB (Privat Vårdgivare)**

## Example Organization: Blekinge Primärvård AB (Privat Vårdgivare)

Profil: [HSA Healthcare Provider Organization](StructureDefinition-hsa-healthcare-provider-organization.md)

Blekinge Primärvård AB (Vårdgivare, Privat) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE5566778899-BPAB1)

-------

| | |
| :--- | :--- |
| Aktiv: | true |
| Type: | * Vårdgivare
* Privat
 |
| Annat id: | [Organisationsnummer (Sverige)](NamingSystem-organisation-nummer.md)/556677-8899 |
| Kontaktuppgift | * [+46457556677](tel:+46457556677)
* [+46457556600](tel:+46457556600)
* [info@blekingeprimaervard.se](mailto:info@blekingeprimaervard.se)
* [redaktion@blekingeprimaervard.se](mailto:redaktion@blekingeprimaervard.se)
* [https://www.blekingeprimaervard.test](https://www.blekingeprimaervard.test)
 |
| Kontaktuppgift | * Järnvägsgatan 12
 |



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "privat-vardgivare-ab",
  "meta" : {
    "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"]
  },
  "identifier" : [{
    "system" : "urn:oid:1.2.752.29.4.19",
    "value" : "SE5566778899-BPAB1"
  },
  {
    "system" : "urn:oid:2.5.4.97",
    "value" : "556677-8899"
  }],
  "active" : true,
  "type" : [{
    "coding" : [{
      "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class",
      "code" : "healthcare-provider",
      "display" : "Vårdgivare"
    }]
  },
  {
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.14",
      "code" : "05",
      "display" : "Privat"
    }]
  }],
  "name" : "Blekinge Primärvård AB",
  "contact" : [{
    "telecom" : [{
      "extension" : [{
        "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type",
        "valueCoding" : {
          "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type",
          "code" : "direct-phone",
          "display" : "Direkttelefon"
        }
      }],
      "system" : "phone",
      "value" : "+46457556677",
      "use" : "work"
    },
    {
      "extension" : [{
        "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type",
        "valueCoding" : {
          "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type",
          "code" : "switchboard",
          "display" : "Växeltelefon"
        }
      }],
      "system" : "phone",
      "value" : "+46457556600",
      "use" : "work"
    },
    {
      "system" : "email",
      "value" : "info@blekingeprimaervard.se",
      "use" : "work"
    },
    {
      "extension" : [{
        "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type",
        "valueCoding" : {
          "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type",
          "code" : "directory-contact",
          "display" : "Innehållsansvarig"
        }
      }],
      "system" : "email",
      "value" : "redaktion@blekingeprimaervard.se",
      "use" : "work"
    },
    {
      "system" : "url",
      "value" : "https://www.blekingeprimaervard.test",
      "use" : "work"
    }]
  },
  {
    "address" : {
      "type" : "postal",
      "text" : "Järnvägsgatan 12",
      "city" : "Ronneby",
      "postalCode" : "37235"
    }
  }]
}

```
