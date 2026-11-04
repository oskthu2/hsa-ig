# LDAP → FHIR Mappning

Denna sida dokumenterar hur HSA-katalogen LDAP-attribut (schema 5.3) mappar till FHIR R5-element i HSA-IG. Sidan riktar sig till producenter som bygger LDAP→FHIR-transformationer och till integratörer som behöver förstå informationsmodellens ursprung.

**Källreferenser:** HSA-schema 5.3 (SRC-001/002), Specifikation produktionslika data v1.8 (SRC-026).

> **Viktig modelleringsprincip:** Flera LDAP-attribut som finns på `Organisation`/`Enhet`-objektet (t.ex. `businessClassificationCode`, `careType`, öppettider) modelleras i FHIR på `HealthcareService`-resursen. En LDAP-enhet ger alltså upphov till **minst två FHIR-resurser**: en `Organization` och en (eller flera) `HealthcareService`. Se tabellen [Resursmappning](#resursmappning) nedan.

---

## Resursmappning

| LDAP-objekttyp | FHIR-resurs | Profil |
|---|---|---|
| Organisation (`organizationName`) | `Organization` | HsaHealthcareProviderOrganization |
| Enhet (`organizationalUnitName`) | `Organization` | HsaHealthcareUnitOrganization |
| Enhet (verksamhets- och tjänsteattribut) | `HealthcareService` | HsaHealthcareService |
| Enhet (besöksadress, koordinater) | `Location` | HsaCatalogLocation |
| Funktion | Ej i scope v1 | — |
| Person | Ej i scope v1 (ADR-007) | — |
| Medarbetaruppdrag | Ej i scope v1 (ADR-007) | — |

---

## Organisation och Enhet → Organization

Attributen nedan gäller för LDAP-objekttyperna `Organisation` och/eller `Enhet`.

### Identitet och status

| LDAP-attribut | Visningsnamn | FHIR-element | System/Kodverk | Notering |
|---|---|---|---|---|
| `hsaIdentity` | HSA-id | `Organization.identifier[hsa-id].value` | `urn:oid:1.2.752.29.4.19` | Genereras automatiskt av HSA; aldrig manuellt |
| `hsaIdPrefix` | HSA-id-prefix | — | — | Internt HSA-attribut; ej exponerat |
| `orgNo` | Organisationsnummer | `Organization.identifier[org-no].value` | `urn:oid:2.5.4.97` | Obligatoriskt för vårdgivare (HSACAT-ORG-007) |
| `unitPrescriptionCode` | Arbetsplatskod (APK) | `Organization.identifier[apk].value` | `urn:oid:1.2.752.29.4.71` ⚠️ | OID preliminär – öppen fråga 8 |
| `hsaGlnCode` | GLN-kod | `Organization.identifier[gln].value` | `urn:oid:1.3.88` | Global Location Number (GS1) |
| `startDate` | Giltigt fr.o.m. | `extension[orgPeriod].valuePeriod.start` | HL7 organization-period | — |
| `endDate` | Giltigt t.o.m. | `extension[orgPeriod].valuePeriod.end` | HL7 organization-period | Obligatoriskt om orgPeriod är satt |
| `hiddenObject` / `hsaArchivedObject` | Dolt/arkiverat | `Organization.active = false` | — | Alla inaktiveringsorsaker → active=false |

### Namn och klassificering

| LDAP-attribut | Visningsnamn | FHIR-element | System/Kodverk | Notering |
|---|---|---|---|---|
| `o` (`organizationName`) | Organisationsnamn | `Organization.name` | — | På Organisation-objekt |
| `ou` (`organizationalUnitName`) | Enhetsnamn | `Organization.name` | — | På Enhet-objekt |
| `ouShort` | Förkortat namn | — | — | Ej modellerat i v1 |
| `hsaIdentity` (objektklass) | HSA-objektklass | `Organization.type[hsa-class].coding.code` | `https://hsa.inera.se/fhir/CodeSystem/hsa-object-class` | `healthcare-provider` / `healthcare-unit` / `organizational-unit` |
| `management` | Ägarform | `Organization.type[ownership].coding` | `urn:oid:1.2.752.129.2.2.1.14` | — |
| `careLevel` | Administrativ vårdnivå | `Organization.type[care-level].coding` | `urn:oid:1.2.752.129.5.1.46` | Obligatorisk (1..1) för vårdenheter |
| `hsaBusinessType` | Enhetstyp | `Organization.type[business-type].coding` | `urn:oid:1.2.752.129.2.2.1.12` | Sjukhus, vårdcentral, apotek m.fl. |
| `hsaDestinationIndicator` | Visas för | `meta.security[destination-indicator].code` | `urn:oid:1.2.752.29.23.1.11` | `03` = Internet/allmänheten |

### Hierarki

| LDAP-attribut | Visningsnamn | FHIR-element | Notering |
|---|---|---|---|
| `hsaResponsibleHealthCareProvider` | Ansvarig vårdgivare | `Organization.partOf` → HsaHealthcareProviderOrganization | Obligatorisk (1..1) för vårdenheter |
| `hsaHealthCareUnitMember` | Ingående enheter | Invers av `Organization.partOf` via `_revinclude` | Ej direkt modellerat som attribut |
| DN-hierarki (LDAP-träd) | Organisationshierarki | `Organization.partOf` (kedja uppåt) | Se [Organisationshierarki](organization-hierarchy.html) |

### Kontaktvägar

| LDAP-attribut | Visningsnamn | FHIR-element | `telecomType`-kod | Notering |
|---|---|---|---|---|
| `telephoneNumber` | Direkttelefon | `contact.telecom` (system=`phone`) | `direct-phone` | Obligatorisk för publika enheter |
| `hsaSwitchboardNumber` | Växeltelefon | `contact.telecom` (system=`phone`) | `switchboard` | — |
| `mobile` | Mobiltelefon | `contact.telecom` (system=`phone`, use=`mobile`) | `mobile` | — |
| `facsimileTelephoneNumber` | Fax | `contact.telecom` (system=`fax`) | `fax` | — |
| `hsaTextTelephoneNumber` | Texttelefon | `contact.telecom` (system=`other`) | — | Ej specifik typ-kod definierad |
| `hsaVideoPhone` | Bildtelefon | `contact.telecom` (system=`other`) | — | Ej specifik typ-kod definierad |
| `mail` | E-postadress | `contact.telecom` (system=`email`) | — | — |
| `hsaDirectoryContact` | Innehållsansvarig e-post | `contact.telecom` (system=`email`) | `directory-contact` | Visas ej för slutanvändare |
| `labeledURI` | Webbadress | `contact.telecom` (system=`url`) | — | — |
| `hsaVpwWebpage` | Länk till 1177-kontaktkort | `contact.telecom` (system=`url`) | — | 1177-specifikt; djuplänk till enhetens profilsida |

### Adress

| LDAP-attribut | Visningsnamn | FHIR-element | Notering |
|---|---|---|---|
| `hsaPostalAddress` | Postadress (strukturerad, 5.2+) | `contact.address` (type=`postal`), komponenter | Normativ form (ADR-010) |
| `postalAddress` | Postadress (legacy) | `contact.address.text` (type=`postal`) | Övergångsform t.o.m. sept 2026 |
| `postalCode` | Postnummer | `contact.address.postalCode` | Hör till postadress |
| `l` (`localityName`) | Lokalitet/ort | `contact.address.city` | — |
| `c` (`countryName`) | Land | `contact.address.country` | — |

### 1177-specifika textfält

| LDAP-attribut | Visningsnamn | FHIR-element | Notering |
|---|---|---|---|
| `hsaVpwInformation2` | Tillfällig information | `extension[temporaryNotice]`: `text` + `period` | Gul informationsruta. Datumprefixet `;ÅÅÅÅMMDD;ÅÅÅÅMMDD;` tolkas till `period` och tas bort ur texten (ADR-013) |
| `hsaVpwInformation4` | Information till patient | `extension[patientInfo].valueString` | Riktad till patient; Markdown |
| `financingOrganization` | Finansierande region/kommun | `extension[financingOrganization].valueCoding` | `urn:oid:1.2.752.129.5.1.1` |

---

## Enhet → HealthcareService

LDAP-attribut på Enhet-objekt som handlar om verksamhet, tjänster och öppettider mappas till en separat `HealthcareService`-resurs. `HealthcareService.providedBy` pekar tillbaka på Organization.

> En Enhet ger normalt upphov till **en** HealthcareService-instans per kombinerad verksamhetsprofil. Tidtyperna (öppettider, telefontider, drop-in, besökstider) blir separata `availability`-poster i samma instans. Varje post anger sin tidtyp i `extension[availabilityType]` (ADR-016).

| LDAP-attribut | Visningsnamn | FHIR-element | System/Kodverk | Notering |
|---|---|---|---|---|
| `businessClassificationCode` | Verksamhetskod | `category[verksamhetskod].coding` | `urn:oid:1.2.752.129.2.2.1.3` | Bred klassificering; eHM-alignment (ADR-011) |
| `careType` | Vård- och omsorgsform | `type[care-type].coding` | `urn:oid:1.2.752.129.2.2.1.13` | Öppenvård, sluten vård, hemsjukvård m.fl. |
| `surgeryHours` | Öppettider | `availability` med `extension[availabilityType]` = `surgery-hours` | `https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type` | Se tidsformat nedan |
| `telephoneHours` | Telefontider | `availability` med `extension[availabilityType]` = `telephone-hours` | samma | — |
| `dropInHours` | Drop-in-tider | `availability` med `extension[availabilityType]` = `drop-in-hours` | samma | Besök utan bokning |
| `hsaVpwInformation1` | Mer om (Om oss) | `comment` | — | Fritext; Markdown; visas på 1177-sidan |
| `hsaVpwInformation2` | Tillfällig information | `extension[temporaryNotice]`: `text` + `period` | — | Gul informationsruta; se ovan (ADR-013) |
| `hsaVpwInformation4` | Information till patient | `extension[patientInfo].valueString` | — | Riktad till patient |
| `hsaDestinationIndicator` | Visas för | `meta.security[destination-indicator].code` | `urn:oid:1.2.752.29.23.1.11` | Delad med Organization/Location |
| `requestTemplateURI` | Adress till remissanvisning | — | — | Ej modellerat i v1 |
| `hsaVisitingRules` | Besöksregler | — | — | Ej modellerat i v1 |
| `hsaVisitingRuleReferral` | Remisskrav | — | — | Ej modellerat i v1 |
| `hsaVisitingRuleAge` | Åldersregler | — | — | Ej modellerat i v1 |
| `visitingHours` | Besökstider för anhöriga | `availability` med `extension[availabilityType]` = `visiting-hours` | `https://hsa.inera.se/fhir/CodeSystem/hsa-availability-type` | — |

### Tidsformat (ADR-014)

Tidsattributen har formatet `<FD>-<TD>#<FT>#<TT>[#<kommentar>][#<fr.o.m.>#<t.o.m.>]`.
Varje värde mappas så här:

| HSA-del | Exempel | FHIR | Regel |
|---|---|---|---|
| Attributnamn | `telephoneHours` | `availability.extension[availabilityType]` | 1..1; kod ur HsaAvailabilityType (ADR-016) |
| `FD-TD` | `1-5` | `availableTime.daysOfWeek` | 1 = `mon` … 7 = `sun`; alla dagar i intervallet listas |
| `FT#TT` | `08:00#17:00` | `availableStartTime` / `availableEndTime` | Sekunder läggs till: `08:00:00` |
| `00:00#24:00` | `1-7#00:00#24:00` | `allDay = true` | Inga klockslag (`hsacat-availability-allday-no-times`) |
| `TT` = `24:00` | `5-5#21:00#24:00` | `availableEndTime = "23:59:59"` | FHIR `time` tillåter inte `24:00`; klienten visar `24:00` |
| Kommentar | `Halvdag` | `availability.extension[comment]` | Max 19 tecken (`hsacat-availability-comment-length`) |
| Datumintervall | `20261223#20261223` | `availability.extension[period]` | Datum, båda inklusive; tom t.o.m. = tills vidare |

Ett värde med kommentar eller datumintervall blir en egen `availability`-post, så att
kommentaren och perioden gäller just de tiderna. Värden utan kommentar och period av
samma tidtyp kan dela post. Sluttiden måste vara senare än starttiden
(`hsacat-availability-time-order`), eftersom HSA inte tillåter att dygnsgränsen passeras.

---

## Enhet → Location

Adress- och positionsattribut för Enhet-objekt mappas till en `Location`-resurs. `Location.managingOrganization` pekar på Organization.

| LDAP-attribut | Visningsnamn | FHIR-element | Notering |
|---|---|---|---|
| `hsaIdentity` | HSA-id | `Location.identifier[hsa-id].value` | Samma HSA-id som Organisation/Enhet |
| `hsaVisitingAddress` | Besöksadress (strukturerad, 5.2+) | `address` (type=`physical`), komponenter | Normativ form (ADR-010) |
| `streetAddress` | Besöksadress (legacy) | `address.text` (type=`physical`) | Övergångsform t.o.m. sept 2026 |
| `l` (`localityName`) | Lokalitet/stad | `address.city` | Obligatorisk (HSACAT-LOC-004) |
| `postalCode` | Postnummer | **0..0** | Uppsala-regel: aldrig på besöksadress |
| `hsaSweref99Latitude` | Nordlig koordinat (SWEREF99 TM, meter) | `position.latitude` (WGS84, omräknad) | Obligatorisk för publika platser. Räknas om tillsammans med longitud, se nedan (ADR-015) |
| `hsaSweref99Longitude` | Östlig koordinat (SWEREF99 TM, meter) | `position.longitude` (WGS84, omräknad) | Obligatorisk för publika platser |
| `geographicalCoordinates` | Koordinater (RT90, äldre) | — | Ej mappat; SWEREF99 TM är primärformat |

**Koordinatomräkning (ADR-015).** HSA lagrar koordinater som heltal i meter i SWEREF99 TM
(`hsaSweref99Latitude` = nordlig koordinat, 7 siffror; `hsaSweref99Longitude` = östlig
koordinat, 6 siffror). FHIR `Location.position` kräver WGS84 i decimalgrader. Servern räknar
om med Gauss–Krüger invers (GRS80, medelmeridian 15°, skalfaktor 0,9996, falsk östlig
500 000) och anger minst 5 decimaler. Skillnaden mellan SWEREF99 och WGS84 är under en
meter. Invarianten `hsacat-position-sweden` varnar för värden utanför Sverige, t.ex.
oomräknade meter eller omkastade koordinater.

| Exempel | SWEREF99 TM (N / E) | WGS84 (lat / long) |
|---|---|---|
| Blekingesjukhuset | 6227289 / 538541 | 56.189003 / 15.621002 |
| Ronneby vårdcentral | 6229465 / 517312 | 56.209798 / 15.279093 |
| `route` | Yttre vägbeskrivning | `description` (`## Yttre vägbeskrivning`) | Markdown; se [Klientrendering](client-rendering.html) |
| `indoorRouteDescription` | Inre vägbeskrivning | `description` (`## Inre vägbeskrivning`) | Markdown; slås samman med yttre i ett fält |
| `hsaDestinationIndicator` | Visas för | `meta.security[destination-indicator].code` | `urn:oid:1.2.752.29.23.1.11` |
| `municipalityCode` | Kommunkod | — | Ej modellerat i v1 |
| `countyCode` | Länskod | — | Ej modellerat i v1 |

---

## Värdeformat och validering

HSA validerar varje strängattribut mot en vitlista med reguljära uttryck
(Informationsspecifikation för Katalogtjänst HSA 3.5.1, kap. 11). Data som kommer
från HSA följer därför alltid dessa format, och IG:n behåller dem oförändrade i FHIR.
Formatering för visning (t.ex. `0455-73 17 00`) görs av klienten.

Specens uttryck är skrivna för Java och matchar hela strängen. I invarianterna nedan
är de ankrade med `^…$` och omskrivna utan lookahead så att de fungerar i alla
FHIRPath-motorer.

| LDAP-attribut | Format i HSA | Exempel | FHIR-element | Invariant |
|---|---|---|---|---|
| `hsaIdentity` (och alla attribut som pekar på ett HSA-id) | `[a-zA-Z0-9-]{1,31}` | `SE2321000081-BSJH01` | `identifier[hsa-id].value` | `hsacat-hsa-id-format` |
| `orgNo`, `financingOrganization` | `\d{6}-\d{4}` | `232100-0081` | `identifier[org-no].value` | `hsacat-orgno-format` |
| `hsaGlnCode` | `\d{13}` | `7350088110002` | `identifier[gln].value` | `hsacat-gln-format` |
| `telephoneNumber`, `hsaSwitchboardNumber`, `mobile`, `facsimileTelephoneNumber` | `(?=\+|11|020|0771)(\+|\d)\d{1,31}` – endast siffror och inledande `+` | `+46455731700` | `contact.telecom.value` (system `phone`/`fax`) | `hsacat-phone-format` |
| `postalCode` / `postCode` i `hsaPostalAddress` | `[a-zA-Z0-9]+` resp. `[0-9]{5}` – inga mellanslag | `37185` | `contact.address.postalCode` | `hsacat-postal-code-format` |
| `hsaVpwWebPage` | `https?://www\.1177\.se/Hitta-vard/Kontakt/\?hsaid=<HSA-id>` | `https://www.1177.se/Hitta-vard/Kontakt/?hsaid=SE2321000081-BSJH01` | `contact.telecom` (typ `vpw-webpage`) | `hsacat-vpw-webpage-format` (kräver även objektets eget HSA-id) |
| `hsaDestinationIndicator` | `\d{2}` | `03` | `meta.security[destination-indicator].code` | `hsacat-destination-indicator-format` |
| `hsaBusinessType` | `\d{2}` | `01` | `Organization.type[business-type]` | `hsacat-business-type-format` |
| `businessClassificationCode` | `\d{4}` | `1101` | `HealthcareService.category[verksamhetskod]` | `hsacat-service-code-format` |
| `careType` | `\d{2}` | `01` | `HealthcareService.type[care-type]` | `hsacat-service-code-format` |
| `hsaSweref99Latitude` / `hsaSweref99Longitude` | `\d{7}` resp. `\d{6}` (SWEREF99 TM, meter) | `6227289` / `538541` | `Location.position` (omräknad till WGS84) | `hsacat-position-sweden` |
| `startDate`, `endDate` | `\d{14}Z` (UTC) | `20231231000000Z` | `Period.start` / `Period.end` | – |
| `surgeryHours`, `telephoneHours`, `dropInHours`, `visitingHours` | `[1-7]-[1-7]#hh:mm#hh:mm[#kommentar ≤19 tecken][#fromDatum#tomDatum]` | `1-5#08:00#17:00` | `availability` (se [Tidsformat](#tidsformat-adr-014)) | `hsacat-availability-*` |
| `hsaVpwInformation2` | valfritt prefix `;ÅÅÅÅMMDD;ÅÅÅÅMMDD;` före texten | `;20201201;20210101;Stängt för underhåll` | `extension[temporaryNotice]`: `text` + `period` | `hsacat-temporary-notice-*` |

Den fullständiga listan med uttryck finns i
`docs/sources/informationsspecifikation_hsa_3.5.1_regex.txt`.

---

## Ej mappade attribut (v1)

Attribut som medvetet utelämnats ur v1 med motivering.

| LDAP-attribut | Visningsnamn | Skäl till utelämnande |
|---|---|---|
| Alla person-attribut (`givenName`, `sn`, `personalIdentityNumber`, m.fl.) | Persondata | ADR-007: Person/PractitionerRole ingår inte i v1 |
| Alla medarbetaruppdragsattribut (`hsaCommissionMember`, m.fl.) | Uppdrag | ADR-007: Uppdrag ingår inte i v1 |
| `hsaHealthCareUnitManager` | Verksamhetschef | Refererar Person (ADR-007) |
| `jpegPhoto` | Bild | Binärdata; ej i FHIR-katalogscope v1 |
| `hsaJpegLogotype` | Logotyp | Binärdata; ej i FHIR-katalogscope v1 |
| `hsaSimpleSearch` / `hsaPhoneticSearch` | Sökindex | Serverinternt index; genereras av HSA-systemet |
| `hsaAdminComment` | Admin-kommentar | Internt förvaltningsstöd; ej konsumentrelevant |
| `hsaVpwNeighbouringObject` | Relaterad enhet | Presentationslogik specifik för 1177 v1 |
| `geographicalCoordinates` | RT90-koordinater | SWEREF99 TM (`hsaSweref99*`) är primärformat |
| `municipalityCode` / `countyCode` | Kommunkod / Länskod | Administrativa koder; ej profilerade i v1 |
| `schoolForm` | Skolform | Utanför vård/omsorg-scope |
| `requestTemplateURI` | Remissanvisnings-URL | Ej modellerat i v1; kan inkluderas i v2 |
| Besöksregler (`hsaVisitingRules`, `hsaVisitingRuleReferral`, `hsaVisitingRuleAge`) | Besöksregler | Ej modellerade i v1 |
