# HSA Visas för (hsaDestinationIndicator) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Visas för (hsaDestinationIndicator)**

## ValueSet: HSA Visas för (hsaDestinationIndicator) 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/ValueSet/hsa-destination-indicator | *Version*:0.1.0 |
| Active as of 2026-05-20 | *Computable Name*:HsaDestinationIndicatorVS |

 
Koder för visningsscope i HSA (hsaDestinationIndicator). Kod 03 = Internet/allmänheten = publik visning på t.ex. 1177 Hitta vård. System: OID 1.2.752.29.23.1.11. 

 **References** 

* [HSA Catalog Location](StructureDefinition-hsa-catalog-location.md)
* [HSA Catalog Organization](StructureDefinition-hsa-catalog-organization.md)
* [HSA Healthcare Service](StructureDefinition-hsa-healthcare-service.md)

### Logisk definition (CLD)

 

### Expansion

No Expansion for this valueset (Unknown Code System)

-------

 Explanation of the columns that may appear on this page: 

| | |
| :--- | :--- |
| Level | A few code lists that FHIR defines are hierarchical - each code is assigned a level. In this scheme, some codes are under other codes, and imply that the code they are under also applies |
| System | The source of the definition of the code (when the value set draws in codes defined elsewhere) |
| Code | The code (used as the code in the resource instance) |
| Display | The display (used in the*display*element of a[Coding](http://hl7.org/fhir/R5/datatypes.html#Coding)). If there is no display, implementers should not simply display the code, but map the concept into their application |
| Definition | An explanation of the meaning of the concept |
| Comments | Additional notes about how to use the code |



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "hsa-destination-indicator",
  "url" : "https://hsa.inera.se/fhir/ValueSet/hsa-destination-indicator",
  "version" : "0.1.0",
  "name" : "HsaDestinationIndicatorVS",
  "title" : "HSA Visas för (hsaDestinationIndicator)",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-05-20",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Koder för visningsscope i HSA (hsaDestinationIndicator).\nKod 03 = Internet/allmänheten = publik visning på t.ex. 1177 Hitta vård.\nSystem: OID 1.2.752.29.23.1.11.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "urn:oid:1.2.752.29.23.1.11"
    }]
  }
}

```
