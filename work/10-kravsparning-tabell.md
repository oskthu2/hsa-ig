# Kravspårningstabell v0.2

> Uppdaterad 2026-05-20. Alla 24 krav listade med implementationsstatus.
> Kolumn "FSH impl." anger om kravet har ett konkret FSH-uttryck på plats.

| Krav-id | Kravstatus | FSH impl. | Källa (SRC) | Beslut (ADR) | Risk (RSK) | Primärt FHIR-uttryck | Nästa steg |
|---|---|---|---|---|---|---|---|
| HSACAT-ORG-001 | Källbekräftad | ✅ | SRC-001, SRC-005 | ADR-003, ADR-005 | - | `Organization.identifier[hsa-id]` 1..1; system=`urn:oid:1.2.752.29.4.19`; NamingSystem hsa-identity | — |
| HSACAT-ORG-002 | Källbekräftad | ✅ | SRC-001, SRC-005 | ADR-002, ADR-003 | - | `Organization.partOf` 1..1 i HsaHealthcareUnitOrganization; invariant hsacat-subunit-partof | — |
| HSACAT-ORG-003 | Källbekräftad | ✅ | SRC-001, SRC-005 | ADR-003 | - | `Organization.name` 1..1 MS | — |
| HSACAT-ORG-004 | Källbekräftad | ✅ | SRC-001, SRC-016, SRC-018 | ADR-003 | - | `Organization.contact.telecom` MS; invariant hsacat-public-org-telecom | — |
| HSACAT-ORG-004b | Källbekräftad | ✅ | SRC-018, SRC-016, SRC-017 | - | - | `Organization.contact.telecom` med HsaTelecomTypeExtension; slice direct-phone + switchboard | Formalisera as separate slices om önskat |
| HSACAT-ORG-005 | Källbekräftad | ✅ | SRC-001, SRC-005, SRC-009 | ADR-002, ADR-003 | RSK-002 | `Organization.type[hsa-class]` från HsaOrganizationTypeVS (CodeSystem hsa-object-class) | — |
| HSACAT-ORG-006 | Källbekräftad | ✅ | SRC-001, SRC-005 | ADR-002, ADR-006 | RSK-001 | `Organization.partOf` rekursivt; SearchParameter _include=Organization:partof | SearchParameter behöver definieras |
| HSACAT-ORG-007 | Källbekräftad | ✅ | SRC-001, SRC-005 | ADR-003 | - | `Organization.identifier[org-no]` 1..1 i HsaHealthcareProviderOrganization; system=`urn:oid:2.5.4.97`; invariant hsacat-provider-orgno | — |
| HSACAT-ORG-008 | Beslutad | ✅ | SRC-005 | ADR-002 | - | `Organization.active` 1..1 MS | `meta.security` för dold/arkiverad ännu ej profilerat |
| HSACAT-ORG-009 | Källbekräftad | ✅ | SRC-016, SRC-017, SRC-001 | - | - | Extension `HsaDestinationIndicatorExtension` named destinationIndicator 0..1 MS på Org/HealthcareService/Location | SearchParameter för destination-indicator |
| HSACAT-ORG-010 | Källbekräftad | ✅ | SRC-016, SRC-001 | - | - | `Organization.type[ownership]` från HsaOwnershipTypeVS; system=`urn:oid:1.2.752.129.2.2.1.14` | — |
| HSACAT-ORG-011 | Källbekräftad | ✅ | SRC-017, SRC-001 | - | - | `Extension HsaFinancingOrganizationExtension` named financingOrganization 0..* MS | — |
| HSACAT-LOC-001 | Källbekräftad | ✅ | SRC-001, SRC-005 | ADR-003 | - | `Location.address` 1..1 MS; type=physical; invariant hsacat-physical-location-address | — |
| HSACAT-LOC-002 | Källbekräftad | ✅ | SRC-005 | ADR-003 | - | `Location.managingOrganization` 1..1 MS; only Reference(HsaCatalogOrganization) | — |
| HSACAT-LOC-003 | Källbekräftad | ✅ | SRC-016, SRC-017, SRC-001 | - | - | `Location.position` MS; lat/long SWEREF99; invariant hsacat-public-location-position | `position.altitude` 0..0 (inga höjddata) |
| HSACAT-LOC-004 | Källbekräftad | ✅ | SRC-016, SRC-001 | - | - | `Location.address.city` 1..1 MS; invariant hsacat-physical-location-city | — |
| HSACAT-LOC-005 | Källbekräftad | ✅ | SRC-018 | - | - | Postadress: `Organization.contact.address` (type=postal); Besöksadress: `Location.address` (type=physical, postalCode 0..0) | — |
| HSACAT-LOC-006 | Källbekräftad | ✅ | SRC-018 | - | - | Extension `HsaNavigationExtension` named navigation 0..1 MS på Location; extension[outer] + extension[inner] | — |
| HSACAT-SVC-001 | Källbekräftad | ✅ | SRC-005 | ADR-003, ADR-006 | - | `HealthcareService.providedBy` 1..1 MS; invariant hsacat-service-provider | — |
| HSACAT-SVC-002 | Källbekräftad | ✅ | SRC-005 | - | - | Invariant hsacat-digital-service-contact: `contact.telecom.exists() or endpoint.exists()` (uppdaterad för R5) | — |
| HSACAT-SVC-003 | Källbekräftad | ✅ | SRC-017, SRC-001 | - | RSK-004 | `HealthcareService.type[care-type]` från HsaCareTypeVS; system=`urn:oid:1.2.752.129.2.2.1.13` | Bekräfta exakta kodvärden |
| HSACAT-SVC-004 | Källbekräftad | ✅ | SRC-018 | - | - | `HealthcareService.availability` MS; `availability.availableTime` MS (R5-struktur) | Separata instanser per tidtyp (öppet/telefon/drop-in) |
| HSACAT-SVC-005 | Källbekräftad | ✅ | SRC-018 | - | - | Extension `HsaTemporaryInfoExtension`; extension[period].valuePeriod.end 1..1; invariant hsacat-temporary-info-end-date | — |
| HSACAT-TERM-001 | Källbekräftad – OID känd; harmonisering väntar | ⚠️ | SRC-002, SRC-013 | ADR-009 | RSK-004, RSK-005 | `HealthcareService.type[service-type]` från HsaServiceTypeVS; system=`urn:oid:1.2.752.129.2.2.1.3`; Required binding | Hämta SRC-014 (eHM Excel) för harmoniseringsmatris |

## Implementationsstatus

| Status | Antal |
|---|---|
| ✅ FSH implementerat | 23 |
| ⚠️ Delvis (OID-bindning klar, harmonisering återstår) | 1 |
| ❌ Ej påbörjat | 0 |
| **Totalt** | **24** |

## Återstående teknisk skuld

| Område | Vad saknas |
|---|---|
| `meta.security` | Modellering av dolt/arkiverat objekt (HSACAT-ORG-008 komplettering) |
| SearchParameters | HSA-id, org-typ, destination-indicator, partOf (HSACAT-ORG-006) |
| CapabilityStatement | Server + klient saknas helt |
| Negativa testinstanser | Behövs för validering av alla 11 invarianter |
| Terminologi canonical | `urn:oid:...` används tills Terminologitjänsten-URLs är bekräftade |
| HSACAT-TERM-001 harmonisering | Väntar på SRC-014 (eHM Nationella vårdtjänster) |
