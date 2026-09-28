# Ronneby Vårdcentral (Vårdenhet, privat utförare) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Ronneby Vårdcentral (Vårdenhet, privat utförare)**

## Example Organization: Ronneby Vårdcentral (Vårdenhet, privat utförare)

Profil: [HSA Healthcare Unit Organization](StructureDefinition-hsa-healthcare-unit-organization.md)

Säkerhetsetikett: 

**HSA Finansierande region/kommun**: okänd: SE2321000016-BLKNG (Region Blekinge)

**HSA Information till patient**: Du kan lista dig hos oss via 1177.se. Vi tar emot både bokade besök och drop-in.

**identifier**: [HSA-identitet (HSA-id)](NamingSystem-hsa-identity.md)/SE5566778899-RNBY1, `urn:oid:1.2.752.29.4.71`/1082040

**active**: true

**type**: Vårdenhet, Primärvård, Vårdcentral, Privat

**name**: Ronneby Vårdcentral

### Contacts

| | | |
| :--- | :--- | :--- |
| - | **Telecom** | **Address** |
| * | ph: 0457-55 66 88(Work), ph: 0457-55 66 00(Work), ph: 072-987 65 43(Mobile),[ronneby@blekingeprimaervard.se](mailto:ronneby@blekingeprimaervard.se),[redaktion.ronneby@blekingeprimaervard.se](mailto:redaktion.ronneby@blekingeprimaervard.se),[https://www.1177.test/blekinge/hitta-vard/SE5566778899-RNBY1](https://www.1177.test/blekinge/hitta-vard/SE5566778899-RNBY1) |  |
| * |  | Järnvägsgatan 14 |

**partOf**: [Organization Blekinge Primärvård AB](Organization-privat-vardgivare-ab.md)



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "ronneby-vardcentral-vardenhet",
  "meta" : {
    "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"],
    "security" : [{
      "system" : "urn:oid:1.2.752.29.23.1.11",
      "code" : "03",
      "display" : "Internet/allmänheten"
    }]
  },
  "extension" : [{
    "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-financing-organization",
    "valueCoding" : {
      "system" : "urn:oid:1.2.752.129.5.1.1",
      "code" : "SE2321000016-BLKNG",
      "display" : "Region Blekinge"
    }
  },
  {
    "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info",
    "valueString" : "Du kan lista dig hos oss via 1177.se. Vi tar emot både bokade besök och drop-in."
  }],
  "identifier" : [{
    "system" : "urn:oid:1.2.752.29.4.19",
    "value" : "SE5566778899-RNBY1"
  },
  {
    "system" : "urn:oid:1.2.752.29.4.71",
    "value" : "1082040"
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
      "code" : "01",
      "display" : "Primärvård"
    }]
  },
  {
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.12",
      "code" : "05",
      "display" : "Vårdcentral"
    }]
  },
  {
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.14",
      "code" : "05",
      "display" : "Privat"
    }]
  }],
  "name" : "Ronneby Vårdcentral",
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
      "value" : "0457-55 66 88",
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
      "value" : "0457-55 66 00",
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
      "value" : "072-987 65 43",
      "use" : "mobile"
    },
    {
      "system" : "email",
      "value" : "ronneby@blekingeprimaervard.se",
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
      "value" : "redaktion.ronneby@blekingeprimaervard.se",
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
      "value" : "https://www.1177.test/blekinge/hitta-vard/SE5566778899-RNBY1",
      "use" : "work"
    }]
  },
  {
    "address" : {
      "type" : "postal",
      "text" : "Järnvägsgatan 14",
      "city" : "Ronneby",
      "postalCode" : "372 35"
    }
  }],
  "partOf" : {
    "reference" : "Organization/privat-vardgivare-ab"
  }
}

```
