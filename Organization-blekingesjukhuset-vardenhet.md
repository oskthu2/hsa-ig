# Blekingesjukhuset (Vårdenhet) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Blekingesjukhuset (Vårdenhet)**

## Example Organization: Blekingesjukhuset (Vårdenhet)

Profil: [HSA Healthcare Unit Organization](StructureDefinition-hsa-healthcare-unit-organization.md)

Säkerhetsetikett: 

**identifier**: [HSA-identitet (HSA-id)](NamingSystem-hsa-identity.md)/SE2321000016-BSJH01, [Organisationsnummer (Sverige)](NamingSystem-organisation-nummer.md)/2321000016, `urn:oid:1.2.752.29.4.71`/1301033, [Global Location Number (GLN)](http://terminology.hl7.org/7.4.0/NamingSystem-GLN.html)/7350088110002

**active**: true

**type**: Vårdenhet, Specialiserad somatisk vård, Sjukhus, Landsting/region

**name**: Blekingesjukhuset

### Contacts

| | | |
| :--- | :--- | :--- |
| - | **Telecom** | **Address** |
| * | ph: 0455-73 17 00(Work), ph: 0455-73 10 00(Work), ph: 070-123 45 67(Mobile), fax: 0455-73 17 99(Work),[blekingesjukhuset@regionblekinge.se](mailto:blekingesjukhuset@regionblekinge.se),[redaktion.bsj@regionblekinge.se](mailto:redaktion.bsj@regionblekinge.se),[https://www.regionblekinge.se/blekingesjukhuset](https://www.regionblekinge.se/blekingesjukhuset),[https://www.1177.test/blekinge/hitta-vard/SE2321000016-BSJH01](https://www.1177.test/blekinge/hitta-vard/SE2321000016-BSJH01) |  |
| * |  | Lyckeby 5 |

**partOf**: [Organization Region Blekinge](Organization-region-blekinge-vardgivare.md)



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
    "value" : "SE2321000016-BSJH01"
  },
  {
    "system" : "urn:oid:2.5.4.97",
    "value" : "2321000016"
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
      "value" : "0455-73 17 00",
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
      "value" : "0455-73 10 00",
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
      "value" : "070-123 45 67",
      "use" : "mobile"
    },
    {
      "system" : "fax",
      "value" : "0455-73 17 99",
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
      "value" : "https://www.1177.test/blekinge/hitta-vard/SE2321000016-BSJH01",
      "use" : "work"
    }]
  },
  {
    "address" : {
      "type" : "postal",
      "text" : "Lyckeby 5",
      "city" : "Karlskrona",
      "postalCode" : "371 85"
    }
  }],
  "partOf" : {
    "reference" : "Organization/region-blekinge-vardgivare"
  }
}

```
