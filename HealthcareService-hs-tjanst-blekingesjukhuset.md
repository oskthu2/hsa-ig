# Blekingesjukhuset Tjänsteutbud (HealthcareService) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Blekingesjukhuset Tjänsteutbud (HealthcareService)**

## Example HealthcareService: Blekingesjukhuset Tjänsteutbud (HealthcareService)

Profil: [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)

Säkerhetsetikett: 

**active**: true

**providedBy**: [Organization Blekingesjukhuset](Organization-blekingesjukhuset-vardenhet.md)

**category**: Internmedicin

**type**: Öppen vård

**location**: [Location Blekingesjukhuset](Location-location-blekingesjukhuset.md)

**name**: Internmedicin och Kardiologi

**comment**: 

Akutmottagning är öppen dygnet runt alla dagar. Planerade mottagningar kräver remiss via din vårdcentral.

> **availability**
> **availableTime****daysOfWeek**: Monday, Tuesday, Wednesday, Thursday, Friday**availableStartTime**: 08:00:00**availableEndTime**: 16:30:00

> **availability**
> **availableTime****daysOfWeek**: Monday, Tuesday, Wednesday, Thursday, Friday**availableStartTime**: 08:00:00**availableEndTime**: 11:00:00



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
    "availableTime" : [{
      "daysOfWeek" : ["mon", "tue", "wed", "thu", "fri"],
      "availableStartTime" : "08:00:00",
      "availableEndTime" : "16:30:00"
    }]
  },
  {
    "availableTime" : [{
      "daysOfWeek" : ["mon", "tue", "wed", "thu", "fri"],
      "availableStartTime" : "08:00:00",
      "availableEndTime" : "11:00:00"
    }]
  }]
}

```
