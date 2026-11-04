# Blekingesjukhuset (Vårdenhet) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Blekingesjukhuset (Vårdenhet)**

## Example Organization: Blekingesjukhuset (Vårdenhet)

Profil: [HSA Healthcare Unit Organization](StructureDefinition-hsa-healthcare-unit-organization.md)

Säkerhetsetikett: 

Blekingesjukhuset (Vårdenhet, Specialiserad somatisk vård, Sjukhus, Landsting/region) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE2321000081-BSJH01)

-------

| | |
| :--- | :--- |
| Aktiv: | true |
| Type: | * Vårdenhet
* Specialiserad somatisk vård
* Sjukhus
* Landsting/region
 |
| Part Of: | [Region Blekinge (Vårdgivare, Landsting/region) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE2321000081-BLKNG)](Organization-region-blekinge-vardgivare.md) |
| Andra id:n: | * [Organisationsnummer (Sverige)](NamingSystem-organisation-nummer.md)/232100-0081
* `urn:oid:1.2.752.29.4.71`/1301033
* [Global Location Number (GLN)](http://terminology.hl7.org/7.5.0/NamingSystem-GLN.html)/7350088110002
 |
| Kontaktuppgift | * [+46455731700](tel:+46455731700)
* [+46455731000](tel:+46455731000)
* [+46701234567](tel:+46701234567)
* fax: +46455731799(Work)
* [blekingesjukhuset@regionblekinge.se](mailto:blekingesjukhuset@regionblekinge.se)
* [redaktion.bsj@regionblekinge.se](mailto:redaktion.bsj@regionblekinge.se)
* [https://www.regionblekinge.se/blekingesjukhuset](https://www.regionblekinge.se/blekingesjukhuset)
* [https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE2321000081-BSJH01](https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE2321000081-BSJH01)
 |
| Kontaktuppgift | * Lyckeby 5
 |



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "blekingesjukhuset-vardenhet",
  "meta" : {
    "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"],
    "security" : [{
      "system" : "urn:oid:1.2.752.29.23.1.11",
      "code" : "03",
      "display" : "Internet/allmänheten"
    }]
  },
  "identifier" : [{
    "system" : "urn:oid:1.2.752.29.4.19",
    "value" : "SE2321000081-BSJH01"
  },
  {
    "system" : "urn:oid:2.5.4.97",
    "value" : "232100-0081"
  },
  {
    "system" : "urn:oid:1.2.752.29.4.71",
    "value" : "1301033"
  },
  {
    "system" : "urn:oid:1.3.88",
    "value" : "7350088110002"
  }],
  "active" : true,
  "type" : [{
    "coding" : [{
      "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class",
      "code" : "healthcare-unit",
      "display" : "Vårdenhet"
    }]
  },
  {
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.5.1.46",
      "code" : "02",
      "display" : "Specialiserad somatisk vård"
    }]
  },
  {
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.12",
      "code" : "01",
      "display" : "Sjukhus"
    }]
  },
  {
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.14",
      "code" : "01",
      "display" : "Landsting/region"
    }]
  }],
  "name" : "Blekingesjukhuset",
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
      "value" : "+46455731700",
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
      "value" : "+46455731000",
      "use" : "work"
    },
    {
      "extension" : [{
        "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type",
        "valueCoding" : {
          "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type",
          "code" : "mobile",
          "display" : "Mobiltelefon"
        }
      }],
      "system" : "phone",
      "value" : "+46701234567",
      "use" : "mobile"
    },
    {
      "system" : "fax",
      "value" : "+46455731799",
      "use" : "work"
    },
    {
      "system" : "email",
      "value" : "blekingesjukhuset@regionblekinge.se",
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
      "value" : "redaktion.bsj@regionblekinge.se",
      "use" : "work"
    },
    {
      "system" : "url",
      "value" : "https://www.regionblekinge.se/blekingesjukhuset",
      "use" : "work"
    },
    {
      "extension" : [{
        "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type",
        "valueCoding" : {
          "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type",
          "code" : "vpw-webpage",
          "display" : "1177-kontaktkortsadress"
        }
      }],
      "system" : "url",
      "value" : "https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE2321000081-BSJH01",
      "use" : "work"
    }]
  },
  {
    "address" : {
      "type" : "postal",
      "text" : "Lyckeby 5",
      "city" : "Karlskrona",
      "postalCode" : "37185"
    }
  }],
  "partOf" : {
    "reference" : "Organization/region-blekinge-vardgivare"
  }
}

```
