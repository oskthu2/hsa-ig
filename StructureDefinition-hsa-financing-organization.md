# HSA Finansierande region/kommun - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Finansierande region/kommun**

## Extension: HSA Finansierande region/kommun 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-financing-organization | *Version*:0.1.0 |
| Draft as of 2026-09-28 | *Computable Name*:HsaFinancingOrganizationExtension |

Den eller de regioner/kommuner som finansierar vården vid enheten. Mappar till LDAP-attributet financingOrganization (OID 1.2.752.129.5.1.1).

**Context of Use**

**Usage info**

**Användningar:**

* Använd denna Extension: [HSA Catalog Organization](StructureDefinition-hsa-catalog-organization.md)
* Exempel för denna Extension: [Ronneby Vårdcentral](Organization-ronneby-vardcentral-vardenhet.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-financing-organization)

### Formal Views of Extension Content

 [Description of Profiles, Differentials, Snapshots, and how the XML and JSON presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-financing-organization.csv), [Excel](StructureDefinition-hsa-financing-organization.xlsx), [Schematron](StructureDefinition-hsa-financing-organization.sch) 

#### Terminologibindningar

#### Begränsningar



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-financing-organization",
  "extension" : [{
    "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-type-characteristics",
    "valueCode" : "can-bind"
  }],
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-financing-organization",
  "version" : "0.1.0",
  "name" : "HsaFinancingOrganizationExtension",
  "title" : "HSA Finansierande region/kommun",
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
  "description" : "Den eller de regioner/kommuner som finansierar vården vid enheten.\nMappar till LDAP-attributet financingOrganization (OID 1.2.752.129.5.1.1).",
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
    "expression" : "Organization"
  }],
  "type" : "Extension",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Extension",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Extension",
      "path" : "Extension",
      "short" : "HSA Finansierande region/kommun",
      "definition" : "Den eller de regioner/kommuner som finansierar vården vid enheten.\nMappar till LDAP-attributet financingOrganization (OID 1.2.752.129.5.1.1)."
    },
    {
      "id" : "Extension.extension",
      "path" : "Extension.extension",
      "max" : "0"
    },
    {
      "id" : "Extension.url",
      "path" : "Extension.url",
      "fixedUri" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-financing-organization"
    },
    {
      "id" : "Extension.value[x]",
      "path" : "Extension.value[x]",
      "type" : [{
        "code" : "Coding"
      }],
      "binding" : {
        "strength" : "preferred",
        "valueSet" : "urn:oid:1.2.752.129.5.1.1"
      }
    }]
  }
}

```
