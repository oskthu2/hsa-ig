# Terminologi - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Terminologi**

## Terminologi

# Terminologi

Denna sida dokumenterar de CodeSystems, ValueSets och namnrymder som HSA-IG använder.

-------

## OID-tabell

| | | | |
| :--- | :--- | :--- | :--- |
| `1.2.752.29.4.19` | HSA-id | `Organization.identifier[hsa-id].system` | Bekräftad |
| `2.5.4.97` | Organisationsnummer | `Organization.identifier[org-no].system` | Bekräftad |
| `1.2.752.29.4.71` | Arbetsplatskod (APK) | `Organization.identifier[apk].system` | **Preliminär – öppen fråga 8** |
| `1.2.752.29.23.1.11` | hsaDestinationIndicator | `meta.security[destination-indicator].system` | Bekräftad |
| `1.2.752.129.2.2.1.3` | Verksamhetskod | `HealthcareService.category[verksamhetskod].coding.system` | Bekräftad |
| `1.2.752.129.2.2.1.13` | Vård-/omsorgsform (careType) | `HealthcareService.type[care-type].coding.system` | Bekräftad |
| `1.2.752.129.2.2.1.14` | Ägarform (management) | `Organization.type[ownership].coding.system` | Bekräftad |
| `1.2.752.129.5.1.1` | Finansierande organisation | `extension[financingOrganization].valueCoding.system` | Bekräftad |
| `1.2.752.129.5.1.46` | Administrativ vårdnivå | `Organization.type[care-level].coding.system` | Bekräftad |
| `1.2.752.129.2.2.1.12` | Enhetstyp (hsaBusinessType) | `Organization.type[business-type].coding.system` | Bekräftad |
| `1.3.88` | GLN (Global Location Number, GS1) | `Organization.identifier[gln].system` | Bekräftad |
| `1.2.752.29.6.10` | hsaHealthCareProvider | Typ-OID för vårdgivare (bakgrundsinformation) | Bekräftad |
| `1.2.752.29.6.13` | hsaHealthCareUnit | Typ-OID för vårdenhet (bakgrundsinformation) | Bekräftad |

-------

## Definierade CodeSystems

| | | |
| :--- | :--- | :--- |
| HsaObjectClass | `https://hsa.inera.se/fhir/CodeSystem/hsa-object-class` | Klassificering av org-typ (healthcare-provider, healthcare-unit) |
| HsaTelecomType | `https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type` | Telecom-typ (direct-phone, switchboard, …) |

-------

## Definierade ValueSets

| | | |
| :--- | :--- | :--- |
| HsaOrganizationTypeVS | required | `Organization.type[hsa-class]` |
| HsaOwnershipTypeVS | required | `Organization.type[ownership]` |
| HsaDestinationIndicatorVS | required | `meta.security[destination-indicator]` |
| HsaCareTypeVS | required | `HealthcareService.type[care-type]` |
| HsaServiceTypeVS | required | `HealthcareService.category[verksamhetskod]` |
| HsaTelecomTypeVS | extensible | `extension[telecomType]`på ContactPoint |
| HsaBusinessTypeVS | required | `Organization.type[business-type]` |

-------

## Öppna frågor

| | | |
| :--- | :--- | :--- |
| 6 | Terminologitjänstens kanoniska URL:er för ValueSets och CodeSystems | Stabil canonical URL (nu används`urn:oid:...`som interimslösning) |
| 7 | eHM Nationella vårdtjänster Excel (SRC-014) | HSACAT-TERM-001 harmoniseringsmatris |
| 8 | Bekräftelse av APK-OID`1.2.752.29.4.71`mot Ineras OID-register | HSACAT-ORG-012 normativt |

