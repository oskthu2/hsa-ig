# HSA Kontaktvägstyp - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Kontaktvägstyp**

## Extension: HSA Kontaktvägstyp 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type | *Version*:0.1.0 |
| Draft as of 2026-09-28 | *Computable Name*:HsaTelecomTypeExtension |

Klassificerar kontaktvägstyp för att skilja direkttelefon från växeltelefon, publik telefon, innehållsansvarig e-post m.fl. Mappar till LDAP-kontexten (telephoneNumber, hsaSwitchboardNumber etc.).

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [HSA Catalog Organization](StructureDefinition-hsa-catalog-organization.md)
* Exempel för denna Extension: [Blekingesjukhuset](Organization-blekingesjukhuset-vardenhet.md), [Hjärtmottagningen Karlskrona](Organization-hjartmottagningen-vardenhet.md), [Blekinge Primärvård AB](Organization-privat-vardgivare-ab.md), [Region Blekinge](Organization-region-blekinge-vardgivare.md) and [Ronneby Vårdcentral](Organization-ronneby-vardcentral-vardenhet.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-telecom-type)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-telecom-type.csv), [Excel](StructureDefinition-hsa-telecom-type.xlsx), [Schematron](StructureDefinition-hsa-telecom-type.sch) 

#### Terminologibindningar

#### Begränsningar



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-telecom-type",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type",
  "version" : "0.1.0",
  "name" : "HsaTelecomTypeExtension",
  "title" : "HSA Kontaktvägstyp",
  "status" : "draft",
  "date" : "2026-09-28T08:39:43+00:00",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Klassificerar kontaktvägstyp för att skilja direkttelefon från\nväxeltelefon, publik telefon, innehållsansvarig e-post m.fl.\nMappar till LDAP-kontexten (telephoneNumber, hsaSwitchboardNumber etc.).",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "fhirVersion" : "5.0.0",
  "mapping" : [{
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  }],
  "kind" : "complex-type",
  "abstract" : false,
  "context" : [{
    "type" : "element",
    "expression" : "ContactPoint"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "HSA Kontaktvägstyp",
      "definition" : "Klassificerar kontaktvägstyp för att skilja direkttelefon från\nväxeltelefon, publik telefon, innehållsansvarig e-post m.fl.\nMappar till LDAP-kontexten (telephoneNumber, hsaSwitchboardNumber etc.)."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "Coding"
      }],
      "binding" : {
        "strength" : "extensible",
        "valueSet" : "https://hsa.inera.se/fhir/ValueSet/hsa-telecom-type"
      }
    }]
  }
}

```
