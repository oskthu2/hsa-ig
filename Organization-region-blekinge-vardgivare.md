# Region Blekinge (Vårdgivare) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Region Blekinge (Vårdgivare)**

## Example Organization: Region Blekinge (Vårdgivare)

Profil: [HSA Healthcare Provider Organization](StructureDefinition-hsa-healthcare-provider-organization.md)

**identifier**: [HSA-identitet (HSA-id)](NamingSystem-hsa-identity.md)/SE2321000016-BLKNG, [Organisationsnummer (Sverige)](NamingSystem-organisation-nummer.md)/2321000016, [Global Location Number (GLN)](http://terminology.hl7.org/7.4.0/NamingSystem-GLN.html)/7350088100003

**active**: true

**type**: Vårdgivare, Landsting/region

**name**: Region Blekinge

### Contacts

| | | |
| :--- | :--- | :--- |
| - | **Telecom** | **Address** |
| * | ph: 0455-73 10 00(Work), ph: 0455-73 10 00(Work),[region@regionblekinge.se](mailto:region@regionblekinge.se),[redaktion@regionblekinge.se](mailto:redaktion@regionblekinge.se),[https://www.regionblekinge.se](https://www.regionblekinge.se) |  |
| * |  | Box 515 |



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "region-blekinge-vardgivare",
  "meta" : {
    "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"]
  },
  "identifier" : [{
    "system" : "urn:oid:1.2.752.29.4.19",
    "value" : "SE2321000016-BLKNG"
  },
  {
    "system" : "urn:oid:2.5.4.97",
    "value" : "2321000016"
  },
  {
    "system" : "urn:oid:1.3.88",
    "value" : "7350088100003"
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
      "code" : "01",
      "display" : "Landsting/region"
    }]
  }],
  "name" : "Region Blekinge",
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
      "value" : "0455-73 10 00",
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
      "system" : "email",
      "value" : "region@regionblekinge.se",
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
      "value" : "redaktion@regionblekinge.se",
      "use" : "work"
    },
    {
      "system" : "url",
      "value" : "https://www.regionblekinge.se",
      "use" : "work"
    }]
  },
  {
    "address" : {
      "type" : "postal",
      "text" : "Box 515",
      "city" : "Karlskrona",
      "postalCode" : "371 81"
    }
  }]
}

```
