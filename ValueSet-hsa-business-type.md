# HSA Enhetstyp (hsaBusinessType) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Enhetstyp (hsaBusinessType)**

## ValueSet: HSA Enhetstyp (hsaBusinessType) 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/ValueSet/hsa-business-type | *Version*:0.1.0 |
| Active as of 2026-05-21 | *Computable Name*:HsaBusinessTypeVS |

 
Enhetstyp för organisation eller enhet i HSA. System: HSA enhetstyp-kodverk (OID 1.2.752.129.2.2.1.12). Typiska värden: sjukhus, vårdcentral, apotek m.fl. 

 **References** 

* [HSA Catalog Organization](StructureDefinition-hsa-catalog-organization.md)

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
  "id" : "hsa-business-type",
  "url" : "https://hsa.inera.se/fhir/ValueSet/hsa-business-type",
  "version" : "0.1.0",
  "name" : "HsaBusinessTypeVS",
  "title" : "HSA Enhetstyp (hsaBusinessType)",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-05-21",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Enhetstyp för organisation eller enhet i HSA.\nSystem: HSA enhetstyp-kodverk (OID 1.2.752.129.2.2.1.12).\nTypiska värden: sjukhus, vårdcentral, apotek m.fl.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "compose" : {
    "include" : [{
      "system" : "urn:oid:1.2.752.129.2.2.1.12"
    }]
  }
}

```
