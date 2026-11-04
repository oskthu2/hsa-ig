# Ronneby Vårdcentral Tjänsteutbud (HealthcareService) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Ronneby Vårdcentral Tjänsteutbud (HealthcareService)**

## Example HealthcareService: Ronneby Vårdcentral Tjänsteutbud (HealthcareService)

Profil: [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)

Säkerhetsetikett: 

Allmänmedicin Ronneby Vårdcentral (Öppen vård) by Ronneby Vårdcentral (Vårdenhet, Primärvård, Vårdcentral, Privat) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE5566778899-RNBY1)

-------

| | |
| :--- | :--- |
| Aktiv: | true |
| Provided By: | [Ronneby Vårdcentral (Vårdenhet, Primärvård, Vårdcentral, Privat) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE5566778899-RNBY1)](Organization-ronneby-vardcentral-vardenhet.md) |
| Category: | Allmänmedicin |
| Type: | Öppen vård |
| Location: | [Ronneby Vårdcentral (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE5566778899-RNBY1)](Location-location-ronneby-vardcentral.md) |
| Comment: | Vi är din fasta läkarkontakt för allmänmedicin och förebyggande vård i Ronneby. Listning görs via 1177.se. |
| Availability: | * Monday, Tuesday, Wednesday, Thursday, Friday: 08:00:00 - 17:00:00
* Monday, Tuesday, Wednesday, Thursday, Friday: 07:30:00 - 08:00:00
* Monday: 13:00:00 - 16:00:00
* Wednesday: 13:00:00 - 16:00:00
 |
| [HSA Information till patient](StructureDefinition-hsa-patient-info.md) | Du kan lista dig hos oss via 1177.se. Vi tar emot både bokade besök och drop-in. |
| HSA Tillfällig information: | * text: Telefonköerna är kortast tidigt på morgonen (07:30-08:00). Ring gärna vid öppning för snabbare svar.
* period: 2026-11-01 --> 2026-12-31
 |



## Resource Content

```json
{
  "resourceType" : "HealthcareService",
  "id" : "hs-tjanst-ronneby-vardcentral",
  "meta" : {
    "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"],
    "security" : [{
      "system" : "urn:oid:1.2.752.29.23.1.11",
      "code" : "03",
      "display" : "Internet/allmänheten"
    }]
  },
  "extension" : [{
    "extension" : [{
      "url" : "text",
      "valueString" : "Telefonköerna är kortast tidigt på morgonen (07:30-08:00). Ring gärna vid öppning för snabbare svar."
    },
    {
      "url" : "period",
      "valuePeriod" : {
        "start" : "2026-11-01",
        "end" : "2026-12-31"
      }
    }],
    "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice"
  },
  {
    "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info",
    "valueString" : "Du kan lista dig hos oss via 1177.se. Vi tar emot både bokade besök och drop-in."
  }],
  "active" : true,
  "providedBy" : {
    "reference" : "Organization/ronneby-vardcentral-vardenhet"
  },
  "category" : [{
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.3",
      "code" : "1502",
      "display" : "Allmänmedicin"
    }]
  }],
  "type" : [{
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.13",
      "code" : "01",
      "display" : "Öppen vård"
    }]
  }],
  "location" : [{
    "reference" : "Location/location-ronneby-vardcentral"
  }],
  "name" : "Allmänmedicin Ronneby Vårdcentral",
  "comment" : "Vi är din fasta läkarkontakt för allmänmedicin och förebyggande vård i Ronneby. Listning görs via 1177.se.",
  "availability" : [{
    "extension" : [{
      "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-type",
      "valueCoding" : {
        "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type",
        "code" : "telephone-hours",
        "display" : "Telefontider"
      }
    }],
    "availableTime" : [{
      "daysOfWeek" : ["mon", "tue", "wed", "thu", "fri"],
      "availableStartTime" : "08:00:00",
      "availableEndTime" : "17:00:00"
    }]
  },
  {
    "extension" : [{
      "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-type",
      "valueCoding" : {
        "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type",
        "code" : "telephone-hours",
        "display" : "Telefontider"
      }
    },
    {
      "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-comment",
      "valueString" : "Tidig telefontid"
    }],
    "availableTime" : [{
      "daysOfWeek" : ["mon", "tue", "wed", "thu", "fri"],
      "availableStartTime" : "07:30:00",
      "availableEndTime" : "08:00:00"
    }]
  },
  {
    "extension" : [{
      "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-type",
      "valueCoding" : {
        "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type",
        "code" : "drop-in-hours",
        "display" : "Drop-in"
      }
    }],
    "availableTime" : [{
      "daysOfWeek" : ["mon"],
      "availableStartTime" : "13:00:00",
      "availableEndTime" : "16:00:00"
    },
    {
      "daysOfWeek" : ["wed"],
      "availableStartTime" : "13:00:00",
      "availableEndTime" : "16:00:00"
    }]
  }]
}

```
