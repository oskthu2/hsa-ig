# Medicinmottagning Karlshamn (arkiverad) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Medicinmottagning Karlshamn (arkiverad)**

## Example Organization: Medicinmottagning Karlshamn (arkiverad)

Profil: [HSA Healthcare Unit Organization](StructureDefinition-hsa-healthcare-unit-organization.md)

**identifier**: [HSA-identitet (HSA-id)](NamingSystem-hsa-identity.md)/SE2321000016-ARKV1

**active**: false

**type**: Vårdenhet, Specialiserad somatisk vård

**name**: Medicinmottagning Karlshamn

**partOf**: [Organization Region Blekinge](Organization-region-blekinge-vardgivare.md)



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "arkiverad-enhet",
  "meta" : {
    "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-healthcare-unit-organization"]
  },
  "identifier" : [{
    "system" : "urn:oid:1.2.752.29.4.19",
    "value" : "SE2321000016-ARKV1"
  }],
  "active" : false,
  "type" : [{
    "coding" : [{
      "system" : "https://hsa.inera.se/fhir/CodeSystem/hsa-object-class",
      "code" : "healthcare-unit",
      "display" : "Vårdenhet"
    }]
  },
  {
    "coding" : [{
      "system" : "urn:oid:1.2.752.129.5.1.46",
      "code" : "02",
      "display" : "Specialiserad somatisk vård"
    }]
  }],
  "name" : "Medicinmottagning Karlshamn",
  "partOf" : {
    "reference" : "Organization/region-blekinge-vardgivare"
  }
}

```
