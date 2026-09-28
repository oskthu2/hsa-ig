# Organisationshierarki - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Organisationshierarki**

## Organisationshierarki

# Organisationshierarki och åtkomstkontroll

Denna sida beskriver hur HSA:s organisationshierarki representeras i FHIR och hur den används för åtkomstkontroll enligt Patientdatalagen (PDL). Implementörer av åtkomstkontroll och tjänsteplattformsintegrationer bör läsa denna sida.

-------

## Hierarkins struktur

HSA-katalogen representerar organisationer som ett träd. Relationen uttrycks via `Organization.partOf`:

```
Landstinget/Region (root)
  └─ Vårdgivare (HsaHealthcareProviderOrganization)
       └─ Vårdenhet (HsaHealthcareUnitOrganization)
            └─ Organisatorisk enhet (HsaCatalogOrganization)

```

`partOf` pekar alltid uppåt i trädet. Kedjan är acyklisk och terminerar i en rotnod utan `partOf` (t.ex. "SE" för svenska staten). Profilen begränsar vårdenhetens `partOf` till att referera direkt till en `HsaHealthcareProviderOrganization`.

### Modelleringskrav

| | | |
| :--- | :--- | :--- |
| `HsaHealthcareProviderOrganization` | 0..1 | `HsaCatalogOrganization`(frivillig, t.ex. region) |
| `HsaHealthcareUnitOrganization` | 1..1 (SHALL) | `HsaHealthcareProviderOrganization` |
| `HsaCatalogOrganization`(bas) | 0..1 | `HsaCatalogOrganization` |

-------

## PDL och spärrnivåer

Patientdatalagen (SFS 2008:355) definierar två spärrnivåer som styr åtkomst till journalinformation:

| | | | |
| :--- | :--- | :--- | :--- |
| **Yttre spärr** | 6 kap. 3 § | Vårdgivare (hsaHealthCareProvider) | `#healthcare-provider` |
| **Inre spärr** | 6 kap. 4 § | Vårdenhet (hsaHealthCareUnit) | `#healthcare-unit` |

En patient kan sätta spärr på vårdgivarnivå (blockerar allt från den vårdgivaren) eller vårdenhetsnivå (blockerar allt från en specifik vårdenhet). Implementörer av journalsystem MÅSTE respektera dessa spärrar via åtkomstkontroll mot HSA-katalogens partOf-hierarki.

-------

## SKLTP-trädklättring (TAK-algoritm)

Tjänsteplattformen (SKLTP) traverserar `partOf`-kedjan uppåt för att fastställa behörighet. Algoritmen söker ett behörighetsbeslut i tre steg:

1. **Explicit behörighet:**Finns ett TAK-beslut för den exakta vårdenhetens HSA-id? → Använd det.
1. **Hierarkisk behörighet:**Finns ett TAK-beslut för en överordnad organisation (via`partOf`)? → Ärv det.
1. **Standardbehörighet:**Finns ett TAK-beslut för rotnoden "SE"? → Använd standardregeln.

Om ingen behörighet hittas nekas anropet.

### Mappning: LDAP → FHIR

| | | |
| :--- | :--- | :--- |
| `hsaResponsibleHealthCareProvider` | `Organization.partOf`(på vårdenhet) | Pekar ut ansvarig vårdgivare |
| `hsaHealthCareUnitMember` | `partOf`på underenhet | Organisatorisk tillhörighet |

### Sökning av hela hierarkin

För att hämta en organisations hela partOf-kedja uppåt:

```
GET /Organization/[hsa-id]?_include=Organization:partof

```

För att hämta alla underorganisationer (rekursivt, om servern stödjer):

```
GET /Organization?partof=[hsa-id]&_include=Organization:partof

```

SearchParameter för `partOf` och `_include=Organization:partof` är planerade för v1 (se [REST API](api.md)).

-------

## Acyklicitetskrav

partOf-kedjan måste vara acyklisk — en organisation får inte vara sin egen förfader. Detta är ett informativt krav (kan inte uttryckas som en enkel FHIRPath-invariant) som stöds av följande regel:

> En `Organization.partOf`-referens får aldrig leda till en cykel. Systemet som producerar resurser ansvarar för att garantera detta vid skrivoperationer.

Profilen inkluderar en informativ varning i `HsaHealthcareUnitOrganization.partOf` om att kedjan måste terminera i en rotnod utan `partOf`.

-------

## Administrativ vårdnivå

Utöver PDL-spärrnivåerna klassificeras vårdenheter med en administrativ vårdnivå (`Organization.type[care-level]`, OID `1.2.752.129.5.1.46`). Denna är obligatorisk (1..1) för alla `HsaHealthcareUnitOrganization`-instanser.

| | |
| :--- | :--- |
| `01` | Primärvård |
| `02` | Specialiserad somatisk vård |
| `03` | Specialiserad psykiatrisk vård |
| `04` | Geriatrik |
| `05` | Övrig hälso- och sjukvård |

Fullständig koddefinition: OID `1.2.752.129.5.1.46` i Ineras terminologitjänst.

