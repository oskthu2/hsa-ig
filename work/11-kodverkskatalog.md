# Kodverkskatalog – HSA v0.1

> Extraherat 2026-05-20 från HSA-schema 5.3 OID-förteckning (SRC-008) och hsa_fhir_ig_agentisk_plan.md (SRC-005).
> Faktiska kodvärden finns i Terminologitjänsten (SRC-007, kräver inloggning) och på Ineras Confluencesida (SRC-006, kräver inloggning).

## Centrala kodverk för v1-profiler

| Kodverk | LDAP-attribut | OID | system (FHIR) | Primärt FHIR-element | I scope v1 | Kommentar |
|---|---|---|---|---|---|---|
| Verksamhetskod | `businessClassificationCode` | `1.2.752.129.2.2.1.3` | `urn:oid:1.2.752.129.2.2.1.3` | `HealthcareService.type` | Ja | Typ av vård-/omsorgsverksamhet; Required binding |
| Enhetstyp | `hsaBusinessType` | `1.2.752.129.2.2.1.12` | `urn:oid:1.2.752.129.2.2.1.12` | `Organization.type` | Ja | Sjukhus, vårdcentral, apotek etc. |
| Vård- och omsorgsform | `careType` | `1.2.752.129.2.2.1.13` | `urn:oid:1.2.752.129.2.2.1.13` | `HealthcareService.type` eller `Location.type` | Ja | Öppen vård (01), Sluten vård (02), Hemsjukvård (03), Socialtjänst |
| Ägarform | `management` | `1.2.752.129.2.2.1.14` | `urn:oid:1.2.752.129.2.2.1.14` | `Organization.type` eller extension | Ja | Regi (offentlig, privat, etc.) |
| Visas för | `hsaDestinationIndicator` | `1.2.752.29.23.1.11` | `urn:oid:1.2.752.29.23.1.11` | `meta.security` eller `Organization.active` | Ja | Styr synlighet; 03 = publika enheter |
| KV Kommun | `municipalityCode` | `1.2.752.129.2.2.1.17` | `urn:oid:1.2.752.129.2.2.1.17` | `Organization.address.district` eller extension | Ja | SCB kommuner; 2-siffrig kod |
| KV Län | `countyCode` | `1.2.752.129.2.2.1.18` | `urn:oid:1.2.752.129.2.2.1.18` | `Organization.address.state` eller extension | Ja | SCB län; 2-siffrig kod |
| Administrativ vårdnivå | `hsaAdministrativeCareLevel` | `1.2.752.129.5.1.46` | `urn:oid:1.2.752.129.5.1.46` | extension på `Organization` | Delvis | Specialiseringsnivå; obligatorisk för vårdenheter |

## HSA-specifika objektklassifieringar (för Organization.type)

| LDAP-objektklass | OID | Syfte | FHIR-kod (förslag) |
|---|---|---|---|
| `hsaHealthCareProvider` | `1.2.752.29.6.10` | Vårdgivare | `healthcare-provider` |
| `hsaHealthCareUnit` | `1.2.752.29.6.13` | Vårdenhet (spärrnivå: inre spärr) | `healthcare-unit` |
| `hiddenObject` | `1.2.752.41.6.107` | Dolt objekt → active = false | (säkerhetsmärkning) |
| `hsaArchivedObject` | `1.2.752.29.6.20` | Arkiverat → active = false | (säkerhetsmärkning) |
| `hsaInaccurateHCP` | `1.2.752.29.6.26` | Felaktigt utpekad vårdgivare | (statusextension) |
| `hsaInaccurateHCU` | `1.2.752.29.6.27` | Felaktigt utpekad vårdenhet | (statusextension) |

## Identifierarsystem

| Identifierare | LDAP-attribut | OID | system (FHIR) | FHIR-element |
|---|---|---|---|---|
| HSA-id | `hsaIdentity` | `1.2.752.29.4.19` | `urn:oid:1.2.752.29.4.19` | `Organization.identifier`, `Location.identifier` etc. |
| Organisationsnummer | `orgNo` | `2.5.4.97` | `urn:oid:2.5.4.97` | `Organization.identifier` (vårdgivare) |

## Kodverk utanför v1-scope (person/uppdrag)

| Kodverk | LDAP-attribut | OID | Anledning till exkludering |
|---|---|---|---|
| Legitimerad yrkesgrupp | `hsaTitle` | `1.2.752.29.23.1.6` | ADR-007 – person ej i scope |
| Befattning | `paTitleCode` | `1.2.752.129.2.2.1.4` | ADR-007 – person ej i scope |
| Medarbetaruppdragets ändamål | `hsaCommissionPurpose` | `1.2.752.29.23.1.100` | ADR-007 – uppdrag ej i scope |
| Chefskod | `hsaManagerCode` | `1.2.752.29.23.1.103` | ADR-007 – person ej i scope |

## Nästa steg för kodverk

1. Logga in på [terminologitjansten.inera.se](https://terminologitjansten.inera.se) och hämta:
   - Faktiska kodvärden för verksamhetskod (5.20, gäller 2026-03-16)
   - Canonical FHIR URL per kodverk (om Terminologitjänsten publicerar dessa)
2. Besluta om IG ska referera `urn:oid:...` eller en HTTPS-canonical från Terminologitjänsten (öppen fråga 6)
3. Ta fram ValueSet-artefakter (FSH) för de 4 kodverk som är i scope för v1
