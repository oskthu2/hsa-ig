# Kravkatalog – v0.2

> Uppdaterad 2026-05-20. Krav markerade **Källbekräftad** har verifierats mot hsa_fhir_ig_agentisk_plan.md och HSA-schema 5.3. Krav med status **Beslutad** härrör direkt från ADR.
> **R5-not (2026-05-20):** `Organization.telecom`/`.address` existerar inte som toppnivåelement i FHIR R5. Dessa hanteras via `Organization.contact.telecom`/`.address`. Profil och invarianter är uppdaterade. FHIR-uttryck i tabellen nedan speglar det som är implementerat.

## Kravtabell

| Krav-id | Kravtext | FHIR-uttryck | Källa | HSA-element | Status |
|---|---|---|---|---|---|
| HSACAT-ORG-001 | Organization som representerar vårdgivare eller vårdenhet i HSA SHALL ha HSA-id | `Organization.identifier` slice `hsa-id` 1..1; system = `urn:oid:1.2.752.29.4.19` | HSA-schema 5.3 (Org + OrgUnit obligatoriska attr); hsa_fhir_ig_agentisk_plan.md FHIRPath invariant | `hsaIdentity` | Källbekräftad |
| HSACAT-ORG-002 | Organization under annan organisation SHALL ha `partOf` | `Organization.partOf` 1..1 vid underenhet | HSA-schema 5.3 (hierarki i organisationsträdet); hsa_fhir_ig_agentisk_plan.md | LDAP `ou`-struktur | Källbekräftad |
| HSACAT-ORG-003 | Externt publicerad Organization SHALL ha namn | `Organization.name` 1..1 | HSA-schema 5.3 (Org obligatoriskt: `organizationName`; OrgUnit: `organizationalUnitName`); hsa_fhir_ig_agentisk_plan.md | `o` / `ou` | Källbekräftad |
| HSACAT-ORG-004 | Externt publicerad Organization SHALL ha minst en kontaktväg | `Organization.contact.telecom` 1..* (R5: telecom finns under contact-backbone) | HSA-schema 5.3 (Org obligatoriska: `telephoneNumber`, `mail`); hsa_fhir_ig_agentisk_plan.md | `telephoneNumber`, `mail` | Källbekräftad |
| HSACAT-ORG-005 | Organisationsnoder som används för åtkomstbeslut SHALL klassificeras med typ som identifierar inre (vårdenhet, PDL 6 kap. 4 §) eller yttre (vårdgivare, PDL 6 kap. 3 §) spärrnivå | `Organization.type` coding från HsaOrganizationTypeVS; system = `https://hsa.inera.se/fhir/CodeSystem/hsa-object-class`; code = `#healthcare-provider` (yttre) eller `#healthcare-unit` (inre) | PDL SFS 2008:355 (SRC-022); Socialstyrelsen inre spärr (SRC-023); SRC-009; ADR-002 | `hsaHealthCareProvider` (OID 1.2.752.29.6.10), `hsaHealthCareUnit` (OID 1.2.752.29.6.13) | Källbekräftad – juridisk grund PDL |
| HSACAT-ORG-006 | Organisationsstruktur för inre och yttre spärr SHALL vara traverserbar uppåt via `partOf` (trädklättring); Tjänsteplattformen prövar behörighet längs kedjan tills träffat eller rotnod nås | `Organization.partOf` rekursiv sökning med `_include=Organization:partof`; TAK stödjer explicit, hierarkisk och standardbehörighet (SRC-024) | SKLTP VP SAD (SRC-024); skltp/takdatahandler (SRC-025); ADR-002 | LDAP trädhierarki, logisk adress = HSA-id | Källbekräftad – SKLTP-algoritm dokumenterad |
| HSACAT-ORG-015 | `partOf`-kedjan SHALL vara acyklisk och terminera i en rotnod utan `partOf`; detta är nödvändigt för att Tjänsteplattformens trädklättring-algoritm ska terminera | Invariant (informativ): `partOf`-kedja utan cykel; rotnod = `Organization` utan `partOf`, motsvarar logisk adress "SE" i TAK | SKLTP VP SAD (SRC-024): "upprepas tills en behörighet hittas eller roten (SE) nås"; skltp/takdatahandler (SRC-025) | LDAP trädhierarki, roten = SE | Källbekräftad – terminationsvillkor dokumenterat |
| HSACAT-ORG-007 | Organization med typ hsaHealthCareProvider (vårdgivare) SHALL ha organisationsnummer | `Organization.identifier` slice `org-no` 1..1 when type = healthcare-provider; system = `urn:oid:2.5.4.97` | HSA-schema 5.3 (Org obligatoriskt: `orgNo`); hsa_fhir_ig_agentisk_plan.md FHIRPath invariant | `orgNo` | Källbekräftad |
| HSACAT-ORG-008 | Organization.active SHALL återspegla publiceringsstatus; dolt (hiddenObject) eller arkiverat (hsaArchivedObject) objekt SHALL ha active = false | `Organization.active` 1..1; `meta.security` för dold/arkiverad markering | ADR-002; hsa_fhir_ig_agentisk_plan.md (Status och synlighetssektion) | `hiddenObject`, `hsaArchivedObject` | Beslutad |
| HSACAT-LOC-001 | Fysisk Location SHALL ha adress | Invariant: `mode = 'instance' implies address.exists()` | HSA-schema 5.3 (Loc: 1 obligatoriskt attr); hsa_fhir_ig_agentisk_plan.md FHIRPath invariant | `postalAddress` / `hsaPostalAddress` | Källbekräftad |
| HSACAT-LOC-002 | Location SHALL peka ut ansvarig organisation | `Location.managingOrganization` 1..1 | hsa_fhir_ig_agentisk_plan.md (Platsansvar i kravtypstabell) | LDAP strukturrelation | Källbekräftad |
| HSACAT-SVC-001 | HealthcareService SHALL peka ut tillhandahållande organisation | `HealthcareService.providedBy` 1..1 | hsa_fhir_ig_agentisk_plan.md FHIRPath invariant; REST API-kravtabell | LDAP strukturrelation | Källbekräftad |
| HSACAT-SVC-002 | Digital HealthcareService SHALL ha telecom eller endpoint | Invariant: `type.coding.where(code = 'digital').exists() implies (telecom.exists() or endpoint.exists())` | hsa_fhir_ig_agentisk_plan.md FHIRPath invariant | Tjänsteträdets digital tjänstmodell | Källbekräftad |
| HSACAT-TERM-001 | Verksamhetskod på HealthcareService SHALL bindas till ValueSet med system `urn:oid:1.2.752.129.2.2.1.3` och modelleras på `category`; ValueSet SHALL jämföras mot eHMs Nationella vårdtjänster v.1.0.0 (SRC-014) | Required binding på `HealthcareService.category[verksamhetskod]`; system = `urn:oid:1.2.752.129.2.2.1.3`; aligns med eHMs `hvo-business-category-inera` (required); harmoniseringsmatris mot SRC-014 | HSA OID-förteckning (SRC-008); eHMs IG (SRC-013, hvo-business-category-inera); Nationella vårdtjänster v.1.0.0 (SRC-014, blockerad); ADR-009, ADR-011 | `businessClassificationCode`, OID `1.2.752.129.2.2.1.3` | Källbekräftad – OID känd; väntar på SRC-014 för harmonisering |

| HSACAT-LOC-003 | Fysisk Location som är synlig för allmänheten (hsaDestinationIndicator = 03) SHALL ha geografiska koordinater | `Location.position` 1..1 when synlig för 03; lat/long SWEREF99 | EK (obligatoriskt för 1177) + KIV; HSA-schema 5.3 (`hsaSweref99Latitude`, `hsaSweref99Longitude`) | `hsaSweref99Latitude`, `hsaSweref99Longitude` | Källbekräftad |
| HSACAT-LOC-004 | Fysisk Location SHALL ha lokalitet (ort/stad) | `Location.address.city` 1..1 vid `mode = 'instance'` | EK (Lokalitet obligatorisk för 1177); HSA-schema 5.3 (`l` = localityName) | `l` (localityName) | Källbekräftad |
| HSACAT-SVC-003 | HealthcareService för vårdenhet SHALL ha vård- och omsorgsform (`careType`) | `HealthcareService.type` slice `care-type`; system = `urn:oid:1.2.752.129.2.2.1.13` | KIV (Vårdform obligatorisk för 1177); HSA-schema 5.3 (`careType`, OID 1.2.752.129.2.2.1.13) | `careType` | Källbekräftad |
| HSACAT-ORG-009 | Organization eller HealthcareService synlig för allmänheten SHALL ha hsaDestinationIndicator = 03 modellerat och sökbart | Extension `hsaDestinationIndicator` eller `meta.security`; sökbart via SearchParameter | EK + KIV (nationell HSA-regel för 1177); HSA-schema 5.3 (`hsaDestinationIndicator`, OID 1.2.752.29.23.1.11) | `hsaDestinationIndicator` | Källbekräftad |
| HSACAT-ORG-010 | Organization SHOULD ha ägarform (regi) | `Organization.type` slice `ownership`; system = `urn:oid:1.2.752.129.2.2.1.14` | EK (Ägarform obligatorisk för 1177); HSA-schema 5.3 (`management`) | `management` | Källbekräftad |
| HSACAT-ORG-011 | Vårdenhet med regional finansiering SHOULD ha finansierande region/kommun | Extension med OID `urn:oid:1.2.752.129.5.1.1` för finansierande org | KIV (obligatorisk i VGR); HSA-schema 5.3 (`financingOrganization`) | `financingOrganization` | Källbekräftad |

| HSACAT-SVC-004 | Externt publicerad HealthcareService SHOULD ha öppettider och telefontider som separata structured time slots | `HealthcareService.availableTime[]` med extension för typ (öppettid/telefontid/drop-in); max 19-tecken etikett för drop-in | Uppsala LoKatt (DocPlusSTYR-35033); HSA-schema 5.3 (`hsaPublicTelephone`, `hsaDropInHours`, `hsaManagingHospital`) | `hsaPublicTelephone`, `hsaDropInHours` | Källbekräftad |
| HSACAT-SVC-005 | HealthcareService med tillfällig information SHALL ha period med end-datum | Extension `temporaryInfo` med `valueString` + obligatoriskt `period.end`; rensas automatiskt vid passerat datum | Uppsala LoKatt (tillfällig information = obligatoriskt slutdatum) | HSA `hsaCreateObjectHours` / temporärt textfält | Källbekräftad |
| HSACAT-ORG-004b | Offentlig Organization SHALL ha både direkttelefon och växeltelefon; privata vårdgivare undantas från krav på växeltelefon | `Organization.telecom` slice `direct-phone` 1..1 + slice `switchboard` 1..1 when NOT private | Uppsala LoKatt; EK; KIV | `telephoneNumber` (direkttelefon), `facsimileTelephoneNumber` / växel | Källbekräftad |
| HSACAT-LOC-005 | Organization SHALL ha postadress och besöksadress som separata adressposter; strukturerade attribut (hsaPostalAddress, hsaVisitingAddress) är normativ form; legacy-attribut (postalAddress, streetAddress) accepteras under övergångsperioden t.o.m. sept 2026 | `Organization.contact.address` (type=postal) med komponenter; `Location.address` (type=physical) med komponenter; under övergångsperiod: `Address.text` för legacy | Uppsala LoKatt (adressregler); HSA-schema 5.2+ (`hsaPostalAddress`, `hsaVisitingAddress`); NPÖ (SRC-020); ADR-010 | `hsaPostalAddress`, `hsaVisitingAddress`, `postalAddress`, `streetAddress` | Källbekräftad |
| HSACAT-LOC-006 | Location MAY ha inre och yttre vägbeskrivning | `Location.description` eller extension med inner/outer navigation text | Uppsala LoKatt (Geografi-sektionen) | HSA `hsaRoute` (yttre), `description` (inre) | Källbekräftad |

| HSACAT-ORG-012 | HsaHealthcareUnitOrganization SHOULD ha arbetsplatskod (identifierare krävd av NPÖ GetHealthCareUnitMembers) | `Organization.identifier` slice `apk` 0..1; system = `urn:oid:<APK-OID>` (OID att bekräfta) | NPÖ tillitsdeklaration (SRC-020): GetHealthCareUnitMembers returnerar arbetsplatskod | `hsaHealthCareUnitExternalId` eller separat attribut – OID okänd, se öppen fråga 8 | Utkast – OID saknas |
| HSACAT-ORG-013 | IG SHOULD dokumentera mappning från legacy adressattribut (postalAddress, streetAddress) till strukturerade (hsaPostalAddress, hsaVisitingAddress) för konsumenter under övergångsperiod t.o.m. sept 2026 | Informativ IG-sida med mappningstabell; normativa profiler pekar på strukturerad form (ADR-010) | HSA-schema 5.2.1 (SRC-021) och 5.3 (SRC-001); ADR-010 | `postalAddress` → `Address.text`; `streetAddress` → `Address.text`; `hsaPostalAddress` → komponent-Address | Beslutad (ADR-010) |

## Stängda frågor

| # | Fråga | Svar | Grund |
|---|---|---|---|
| 1 | Vilken exakt URI/OID gäller för HSA-id? | `urn:oid:1.2.752.29.4.19` | hsa_fhir_ig_agentisk_plan.md FHIRPath invariant `hsacat-org-hsa-id` |
| 2 | Ska publiceringsstatus modelleras explicit i v1? | Ja – via `Organization.active` + `meta.security` för dold/arkiverad | ADR-002 + hsa_fhir_ig_agentisk_plan.md, se HSACAT-ORG-008 |
| 3 | Är person + uppdrag i scope för första release? | Nej – se ADR-007 | Användarbeslut 2026-05-20 |
| 4 | Vilken exakt nivåklassificering för åtkomstbeslut? | Inre spärr = vårdenhet (`hsaHealthCareUnit`, OID 1.2.752.29.6.13); yttre spärr = vårdgivare (`hsaHealthCareProvider`, OID 1.2.752.29.6.10) | HSA-schema 5.3 objektklasser + Ineras spärrhanteringsmodell |

## Återstående öppna frågor

| # | Fråga | Vad behövs |
|---|---|---|
| 5 | Exakt kodtabellsinnehåll för verksamhetskoder (HSACAT-TERM-001) | DC Koder-bladet ur tjänsteträdets xlsx eller separat kodverksexport |
| 6 | Canonical URI för HSA CodeSystem/ValueSet i Terminologitjänsten | Logga in på terminologitjansten.inera.se och hämta canonical URL per kodverk; använd tills vidare `urn:oid:<OID>` |
| 7 | Exakt innehåll i "Nationella vårdtjänster v.1.0.0" (SRC-014) | Logga in på eHMs samarbetsyta (AFI-utrymme) och ladda ner Excel-filen; krävs för harmoniseringsanalys i HSACAT-TERM-001 |
| 8 | OID och formell definition för arbetsplatskod (HSACAT-ORG-012) | Bekräfta OID för arbetsplatskod (APK) – troligtvis `1.2.752.29.4.71` men ska verifieras; NPÖ-förvaltningen eller Ineras OID-register |

## Informativa noter om behörighetsmodellen

Från SKLTP VP SAD (SRC-024) och Ineras behörighetsmodell – relevanta för IG-konsumenter:

| Begrepp | Förklaring | FHIR-konsekvens |
|---|---|---|
| Explicit behörighet | TAK-grant för ett specifikt HSA-id | `Organization.identifier[hsa-id]` är söknyckeln |
| Hierarkisk behörighet | TAK-grant för en föräldernod, ärvs nedåt | `partOf`-kedjan måste vara traverserbar (HSACAT-ORG-006/015) |
| Standardbehörighet | Fallback för alla parter på ett tjänstekontrakt | Ej direkt FHIR-modellerat; dokumenteras informativt |
| SJF-åtkomstnivåer | `SJF` = annan vårdgivare; `VG` = alla enheter inom vårdgivare; `VE` = egna enheten | Mappar till yttre/inre spärrnivå; inte direkt i katalog-IG v1 |
| Logisk adress = HSA-id | Tjänsteplattformen adresserar via HSA-id | Stärker HSACAT-ORG-001; HSA-id MÅSTE vara stabilt |

## Statusöversikt

| Status | Antal |
|---|---|
| Källbekräftad | 25 |
| Beslutad | 2 |
| Utkast | 1 |
| **Totalt** | **28** |
