# HSA Tidtyp - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Tidtyp**

## CodeSystem: HSA Tidtyp 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type | *Version*:0.1.0 |
| Active as of 2026-11-04 | *Computable Name*:HsaAvailabilityType |

 
Anger vilket HSA-tidsattribut en tillgänglighetspost (Availability) kommer från, så att klienter kan skilja öppettider, telefontider, drop-in och besökstider åt (ADR-016). 

 This Code system is referenced in the content logical definition of the following value sets: 

* [HSA Tidtyp](ValueSet-hsa-availability-type-vs.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "hsa-availability-type",
  "url" : "https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type",
  "version" : "0.1.0",
  "name" : "HsaAvailabilityType",
  "title" : "HSA Tidtyp",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-11-04",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Anger vilket HSA-tidsattribut en tillgänglighetspost (Availability) kommer\nfrån, så att klienter kan skilja öppettider, telefontider, drop-in och\nbesökstider åt (ADR-016).",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 4,
  "concept" : [{
    "code" : "surgery-hours",
    "display" : "Öppettider",
    "definition" : "Tider då enheten tar emot besök (surgeryHours)."
  },
  {
    "code" : "telephone-hours",
    "display" : "Telefontider",
    "definition" : "Tider då enheten svarar i telefon (telephoneHours)."
  },
  {
    "code" : "drop-in-hours",
    "display" : "Drop-in",
    "definition" : "Tider för besök utan tidsbokning (dropInHours)."
  },
  {
    "code" : "visiting-hours",
    "display" : "Besökstider för anhöriga",
    "definition" : "Tider då anhöriga får besöka patienter (visitingHours)."
  }]
}

```
