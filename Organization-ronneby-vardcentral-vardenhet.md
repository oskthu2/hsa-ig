# Ronneby Vårdcentral (Vårdenhet, privat utförare) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Ronneby Vårdcentral (Vårdenhet, privat utförare)**

## Example Organization: Ronneby Vårdcentral (Vårdenhet, privat utförare)

Profil: [HSA Healthcare Unit Organization](StructureDefinition-hsa-healthcare-unit-organization.md)

Säkerhetsetikett: 

Ronneby Vårdcentral (Vårdenhet, Primärvård, Vårdcentral, Privat) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE5566778899-RNBY1)

-------

| | |
| :--- | :--- |
| Aktiv: | true |
| Type: | * Vårdenhet
* Primärvård
* Vårdcentral
* Privat
 |
| Part Of: | [Blekinge Primärvård AB (Vårdgivare, Privat) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE5566778899-BPAB1)](Organization-privat-vardgivare-ab.md) |
| Annat id: | `urn:oid:1.2.752.29.4.71`/1082040 |
| Kontaktuppgift | * [+46457556688](tel:+46457556688)
* [+46457556600](tel:+46457556600)
* [+46729876543](tel:+46729876543)
* [ronneby@blekingeprimaervard.se](mailto:ronneby@blekingeprimaervard.se)
* [redaktion.ronneby@blekingeprimaervard.se](mailto:redaktion.ronneby@blekingeprimaervard.se)
* [https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE5566778899-RNBY1](https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE5566778899-RNBY1)
 |
| Kontaktuppgift | * Järnvägsgatan 14
 |
| [HSA Finansierande region/kommun](StructureDefinition-hsa-financing-organization.md) | okänd: 232100-0081 (Region Blekinge) |
| [HSA Information till patient](StructureDefinition-hsa-patient-info.md) | Du kan lista dig hos oss via 1177.se. Vi tar emot både bokade besök och drop-in. |



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
      "code" : "232100-0081",
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
      "value" : "+46457556688",
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
      "extension" : [{
        "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type",
        "valueCoding" : {
          "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type",
          "code" : "mobile",
          "display" : "Mobiltelefon"
        }
      }],
      "system" : "phone",
      "value" : "+46729876543",
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
      "value" : "https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE5566778899-RNBY1",
      "use" : "work"
    }]
  },
  {
    "address" : {
      "type" : "postal",
      "text" : "Järnvägsgatan 14",
      "city" : "Ronneby",
      "postalCode" : "37235"
    }
  }],
  "partOf" : {
    "reference" : "Organization/privat-vardgivare-ab"
  }
}

```
