# HSA Objektklassificering - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Objektklassificering**

## CodeSystem: HSA Objektklassificering 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/CodeSystem/hsa-object-class | *Version*:0.1.0 |
| Active as of 2026-03-16 | *Computable Name*:HsaObjectClass |

 
Klassificering av HSA-objekt baserat på LDAP-objektklasser i HSA-schemat. Används för att identifiera om en organisation är vårdgivare, vårdenhet eller annan organisatorisk enhet, samt för statusmarkering. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [HSA Organisationstyp](ValueSet-hsa-organization-type.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "hsa-object-class",
  "url" : "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class",
  "version" : "0.1.0",
  "name" : "HsaObjectClass",
  "title" : "HSA Objektklassificering",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-03-16",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Klassificering av HSA-objekt baserat på LDAP-objektklasser i HSA-schemat.\nAnvänds för att identifiera om en organisation är vårdgivare, vårdenhet\neller annan organisatorisk enhet, samt för statusmarkering.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 8,
  "concept" : [{
    "code" : "healthcare-provider",
    "display" : "Vårdgivare (hsaHealthCareProvider)",
    "definition" : "Organisation som är markerad som vårdgivare enligt HSA (OID 1.2.752.29.6.10). Representerar yttre spärrnivå i PDL."
  },
  {
    "code" : "healthcare-unit",
    "display" : "Vårdenhet (hsaHealthCareUnit)",
    "definition" : "Organisation som är markerad som vårdenhet enligt HSA (OID 1.2.752.29.6.13). Representerar inre spärrnivå i PDL."
  },
  {
    "code" : "organizational-unit",
    "display" : "Organisationsenhet",
    "definition" : "Organisatorisk enhet som varken är vårdgivare eller vårdenhet (LDAP organizationalUnit)."
  },
  {
    "code" : "hidden",
    "display" : "Dolt objekt (hiddenObject)",
    "definition" : "Objektet är dolt och ska inte exponeras i publikt API. Sätts active = false (OID 1.2.752.41.6.107)."
  },
  {
    "code" : "archived",
    "display" : "Arkiverat objekt (hsaArchivedObject)",
    "definition" : "Objektet är arkiverat. Sätts active = false (OID 1.2.752.29.6.20)."
  },
  {
    "code" : "inaccurate-provider",
    "display" : "Felaktigt utpekad vårdgivare (hsaInaccurateHCP)",
    "definition" : "Vårdgivaren är felaktigt utpekad (OID 1.2.752.29.6.26)."
  },
  {
    "code" : "inaccurate-unit",
    "display" : "Felaktigt utpekad vårdenhet (hsaInaccurateHCU)",
    "definition" : "Vårdenheten är felaktigt utpekad (OID 1.2.752.29.6.27)."
  },
  {
    "code" : "feigned",
    "display" : "Fingerat objekt (hsaFeignedDataObject)",
    "definition" : "Testdata eller fingerat objekt (OID 1.2.752.29.6.25)."
  }]
}

```
