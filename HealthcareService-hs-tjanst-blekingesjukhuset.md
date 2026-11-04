# Blekingesjukhuset Tjänsteutbud (HealthcareService) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Blekingesjukhuset Tjänsteutbud (HealthcareService)**

## Example HealthcareService: Blekingesjukhuset Tjänsteutbud (HealthcareService)

Profil: [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)

Säkerhetsetikett: 

Internmedicin och Kardiologi (Öppen vård) by Blekingesjukhuset (Vårdenhet, Specialiserad somatisk vård, Sjukhus, Landsting/region) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE2321000081-BSJH01)

-------

| | |
| :--- | :--- |
| Aktiv: | true |
| Provided By: | [Blekingesjukhuset (Vårdenhet, Specialiserad somatisk vård, Sjukhus, Landsting/region) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE2321000081-BSJH01)](Organization-blekingesjukhuset-vardenhet.md) |
| Category: | Internmedicin |
| Type: | Öppen vård |
| Location: | [Blekingesjukhuset (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE2321000081-BSJH01)](Location-location-blekingesjukhuset.md) |
| Comment: | Akutmottagning är öppen dygnet runt alla dagar. Planerade mottagningar kräver remiss via din vårdcentral. |
| Availability: | * Monday, Tuesday, Wednesday, Thursday, Friday: 08:00:00 - 16:30:00
* Monday, Tuesday, Wednesday, Thursday, Friday: 08:00:00 - 11:00:00
* Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday: all day
* Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday: 08:00:00 - 12:30:00
 |



## Resource Content

```json
{
  "resourceType" : "HealthcareService",
  "id" : "hs-tjanst-blekingesjukhuset",
  "meta" : {
    "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-service"],
    "security" : [{
      "system" : "urn:oid:1.2.752.29.23.1.11",
      "code" : "03",
      "display" : "Internet/allmänheten"
    }]
  },
  "active" : true,
  "providedBy" : {
    "reference" : "Organization/blekingesjukhuset-vardenhet"
  },
  "category" : [{
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.3",
      "code" : "1101",
      "display" : "Internmedicin"
    },
    {
      "system" : "urn:oid:1.2.752.129.2.2.1.3",
      "code" : "1126",
      "display" : "Kardiologi"
    }]
  }],
  "type" : [{
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.13",
      "code" : "01",
      "display" : "Öppen vård"
    },
    {
      "system" : "urn:oid:1.2.752.129.2.2.1.13",
      "code" : "02",
      "display" : "Sluten vård"
    }]
  }],
  "location" : [{
    "reference" : "Location/location-blekingesjukhuset"
  }],
  "name" : "Internmedicin och Kardiologi",
  "comment" : "Akutmottagning är öppen dygnet runt alla dagar. Planerade mottagningar kräver remiss via din vårdcentral.",
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
      "availableEndTime" : "16:30:00"
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
      "daysOfWeek" : ["mon", "tue", "wed", "thu", "fri"],
      "availableStartTime" : "08:00:00",
      "availableEndTime" : "11:00:00"
    }]
  },
  {
    "extension" : [{
      "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-type",
      "valueCoding" : {
        "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type",
        "code" : "surgery-hours",
        "display" : "Öppettider"
      }
    },
    {
      "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-comment",
      "valueString" : "Akutmottagning"
    }],
    "availableTime" : [{
      "daysOfWeek" : ["mon",
      "tue",
      "wed",
      "thu",
      "fri",
      "sat",
      "sun"],
      "allDay" : true
    }]
  },
  {
    "extension" : [{
      "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-type",
      "valueCoding" : {
        "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type",
        "code" : "surgery-hours",
        "display" : "Öppettider"
      }
    },
    {
      "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-comment",
      "valueString" : "Halvdag"
    },
    {
      "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-availability-period",
      "valuePeriod" : {
        "start" : "2026-12-23",
        "end" : "2026-12-23"
      }
    }],
    "availableTime" : [{
      "daysOfWeek" : ["mon",
      "tue",
      "wed",
      "thu",
      "fri",
      "sat",
      "sun"],
      "availableStartTime" : "08:00:00",
      "availableEndTime" : "12:30:00"
    }]
  }]
}

```
