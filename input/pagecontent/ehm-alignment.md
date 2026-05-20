# Harmonisering med eHM Nationell katalog-IG

Denna sida dokumenterar relationen mellan HSA-IG och eHälsomyndighetens (eHM) Nationell katalog-IG (`ehalsomyndigheten.se.katalog` v0.1.0, FHIR R4).

---

## Jämförelsetabell

| Koncept | eHM Nationell katalog-IG (R4) | HSA-IG (R5) | Notering |
|---|---|---|---|
| Verksamhetskod | `HealthcareService.category[hvo-business-category-inera]` (required) | `HealthcareService.category[verksamhetskod]` (required) | **Aligned:** samma element, kompatibel bindning |
| Vård-/omsorgsform | `HealthcareService.type` | `HealthcareService.type[care-type]` | Aligned |
| Organisationshierarki | `Organization.partOf` | `Organization.partOf` | Aligned |
| Publik synlighet | Ej specificerat (externt filter) | `meta.security[destination-indicator]` | HSA-IG lägger till explicit modellering |
| Administrativ vårdnivå | Ej profilerat | `Organization.type[care-level]` | HSA-IG lägger till |
| Öppettider | `HealthcareService.availableTime` (R4) | `HealthcareService.availability.availableTime` (R5) | Strukturellt ekvivalenta |
| FHIR-version | R4 | R5 | Skillnad kräver transformering |

---

## HSACAT-TERM-001: Harmoniseringsmatris för tjänstetyp

HSA verksamhetskod (OID `1.2.752.129.2.2.1.3`) ska analyseras mot eHMs kodverk Nationella vårdtjänster (SRC-014). Harmoniseringsmatrisen är en öppen uppgift (öppen fråga 7) och publiceras när eHM Excel-underlaget mottagits.

---

## R4-bakåtkompatibilitetsguide

En guide för implementörer som behöver transformera mellan HSA-IG (R5) och eHM (R4) planeras till version 2 av HSA-IG (ADR-008).
