# HSA Healthcare Unit Organization - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Healthcare Unit Organization**

## Resource Profile: HSA Healthcare Unit Organization 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization | *Version*:0.1.0 |
| Draft as of 2026-09-28 | *Computable Name*:HsaHealthcareUnitOrganization |

 
Profil för organisation markerad som vårdenhet (hsaHealthCareUnit, OID 1.2.752.29.6.13) i HSA-katalogen. 
Representerar inre spärrnivå i PDL-sammanhang. Ska alltid ha en referens till överordnad organisation (partOf → HsaHealthcareProviderOrganization). 

**Användningar:**

* Exempel för denna Profil: [Medicinmottagning Karlshamn](Organization-arkiverad-enhet.md), [Blekingesjukhuset](Organization-blekingesjukhuset-vardenhet.md), [Hjärtmottagningen Karlskrona](Organization-hjartmottagningen-vardenhet.md) and [Ronneby Vårdcentral](Organization-ronneby-vardcentral-vardenhet.md)
* CapabilityStatements som använder denna Profil: [HSA Central Catalog Server](CapabilityStatement-hsa-catalog-server.md) and [HSA Regional Catalog Server (hypotes)](CapabilityStatement-hsa-regional-catalog-server.md)

Du kan också kontrollera [användningar i FHIR IG-statistiken](https://packages2.fhir.org/xig/inera.se.hsa.katalog|current/StructureDefinition/hsa-healthcare-unit-organization)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-hsa-healthcare-unit-organization.csv), [Excel](StructureDefinition-hsa-healthcare-unit-organization.xlsx), [Schematron](StructureDefinition-hsa-healthcare-unit-organization.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "hsa-healthcare-unit-organization",
  "url" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization",
  "version" : "0.1.0",
  "name" : "HsaHealthcareUnitOrganization",
  "title" : "HSA Healthcare Unit Organization",
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
  "description" : "Profil för organisation markerad som vårdenhet (hsaHealthCareUnit,\nOID 1.2.752.29.6.13) i HSA-katalogen.\n\nRepresenterar inre spärrnivå i PDL-sammanhang. Ska alltid ha en\nreferens till överordnad organisation (partOf → HsaHealthcareProviderOrganization).",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "fhirVersion" : "5.0.0",
  "mapping" : [{
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 V2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "interface",
    "uri" : "http://hl7.org/fhir/interface",
    "name" : "Interface Pattern"
  },
  {
    "identity" : "servd",
    "uri" : "http://www.omg.org/spec/ServD/1.0/",
    "name" : "ServD"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Organization",
  "baseDefinition" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-organization",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Organization",
      "path" : "Organization",
      "constraint" : [{
        "key" : "hsacat-subunit-partof",
        "severity" : "error",
        "human" : "En organisationsenhet under en annan organisation SHALL ha partOf ifyllt.",
        "expression" : "type.coding.where(code = 'organizational-unit' or code = 'healthcare-unit').exists() implies partOf.exists()",
        "source" : "https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"
      }]
    },
    {
      "id" : "Organization.type",
      "path" : "Organization.type",
      "min" : 2
    },
    {
      "id" : "Organization.type:hsa-class",
      "path" : "Organization.type",
      "sliceName" : "hsa-class",
      "min" : 1
    },
    {
      "id" : "Organization.type:hsa-class.coding.code",
      "path" : "Organization.type.coding.code",
      "fixedCode" : "healthcare-unit"
    },
    {
      "id" : "Organization.type:care-level",
      "path" : "Organization.type",
      "sliceName" : "care-level",
      "min" : 1
    },
    {
      "id" : "Organization.partOf",
      "path" : "Organization.partOf",
      "min" : 1,
      "type" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/StructureDefinition/structuredefinition-hierarchy",
          "valueBoolean" : true
        }],
        "code" : "Reference",
        "targetProfile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-provider-organization"]
      }]
    }]
  }
}

```
