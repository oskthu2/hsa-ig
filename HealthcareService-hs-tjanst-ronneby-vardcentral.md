# Ronneby Vårdcentral Tjänsteutbud (HealthcareService) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Ronneby Vårdcentral Tjänsteutbud (HealthcareService)**

## Example HealthcareService: Ronneby Vårdcentral Tjänsteutbud (HealthcareService)

Profil: [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)

Säkerhetsetikett: 

**HSA Tillfällig information (text)**: Telefonköerna är kortast tidigt på morgonen (07:30-08:00). Ring gärna vid öppning för snabbare svar.

**HSA Information till patient**: Du kan lista dig hos oss via 1177.se. Vi tar emot både bokade besök och drop-in.

**active**: true

**providedBy**: [Organization Ronneby Vårdcentral](Organization-ronneby-vardcentral-vardenhet.md)

**category**: Allmänmedicin

**type**: Öppen vård

**location**: [Location Ronneby Vårdcentral](Location-location-ronneby-vardcentral.md)

**name**: Allmänmedicin Ronneby Vårdcentral

**comment**: 

Vi är din fasta läkarkontakt för allmänmedicin och förebyggande vård i Ronneby. Listning görs via 1177.se.

> **availability**
> **availableTime****daysOfWeek**: Monday, Tuesday, Wednesday, Thursday, Friday**availableStartTime**: 08:00:00**availableEndTime**: 17:00:00

> **availability**
> **availableTime****daysOfWeek**: Monday, Tuesday, Wednesday, Thursday, Friday**availableStartTime**: 07:30:00**availableEndTime**: 08:00:00

> **availability**
> **availableTime****daysOfWeek**: Monday**availableStartTime**: 13:00:00**availableEndTime**: 16:00:00

> **availableTime****daysOfWeek**: Wednesday**availableStartTime**: 13:00:00**availableEndTime**: 16:00:00



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
    "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice",
    "valueString" : "Telefonköerna är kortast tidigt på morgonen (07:30-08:00). Ring gärna vid öppning för snabbare svar."
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
    "availableTime" : [{
      "daysOfWeek" : ["mon", "tue", "wed", "thu", "fri"],
      "availableStartTime" : "08:00:00",
      "availableEndTime" : "17:00:00"
    }]
  },
  {
    "availableTime" : [{
      "daysOfWeek" : ["mon", "tue", "wed", "thu", "fri"],
      "availableStartTime" : "07:30:00",
      "availableEndTime" : "08:00:00"
    }]
  },
  {
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
