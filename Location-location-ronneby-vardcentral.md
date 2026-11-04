# Ronneby Vårdcentral (Besöksplats, legacy adress) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Ronneby Vårdcentral (Besöksplats, legacy adress)**

## Example Location: Ronneby Vårdcentral (Besöksplats, legacy adress)

Profil: [HSA Catalog Location](StructureDefinition-hsa-catalog-location.md)

Säkerhetsetikett: 

Ronneby Vårdcentral (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE5566778899-RNBY1)

-------

| | | | |
| :--- | :--- | :--- | :--- |
| Status: | Active | Mode: | Instance |
| Description: | Centralt läge i Ronneby, 200 m från järnvägsstationen. Parkering bakom fastigheten, ingång från Järnvägsgatan 14. | | |
| Address: | Järnvägsgatan 14 | | |
| Position: | 56.209798, 15.279093 | | |
| Managed By: | [Ronneby Vårdcentral (Vårdenhet, Primärvård, Vårdcentral, Privat) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE5566778899-RNBY1)](Organization-ronneby-vardcentral-vardenhet.md) | | |



## Resource Content

```json
{
  "resourceType" : "Location",
  "id" : "location-ronneby-vardcentral",
  "meta" : {
    "profile" : ["https://hsa.inera.se/fhir/StructureDefinition/hsa-catalog-location"],
    "security" : [{
      "system" : "urn:oid:1.2.752.29.23.1.11",
      "code" : "03",
      "display" : "Internet/allmänheten"
    }]
  },
  "identifier" : [{
    "system" : "urn:oid:1.2.752.29.4.19",
    "value" : "SE5566778899-RNBY1"
  }],
  "status" : "active",
  "name" : "Ronneby Vårdcentral",
  "description" : "Centralt läge i Ronneby, 200 m från järnvägsstationen. Parkering bakom fastigheten, ingång från Järnvägsgatan 14.",
  "mode" : "instance",
  "address" : {
    "type" : "physical",
    "text" : "Järnvägsgatan 14",
    "city" : "Ronneby"
  },
  "position" : {
    "longitude" : 15.279093,
    "latitude" : 56.209798
  },
  "managingOrganization" : {
    "reference" : "Organization/ronneby-vardcentral-vardenhet"
  }
}

```
