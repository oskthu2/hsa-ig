# Hjärtmottagningen Karlskrona (Vårdenhet) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Hjärtmottagningen Karlskrona (Vårdenhet)**

## Example Organization: Hjärtmottagningen Karlskrona (Vårdenhet)

Profil: [HSA Healthcare Unit Organization](StructureDefinition-hsa-healthcare-unit-organization.md)

Säkerhetsetikett: 

Hjärtmottagningen Karlskrona (Vårdenhet, Specialiserad somatisk vård, Mottagning, Landsting/region) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE2321000081-HJRT01)

-------

| | |
| :--- | :--- |
| Aktiv: | true |
| Type: | * Vårdenhet
* Specialiserad somatisk vård
* Mottagning
* Landsting/region
 |
| Part Of: | [Region Blekinge (Vårdgivare, Landsting/region) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE2321000081-BLKNG)](Organization-region-blekinge-vardgivare.md) |
| Kontaktuppgift | * [+46455734800](tel:+46455734800)
* [+46455731000](tel:+46455731000)
* [hjartvard@regionblekinge.se](mailto:hjartvard@regionblekinge.se)
* [redaktion.hjart@regionblekinge.se](mailto:redaktion.hjart@regionblekinge.se)
* [https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE2321000081-HJRT01](https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE2321000081-HJRT01)
 |
| Kontaktuppgift | * Lyckeby 5
 |
| [HSA Information till patient](StructureDefinition-hsa-patient-info.md) | Ta med aktuell medicinlista och remiss till ditt besök. Kontakta oss i god tid om du behöver avboka. |
| [Organization Period](http://hl7.org/fhir/extensions/5.4.0/StructureDefinition-organization-period.html) | 2006-03-01 --> 2028-01-01 |
| HSA Tillfällig information: | * text: Tillfällig lokal under renovering. Vi finns nu i byggnad B, plan 4.
* period: 2026-09-01 --> 2027-12-31
 |



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "hjartmottagningen-vardenhet",
  "meta" : {
    "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"],
    "security" : [{
      "system" : "urn:oid:1.2.752.29.23.1.11",
      "code" : "03",
      "display" : "Internet/allmänheten"
    }]
  },
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/organization-period",
    "valuePeriod" : {
      "start" : "2006-03-01",
      "end" : "2028-01-01"
    }
  },
  {
    "extension" : [{
      "url" : "text",
      "valueString" : "Tillfällig lokal under renovering. Vi finns nu i byggnad B, plan 4."
    },
    {
      "url" : "period",
      "valuePeriod" : {
        "start" : "2026-09-01",
        "end" : "2027-12-31"
      }
    }],
    "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice"
  },
  {
    "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info",
    "valueString" : "Ta med aktuell medicinlista och remiss till ditt besök. Kontakta oss i god tid om du behöver avboka."
  }],
  "identifier" : [{
    "system" : "urn:oid:1.2.752.29.4.19",
    "value" : "SE2321000081-HJRT01"
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
      "code" : "15",
      "display" : "Mottagning"
    }]
  },
  {
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.14",
      "code" : "01",
      "display" : "Landsting/region"
    }]
  }],
  "name" : "Hjärtmottagningen Karlskrona",
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
      "value" : "+46455734800",
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
      "system" : "email",
      "value" : "hjartvard@regionblekinge.se",
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
      "value" : "redaktion.hjart@regionblekinge.se",
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
      "value" : "https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE2321000081-HJRT01",
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
