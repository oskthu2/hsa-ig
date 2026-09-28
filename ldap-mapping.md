# LDAP → FHIR Mappning - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* **LDAP → FHIR Mappning**

## LDAP → FHIR Mappning

# LDAP → FHIR Mappning

Denna sida dokumenterar hur HSA-katalogen LDAP-attribut (schema 5.3) mappar till FHIR R5-element i HSA-IG. Sidan riktar sig till producenter som bygger LDAP→FHIR-transformationer och till integratörer som behöver förstå informationsmodellens ursprung.

**Källreferenser:** HSA-schema 5.3 (SRC-001/002), Specifikation produktionslika data v1.8 (SRC-026).

> **Viktig modelleringsprincip:** Flera LDAP-attribut som finns på `Organisation`/`Enhet`-objektet (t.ex. `businessClassificationCode`, `careType`, öppettider) modelleras i FHIR på `HealthcareService`-resursen. En LDAP-enhet ger alltså upphov till **minst två FHIR-resurser**: en `Organization` och en (eller flera) `HealthcareService`. Se tabellen [Resursmappning](#resursmappning) nedan.

-------

## Resursmappning

| | | |
| :--- | :--- | :--- |
| Organisation (`organizationName`) | `Organization` | HsaHealthcareProviderOrganization |
| Enhet (`organizationalUnitName`) | `Organization` | HsaHealthcareUnitOrganization |
| Enhet (verksamhets- och tjänsteattribut) | `HealthcareService` | HsaHealthcareService |
| Enhet (besöksadress, koordinater) | `Location` | HsaCatalogLocation |
| Funktion | Ej i scope v1 | — |
| Person | Ej i scope v1 (ADR-007) | — |
| Medarbetaruppdrag | Ej i scope v1 (ADR-007) | — |

-------

## Organisation och Enhet → Organization

Attributen nedan gäller för LDAP-objekttyperna `Organisation` och/eller `Enhet`.

### Identitet och status

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| `hsaIdentity` | HSA-id | `Organization.identifier[hsa-id].value` | `urn:oid:1.2.752.29.4.19` | Genereras automatiskt av HSA; aldrig manuellt |
| `hsaIdPrefix` | HSA-id-prefix | — | — | Internt HSA-attribut; ej exponerat |
| `orgNo` | Organisationsnummer | `Organization.identifier[org-no].value` | `urn:oid:2.5.4.97` | Obligatoriskt för vårdgivare (HSACAT-ORG-007) |
| `unitPrescriptionCode` | Arbetsplatskod (APK) | `Organization.identifier[apk].value` | `urn:oid:1.2.752.29.4.71`⚠️ | OID preliminär – öppen fråga 8 |
| `hsaGlnCode` | GLN-kod | `Organization.identifier[gln].value` | `urn:oid:1.3.88` | Global Location Number (GS1) |
| `startDate` | Giltigt fr.o.m. | `extension[orgPeriod].valuePeriod.start` | HL7 organization-period | — |
| `endDate` | Giltigt t.o.m. | `extension[orgPeriod].valuePeriod.end` | HL7 organization-period | Obligatoriskt om orgPeriod är satt |
| `hiddenObject`/`hsaArchivedObject` | Dolt/arkiverat | `Organization.active = false` | — | Alla inaktiveringsorsaker → active=false |

### Namn och klassificering

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| `o`(`organizationName`) | Organisationsnamn | `Organization.name` | — | På Organisation-objekt |
| `ou`(`organizationalUnitName`) | Enhetsnamn | `Organization.name` | — | På Enhet-objekt |
| `ouShort` | Förkortat namn | — | — | Ej modellerat i v1 |
| `hsaIdentity`(objektklass) | HSA-objektklass | `Organization.type[hsa-class].coding.code` | `https://hsa.inera.se/fhir/CodeSystem/hsa-object-class` | `healthcare-provider`/`healthcare-unit`/`organizational-unit` |
| `management` | Ägarform | `Organization.type[ownership].coding` | `urn:oid:1.2.752.129.2.2.1.14` | — |
| `careLevel` | Administrativ vårdnivå | `Organization.type[care-level].coding` | `urn:oid:1.2.752.129.5.1.46` | Obligatorisk (1..1) för vårdenheter |
| `hsaBusinessType` | Enhetstyp | `Organization.type[business-type].coding` | `urn:oid:1.2.752.129.2.2.1.12` | Sjukhus, vårdcentral, apotek m.fl. |
| `hsaDestinationIndicator` | Visas för | `meta.security[destination-indicator].code` | `urn:oid:1.2.752.29.23.1.11` | `03`= Internet/allmänheten |

### Hierarki

| | | | |
| :--- | :--- | :--- | :--- |
| `hsaResponsibleHealthCareProvider` | Ansvarig vårdgivare | `Organization.partOf`→ HsaHealthcareProviderOrganization | Obligatorisk (1..1) för vårdenheter |
| `hsaHealthCareUnitMember` | Ingående enheter | Invers av`Organization.partOf`via`_revinclude` | Ej direkt modellerat som attribut |
| DN-hierarki (LDAP-träd) | Organisationshierarki | `Organization.partOf`(kedja uppåt) | Se[Organisationshierarki](organization-hierarchy.md) |

### Kontaktvägar

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| `telephoneNumber` | Direkttelefon | `contact.telecom`(system=`phone`) | `direct-phone` | Obligatorisk för publika enheter |
| `hsaSwitchboardNumber` | Växeltelefon | `contact.telecom`(system=`phone`) | `switchboard` | — |
| `mobile` | Mobiltelefon | `contact.telecom`(system=`phone`, use=`mobile`) | `mobile` | — |
| `facsimileTelephoneNumber` | Fax | `contact.telecom`(system=`fax`) | `fax` | — |
| `hsaTextTelephoneNumber` | Texttelefon | `contact.telecom`(system=`other`) | — | Ej specifik typ-kod definierad |
| `hsaVideoPhone` | Bildtelefon | `contact.telecom`(system=`other`) | — | Ej specifik typ-kod definierad |
| `mail` | E-postadress | `contact.telecom`(system=`email`) | — | — |
| `hsaDirectoryContact` | Innehållsansvarig e-post | `contact.telecom`(system=`email`) | `directory-contact` | Visas ej för slutanvändare |
| `labeledURI` | Webbadress | `contact.telecom`(system=`url`) | — | — |
| `hsaVpwWebpage` | Länk till 1177-kontaktkort | `contact.telecom`(system=`url`) | — | 1177-specifikt; djuplänk till enhetens profilsida |

### Adress

| | | | |
| :--- | :--- | :--- | :--- |
| `hsaPostalAddress` | Postadress (strukturerad, 5.2+) | `contact.address`(type=`postal`), komponenter | Normativ form (ADR-010) |
| `postalAddress` | Postadress (legacy) | `contact.address.text`(type=`postal`) | Övergångsform t.o.m. sept 2026 |
| `postalCode` | Postnummer | `contact.address.postalCode` | Hör till postadress |
| `l`(`localityName`) | Lokalitet/ort | `contact.address.city` | — |
| `c`(`countryName`) | Land | `contact.address.country` | — |

### 1177-specifika textfält

| | | | |
| :--- | :--- | :--- | :--- |
| `hsaVpwInformation2` | Tillfällig information | `extension[temporaryNotice].valueString` | Gul informationsruta; kombineras med`extension[orgPeriod]` |
| `hsaVpwInformation4` | Information till patient | `extension[patientInfo].valueString` | Riktad till patient; Markdown |
| `financingOrganization` | Finansierande region/kommun | `extension[financingOrganization].valueCoding` | `urn:oid:1.2.752.129.5.1.1` |

-------

## Enhet → HealthcareService

LDAP-attribut på Enhet-objekt som handlar om verksamhet, tjänster och öppettider mappas till en separat `HealthcareService`-resurs. `HealthcareService.providedBy` pekar tillbaka på Organization.

> En Enhet ger normalt upphov till **en** HealthcareService-instans per kombinerad verksamhetsprofil. Enheter med separata öppettider per tidtyp (öppet/telefon/drop-in) kan ha ett HealthcareService-element per tidtyp, eller separata `availability`-poster inom samma instans.

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| `businessClassificationCode` | Verksamhetskod | `category[verksamhetskod].coding` | `urn:oid:1.2.752.129.2.2.1.3` | Bred klassificering; eHM-alignment (ADR-011) |
| `careType` | Vård- och omsorgsform | `type[care-type].coding` | `urn:oid:1.2.752.129.2.2.1.13` | Öppenvård, sluten vård, hemsjukvård m.fl. |
| `surgeryHours` | Öppettider | `availability.availableTime` | — | En`availability`-post per tidtyp rekommenderas |
| `telephoneHours` | Telefontider | `availability.availableTime` | — | Separeras från öppettider |
| `dropInHours` | Drop-in-tider | `availability.availableTime` | — | Besök utan bokning |
| `hsaVpwInformation1` | Mer om (Om oss) | `comment` | — | Fritext; Markdown; visas på 1177-sidan |
| `hsaVpwInformation2` | Tillfällig information | `extension[temporaryNotice].valueString` | — | Gul informationsruta |
| `hsaVpwInformation4` | Information till patient | `extension[patientInfo].valueString` | — | Riktad till patient |
| `hsaDestinationIndicator` | Visas för | `meta.security[destination-indicator].code` | `urn:oid:1.2.752.29.23.1.11` | Delad med Organization/Location |
| `requestTemplateURI` | Adress till remissanvisning | — | — | Ej modellerat i v1 |
| `hsaVisitingRules` | Besöksregler | — | — | Ej modellerat i v1 |
| `hsaVisitingRuleReferral` | Remisskrav | — | — | Ej modellerat i v1 |
| `hsaVisitingRuleAge` | Åldersregler | — | — | Ej modellerat i v1 |
| `visitingHours` | Besökstider för anhöriga | — | — | Ej modellerat i v1 |

-------

## Enhet → Location

Adress- och positionsattribut för Enhet-objekt mappas till en `Location`-resurs. `Location.managingOrganization` pekar på Organization.

| | | | |
| :--- | :--- | :--- | :--- |
| `hsaIdentity` | HSA-id | `Location.identifier[hsa-id].value` | Samma HSA-id som Organisation/Enhet |
| `hsaVisitingAddress` | Besöksadress (strukturerad, 5.2+) | `address`(type=`physical`), komponenter | Normativ form (ADR-010) |
| `streetAddress` | Besöksadress (legacy) | `address.text`(type=`physical`) | Övergångsform t.o.m. sept 2026 |
| `l`(`localityName`) | Lokalitet/stad | `address.city` | Obligatorisk (HSACAT-LOC-004) |
| `postalCode` | Postnummer | **0..0** | Uppsala-regel: aldrig på besöksadress |
| `hsaSweRef99Latitude` | Latitud (SWEREF99) | `position.latitude` | Obligatorisk för publika platser |
| `hsaSweRef99Longitude` | Longitud (SWEREF99) | `position.longitude` | Obligatorisk för publika platser |
| `geographicalCoordinates` | Koordinater (RT90, äldre) | — | Ej mappat; SWEREF99 är primärformat |
| `route` | Yttre vägbeskrivning | `description`(`## Yttre vägbeskrivning`) | Markdown; se[Klientrendering](client-rendering.md) |
| `indoorRouteDescription` | Inre vägbeskrivning | `description`(`## Inre vägbeskrivning`) | Markdown; slås samman med yttre i ett fält |
| `hsaDestinationIndicator` | Visas för | `meta.security[destination-indicator].code` | `urn:oid:1.2.752.29.23.1.11` |
| `municipalityCode` | Kommunkod | — | Ej modellerat i v1 |
| `countyCode` | Länskod | — | Ej modellerat i v1 |

-------

## Ej mappade attribut (v1)

Attribut som medvetet utelämnats ur v1 med motivering.

| | | |
| :--- | :--- | :--- |
| Alla person-attribut (`givenName`,`sn`,`personalIdentityNumber`, m.fl.) | Persondata | ADR-007: Person/PractitionerRole ingår inte i v1 |
| Alla medarbetaruppdragsattribut (`hsaCommissionMember`, m.fl.) | Uppdrag | ADR-007: Uppdrag ingår inte i v1 |
| `hsaHealthCareUnitManager` | Verksamhetschef | Refererar Person (ADR-007) |
| `jpegPhoto` | Bild | Binärdata; ej i FHIR-katalogscope v1 |
| `hsaJpegLogotype` | Logotyp | Binärdata; ej i FHIR-katalogscope v1 |
| `hsaSimpleSearch`/`hsaPhoneticSearch` | Sökindex | Serverinternt index; genereras av HSA-systemet |
| `hsaAdminComment` | Admin-kommentar | Internt förvaltningsstöd; ej konsumentrelevant |
| `hsaVpwNeighbouringObject` | Relaterad enhet | Presentationslogik specifik för 1177 v1 |
| `geographicalCoordinates` | RT90-koordinater | SWEREF99 (`hsaSweRef99*`) är primärformat |
| `municipalityCode`/`countyCode` | Kommunkod / Länskod | Administrativa koder; ej profilerade i v1 |
| `schoolForm` | Skolform | Utanför vård/omsorg-scope |
| `requestTemplateURI` | Remissanvisnings-URL | Ej modellerat i v1; kan inkluderas i v2 |
| Besöksregler (`hsaVisitingRules`,`hsaVisitingRuleReferral`,`hsaVisitingRuleAge`) | Besöksregler | Ej modellerade i v1 |

