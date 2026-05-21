# Profiler

HSA-IG definierar profiler för FHIR R5-resurserna Organization, Location och HealthcareService.
Profilerna är uppbyggda i ett lager: en basprofil med gemensamma krav och specialiserade profiler
som lägger till rollspecifika begränsningar.

---

## Översikt

| Profil | Basresurs | Syfte |
|---|---|---|
| [HsaCatalogOrganization](StructureDefinition-hsa-catalog-organization.html) | Organization | Basprofil för alla HSA-organisationer |
| [HsaHealthcareProviderOrganization](StructureDefinition-hsa-healthcare-provider-organization.html) | Organization | Vårdgivare – yttre PDL-spärrnivå |
| [HsaHealthcareUnitOrganization](StructureDefinition-hsa-healthcare-unit-organization.html) | Organization | Vårdenhet – inre PDL-spärrnivå |
| [HsaCatalogLocation](StructureDefinition-hsa-catalog-location.html) | Location | Fysiska besöksplatser och mottagningslokaler |
| [HsaHealthcareService](StructureDefinition-hsa-healthcare-service.html) | HealthcareService | Vårdtjänster och tjänsteutbud |

---

## HsaCatalogOrganization

Basprofil för alla organisationer hämtade ur HSA-katalogen. Täcker vårdgivare, vårdenheter och
övriga organisatoriska enheter i organisationsträdet.

**Nyckelkrav:**

- `identifier[hsa-id]` (1..1) – unikt HSA-id, system `urn:oid:1.2.752.29.4.19`
- `identifier[org-no]` (0..1) – organisationsnummer, system `urn:oid:2.5.4.97`
- `identifier[apk]` (0..1) – arbetsplatskod för NPÖ, system `urn:oid:1.2.752.29.4.71`
- `active` (1..1) – publiceringsstatus
- `name` (1..1) – organisations-/enhetsnamn
- `meta.security[destination-indicator]` (0..1) – publik synlighet (kod 03 = Internet)
- `partOf` – referens till överordnad `HsaCatalogOrganization`
- `extension[orgPeriod]` – tidsbegränsad giltighetsperiod (organization-period)
- `extension[financingOrganization]` – finansierande region/kommun

---

## HsaHealthcareProviderOrganization

Specialisering av `HsaCatalogOrganization` för organisationer markerade som
*vårdgivare* (`hsaHealthCareProvider`, OID `1.2.752.29.6.10`).

Representerar den **yttre spärrnivån** i PDL-sammanhang.

**Tillägg utöver basprofilen:**

- `identifier[org-no]` är obligatorisk (1..1)
- `type[hsa-class]` är obligatorisk (1..1) med kod `#healthcare-provider`

---

## HsaHealthcareUnitOrganization

Specialisering av `HsaCatalogOrganization` för organisationer markerade som
*vårdenhet* (`hsaHealthCareUnit`, OID `1.2.752.29.6.13`).

Representerar den **inre spärrnivån** i PDL-sammanhang.

**Tillägg utöver basprofilen:**

- `type[hsa-class]` är obligatorisk (1..1) med kod `#healthcare-unit`
- `type[care-level]` är obligatorisk (1..1) – administrativ vårdnivå (OID `1.2.752.129.5.1.46`)
- `partOf` är obligatorisk (1..1) och måste referera till en `HsaHealthcareProviderOrganization`

---

## HsaCatalogLocation

Profil för fysiska platser – besöksplatser, mottagningar och vårdlokaler – hämtade ur HSA-katalogen.

**Nyckelkrav:**

- `address` (1..1, typ `physical`) – besöksadress med gatuadress och stad; postnummer tillåts ej
- `position` (0..1) – SWEREF99-koordinater; krävs för offentlig publicering på 1177 Hitta vård
- `managingOrganization` (1..1) – referens till ansvarig `HsaCatalogOrganization`
- `meta.security[destination-indicator]` (0..1) – publik synlighet
- `description` – Markdown-formaterad vägbeskrivning (yttre/inre)

---

## HsaHealthcareService

Profil för vårdtjänster och tjänsteutbud från HSA-katalogen.

**Nyckelkrav:**

- `providedBy` (1..1) – tillhandahållande `HsaCatalogOrganization`
- `category[verksamhetskod]` (1..*) – verksamhetskod (OID `1.2.752.129.2.2.1.3`), i linje med eHMs `hvo-business-category-inera`
- `type[care-type]` (0..*) – vård-/omsorgsform (OID `1.2.752.129.2.2.1.13`)
- `active` (1..1) – tjänstens aktiva status
- `availability` – öppettider per veckodag
- `meta.security[destination-indicator]` (0..1) – publik synlighet

---

## Extensions

| Extension | Används på | Syfte |
|---|---|---|
| [HsaFinancingOrganizationExtension](StructureDefinition-hsa-financing-organization-extension.html) | Organization | Finansierande region eller kommun |
| [HsaTelecomTypeExtension](StructureDefinition-hsa-telecom-type-extension.html) | ContactPoint | Telecom-typ (direkttelefon, växel, e-post m.fl.) |

Se [Designprinciper](design-principles.html) för motivering av när standard-FHIR används framför custom extensions.
