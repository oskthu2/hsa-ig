# REST API

HSA-IG-konforma servrar implementerar ett FHIR R5 REST-API för läsning och sökning.
Skrivoperationer (create/update/delete) är inte i scope för v1.

Fullständig serverkonformans deklareras i [CapabilityStatement-hsa-catalog-server](CapabilityStatement-hsa-catalog-server.html).

---

## Sökparametrar

### Standard FHIR-parametrar (gäller alla resurser)

| Parameter | Typ | Användning |
|---|---|---|
| `_id` | token | Exakt match på resurens FHIR-id |
| `_security` | token | Filtrering på `meta.security`; `urn:oid:1.2.752.29.23.1.11\|03` för publika resurser |
| `_include` | special | Inkludera refererade resurser i svarsbundtet |
| `_revinclude` | special | Inkludera resurser som refererar till träffarna |
| `identifier` | token | Sökning på valfri identifierare (`system\|value`) |
| `active` | token | Filtrera på `true`/`false` |

### Organization

| Parameter | Typ | FHIRPath / Anmärkning |
|---|---|---|
| `name` | string | `Organization.name` (prefix-match) |
| `type` | token | `Organization.type.coding` |
| `partof` | reference | `Organization.partOf` |
| `hsa-id`* | token | `identifier.where(system='urn:oid:1.2.752.29.4.19').value` |
| `hsa-org-class`* | token | `type.coding.where(system='https://hsa.inera.se/fhir/CodeSystem/hsa-object-class')` |

### Location

| Parameter | Typ | FHIRPath / Anmärkning |
|---|---|---|
| `status` | token | `Location.status` |
| `organization` | reference | `Location.managingOrganization` |
| `near` | special | Geosökning (position.latitude/longitude) |
| `hsa-id`* | token | `identifier.where(system='urn:oid:1.2.752.29.4.19').value` |

### HealthcareService

| Parameter | Typ | FHIRPath / Anmärkning |
|---|---|---|
| `organization` | reference | `HealthcareService.providedBy` |
| `location` | reference | `HealthcareService.location` |
| `service-category` | token | `HealthcareService.category` (verksamhetskod) |
| `service-type` | token | `HealthcareService.type` (careType) |
| `hsa-provided-by`* | reference | `HealthcareService.providedBy` (explicit HSA-SP) |

\* = Definierad i denna IG. Övriga är standard FHIR R5-parametrar.

---

## Typiska frågemönster

### Hämta publik vårdenhet med plats och tjänst

```
# Hämta alla publika vårdenheter
GET /Organization?_security=urn:oid:1.2.752.29.23.1.11|03
  &hsa-org-class=healthcare-unit
  &_include=Organization:partof

# Hämta plats för en specifik enhet
GET /Location?organization=Organization/[id]
  &_security=urn:oid:1.2.752.29.23.1.11|03

# Hämta tjänster för en enhet
GET /HealthcareService?organization=Organization/[id]
  &_security=urn:oid:1.2.752.29.23.1.11|03
```

### Hämta enhet via HSA-id

```
# Via custom SearchParameter (kortform)
GET /Organization?hsa-id=SE2321000016-ABC1

# Via standard identifier-parameter (ekvivalent)
GET /Organization?identifier=urn:oid:1.2.752.29.4.19|SE2321000016-ABC1
```

### Trädklättring: hämta hela partOf-kedjan uppåt

```
GET /Organization?_id=[id]
  &_include=Organization:partof
  &_include:iterate=Organization:partof
```

### Hitta alla enheter under en vårdgivare

```
GET /Organization?partof=Organization/[vardgivare-id]
  &_revinclude=Organization:partof
```

### NPÖ: slå upp vårdenhet via arbetsplatskod

```
GET /Organization?identifier=urn:oid:1.2.752.29.4.71|[apk-kod]
```

### 1177 Hitta vård: publika vårdcentraler inom ett geografiskt område

```
GET /Location?near=[lat]|[lon]|[radius]|km
  &_security=urn:oid:1.2.752.29.23.1.11|03
  &_revinclude=HealthcareService:location
  &_revinclude=Organization:organization
```

---

## Felsvar

| HTTP-kod | Situation |
|---|---|
| `200 OK` | Lyckad sökning (tom Bundle om inga träffar) |
| `400 Bad Request` | Ogiltig söksyntax |
| `404 Not Found` | Resurs med angivet id finns inte |
| `410 Gone` | Resursen existerade men är borttagen |
| `422 Unprocessable Entity` | Ogiltig parameterkombo eller värdefel |

---

## Paginering

Servern returnerar ett paginerat `Bundle` med `link.relation = next` för sökresultat.
Rekommenderad sidstorlek per förfrågan: 20–100 resurser (`_count=50`).

```
GET /Organization?hsa-org-class=healthcare-unit&_count=50
```
