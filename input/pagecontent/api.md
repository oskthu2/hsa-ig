# REST API

Denna sida dokumenterar det FHIR R5 REST API som en HSA-IG-konform server exponerar. SearchParameters och CapabilityStatement är planerade artefakter för v1.

---

## Planerade SearchParameters

| Parameter | Resurs | FHIRPath | Syfte |
|---|---|---|---|
| `hsa-id` | Organization, Location | `identifier.where(system='urn:oid:1.2.752.29.4.19').value` | Sökning på HSA-identitet |
| `_security` (standard) | Alla | `meta.security` | Filtrering på destinationIndicator |
| `partof` (standard) | Organization | `Organization.partOf` | Hierarkisökning |
| `destination-indicator` | Organization, Location, HealthcareService | `meta.security.where(system='urn:oid:1.2.752.29.23.1.11').code` | Publika resurser |
| `org-type` | Organization | `type.coding.where(system='https://hsa.inera.se/fhir/CodeSystem/hsa-object-class').code` | Filter på org-klass |
| `apk` | Organization | `identifier.where(system='urn:oid:1.2.752.29.4.71').value` | NPÖ arbetsplatskod-sökning |

> SearchParameters är ej formellt definierade i v0.1. De kommer att inkluderas som `SearchParameter`-resurser i en kommande version.

---

## Typiska frågemönster

### Hämta publik vårdenhet med lokation och tjänst

```
GET /Organization?_security=urn:oid:1.2.752.29.23.1.11|03
    &type=https://hsa.inera.se/fhir/CodeSystem/hsa-object-class|healthcare-unit
    &_include=Organization:partof

GET /Location?organization=[hsa-id]
    &_security=urn:oid:1.2.752.29.23.1.11|03

GET /HealthcareService?organization=[hsa-id]
    &_security=urn:oid:1.2.752.29.23.1.11|03
```

### Hämta organisationens partOf-kedja (trädklättring)

```
GET /Organization?_id=[hsa-id]&_include=Organization:partof&_include:iterate=Organization:partof
```

### NPÖ: slå upp vårdenhet via arbetsplatskod

```
GET /Organization?identifier=urn:oid:1.2.752.29.4.71|[apk-kod]
```

---

## CapabilityStatement

CapabilityStatement (server och klient) är planerade artefakter. De kommer att specificera:

- Stödda resurser och operationer
- Obligatoriska SearchParameters
- Include-stöd (`_include`, `_revinclude`)
- Paginering (Bundle.link rel=next)

> Status: ej implementerat i v0.1.
