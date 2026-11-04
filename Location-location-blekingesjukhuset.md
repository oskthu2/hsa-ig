# Blekingesjukhuset (Besöksplats) - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Blekingesjukhuset (Besöksplats)**

## Example Location: Blekingesjukhuset (Besöksplats)

Profil: [HSA Catalog Location](StructureDefinition-hsa-catalog-location.md)

Säkerhetsetikett: 

Blekingesjukhuset (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE2321000081-BSJH01)

-------

| | | | |
| :--- | :--- | :--- | :--- |
| Status: | Active | Mode: | Instance |
| Description: | ### Yttre vägbeskrivningFrån centrum: Kör mot Lyckeby längs E22. Ta av mot sjukhuset vid trafikljusen vid rondellen Lyckeby.Parkering finns vid huvudentrén (avgiftsbelagd). Handikapp-parkering närmast entrén.Buss linje 1 och 5 stannar vid hållplatsen Blekingesjukhuset (100 m från entrén).### Inre vägbeskrivningHuvudentré mot Lyckeby 5 — receptionen finns direkt till höger vid entrén.Akutmottagning: separat ingång på norra sidan av byggnaden (skyltad).Hjärtmottagningen: Byggnad B, Plan 4 (t.o.m. dec 2027 pga renovering). Ta hissen vid huvudentrén. | | |
| Address: | Lyckeby 5 Karlskrona | | |
| Position: | 56.189003, 15.621002 | | |
| Managed By: | [Blekingesjukhuset (Vårdenhet, Specialiserad somatisk vård, Sjukhus, Landsting/region) (urn:oid:1.2.752.29.4.19#HSA-identitet (HSA-id)#SE2321000081-BSJH01)](Organization-blekingesjukhuset-vardenhet.md) | | |



## Resource Content

```json
{
  "resourceType" : "Location",
  "id" : "location-blekingesjukhuset",
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
    "value" : "SE2321000081-BSJH01"
  }],
  "status" : "active",
  "name" : "Blekingesjukhuset",
  "description" : "## Yttre vägbeskrivning\nFrån centrum: Kör mot Lyckeby längs E22. Ta av mot sjukhuset vid trafikljusen vid rondellen Lyckeby.\n\nParkering finns vid huvudentrén (avgiftsbelagd). Handikapp-parkering närmast entrén.\n\nBuss linje 1 och 5 stannar vid hållplatsen Blekingesjukhuset (100 m från entrén).\n\n## Inre vägbeskrivning\nHuvudentré mot Lyckeby 5 — receptionen finns direkt till höger vid entrén.\n\nAkutmottagning: separat ingång på norra sidan av byggnaden (skyltad).\n\nHjärtmottagningen: Byggnad B, Plan 4 (t.o.m. dec 2027 pga renovering). Ta hissen vid huvudentrén.",
  "mode" : "instance",
  "address" : {
    "type" : "physical",
    "line" : ["Lyckeby 5"],
    "city" : "Karlskrona"
  },
  "position" : {
    "longitude" : 15.621002,
    "latitude" : 56.189003
  },
  "managingOrganization" : {
    "reference" : "Organization/blekingesjukhuset-vardenhet"
  }
}

```
