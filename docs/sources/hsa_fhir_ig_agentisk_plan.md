# Plan för agentiskt framtagande av FHIR Implementation Guide för HSA baserad kataloginformation

## Syfte

Detta dokument beskriver ett arbetssätt för att ta fram en FHIR Implementation Guide för kataloginformation om organisationer, platser, vårdtjänster, uppdrag, kontaktvägar och tekniska ändpunkter med HSA som huvudsaklig kravkälla.

Målet är att specifikationen ska kunna användas som krav mot regionala systemleverantörer och samtidigt fungera som utdataformat för ett resursorienterat REST API ovanpå HSA.

Dokumentet utgår från följande principer:

1. HSA ska inte behandlas enbart som en katalogdatabas.
2. HSA ska behandlas som en etablerad informationsförsörjningsmodell för svensk vård.
3. FHIR modellen ska uttrycka både explicita och implicita krav.
4. Så många krav som möjligt ska göras validerbara genom profiler, kardinalitet, slicing, bindningar och FHIRPath.
5. Ehälsomyndighetens vårdgivarkatalog kan användas som jämförelsepunkt, men ska inte vara styrande om den förenklar bort HSA krav som behövs i vårdens praktiska tillämpning.

## Källunderlag i denna första inventering

| Fil | Del | Blad | Rader | Kolumner |
| --- | --- | --- | --- | --- |
| hsa-schema_organisationstradet_version_5.3.xlsx | Organisationsträd | Attribut i HSA org.träd | 133 | 55 |
| hsa-schema_organisationstradet_version_5.3.xlsx | Organisationsträd | Objektklasser i HSA org.träd | 18 | 7 |
| hsa-schema_organisationstradet_version_5.3.xlsx | Organisationsträd | LDAP-specifika objektklasser | 8 | 7 |
| hsa-schema_organisationstradet_version_5.3.xlsx | Organisationsträd | HSA Enkel sökning populering | 17 | 3 |
| hsa-schema_organisationstradet_version_5.3.xlsx | Organisationsträd | HSA OID-förteckning | 64 | 10 |
| hsa-schema_organisationstradet_version_5.3.xlsx | Organisationsträd | Borttagna attribut | 72 | 11 |
| hsa-schema_organisationstradet_version_5.3.xlsx | Organisationsträd | Översättn. matchn. indexering | 54 | 8 |
| hsa-schema_tjanstetradet_version_5.3.xlsx | Tjänsteträd | DC Nod1 | 35 | 26 |
| hsa-schema_tjanstetradet_version_5.3.xlsx | Tjänsteträd | DC Koder | 18 | 9 |
| hsa-schema_tjanstetradet_version_5.3.xlsx | Tjänsteträd | DC HOSP | 22 | 16 |
| hsa-schema_tjanstetradet_version_5.3.xlsx | Tjänsteträd | DC Certifier | 13 | 17 |
| hsa-schema_tjanstetradet_version_5.3.xlsx | Tjänsteträd | DC AuthorizationAreas | 17 | 18 |
| hsa-schema_tjanstetradet_version_5.3.xlsx | Tjänsteträd | DC HSA-ansvariga | 19 | 22 |
| hsa-schema_tjanstetradet_version_5.3.xlsx | Tjänsteträd | Objektklasser i HSA Tjänsteträd | 13 | 7 |
| hsa-schema_tjanstetradet_version_5.3.xlsx | Tjänsteträd | LDAP-specifika objektklasser | 4 | 7 |

## Övergripande målbild

| Perspektiv | Mål |
| --- | --- |
| Kravställning | Specifikationen ska kunna användas för att ställa krav på regionala leverantörer |
| Informationsmodell | HSA objekt, attribut, relationer och kodverk ska få en tydlig FHIR representation |
| API | REST API ska kunna leverera kataloginformation som FHIR resurser |
| Validering | Obligatoriska regler ska kunna testas maskinellt där det är möjligt |
| Förvaltning | IG:n ska kunna byggas, versionshanteras och publiceras med FHIR toolchain |
| Harmonisering | Modellen ska kunna jämföras med eHM, svenska basprofiler, mCSD och EHDS relaterade behov |
| Bevarande av semantik | Struktur och innehållskrav från HSA ska inte reduceras till en tunn leverantörsneutral katalog |

## Grundläggande designprinciper

| Princip | Konsekvens för profilering |
| --- | --- |
| Organisation är inte plats | `Organization` ska beskriva ansvar, juridik, organisatorisk struktur och vårdgivarrelationer |
| Plats är inte verksamhetsinriktning | `Location` ska beskriva fysisk eller virtuell plats, inte bära all verksamhetssemantik |
| Vårdtjänst är egen företeelse | `HealthcareService` ska beskriva erbjuden vård, tjänsteutbud och åtkomlig vård |
| Teknisk nåbarhet är egen företeelse | `Endpoint` ska användas för teknisk adressering och integration |
| Uppdrag är inte bara kontaktinformation | `PractitionerRole` eller särskild uppdragsmodell behövs för person, organisation, behörighet och uppdrag |
| Kodverk ska inte användas som allt i allo | HSA verksamhetskoder måste analyseras per FHIR element |
| Sökindex är inte alltid masterdata | HSA enkel sökning och fonetisk sökning bör främst beskrivas som sökförmåga |
| Status är informationsbärande | Dold, arkiverad, felaktigt utpekad och fingerad data måste modelleras explicit |
| FHIR id och HSA id ska inte blandas ihop | HSA id bör normalt ligga i `identifier`, inte användas som enda tekniska FHIR id |
| API krav ska vara testbara | Varje krav bör kunna spåras till profil, SearchParameter, CapabilityStatement eller testfall |

## Objektklasser i HSA organisationsträd

| LDAP objektklass | Typ | OID | Ursprung | FHIR kandidat |
| --- | --- | --- | --- | --- |
| hiddenObject | auxiliary | 1.2.752.41.6.107 | HSA | statusregel, meta.security eller exkludering från publikt API |
| hsaAdminCommission | structural | 1.2.752.29.6.22 | HSA | PractitionerRole eller Basic i separat förvaltningsprofil |
| hsaArchivedObject | auxiliary | 1.2.752.29.6.20 | HSA | meta.security, extension eller statusregel |
| hsaCommission | structural | 1.2.752.29.6.12 | HSA | PractitionerRole |
| hsaConfidentialPerson | auxiliary | 1.2.752.29.6.9 | HSA | säkerhetsklassning och åtkomstregel, inte publik katalogdata |
| hsaDeletedPersonWithValidCertificates | auxiliary | 1.2.752.29.6.28 | HSA |  |
| hsaFeignedDataObject | auxiliary | 1.2.752.29.6.25 | HSA | test eller fingerad data markering |
| hsaHealthCareProvider | auxiliary | 1.2.752.29.6.10 | HSA | Organization profil för vårdgivare |
| hsaHealthCareUnit | auxiliary | 1.2.752.29.6.13 | HSA | Organization profil för vårdenhet |
| hsaInaccurateHCP | auxiliary | 1.2.752.29.6.26 | HSA | statusregel för felaktigt utpekad vårdgivare |
| hsaInaccurateHCU | auxiliary | 1.2.752.29.6.27 | HSA | statusregel för felaktigt utpekad vårdenhet |
| locality | structural | 2.5.6.3 | RFC2256 | Location |
| organization | structural | 2.5.6.4 | RFC2256 | Organization |
| organizationalRole | structural | 2.5.6.8 | RFC2256 | PractitionerRole, Organization eller Endpoint beroende på användning |
| organizationalUnit | structural | 2.5.6.5 | RFC2256 | Organization |
| person | structural | 2.5.6.6 | RFC2256 | Practitioner |

## Objektklasser i HSA tjänsteträd

| LDAP objektklass | Typ | OID | Ursprung | FHIR kandidat |
| --- | --- | --- | --- | --- |
| domain | structural | 0.9.2342.19200300.100.4.13 | RFC 4524 | rot eller partition, oftast inte publik FHIR resurs |
| hiddenObject | auxiliary | 1.2.752.41.6.107 | HSA | statusregel, meta.security eller exkludering från publikt API |
| hsaAdminCommission | structural | 1.2.752.29.6.22 | HSA | PractitionerRole eller Basic i separat förvaltningsprofil |
| hsaCertifier | structural | 1.2.752.29.6.21 | HSA | Practitioner eller separat administrativ katalogprofil |
| hsaCodeTable | structural | 1.2.752.29.6.5 | HSA | CodeSystem och ValueSet |
| hsaDomain | structural | 1.2.752.29.6.24 | HSA | CodeSystem, ValueSet eller administrativ domänmodell |
| hsaDomainArea | structural | 1.2.752.29.6.23 | HSA | CodeSystem eller ValueSet |
| hsaSosPerson | structural | 1.2.752.29.6.4 | HSA | Practitioner med legitimation och HOSP attribut |
| organization | structural | 2.5.6.4 | RFC2256 | Organization |
| organizationalRole | structural | 2.5.6.8 | RFC2256 | PractitionerRole, Organization eller Endpoint beroende på användning |
| organizationalUnit | structural | 2.5.6.5 | RFC2256 | Organization |

## Första observationer från HSA schema

| Observation | Betydelse för FHIR IG |
| --- | --- |
| Organisationsträdet innehåller 127 attribut i schemabladet | IG arbetet behöver en strukturerad attributmatris och prioritering |
| Det finns både strukturella och hjälpande objektklasser | FHIR profileringen måste särskilja resursidentitet från status eller klassificering |
| Vårdgivare och vårdenhet är hjälpobjektklasser | De kan representeras som profiler eller klassificeringar på `Organization` |
| Hidden, archived och inaccurate är egna semantiska markörer | Dessa bör inte tappas bort vid API exponering |
| Tjänsteträdet innehåller kodverk, HOSP, behörighetsområden och administrativa uppdrag | Allt bör inte ingå i samma publika organisations API |
| Flera attribut har markering för 1177, Pascal, NPÖ, säkerhetstjänster och tjänsteplattform | Dessa markeringar är viktiga indikatorer för MustSupport och användningsfall |
| HSA innehåller sök och indexattribut | Dessa bör översättas till serverkrav och SearchParameters, inte nödvändigtvis till utdatafält |
| HSA innehåller operationella LDAP attribut | Dessa bör normalt mappas till `meta`, versionshantering eller utelämnas från publik modell |

## Attributförekomst per objekttyp i organisationsträdet

| Objekttyp i schemat | Obligatoriska attribut | Tillåtna attribut | Övriga markeringar |
| --- | --- | --- | --- |
| Org | 11 | 67 |  |
| Org  Unit | 4 | 71 |  |
| Pers | 6 | 58 |  |
| Org Role | 4 | 64 |  |
| Commission | 3 | 13 |  |
| AdminCommission | 3 | 16 |  |
| Loc | 1 | 9 |  |

## Obligatoriska attribut i organisationsträdet och första FHIR kandidat

| Objekttyp | Attribut | LDAP namn | FHIR kandidat | Kommentar |
| --- | --- | --- | --- | --- |
| Org | direkttelefon<br> | telephoneNumber | Organization.telecom eller HealthcareService.telecom |  |
| Org | e-postadress | mail (rfc822Mailbox) | Organization.telecom eller HealthcareService.telecom |  |
| Org | godkänd HPT för organisationen | hsaHpt | extension eller identifier beroende på HPT semantik |  |
| Org | HSA enkel sökning | hsaSimpleSearch | sökindex, normalt inte normativt utdatafält | Bör beskrivas som serverförmåga eller sökparameter snarare än masterdata |
| Org | HSA fonetisk sökning | hsaPhoneticSearch | sökindex, normalt inte normativt utdatafält | Bör beskrivas som serverförmåga eller sökparameter snarare än masterdata |
| Org | HSA-id | hsaIdentity | identifier slice för HSA id | Bör vara stabil identifierare, inte nödvändigtvis FHIR id |
| Org | innehållsansvarigs e-postadress | hsaDirectoryContact | Organization.contact.telecom eller extension |  |
| Org | organisationsnamn | o (organizationName) | Organization.name |  |
| Org | organisationsnummer | orgNo | Organization.identifier slice för organisationsnummer |  |
| Org | postadress | postalAddress | Organization.address |  |
| Org | strukturerad postadress | hsaPostalAddress | Organization.address med strukturerad profilering |  |
| Org  Unit | enhetsnamn | ou (organizationalUnitName) | Organization.name |  |
| Org  Unit | HSA enkel sökning | hsaSimpleSearch | sökindex, normalt inte normativt utdatafält | Bör beskrivas som serverförmåga eller sökparameter snarare än masterdata |
| Org  Unit | HSA fonetisk sökning | hsaPhoneticSearch | sökindex, normalt inte normativt utdatafält | Bör beskrivas som serverförmåga eller sökparameter snarare än masterdata |
| Org  Unit | HSA-id | hsaIdentity | identifier slice för HSA id | Bör vara stabil identifierare, inte nödvändigtvis FHIR id |
| Pers | efternamn | sn (surname ) | Practitioner.name.family |  |
| Pers | fullständigt namn | fullName | Practitioner.name.text |  |
| Pers | HSA enkel sökning | hsaSimpleSearch | sökindex, normalt inte normativt utdatafält | Bör beskrivas som serverförmåga eller sökparameter snarare än masterdata |
| Pers | HSA fonetisk sökning | hsaPhoneticSearch | sökindex, normalt inte normativt utdatafält | Bör beskrivas som serverförmåga eller sökparameter snarare än masterdata |
| Pers | HSA-id | hsaIdentity | identifier slice för HSA id | Bör vara stabil identifierare, inte nödvändigtvis FHIR id |
| Pers | objektnamn | cn (commonName) | name eller identifier beroende på objektklass |  |
| Org Role | HSA enkel sökning | hsaSimpleSearch | sökindex, normalt inte normativt utdatafält | Bör beskrivas som serverförmåga eller sökparameter snarare än masterdata |
| Org Role | HSA fonetisk sökning | hsaPhoneticSearch | sökindex, normalt inte normativt utdatafält | Bör beskrivas som serverförmåga eller sökparameter snarare än masterdata |
| Org Role | HSA-id | hsaIdentity | identifier slice för HSA id | Bör vara stabil identifierare, inte nödvändigtvis FHIR id |
| Org Role | objektnamn | cn (commonName) | name eller identifier beroende på objektklass |  |
| Commission | HSA-id | hsaIdentity | identifier slice för HSA id | Bör vara stabil identifierare, inte nödvändigtvis FHIR id |
| Commission | objektnamn | cn (commonName) | name eller identifier beroende på objektklass |  |
| Commission | vårdmedarbetaruppdragets ändamål | hsaCommissionPurpose | PractitionerRole.code, purpose extension eller Consent relaterad policy |  |
| AdminCommission | administrativa medarbetaruppdragets organisationsomfång | hsaAdminCommissionSector | PractitionerRole eller administrativ behörighetsmodell |  |
| AdminCommission | HSA-id | hsaIdentity | identifier slice för HSA id | Bör vara stabil identifierare, inte nödvändigtvis FHIR id |
| AdminCommission | objektnamn | cn (commonName) | name eller identifier beroende på objektklass |  |

## Markerade konsumenter och tjänster i HSA attributschemat

Denna tabell visar att HSA redan bär spår av praktisk användning i nationella och regionala tjänster. Markeringarna bör användas som signaler vid prioritering av MustSupport, sökbarhet och kompatibilitet.

| Tjänst eller konsument | Antal markerade attribut | Analys i IG |
| --- | --- | --- |
| 1177 Hitta vård | 45 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| 1177.se | 25 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Pascal | 20 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Säkerhetstjänster | 21 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Infektionsverktyget | 11 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Stöd och behandling | 18 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Intygstjänster | 33 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| eMortis | 14 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Statistiktjänst för ordinerad sjukskrivning | 11 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Tieto LIAM | 16 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Tjänsteplattformen | 4 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Svensk e-identitet Autentiseringstjänst | 13 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| NPÖ | 12 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Statistiktjänsten | 16 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| 1177 journal | 9 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| UCR Qreg5 | 7 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Formulär (1177) | 3 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Vården i siffror | 18 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| StretchCareAgent | 23 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Signe | 22 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| OMCX (Arbets-förmedlingen) | 3 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| iChemistry | 8 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| SmiNet3 | 12 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Arbetsplatsregister (Vårdförbundet) | 16 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Digital rekvirering (Löf) | 21 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |
| Publika enheter    (Visas för "03") | 42 | Används som signal för MustSupport, sökbarhet och kompatibilitetskrav |

## Tjänsteträdets blad och användning i IG arbetet

| Blad | Rader | Kolumner | Användning i IG arbetet |
| --- | --- | --- | --- |
| DC Nod1 | 35 | 26 | Krav på tjänsteobjekt, funktioner, administrativa uppdrag och rotstruktur |
| DC Koder | 18 | 9 | Underlag för CodeSystem, ValueSet och kodverksmetadata |
| DC HOSP | 22 | 16 | Underlag om HOSP information och relation till Practitioner |
| DC Certifier | 13 | 17 | Administrativ person eller certifieringsinformation, sannolikt utanför kärn API |
| DC AuthorizationAreas | 17 | 18 | Behörighetsområden och egenskaper, viktigt för uppdrag och åtkomst |
| DC HSA-ansvariga | 19 | 22 | Administrativa ansvarsfunktioner, främst för förvaltning |
| Objektklasser i HSA Tjänsteträd | 13 | 7 | Objektklasser som ska klassas som katalogdata, kodverk eller förvaltningsdata |
| LDAP-specifika objektklasser | 4 | 7 | Tekniska objektklasser och LDAP tillägg |

## Föreslagen FHIR resurskarta

| Verklig företeelse | Primär FHIR resurs | Sekundära resurser | Kommentar |
| --- | --- | --- | --- |
| Vårdgivare | `Organization` | `Endpoint`, `HealthcareService` | Bör profileras som juridiskt eller ansvarigt vårdgivarobjekt |
| Vårdenhet | `Organization` | `Location`, `HealthcareService` | Bör inte automatiskt likställas med fysisk mottagning |
| Organisatorisk enhet | `Organization` | `OrganizationAffiliation` | Behöver regler för `partOf` och ansvar |
| Person | `Practitioner` | `PractitionerRole` | Ingår endast om personinformation är i scope |
| Vårdmedarbetaruppdrag | `PractitionerRole` | `Organization`, `HealthcareService` | Viktigt för behörighet och PDL relaterad användning |
| Administrativt medarbetaruppdrag | `PractitionerRole` eller administrativ profil | `Organization` | Kan behöva ligga utanför kärn API |
| Fysisk plats | `Location` | `Organization` | Adress, geografisk information och platshierarki |
| Virtuell plats | `Location` eller `HealthcareService` | `Endpoint` | Beslut krävs för digital mottagning och e tjänst |
| Vårdtjänst | `HealthcareService` | `Organization`, `Location`, `Endpoint` | Bästa platsen för erbjuden vård och verksamhetsutbud |
| Teknisk tjänsteadress | `Endpoint` | `Organization`, `HealthcareService` | Viktig för resursorienterad API modell ovanpå HSA |
| Kodverk i tjänsteträdet | `CodeSystem`, `ValueSet` | `ConceptMap` | Bör publiceras i terminologidelen av IG:n |
| Behörighetsområde | `CodeSystem`, `ValueSet` eller policyprofil | `PractitionerRole` | Beror på om behörighet ingår i scope |

## Rekommenderade profiler

| Profil | Basresurs | Syfte |
| --- | --- | --- |
| `HsaCatalogOrganization` | `Organization` | Gemensam basprofil för organisationer från HSA |
| `HsaHealthcareProviderOrganization` | `Organization` | Vårdgivare |
| `HsaHealthcareUnitOrganization` | `Organization` | Vårdenhet |
| `HsaOrganizationalUnit` | `Organization` | Organisationsenhet som inte är vårdgivare eller vårdenhet |
| `HsaCatalogLocation` | `Location` | Gemensam platsprofil |
| `HsaCareDeliveryLocation` | `Location` | Plats där vård erbjuds |
| `HsaHealthcareService` | `HealthcareService` | Erbjuden vård, mottagningsbar tjänst eller tjänsteutbud |
| `HsaEndpoint` | `Endpoint` | Teknisk nåbarhet och tjänsteadressering |
| `HsaPractitioner` | `Practitioner` | Personinformation om person ingår |
| `HsaPractitionerRole` | `PractitionerRole` | Uppdrag, roll och relation till organisation |
| `HsaOrganizationAffiliation` | `OrganizationAffiliation` | Relationer som inte är ren `partOf` hierarki |

## Avgränsningsbeslut som bör fattas tidigt

| Beslut | Alternativ | Rekommendation |
| --- | --- | --- |
| FHIR version | R4, R4B, R5 | Välj R4 om leverantörsstöd väger tyngst, välj R5 om katalog och API modellering får väga tyngre |
| Scope för person | Med eller utan `Practitioner` | Bör beslutas separat eftersom persondata påverkar skydd, åtkomst och förvaltning |
| Scope för uppdrag | Med eller utan medarbetaruppdrag | Vårdmedarbetaruppdrag är centralt för vissa HSA användningar men kan göra IG:n betydligt bredare |
| Scope för tjänsteadressering | Med eller utan `Endpoint` | Bör ingå om API:t även ska stödja adressering och teknisk nåbarhet |
| Scope för kodverk | Kodverk som externa beroenden eller del av IG | Bör åtminstone inkludera ValueSet och canonical URI strategi |
| Publikt API | Hela HSA eller vyer | Bör bygga på vyer eftersom allt i HSA inte ska exponeras likadant |
| Statushantering | Dold, arkiverad, felaktig som data eller filtrering | Bör vara explicit eftersom status påverkar säkerhet, åtkomst och spårbarhet |

## Kodverksanalys

Kodverken är en av de största semantiska riskerna. Samma kodverk får inte användas för organisation, plats, vårdtjänst och klinisk specialitet utan tydlig regel.

| FHIR element | Möjlig HSA källa | Risk | Rekommendation |
| --- | --- | --- | --- |
| `Organization.type` | HSA verksamhetskod eller organisationstyp | Kan blanda organisationsroll och verksamhetsinriktning | Definiera exakt vad typen betyder och skilj vårdgivare, vårdenhet och organisatorisk enhet |
| `HealthcareService.type` | HSA verksamhetskod | Ofta rimligt | Använd som verksamhetsinriktning eller tjänstetyp med tydlig definition |
| `HealthcareService.category` | Nationell kategori eller FHIR kategori | Risk för överlapp med type | Använd för grövre kategorisering |
| `HealthcareService.specialty` | Specialitetskodverk | Risk att HSA verksamhet används som specialitet | Använd endast kodverk som faktiskt uttrycker specialitet |
| `Location.type` | Plats eller lokalkodverk | HSA verksamhetskod beskriver inte plats | Använd platstyp om möjligt |
| `Endpoint.connectionType` | Teknisk kod | Ska inte blandas med verksamhetskod | Använd tekniska kodverk |
| `PractitionerRole.code` | Roll eller uppdragstyp | Risk att uppdragets syfte blandas med yrkesroll | Separera yrke, roll, uppdrag och ändamål |

## Terminologiartefakter som bör tas fram

| Artefakt | Innehåll | Syfte |
| --- | --- | --- |
| `CodeSystem` för HSA objektklassificering | Vårdgivare, vårdenhet, arkiverad, dold och liknande där det behövs | Stabil FHIR terminologi |
| `ValueSet` för organisationstyper | Tillåtna typer för `Organization.type` | Validering |
| `ValueSet` för vårdtjänsttyper | Tillåtna typer för `HealthcareService.type` | Tjänstesökning och krav |
| `ValueSet` för platstyper | Tillåtna typer för `Location.type` | Undvika missbruk av verksamhetskoder |
| `ValueSet` för kontaktvägsändamål | Telefon, e post, remiss, publik kontakt | Strukturera telecom och contact |
| `ConceptMap` HSA till FHIR | HSA kodverk till FHIR element och eventuellt externa kodverk | Spårbarhet och harmonisering |
| `NamingSystem` för HSA id | Identifierarsystem och URI | Entydig identifiering |
| `NamingSystem` för organisationsnummer | Identifierarsystem och URI | Entydig identifiering av juridiska organisationer |

## Exempel på FHIRPath regler

```fsh
Invariant: hsacat-org-hsa-id
Description: "En organisation från HSA ska ha HSA id."
Severity: #error
Expression: "identifier.where(system = 'urn:oid:1.2.752.29.4.19').exists()"
```

```fsh
Invariant: hsacat-healthcare-provider-orgno
Description: "En organisation som är markerad som vårdgivare ska ha organisationsnummer."
Severity: #error
Expression: "type.coding.where(code = 'healthcare-provider').exists() implies identifier.where(system = 'urn:oid:2.5.4.97').exists()"
```

```fsh
Invariant: hsacat-physical-location-address
Description: "En fysisk plats ska ha adress."
Severity: #error
Expression: "mode = 'instance' implies address.exists()"
```

```fsh
Invariant: hsacat-healthcare-service-provider-or-location
Description: "En vårdtjänst ska knytas till tillhandahållande organisation eller plats."
Severity: #error
Expression: "providedBy.exists() or location.exists()"
```

```fsh
Invariant: hsacat-digital-service-contact
Description: "En digital vårdtjänst ska ha kontaktväg eller teknisk ändpunkt."
Severity: #error
Expression: "type.coding.where(code = 'digital').exists() implies (telecom.exists() or endpoint.exists())"
```

## Kravtyper och FHIR uttryck

| Kravtyp | Exempel från HSA eller tillämpning | FHIR uttryck |
| --- | --- | --- |
| Identitet | HSA id krävs på centrala objekt | `identifier` slicing och kardinalitet |
| Namn | Organisation och enhet ska ha namn | `Organization.name` med kardinalitet |
| Organisationsnummer | Vårdgivare ska ha organisationsnummer | `Organization.identifier` slice |
| Struktur | En enhet kan ingå i organisation | `Organization.partOf` |
| Platsansvar | Plats hanteras av organisation | `Location.managingOrganization` |
| Vårdtjänst | Organisation erbjuder tjänst vid plats | `HealthcareService.providedBy` och `HealthcareService.location` |
| Kontaktväg | Kontakt ska finnas för publik enhet | `telecom`, `contact` eller `Endpoint` |
| Status | Objekt kan vara dolt, arkiverat eller felaktigt | `active`, `meta.security`, extension eller profilregel |
| Kodverk | Värden ska hämtas från HSA kodverk | `ValueSet` binding |
| Sökbarhet | Enkel sökning och fonetisk sökning | `SearchParameter` och serverkrav |

## Agentiskt arbetssätt

### Roller

| Agent | Huvuduppgift | Viktigaste leverabler |
| --- | --- | --- |
| Källinventeringsagent | Samla och klassificera källor | Källkatalog, versionslista, luckor |
| Attributagent | Extrahera attribut, kardinalitet och objektklasser | Attributmatris, kravkatalog |
| Tillämpningsagent | Identifiera faktisk användning i vårdtjänster | Användningsfall, beroenden, risker |
| Terminologiagent | Analysera kodverk och bindningar | CodeSystem, ValueSet, ConceptMap förslag |
| FHIR modelleringsagent | Ta fram profilstruktur | Resurskarta, profiler, extensions |
| Regelagent | Översätta krav till validerbara uttryck | FHIRPath, slicing, kardinalitet |
| API agent | Definiera REST och CapabilityStatement | SearchParameters, include regler, felhantering |
| Testagent | Bygga testpaket | Exempeldata, negativa test, valideringsregler |
| Harmoniseringsagent | Jämföra med eHM och internationella mönster | Avvikelsematris, harmoniseringsbeslut |
| Granskningsagent | Säkerställa konsekvens | Beslutslogg, kvalitetssäkring |

### Arbetsflöde

| Steg | Input | Agent | Output |
| --- | --- | --- | --- |
| 1. Källbas | HSA schema, policy, tillämpningsdokument | Källinventeringsagent | Källkatalog och läsordning |
| 2. Råextraktion | Excel schema, kodverkslista | Attributagent | Maskinläsbar attributmatris |
| 3. Begreppsmodell | Attribut och objektklasser | FHIR modelleringsagent | Begreppskarta och resursval |
| 4. Tillämpningsanalys | NPÖ, 1177, Pascal, säkerhetstjänster, tjänsteplattform | Tillämpningsagent | Scenarier och MustSupport kandidater |
| 5. Terminologi | HSA kodverk och externa kodverk | Terminologiagent | Bindningsstrategi |
| 6. Profilering | Resursval och krav | FHIR modelleringsagent | FSH profiler |
| 7. Regler | Kardinalitet och innehållskrav | Regelagent | FHIRPath invariants |
| 8. API design | Use cases och profiler | API agent | CapabilityStatement och SearchParameters |
| 9. Test | Profiler och exempel | Testagent | Testpaket och valideringsfall |
| 10. Harmonisering | eHM, mCSD, svenska basprofiler | Harmoniseringsagent | Avvikelsematris |
| 11. Remiss | IG utkast | Granskningsagent | Remissversion |
| 12. Fastställande | Remissvar och beslut | Granskningsagent | Version 1.0 kandidat |

## Kravspårningsmodell

Varje krav bör dokumenteras med följande fält.

| Fält | Beskrivning | Exempel |
| --- | --- | --- |
| Krav id | Stabil identifierare | `HSACAT-ORG-001` |
| Kravtext | Normativ formulering | En organisation som representerar vårdgivare ska ha HSA id |
| Källa | Dokument, schema eller tillämpning | HSA schema organisationsträd |
| HSA element | Attribut eller objektklass | `hsaIdentity` |
| FHIR element | Mål i FHIR | `Organization.identifier:hsa-id` |
| Kravstyrka | SHALL, SHOULD eller MAY | SHALL |
| Validering | Hur kravet testas | Kardinalitet och slicing |
| Testfall | Positivt och negativt test | Organization utan HSA id ska underkännas |
| Motivering | Varför kravet finns | Entydig identifiering i nationella tjänster |
| Status | Arbetsstatus | Föreslagen, granskad, beslutad |

## REST API krav

| Förmåga | Exempel | Kravnivå |
| --- | --- | --- |
| Läs organisation | `GET /Organization/{id}` | SHALL |
| Sök via HSA id | `GET /Organization?identifier=...` | SHALL |
| Sök via organisationsnummer | `GET /Organization?identifier=...` | SHOULD |
| Hämta organisationshierarki | `GET /Organization?_include=Organization:partof` | SHOULD |
| Sök vårdtjänst per organisation | `GET /HealthcareService?organization=...` | SHALL om `HealthcareService` ingår |
| Sök vårdtjänst per plats | `GET /HealthcareService?location=...` | SHOULD |
| Sök plats per organisation | `GET /Location?organization=...` eller sökning via managing organization | SHOULD |
| Hämta teknisk ändpunkt | `GET /Endpoint?organization=...` | SHOULD om tjänsteadressering ingår |
| Filtrera aktiva objekt | `active=true` eller profilbestämd sökparameter | SHALL |
| Delta eller förändringar | `_lastUpdated` eller annan förändringsmekanism | SHOULD |
| Felhantering | `OperationOutcome` | SHALL |
| Metadata | `CapabilityStatement` | SHALL |

## SearchParameters som bör definieras eller krävas

| Resurs | SearchParameter | Syfte |
| --- | --- | --- |
| `Organization` | `identifier` | Sökning på HSA id och organisationsnummer |
| `Organization` | `name` | Namnsökning |
| `Organization` | `type` | Vårdgivare, vårdenhet, organisationsenhet |
| `Organization` | `partof` | Hierarki |
| `Organization` | `active` | Filtrering av aktiva objekt |
| `Location` | `identifier` | Platsidentifiering |
| `Location` | `name` | Platssökning |
| `Location` | `organization` eller anpassad parameter | Sök plats via ansvarig organisation |
| `HealthcareService` | `organization` | Tjänster som tillhandahålls av organisation |
| `HealthcareService` | `location` | Tjänster på plats |
| `HealthcareService` | `service-type` | Vårdtjänsttyp eller verksamhetsinriktning |
| `HealthcareService` | `specialty` | Specialitet |
| `Endpoint` | `organization` | Teknisk nåbarhet för organisation |
| `Endpoint` | `connection-type` | Typ av teknisk anslutning |

## Include och sammanhållen hämtning

| Fråga | Rekommenderad mekanism |
| --- | --- |
| Hämta organisation med överordnad organisation | `_include=Organization:partof` |
| Hämta vårdtjänster för organisation | `_revinclude=HealthcareService:organization` eller separat sökning |
| Hämta platser för vårdtjänst | `_include=HealthcareService:location` |
| Hämta organisation bakom vårdtjänst | `_include=HealthcareService:organization` |
| Hämta endpoints för organisation | `_revinclude=Endpoint:organization` eller profilbestämd parameter |
| Hämta sammanhållet katalogpaket | `$everything`, `$graph` eller definierad operation |

## Status och synlighet

| HSA markör | Betydelse | FHIR strategi |
| --- | --- | --- |
| `hiddenObject` | Objekt är dolt eller inaktiverat | `active=false`, `meta.security`, extension eller exkludering från publik vy |
| `hsaArchivedObject` | Objekt är arkiverat | `active=false` och arkiverings extension eller säkerhetsmärkning |
| `hsaInaccurateHCP` | Felaktigt utpekad vårdgivare | Status extension och särskild valideringsregel |
| `hsaInaccurateHCU` | Felaktigt utpekad vårdenhet | Status extension och särskild valideringsregel |
| `hsaFeignedDataObject` | Fingerat objekt | Säkerhetsmärkning eller testdata markering |
| `hsaConfidentialPerson` | Skyddad person | Ska normalt inte exponeras i publik katalogvy |

## Harmonisering med eHM vårdgivarkatalog

| Harmoniseringsfråga | Rekommenderad princip |
| --- | --- |
| Samma begrepp finns i båda modellerna | Mappa och återanvänd där semantiken är jämförbar |
| eHM begrepp är grövre än HSA | Bevara HSA kravet i Inera IG |
| eHM saknar strukturkrav som används i vården | Dokumentera avvikelse och motivering |
| eHM har annat API mönster | Harmoniera där det inte försvagar HSA semantik |
| Gemensam identifierare finns | Återanvänd identifierare och dokumentera system URI |
| Konflikt i kodverk | Prioritera HSA där krav härrör från etablerad vårdtillämpning |
| Konflikt i ansvarsbegrepp | Beskriv skillnaden explicit i IG:n |

## Förhållande till internationella mönster

| Mönster | Relevans | Rekommendation |
| --- | --- | --- |
| mCSD | Katalog över organisationer, platser, tjänster och endpoints | Använd som jämförelsemönster |
| IPS | Indirekt relevans via vårdkontakter och organisationer | Säkerställ att referenser kan användas i kliniska resurser |
| IHE profiler | Kan ge vägledning för katalog och dokumentdelning | Använd som jämförelse men låt inte SOAP mönster styra API |
| EHDS | Behöver robusta organisations och tjänstereferenser | Säkerställ att modellen kan bära åtkomst och utbytesbehov |
| Svenska basprofiler | Viktiga beroenden | Återanvänd där de är semantiskt tillräckliga |

## Exempel på leverantörskrav

| Krav id | Krav | Typ | Test |
| --- | --- | --- | --- |
| HSACAT-API-001 | Servern ska exponera `CapabilityStatement` | API | `GET /metadata` |
| HSACAT-ORG-001 | Organisation från HSA ska ha HSA id | Profil | Validera `Organization.identifier` |
| HSACAT-ORG-002 | Vårdgivare ska ha organisationsnummer | Profil | Negativt test utan organisationsnummer |
| HSACAT-ORG-003 | Organisation ska ha namn | Profil | Validera `Organization.name` |
| HSACAT-LOC-001 | Fysisk plats ska ha adress | Profil och invariant | Negativt test utan `address` |
| HSACAT-HSVC-001 | Vårdtjänst ska ha tillhandahållande organisation eller plats | Invariant | Negativt test utan båda |
| HSACAT-TERM-001 | Kodade värden ska använda definierade ValueSets | Terminologi | Terminologivalidering |
| HSACAT-SEARCH-001 | Sökning på HSA id ska stödjas | API | `GET /Organization?identifier=...` |
| HSACAT-ERR-001 | Fel ska returneras som `OperationOutcome` | API | Skicka ogiltig sökning |
| HSACAT-VERS-001 | Profiler och kodverk ska versioneras | Förvaltning | Kontroll av package och canonical |

## Föreslagen IG struktur

| Sida | Innehåll |
| --- | --- |
| `index.md` | Syfte, scope och målgrupp |
| `background.md` | HSA, organisationsträd, tjänsteträd och användning i vården |
| `design-principles.md` | Designprinciper och gränsdragningar |
| `conceptual-model.md` | Begreppsmodell för organisation, plats, vårdtjänst och endpoint |
| `hsa-mapping.md` | Mappning från HSA objekt och attribut till FHIR |
| `profiles.md` | Samlad profilöversikt |
| `terminology.md` | Kodsystem, ValueSets, NamingSystems och ConceptMaps |
| `rules.md` | Invariants, kardinaliteter och verksamhetsregler |
| `api.md` | REST API, sökningar, includes och felhantering |
| `examples.md` | Exempelresurser och scenarier |
| `testing.md` | Testfall, validering och leverantörstest |
| `ehm-alignment.md` | Harmonisering och avvikelser mot eHM |
| `governance.md` | Förvaltning, versionering och ändringshantering |

## Prioriterad backlog

| Prioritet | Arbete | Resultat |
| --- | --- | --- |
| 1 | Fastställ scope för version 0.1 | Beslutat om person, uppdrag och endpoint ingår |
| 1 | Normalisera HSA attributmatris | CSV eller JSON med attribut, objektklass, kardinalitet och källor |
| 1 | Ta fram begreppsmodell | Diagram och tabell över centrala begrepp |
| 1 | Besluta FHIR version | R4, R4B eller R5 med motivering |
| 1 | Ta fram profilkarta | Lista över profiler och basresurser |
| 2 | Terminologianalys av HSA verksamhetskoder | Bindningsbeslut per FHIR element |
| 2 | Identifierarsystem och NamingSystems | HSA id, organisationsnummer och andra identifierare |
| 2 | Första FSH profiler | Organization, Location, HealthcareService |
| 2 | Första API kontrakt | CapabilityStatement och centrala SearchParameters |
| 3 | Testdata | Kompletta svenska katalogexempel |
| 3 | Negativa testfall | Validering av felaktiga kombinationer |
| 3 | Harmonisering med eHM | Jämförelsematris och avvikelser |
| 3 | Remisspaket | IG, kravmatris och beslutslogg |

## Kvalitetskriterier

| Kriterium | Beskrivning |
| --- | --- |
| Full spårbarhet | Varje normativt krav ska ha källa eller beslutsmotivering |
| Validerbarhet | Krav ska uttryckas maskinläsbart där det är rimligt |
| Leverantörstestbarhet | Krav ska kunna testas utan informella tolkningar |
| Semantisk tydlighet | Organisation, plats, vårdtjänst och endpoint ska hållas isär |
| Terminologisk precision | Kodverk ska användas på rätt FHIR element |
| Kompatibilitet | Modellen ska kunna samexistera med svenska basprofiler och relevanta internationella mönster |
| Förvaltningsbarhet | Ändringar ska kunna versioneras och publiceras som FHIR package |
| API duglighet | Specifikationen ska beskriva faktisk serverförmåga, inte bara resursformat |

## Rekommenderad första leverans

Den första leveransen bör vara en IG version `0.1.0` med följande innehåll:

| Del | Innehåll |
| --- | --- |
| Profiler | `HsaCatalogOrganization`, `HsaCatalogLocation`, `HsaHealthcareService`, `HsaEndpoint` |
| Terminologi | HSA identifierarsystem, centrala ValueSets, första ConceptMaps |
| Regler | HSA id, organisationsnummer, namn, status och grundläggande relationer |
| API | `CapabilityStatement`, sökning på identifierare, namn, typ och relationer |
| Exempel | Vårdgivare, vårdenhet, mottagning, plats, vårdtjänst och endpoint |
| Test | Minst tio positiva och tio negativa testfall |
| Dokumentation | Designprinciper, mappningstabell och harmonisering mot eHM |

## Slutlig målbild

Den färdiga specifikationen bör bestå av följande artefakter:

| Artefakt | Syfte |
| --- | --- |
| Publicerad FHIR IG | Normativ dokumentation |
| FSH källkod | Förvaltning och CI |
| NPM package | Validering och beroendehantering |
| CapabilityStatement | API krav |
| SearchParameters | Sökkrav |
| CodeSystems och ValueSets | Terminologikrav |
| ConceptMaps | Mappning och harmonisering |
| Exempeldata | Leverantörsförståelse och test |
| Negativa testfall | Kvalitetssäkring |
| Kravmatris | Upphandling och leverantörsstyrning |
| Beslutslogg | Spårbarhet i semantiska vägval |

## Nästa praktiska steg

| Ordning | Aktivitet | Konkret output |
| --- | --- | --- |
| 1 | Exportera HSA schema till normaliserad arbetsmatris | `hsa-attributes.csv` och `hsa-objectclasses.csv` |
| 2 | Markera vilka attribut som är API relevanta | Kolumn för scope och prioritet |
| 3 | Klassificera varje attribut semantiskt | Organisation, plats, tjänst, endpoint, person, uppdrag, status, sökindex |
| 4 | Föreslå FHIR element per attribut | Mappningsmatris |
| 5 | Markera vilka krav som kan valideras | Kardinalitet, slicing, binding, invariant eller test |
| 6 | Ta fram första FSH skeleton | Profiler och exempel |
| 7 | Bygg IG i CI | Publicerad `ci-build` |
| 8 | Kör validering mot exempeldata | Felrapport och förbättringslogg |
| 9 | Genomför expertgranskning | Beslut om gränsdragningar |
| 10 | Skapa leverantörsvänlig kravmatris | Krav med SHALL, SHOULD och MAY |

