# Designprinciper

Denna sida sammanfattar de viktigaste arkitektoniska besluten bakom HSA-IG. Fullständiga beslutsbegränsningar med alternativ och konsekvenser finns i [beslutsloggen](https://github.com/oskthu2/hsa-ig/blob/main/work/03-beslutslogg.md).

---

## FHIR R5 (ADR-003)

HSA-IG är designad mot FHIR R5 (5.0.0). Skäl:

- R5 ger bättre semantisk modellering för organisation och kontakt: `Organization.contact`-backbonen (telecom + adress samlad per kontaktpunkt) passar HSA:s datamodell bättre än R4:s separata `telecom`/`address`.
- `HealthcareService.availability` (R5) är mer expressiv än R4:s `availableTime`.
- R5 är framtidsriktningen för FHIR-ekosystemet.

En R4-mappningsguide planeras i version 2 för bakåtkompatibilitet mot eHMs Nationell katalog-IG.

---

## Standard-FHIR-mekanismer före custom extensions (ADR-012)

Custom extensions används bara när standard-FHIR saknar lämplig mekanism:

| Behov | Lösning | Kvar som extension? |
|---|---|---|
| Publik synlighet (destinationIndicator) | `meta.security[destination-indicator]` | Nej |
| Administrativ vårdnivå | `Organization.type[care-level]` (slice) | Nej |
| Vägbeskrivning | `Location.description` (Markdown) | Nej |
| Tillfällig information/period | `organization-period` (HL7-standard) | Nej |
| Finansierande region/kommun | `HsaFinancingOrganizationExtension` | **Ja** – inget FHIR-standard-alternativ |
| Telecom-typ (direkttelefon/växel) | `HsaTelecomTypeExtension` | **Ja** – `ContactPoint.type` täcker ej distinktionen |

---

## Verksamhetskod på `category`, careType på `type` (ADR-011)

`HealthcareService.category` används för bred verksamhetsklassificering (verksamhetskod, OID 1.2.752.129.2.2.1.3) och `.type` för mer specifik vård-/omsorgsform (careType, OID 1.2.752.129.2.2.1.13).

Skäl: eHMs Nationell katalog-IG (hvo-business-category-inera) binder verksamhetskod mot `.category`. Harmonisering minskar transformeringsbehov. VGR:s `Encounter.type`-behov hanteras via referens `Encounter.serviceType → HealthcareService.category`.

---

## OID-konvention

Alla OID-system skrivs som `urn:oid:<OID>` i FHIR (inte bara `<OID>`). Kanoniska URL:er för CodeSystems och ValueSets under `https://hsa.inera.se/fhir/` används tills Terminologitjänstens URL:er bekräftats (öppen fråga 6).

---

## Profileringsfilosofi

- **Basprofil + specialiseringar:** `HsaCatalogOrganization` bär generella krav. Specialprofiler (`HsaHealthcareProviderOrganization`, `HsaHealthcareUnitOrganization`) lägger till rollen-specifika begränsningar.
- **Öppna slices:** Slices i basprofilerna är `#open` — implementatörer kan lägga till ytterligare element utan att bryta mot profilen.
- **Must-Support:** MS-flagga anger att konsumenter ska kunna hantera fältet om det är satt; det innebär inte att producenter måste sätta det (om kardinaliteten tillåter det).
