# HSA Katalog Implementation Guide

FHIR R5 Implementation Guide för HSA-baserad kataloginformation om organisationer, platser, vårdtjänster och ändpunkter inom svensk vård och omsorg.

**Version:** 0.1.0 (ci-build) | **FHIR:** R5 (5.0.0) | **Status:** Utkast | **Utgivare:** Inera AB / HSA-IG projekt

---

## Syfte och scope

Denna IG definierar hur HSA-katalogen (Hälso- och sjukvårdens Adressregister) exponeras som FHIR R5-resurser. Primära användningsfall:

- **EHR-katalogsynk:** Regionala vårdsystem hämtar och cachar organisationsdata från HSA.
- **NPÖ:** Nationell Patientöversikt hämtar vårdenheters arbetsplatskod och hierarki.
- **1177 Hitta vård:** Publika sökfunktioner presenterar publika vårdenheter, adresser och öppettider.
- **Tjänsteadressering:** Tjänsteplattformen (SKLTP) traverserar partOf-kedjor för åtkomstkontroll.

IG:n täcker **inte** persondata (Practitioner/PractitionerRole) i version 1.

---

## Profiler

| Profil | Resurs | Syfte |
|---|---|---|
| [HsaCatalogOrganization](StructureDefinition-hsa-catalog-organization.html) | Organization | Basprofil för alla HSA-organisationer |
| [HsaHealthcareProviderOrganization](StructureDefinition-hsa-healthcare-provider-organization.html) | Organization | Vårdgivare (PDL yttre spärr) |
| [HsaHealthcareUnitOrganization](StructureDefinition-hsa-healthcare-unit-organization.html) | Organization | Vårdenhet (PDL inre spärr) |
| [HsaCatalogLocation](StructureDefinition-hsa-catalog-location.html) | Location | Besöksplatser och mottagningslokaler |
| [HsaHealthcareService](StructureDefinition-hsa-healthcare-service.html) | HealthcareService | Vårdtjänster och tjänsteutbud |

---

## Stödjande sidor

| Sida | Innehåll |
|---|---|
| [Designprinciper](design-principles.html) | Arkitekturbeslut, R5-val, profilstrategi |
| [Användningsfall](use-cases.html) | Kravbakgrund per integrationsscenario |
| [Organisationshierarki](organization-hierarchy.html) | partOf-kedja, PDL-spärrnivåer, SKLTP-trädklättring |
| [Klientrendering](client-rendering.html) | Display-konventioner för 1177 och konsumentsystem |
| [Adressövergång](address-transition.html) | HSA 5.2+ strukturerade adresser, övergångsperiod |
| [LDAP → FHIR Mappning](ldap-mapping.html) | Attributtabell: LDAP-attributnamn → FHIR-element, ej mappade attribut |
| [Terminologi](terminology.html) | CodeSystems, OID-tabell, väntande kodverk |
| [REST API](api.html) | SearchParameters, CapabilityStatement, frågemönster |
| [Harmonisering med eHM](ehm-alignment.html) | Mappning mot eHMs Nationell katalog-IG |

---

## Snabbstart

En publik vårdenhet som ska synas på 1177 Hitta vård behöver minst:

```
Organization (HsaHealthcareUnitOrganization)
  identifier[hsa-id]               // HSA-id
  identifier[org-no]               // Org.nr (om vårdgivare)
  meta.security[destination-ind.]  // Kod 03 = publik
  active = true
  name                             // Enhetsnamn
  type[hsa-class]                  // healthcare-unit
  type[care-level]                 // Administrativ vårdnivå (1..1)
  partOf → HsaHealthcareProvider   // Ansvarig vårdgivare
  contact.telecom[direct-phone]    // Direkttelefon (krävs för publik enhet)

Location (HsaCatalogLocation)
  meta.security[destination-ind.]  // Kod 03 = publik
  address (type=physical)          // Gatuadress + stad (utan postnummer)
  position                         // SWEREF99-koordinater
  managingOrganization             // → Organization ovan

HealthcareService (HsaHealthcareService)
  meta.security[destination-ind.]  // Kod 03 = publik
  providedBy → Organization        // Tillhandahållande enhet
  category[verksamhetskod]         // Verksamhetskod (1..*)
  availability                     // Öppettider
```

Se [Klientrendering](client-rendering.html) för fullständig publiceringschecklista.
