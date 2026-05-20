
|  | infrastructure:directory:organization / Tjänstekontraktsbeskrivning / Version 5.0 / ARK_0015 / 2025-10-13 |
| :--- | :--- |
Innehåll
1	Inledning	13
1.1	Svenskt namn	13
2	Versionsinformation	14
2.1	Version 5.0	14
2.1.1	Oförändrade tjänstekontrakt	14
2.1.2	Nya tjänstekontrakt	14
2.1.3	Förändrade tjänstekontrakt	14
2.1.4	Utgångna tjänstekontrakt	15
2.2	Version tidigare	15
3	Tjänstedomänens arkitektur	15
3.1	Flöden	15
3.1.1	Hämta information om en vårdenhet	15
3.1.2	Hämta information om en vårdgivares alla vårdenheter	16
3.1.3	Hämta information om en vårdenhets ingående enheter	17
3.1.4	Hämta information om en organisatorisk enhet	17
3.1.5	Hämta information om en vårdgivare	18
3.1.6	Obligatoriska kontrakt	18
3.2	Adressering	19
3.3	Aggregering och engagemangsindex	19
4	Tjänstedomänens krav och regler	19
4.1	Informationssäkerhet och juridik	20
4.2	Icke funktionella krav	20
4.2.1	SLA krav	20
4.3	Felhantering	20
4.3.1	Krav på en tjänsteproducent	21
4.3.2	Krav på en tjänstekonsument	22
5	Tjänstedomänens meddelandemodeller	22
5.1	V-MIM	22
5.2	Formatregler	23
5.2.1	RIV-specifikation	23
6	Tjänstekontrakt	24
6.1	GetHealthCareUnit	24
6.1.1	Version	24
6.1.2	Fältregler	24
6.1.3	Tjänstekontraktsspecifika krav och regler	26
6.1.4	Annan information om kontraktet	27
6.2	GetHealthCareUnitList	28
6.2.1	Version	28
6.2.2	Fältregler	28
6.2.3	Tjänstekontraktsspecifika krav och regler	30
6.2.4	Annan information om kontraktet	31
6.3	GetHealthCareUnitMembers	32
6.3.1	Version	32
6.3.2	Fältregler	32
6.3.3	Tjänstekontraktsspecifika krav och regler	37
6.3.4	Annan information om kontraktet	38
6.4	GetUnit	39
6.4.1	Version	39
6.4.2	Fältregler	39
6.4.3	Tjänstekontraktsspecifika krav och regler	45
6.4.4	Annan information om kontraktet	47
6.5	GetHealthCareProvider	48
6.5.1	Version	48
6.5.2	Fältregler	48
6.5.3	Tjänstekontraktsspecifika krav och regler	49
6.5.4	Annan information om kontraktet	50
Revisionshistorik

| Version | Revision Nr | Revision Datum | Beskrivning av ändringar | Ändringar gjorda av | Granskad av |
| :--- | :--- | :--- | :--- | :--- | :--- |
|  | PA1 | 2013-05-22 – 2013-07-19 | Första version | Ronny Nilsson, Henrika Littorin, Björn Skeppner |  |
|  | PA2 | 2013-09-06 | Uppdaterat efter synpunkter från Arkitektur och Regelverk / Skapat bilaga Arkitekturella beslut och lyft ut relevanta delar i skrivningar och kommentarer till detta dokument / Förbättringsförslag för mallen utlyfta till separat mail / Två mindre språkliga korrigeringar / Tydliggjort skrivning om informationsägarskap samt hänvisningen till R4 | Henrika Littorin |  |
|  | PA3 | 2013-10-03 – 2013-10-30 | Uppdaterat efter synpunkter från Arkitektur & Regelverk / Justering av SLA-nivåer / Anrop med felaktiga svar ska ge svar med felinformation / Förtydligande av att referenser till HSA är exempel där så är tillämpligt / Uppdaterat referenser till befintliga och nya arkitekturella beslut. / Byte av namn från organisation till organization / Förberedelse för delning i tre domäner | Ronny Nilsson, Henrika Littorin |  |
|  | PA4 | 2013-10-30 | Delad och rensad från information som enbart berör tjänstedomänerna employee och authorizationmanagement | Henrika Littorin |  |
|  | PA5 | 2014-01-29 | Borttag av attributet Fakturaadress / Förändrad funktionalitet i tjänstekontraktet GetHealthCareUnit / Tillägg av namn på enhet, vårdenhet och vårdgivare / Tillägg av HSA-id samt start- och slutdatum för vårdenhet / Tillägg av organisationsnummer för vårdgivare / Funktionsändring så att kontraktet ger svar även om HSA-id i frågan motsvarar en vårdenhet och att svaret då returneras med en flagga som informerar om att enheten är en vårdenhet / Tillägg av ytterligare felfall | Robert Lundmark |  |
| 1.0_RC2 |  | 2014-03-18 | Justeringar enligt avstämning med Ineras IT-arkitekt och A&R I samt efter intern genomgång: / Infört två alternativ för hantering av flera anslutna tjänsteproducenter (katalogtjänster) med beskrivning av fördelar för respektive alternativ / Justering av hänvisning till arkitekturella beslut (nu gemensamma för tre domäner), borttag av referenser till borttagna AB:n samt justering av numrering av övriga AB:n / Justerat skrivning om styrning av åtkomst / Borttag av några exempel på krav som kan ställas på tjänstekonsument / Borttag av referens till HSA-policyn för krav på producent / Borttag av SLA-krav på antal avbrott och längd på avbrott | Henrika Littorin, Ronny Nilsson |  |
| 1.0.0.RC_03 |  | 2014-07-22 | Justeringar enligt granskningsprotokoll VIS samt T / Benämning av domänen på förstasidan samt svenskt namn på domänen / Överflytt av beskrivning av alternativ för aggregering/engagemangsindex till AB / Överfört till ny mall | Henrika Littorin |  |
| 1.0_RC4 |  | 2014-09-05 | Återgått till gammal benämning av versioner enligt besked från Leo Röjerås / Tillägg av nytt avsnitt ”Svenskt namn” samt justering under rubriken WEB beskrivning enligt ny mall för TKB | Henrika Littorin, Inera AB |  |
| 1.0_RC5 |  | 2014-10-22 | Korrigerat felkoder och varningar. | Robert Lundmark, Cybercom AB |  |
| 1.0.1_RC1 |  | 2015-02-24 | Ny metod getHealthCareUnitIncludingManager / Tagit bort RC-nummer för tjänstekontrakt / Förtydligat att getHealthCareUnit även gäller funktioner | Robert Lundmark, Cybercom AB |  |
| 1.1_RC1 |  | 2015-07-30 | Lagt till stöd för fingerade objekt i alla metoder / Nya felfall Vårdgivare finns inte i katalogen och Det går inte att hitta några vårdenheter under vårdgivaren / Uppdaterat referens till HSA-schemat samt kompletterat inbäddat schema för tjänstedomänerna | Robert Lundmark Cybercom AB, Henrika Littorin, Inera AB |  |
| 1.2_RC1 |  | 2015-10-14 | Lagt till stöd för arkiverade objekt i metoderna
getHealthCareUnit
getHealthCareUnitIncludingManager
getHealthCareUnitList
getHealthCareUnitMembers | Robert Lundmark Cybercom AB |  |
| 1.3_RC1 |  | 2016-04-11 | Ändrat kardinalitet för fälten healthCareUnitMemberHsaId och healthCareUnitMemberName till att inte längre vara obligatoriska. / Förtydligat hur argumentet searchBase används i metodanropen. | Robert Lundmark Cybercom AB |  |
| 2.0_RC1 |  | 2016-10-24 | Justerat felhantering enligt avstämning med A&R / Justerat skrivning om adressering efter input från Tommy Carlsson. / Uppdaterat/förtydligat textuella beskrivningar av attributen organisationsnummer, HSA-id, arbetsplatskod och e-postadress; justerat maxlängd för remisskrav till 1024 tecken samt kompletterat fliken Reserverade funktionsnamn (tillägg av nya värden samt beskrivningar för samtliga värden) i schemat utifrån förändringar i HSA-schemaversion 4.6.1 och 4.7. / Kompletterat Excel-schemat med beskrivning av tjänstekontraktsparametrar som inte tekniskt är attribut (healthCareUnitHsaId etc.) / Ensat benämningar för arkiverade och fingerade objekt / Lagt till uppgifter om vårdgivare i tjänstekontraktet GetHealthCareUnitMembers. / Justerat referens till ”Råd utlämnande av information från HSA” samt justerat versioner för HSA-policy och HSA-schema. / Lagt till vårdgivarens organisationsnummer i GetHealthCareUnitList / Tagit bort attributet Kommundel som inte längre finns i HSA. / Bytt namn på attributen county (--> countyName) och municipality (-->municipalityName) / Nya domännamn | Henrika Littorin, Inera AB / Ronny Nilsson, Inera AB / Robert Lundmark, Inera AB |  |
| 2.0_RC2 |  | 2017-07-07 | Uppdaterat efter granskningskommentarer: / Flödesschemana ersatta av Sekvensdiagram / Referenser till nya Informations specifikationen, även införda per attribut i anrop och svar – därmed har Excel dokumenten också kunnat tas bort. / Kapitlet om informationssäkerhet ersatt med ref till Informationsspecifikationen / Nytt krav vid bulk-uppdatering infört | Ronny Nilsson Inera AB |  |
| 2.0_RC3 |  | 2017-08-24 | Bytt tillbaka till tidigare domännamn enligt beslut i A&R / Justerat länkar efter ny Inera-webb / Tagit bort referens till AB som beskrivit undantag från kravet att mappa mot nationellt fackspråk då detta är gjort i den senaste informationsspecifikationen | Henrika Littorin, Inera AB |  |
| 2.0.1_RC1 |  | 2017-09-27 | Tillägg av publicName attribut till metoderna
- GetHealthCareUnit
- GetHealthCareUnitIncludingManager
- GetHealthCareUnitList
- GetHealthCareUnitMembers | Robert Lundmark, Cybercom AB |  |
| 2.0.1 |  | 2017-11-30 | Godkänd av Inera A&R |  |  |
| 2.1_RC1 | PA1 | 2018-02-10 | Tillägg av kontrakten 
IsUnitWithinSector och / ListUnitsWithinSector / samt Ändring av GetUnit / m a p avvikande tider (öppettider, telefontider, besökstider och drop-in tider). | Ronny Nilsson, Inera AB |  |
| 2.1_RC1 | PA2 | 2018-02-27 | Justerat versionsnummer för att överensstämma med RivTa | Robert Lundmark, Cybercom AB |  |
| 2.1_RC1 | PA3 | 2018-03-07 | Uppdatering utifrån intern granskning | Ronny Nilsson, Inera AB |  |
| 2.1 |  | 2018-04-10 | Fastställd version | Ronny Nilsson, Inera AB |  |
| 2.2_RC1 | PA1 | 2018-08-07 | Tillägg av attributet financingOrganization till GetUnit | Robert Lundmark, Cybercom AB |  |
| 2.3_RC1 | PA1 | 2019-06-10 | Tillägg attributen indoorRouteDescription. Ersatt geographicalCoordinatesSweref99TM med hsaSweref99Longitude och hsaSweref99Latitude. | Robert Lundmark, Cybercom AB |  |
| 2.3 |  | 2019-07-02 | Release version 2.3 | Robert Lundmark, Cybercom AB |  |
| 2.4_RC1 | PA1 | 2019-11-12 | Tillägg av tjänstekontrakt för GetHealthCareProvider samt en profilparameter för att begränsa svaret i GetUnit, | Ronny Nilsson Inera AB |  |
| 2.4 |  | 2019-12-18 | Release version 2.4 |  |  |
| 3.0_RC1 | PA1 | 2020-04-06 | visitingRuleAge ändrat från envärdes till flervärdesattribut i getUnit | Robert Lundmark, Cybercom AB |  |
| 3.0 |  | 2020-05-11 | Release version 3.0 | Robert Lundmark,
Cybercom AB |  |
| 3.1 | PA1 | 2020-06-18 | Tillägg av attribut alternateTextLogotype | Robert Lundmark, Cybercom AB |  |
| 4.0_RC1 | PA1 | 2021-06-17 | Tillägg av attribut videoPhone för tjänstekontrakt GetUnit. | Robert Lundmark, Cybercom AB |  |
| 4.0_RC2 | PA1 | 2021-07-12 | Uppdatering efter granskning.

Ändringar i GetUnit.

Datatype för profile ändrad från Enum till String

Profile ändrat till multivärdesattribut.

Ny profile tillagd:
- extended2

Tillägg av attribut:
- nonPublicTelephoneNumber
- videoPhone

Borttag av attribut:
- healthCareArea
- priceInformation
- smsTelephoneNumber | Robert Lundmark, Cybercom AB |  |
| 4.0_RC3 |  | 2022-01-12 | Anpassning av nomenklaturen efter Behörighetsmodell för vård och omsorg. / Översyn och korrigering av referenser samt beskrivningar i avsnitten 3, 4 och 5. Justerat sidhuvud och sidfot enligt Ineras nu gällande dokumentmall. / Klar för formell granskning, baserat på godkännande i informell granskning av TKB för relaterad domän (TFF- 821524) samt på godkännande av RC2 (TFF- 799766). | Henrika Littorin, Inera AB |  |
| 4.0 |  | 2022-01-28 | Godkänd granskning (VG-TFF-860526) | Robert Lundmark, Knowit |  |
| 4.0.1 |  | 2022-08-24 | Borttag av tjänstekontrakt GetHealthcareUnitIncludingManager | Robert Lundmark, Knowit |  |
| 4.0.1 |  | 2022-12-23 | Tagit bort Track Changes | Robert Lundmark, Knowit |  |
| 4.1_RC1 |  | 2023-06-26 | Lagt till svarsparameter till GetUnit | Robert Lundmark, Knowit |  |
| 4.1 |  | 2023-08-22 | Godkänd granskning (VG-TFF-1017279) | Robert Lundmark, Knowit |  |
| 4.1.1_RC1 |  | 2024-01-29 | Borttag av tjänstekontrakten IsUnitWithinSector och ListUnitsWithinSector då dessa inte längre används. / Förtydligande av referenser. | Henrika Littorin, Inera / Robert Lundmark, Knowit |  |
| 4.1.1 |  | 2024-02-05 | Godkänd version | Robert Lundmark, Knowit |  |
| 4.1.2 |  | 2024-03-01 | Inga dokumentändringar | Robert Lundmark, Knowit |  |
| 5.0_arbetsversion |  | 2025-05-09 | Uppdatering för HSA-schema 5.2: / Tillägg av attributet ”strukturerad postadress” i GetUnit och GetHealthCareUnitMembers. / Tillägg av attributet ”strukturerad besöksadress” i GetUnit. / Justering av datatyp för attributet ”texttelefon”, från TEL till string, i GetUnit. (I september 2024 stängdes analog texttelefon ned och endast sip-adresser började tillåtas för texttelefon.) / Justerat för namnändring från HSA-policy till HSA Tillitsramverk samt från HPT/HSA-policytillämpning till HSA Tillitsdeklaration. / Tagit bort versionsangivelser för referenser. | Henrika Littorin, Inera / Per Grundström, Inera Test och utveckling |  |
| 5.0_RC1 |  | 2025-06-02 | Justerat efter förhandsgranskning från Informationsarkitektur. / Tillägg av frivilligt attribut i söksvar för GetUnit: schoolType. / Borttag av felaktig textuell beskrivning avseende hantering av enheter som själva är vårdenheter i GetHealthCareUnit (funktionaliteten ändrades 2014). | Henrika Littorin, Inera AB |  |
| 5.0 |  | 2025-10-13 | Godkänd efter kvalitetssäkring | Per Grundström, Inera Test och utveckling |  |
Referenser

| Namn | Dokument | Kommentar | Länk |
| :--- | :--- | :--- | :--- |
| R1 | Arkitekturella beslut – Infrastructure:directory:organization |  | https://rivta.se/tkview/#/domain/infrastructure:directory:organization |
| R2 | RIVTA flera dokument | Finns på Webben | http://rivta.se/ |
| R3 | Inera A&R Råd Utlämnande av information från HSA |  | www.inera.se/hsa/dokument, under länken Stödjande dokument |
| R4 | Tillitsramverk: HSA Tillitsramverk |  | www.inera.se/hsa/dokument, under länken Styrande dokument |
| R5 | Informationsspecifikation för Katalogtjänst HSA |  | www.inera.se/hsa/dokument, under länken Styrande dokument |
Förkortningar

| Förkortning | Betydelse | Kommentar |
| :--- | :--- | :--- |
|  |  |  |

## Inledning
Detta är beskrivningen av tjänstekontrakten i tjänstedomänen
Infrastructure: Directory: Organization
Tjänstekontrakten är baserade på RIVTA 2.1 [R2] och reglerade genom arkitekturella beslut [R1].
Tjänstekontraktsbeskrivningen är en kravspecifikation. Den skall fungera som ett teknikneutralt, formellt regelverk som reglerar integrationskrav för parter (tjänstekonsumenter och tjänsteproducenter) som avser ansluta system för samverkan enligt dessa tjänstekontrakt. Tjänstekontraktsbeskrivningen är också ett viktigt underlag för skapande av de tekniska kontrakten (scheman och WSDL-filer).
Detta dokument kompletterar reglerna i de tekniska kontrakten. Tjänsteproducenter och tjänstekonsumenter ska m.a.o. följa såväl de maskintolkbara reglerna i de tekniska kontrakten, så väl som de regler som uttrycks verbalt i detta dokument.

### Svenskt namn
Infrastruktur Katalogtjänster Organisation
Organisation

## Versionsinformation
Denna revision av tjänstekontraktsbeskrivningen handlar om domänen Infrastructure: Directory: Organization. Observera att version för detta dokument och domänen måste vara lika. Detta för att spårbarheten inte skall brytas.

### Version 5.0

#### Oförändrade tjänstekontrakt
Följande tjänstekontrakt är oförändrade:
GetHealthCareUnit
GetHealthCareUnitList
GetHealthCareProvider

#### Nya tjänstekontrakt
Följande tjänstekontrakt har tillkommit.

#### Förändrade tjänstekontrakt
Följande tjänstekontrakt har förändrats.
GetHealthCareUnitMembers
GetUnit
Nedan redovisas kompatibilitet mellan konsument och producent för tjänstekontrakten som finns i flera versioner. Kompatibilitet avser här såväl format som semantik. För definition av kompatibilitet mellan format, se RIV Tekniska Anvisningar, Översikt.

| Tjänstekontrakt | Konsument | Producent | Kompatibilitet |
| :--- | :--- | :--- | :--- |
| GetUnit | 4.0 | 4.1 | Kompatibel |
|  | 4.1 | 4.0 | Kompatibel |
|  | 4.0, 4.1 | 5.0 | Icke-kompatibel med avseende på användning av attributet texttelefon (textTelephoneNumber), Kompatibel för övriga parametrar. |
|  | 5.0 | 4.0, 4.1 | Icke-kompatibel med avseende på användning av attributet texttelefon (textTelephoneNumber).
 Kompatibel för övriga parametrar. |
| GetHealtCareUnitMembers | 2.0 | 2.1 | Kompatibel |
|  | 2.1 | 2.0 | Kompatibel |

#### Utgångna tjänstekontrakt
Inga tjänstekontrakt har utgått.
-

### Version tidigare
Struktur enligt ovan

## Tjänstedomänens arkitektur
Kataloginformation om organisation och enheter/funktioner kan användas för många olika syften och behovet av information ser då också olika ut. Principen för informationshämtningen är dock densamma och kan beskrivas med samma flöde.
Ett stort och viktigt användningsområde för katalogtjänster inom vård och omsorg är vårdsökningar där en användare på en webbsida söker efter till exempel en sjukgymnastikmottagning i Oxelösund eller information om vart de ska vända sig med akut halsfluss när klockan är sju på en fredag kväll. Sökalgoritmerna skapas i detta fall av tjänstekonsumentens tjänst (webbsidan), men tjänsteproducentens tjänst bidrar med information om vilka vårdmottagningar som finns, vilken typ av verksamhet de bedriver samt öppettider och annan kontaktinformation.
Andra exempel på befintliga användningar är presentation av olika typer av förvalslistor i gränssnitt riktade mot vårdpersonal (t.ex. vilka vårdenheter som ingår i en vårdgivares verksamhet eller vilka mottagningar som tillhör en klinik) eller detaljerad kontaktinformation till en enhet, funktion eller person. Informationen skulle också kunna sägas stödja en behörighetshantering baserad personliga/anställningsrelaterade egenskaper, då tjänstekontrakten också levererar behörighetsgrundande information i form av t.ex. tillhörighet till legitimerad yrkesgrupp och befattning.

### Flöden

#### Hämta information om en vårdenhet
Flödet för en typisk användning är normalt att en tjänstekonsument hämtar information om en vårdenhet via en virtuell tjänst som i sin tur anropar tjänsteproducenten samt returnerar svaret från producenten tillbaka till den anropande konsumenten. Se Sekvensdiagram nedan.

##### Arbetsflöde 1
Se Sekvensdiagram nedan.

##### Sekvensdiagram

![img_001.png](images/img_001.png)

#### Hämta information om en vårdgivares alla vårdenheter
Flödet för en typisk användning är normalt att en tjänstekonsument hämtar information om en vårdgivares alla vårdenheter via en virtuell tjänst som i sin tur anropar tjänsteproducenten samt returnerar svaret från producenten tillbaka till den anropande konsumenten. Se Sekvensdiagram nedan.

##### Arbetsflöde 2
Se Sekvensdiagram nedan.

##### Sekvensdiagram

![img_004.png](images/img_004.png)

#### Hämta information om en vårdenhets ingående enheter
Flödet för en typisk användning är normalt att en tjänstekonsument hämtar information om en vårdenhets ingående enheter via en virtuell tjänst som i sin tur anropar tjänsteproducenten samt returnerar svaret från producenten tillbaka till den anropande konsumenten. Se Sekvensdiagram nedan.

##### Arbetsflöde 3
Se Sekvensdiagram nedan.

##### Sekvensdiagram

![img_003.png](images/img_003.png)

#### Hämta information om en organisatorisk enhet
Flödet för en typisk användning är normalt att en tjänstekonsument hämtar information om en organisatorisk enhet via en virtuell tjänst som i sin tur anropar tjänsteproducenten samt returnerar svaret från producenten tillbaka till den anropande konsumenten. Se Sekvensdiagram nedan.

##### Arbetsflöde 4
Se Sekvensdiagram nedan.

##### Sekvensdiagram

![img_002.png](images/img_002.png)

#### Hämta information om en vårdgivare
Flödet för en typisk användning är normalt att en tjänstekonsument hämtar information om en vårdgivare via en virtuell tjänst som i sin tur anropar tjänsteproducenten samt returnerar svaret från producenten tillbaka till den anropande konsumenten. Se Sekvensdiagram nedan.

##### Arbetsflöde 5
Se Sekvensdiagram nedan.

##### Sekvensdiagram

![img_005.png](images/img_005.png)

#### Obligatoriska kontrakt
Följande tabell specificerar vilka kontrakt som är obligatoriska att realisera för respektive flöde.

| Tjänstekontrakt | Flöde 1 | Flöde 2 | Flöde 3 | Flöde 4 | Flöde 5 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| GetHealthCareUnit (se avsnitt 6.1) | X |  |  |  |  |
| GetHealthCareUnitList (se avsnitt 6.2) |  | X |  |  |  |
| GetHealthCareUnitMembers (se avsnitt 6.3) |  |  | X |  |  |
| GetUnit (se avsnitt 6.4) |  |  |  | X |  |
| GetHealthCareProvider (se avsnitt 6.8) |  |  |  |  | X |

### Adressering
Tjänstedomänen tillämpar verksamhetsbaserad adressering. Som logisk adress används Inera AB:s HSA-id för Katalogtjänst HSA.

### Aggregering och engagemangsindex
För närvarande är aggregering eller engagemangsindex ej aktuellt, då endast en tjänsteproducent är ansluten till tjänstedomänen.
I samband med att fler tjänsteproducenter ansluter till tjänstedomänen behöver sökningen från anropande tjänstekonsument realiseras mot flera tjänsteproducenter. Vilken alternativ lösning som ska tillämpas när denna situation uppstår är ännu inte beslutat, se AB-2.3 [R1].

## Tjänstedomänens krav och regler
Följande krav skall beaktas då ett system agerar som en tjänstekonsument för tjänstedomänens ingående tjänster.
Autentisering av tjänstekonsument ska alltid ske med SITHS Funktionscertifikat.
Tjänstekonsumenten ansvarar för att ha en kontinuitetsplan för det fall att tjänsteproducentens tjänst inte skulle vara tillgänglig.
Tjänstekonsumenten skall redovisa sin belastning på tjänstedomänen (antalet anrop) till såväl tjänstedomänansvarig som till ansvarig för den/de tjänsteproducenter som tjänstekonsumenten anropar. Eventuella väsentliga ändringar av belastning ska kommuniceras i god tid före effektuering så att tillgänglighet och prestanda kan upprätthållas över tid.
Tjänstekonsumenten skall följa vid var tid gällande villkor för den/de tjänsteproducenter från vilka tjänstekonsumenten hämtar information. Ett exempel på sådana villkor är HSA Tillitsramverk [R4], där informationsägarna bland annat ställer krav på
att all användning av informationen erhållen från tjänsteproducenten ska beskrivas i godkänd HSA Tillitsdeklaration Konsument (alternativt i godkänd HSA Tillitsdeklaration Producent om det handlar om en lokal tjänst).
att tillämpliga lagar och regelverk, t.ex. Dataskyddsförordningen, GDPR, efterlevs
att information som lagras i egen applikation ska skyddas på tillfredställande sätt
att information som lagras i egen applikation ska hållas uppdaterad mot ursprungskällan
att intern revision genomförs årligen för kontroll av efterlevnad till HSA Tillitsramverk
Anslutna tjänsteproducenter kan ha egna processer för godkännande av tjänstekonsumenter som anropar tjänsteproducentens katalogtjänst.
OBS Vid anrop i syfte att uppdatera en lokal DB med aktuella uppgifter från producenten, så ska konsumenten bara använda 1 tråd, dvs göra ett anrop och sedan vänta på och ta emot svaret innan nästa anrop görs, och med en 50 mS paus mellan anropen. Detta för att kunna garantera svarstider för övriga användare.

### Informationssäkerhet och juridik
Se Informationsspecifikationen [R5].

### Icke funktionella krav

#### SLA krav
Följande generella SLA-krav gäller för alla tjänsteproducenter som tillhandahåller tjänstekontrakt inom domänen. Observera att för en konsument kan tillgängligheten bli något lägre utifrån t.ex. mellanliggande kommunikationsutrustning, kommunikationsnät och användning av regional tjänsteplattform.

| Kategori | Värde | Beskrivning |
| :--- | :--- | :--- |
| Svarstid |  | Definieras per tjänstekontrakt i avsnitt 6. |
| Tillgänglighet | 24x7, 99,9% |  |
| Last |  | Definieras per tjänstekontrakt i avsnitt 6. |
| Aktualitet | 10 minuter | Vid uppdatering av information i katalogtjänsten får det maximalt ta så lång tid innan den informationen används av och returneras via tjänstekontrakten. |
| Återställningstid | 1 dygn | Vid katastrof som bortfall av driftshall |

### Felhantering
Vid ett tekniskt fel levereras normalt ett generellt undantag (SOAP-fault).
Exempel på tekniska fel vid anrop till någon av tjänstedomänens tjänstekontrakt där SOAP-fault returneras är:
Katalogen (eller ev. läskopia) är inte nåbar (ur funktion, överlastad, kommunikationsmässigt eller på annat sätt onåbar)
Katalogen returnerar att det blev ett internt fel vid sökningen
Grundläggande information i katalogen, t ex kodtabeller, innehåller felaktig information eller felaktigt strukturerad information.
Exempel på andra tekniska fel är:
Anslutande tjänst är inte behörig att anropa det aktuella tjänstekontraktet. För denna typ av fel returneras ”http Status 403 – Access is denied”.
Tjänstekontraktsprogramvaran har slutat fungera. För denna typ av fel returneras ”http Status 503 – Service Temporarily Unavailable”.
För fatala tekniska fel t ex server-fel, fel på kommunikationsutrustning, fel i webb-tjänst-systemprogramvaran, kan svar helt utebli, därför måste konsumenten ha hantering för uteblivet svar (time-out) för sådant fall.
Vid tekniska fel förmedlas inga kataloguppgifter till konsumenten.

#### Krav på en tjänsteproducent
Följande krav skall beaktas då ett system agerar som en tjänsteproducent för tjänstedomänens ingående tjänster.
Tjänsteproducenten ansvarar för
att tillhandahålla tjänsten i enlighet med denna tjänstekontraktsbeskrivning med avseende på
tjänstedomänens arkitektur (se avsnitt 3)
informationssäkerhet och juridik (se [R5])
felhantering (både tekniska och logiska fel som beskrivs i detta kapitel)
SLA:er (se avsnitt 4.2.1)
informationsinnehåll (specificeras för resp. tjänstekontrakt under avsnitt 6)
tjänstedomänens meddelandemodeller (se avsnitt 5)
att vid behov förmedla kontakt mellan tjänstekonsument och informationsägare, t.ex. i frågor som rör förändring av innehåll
att (vid behov genom kravställning på anslutna organisationer/informationsägare) tillse att
den information som tillhandahålls vid var tid är uppdaterad och korrekt
den information som tillhandahålls vid var tid i möjligaste mån är säkrad mot ursprungskällor
minst omfattar detta: kontroll av namnuppgifter mot Skatteverket samt kontroll av legitimerad yrkesgrupp mot Socialstyrelsens register minst en gång per månad
tillämpliga lagar och regelverk, t.ex. Dataskyddsförordningen, efterlevs
det finns ett dokumenterat regelverk för hur administratörsbehörigheter tilldelas och tas bort
uppgifter om koppling mellan HSA-id och individ arkiveras i enlighet med organisationens gallringsbeslut efter det att anställning upphört
uppgifter om koppling mellan HSA-id och organisation samt mellan HSA-id och vårdgivare/vårdenhet arkiveras efter det att verksamheten upphört
HSA-id behålls då en person byter person-identitet (t.ex. från samordningsnummer till personnummer)
att upprätthålla en organisation för administration samt för mottagande av driftstörningsinformation
att förändringar som görs i tjänsten loggas så att det går att spåra vem som gjort en förändring och när
att särskild hantering av personer med skyddade personuppgifter finns dokumenterad och tillämpas
att årligen genomföra intern revision för att säkerställa att tjänsteproducenten verkligen uppfyller samtliga krav beskrivna i denna tjänstekontraktsbeskrivning

##### Logiska fel
Logiskt fel, d.v.s. förutsättning för att kunna besvara anropet saknas, t ex för att visst nödvändigt objekt eller attributvärde saknas ska hanteras enligt:
Då obligatoriska attribut (som skulle returnerats) saknas. Objekt som saknar obligatoriska attribut (eller där de obligatoriska attributen inte följer specificerad syntax) returneras ej.
Attribut med värde som inte följer gällande värdemängd
Värdemängdsattribut med både kod-del och klartext-del men där dessa inte matchar varandra enligt gällande värdemängd
Attribut med felaktig syntax, t ex
Sammansatta attribut saknad någon del (t ex öppettider)

#### Krav på en tjänstekonsument
Konsumenten behöver hantera de tekniska fel som kan uppstå, t ex uteblivet svar, se ovan.
Dessutom rekommenderas konsumenten ha egna kontroller av den information som returneras[.

## Tjänstedomänens meddelandemodeller

### V-MIM
För tjänstedomänen utnyttjas befintliga strukturer inom HSA för förvaltning och vidareutveckling av informations- och meddelandemodeller, se även AB-2.4 [R2]. Två gånger per år införs genomarbetade och beslutade ändringar i informationsmodellen enligt särskild process.
Nuvarande informationsmodell som också inkluderar mappning mot Nationell Informationsstruktur 2017:1 beskrivs i Informationsspecifikation för Katalogtjänst HSA [R5].

### Formatregler

#### RIV-specifikation
Formatregler för tjänstedomänen specificeras i Informationsspecifikation för Katalogtjänst HSA [R5], se även AB-2.6 [R1]. Ytterligare detaljer finns i även schemabeskrivningen för respektive tjänstekontrakt, se avsnitt 6.

## Tjänstekontrakt

### GetHealthCareUnit
Söker ut vilken vårdenhet den angivna enheten eller funktionen är kopplad till. Kan användas av tjänstekonsumenten för att koppla ihop en enhet eller funktion i ett vårdsystem med vårdenhet i enlighet med PDL. Notera särskilt att alla enheter inte är kopplade till en vårdenhet. Om enheten i sig själv är utpekad som vårdenhet markeras detta med en flagga i svaret.

#### Version
Version på detta kontrakt är 2.0.

#### Fältregler
Nedanstående tabell beskriver varje element i begäran och svar. Har namnet en * finns ytterligare regler för detta element och beskrivs mer i detalj i stycket Regler. Attributen som levereras beskrivs mer ingående i Informationsspecifikationen [R5], med avseende på till exempel fältlängder och krav på innehållet.

| Namn | Typ | Beskrivning, Ref Informationsspec. | Kardinalitet |
| :--- | :--- | :--- | :--- |
| Begäran |  |  |  |
| healthCareUnitMemberHsaId | String | HSA-id för en enhet eller funktion som är kopplad till en vårdenhet enligt PDL. 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| searchBase *1) | DN | Sökbas. Om ingen sökbas anges används c=SE som sökbas. | 0..1 |
| includeFeignedObject | boolean | true: om metoden ska leverera svar med fingerade objekt. Uteblivet värde tolkas som false, dvs inga fingerade objekt levereras. | 0..1 |
| Svar |  |  |  |
| healthCareUnit | HealthCareUnitType |  | 0..1 |
| ..healthCareUnitMemberHsaId | String | Enhetens (funktionens) HSA-id 
Ref. HSA-id (hsaIdentity) [R5] | 0..1 |
| ..healthCareUnitMemberName | String | Enhetens (funktionens) namn
Ref. organisationsnamn (o), enhetsnamn (ou) resp. objektnamn (cn) [R5] | 0..1 |
| ..healthCareUnitMemberPublicName | String | Publikt officiellt namn.
Det publika namnet beräknas i första hand utifrån enhetens DN tillsammans med värdet i attributet displayOption.
Om displayOption saknas beräknas det publika namnet enligt:
enhetens namn <blanktecken> location / Ref. alternativ namnvisning (displayOption), organisationsnamn (o), enhetsnamn (ou), objektnamn (cn), resp geografisk plats (l, localityName) [R5] | 0..1 |
| ..healthCareUnitMemberStartDate | dateTime | Startdatum för enhetens (funktionens) verksamhet
Ref. startdatum (startDate) [R5] | 0..1 |
| ..healthCareUnitMemberEndDate | dateTime | Slutdatum för enhetens (funktionens) verksamhet
Ref. slutdatum (endDate) [R5] | 0..1 |
| ..healthCareUnitHsaId | String | Vårdenhetens HSA-id 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| ..unitIsHealthCareUnit | Boolean | True, om enheten (funktionen) själv är en vårdenhet
Om enheten (funktionen) inte är vårdenhet kommer inget värde att returneras. 
Ref. hjälpklassen Vårdenhet (hsaHealthCareUnit) [R5] | 0..1 |
| ..healthCareUnitName | String | Vårdenhetens namn
Ref. organisationsnamn (o) resp.  enhetsnamn (ou) [R5] | 1..1 |
| ..healthCareUnitPublicName | String | Publikt officiellt namn.
Det publika namnet beräknas i första hand utifrån enhetens DN tillsammans med värdet i attributet displayOption.
Om displayOption saknas beräknas det publika namnet enligt:
enhetens namn <blanktecken> location / Ref. alternativ namnvisning (displayOption), organisationsnamn (o), enhetsnamn (ou), objektnamn (cn), resp geografisk plats (l, localityName) [R5] | 1..1 |
| ..healthCareUnitStartDate | dateTime | Startdatum för vårdenhetens verksamhet. / Ref. startdatum (startDate) [R5] | 0..1 |
| ..healthCareUnitEndDate | dateTime | Slutdatum för vårdenhetens verksamhet.
Ref. slutdatum (endDate) [R5] | 0..1 |
| ..healthCareProviderHsaId | String | Vårdgivarens HSA-id 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| ..healthCareProviderName | String | Vårdgivarens namn 
Ref. organisationsnamn (o) resp.  enhetsnamn (ou) [R5] | 1..1 |
| ..healthCareProviderPublicName | String | Publikt officiellt namn.
Det publika namnet beräknas i första hand utifrån enhetens DN tillsammans med värdet i attributet displayOption.
Om displayOption saknas beräknas det publika namnet enligt:
enhetens namn <blanktecken> location / Ref. alternativ namnvisning (displayOption), organisationsnamn (o), enhetsnamn (ou), objektnamn (cn), resp geografisk plats (l, localityName) [R5] | 1..1 |
| ..healthCareProviderOrgNo | String | Vårdgivarens organisationsnummer
Ref. organisationsnummer (orgNo) [R5] | 1..1 |
| ..healthCareProviderStartDate | dateTime | Startdatum för vårdgivarens verksamhet. / Ref. startdatum (startDate) [R5] | 0..1 |
| ..healthCareProviderEndDate | dateTime | Slutdatum för vårdgivarens verksamhet.
Ref. slutdatum (endDate) [R5] | 0..1 |
| ..feignedHealthCareUnitMember | Boolean | true: om enheten är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| ..feignedHealthCareUnit | Boolean | true: om vårdenheten är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| ..feignedHealthCareProvider | Boolean | true: om vårdgivaren är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| ..archivedHealthCareUnitMember | Boolean | true: om enheten är ett arkiverat objekt
Ref. hjälpklassen arkiverat objekt (hsaArchivedObject) [R5] | 0..1 |
| ..archivedHealthCareUnit | Boolean | true: om vårdenheten är ett arkiverat objekt 
Ref. hjälpklassen arkiverat objekt (hsaArchivedObject) [R5] | 0..1 |
| ..archivedHealthCareProvider | Boolean | true: om vårdgivaren är ett arkiverat objekt 
Ref. hjälpklassen arkiverat objekt (hsaArchivedObject) [R5] | 0..1 |

#### Tjänstekontraktsspecifika krav och regler
Till denna informationsmängd finns regler som ej uttrycks i schemafilerna och tabellen ovan. Dessa återfinns nedan.
*1) searchBase
För GetHealthCareUnit används följande sökningar/sökbaser:
- Sök efter kopplad enhet: i anropet angiven sökbas
- Sök efter vårdenhet: i anropet angiven sökbas
- Sök efter vårdgivare: i anropet angiven sökbas

##### Icke funktionella krav

###### SLA-krav
Krav på svarstider anges under förutsättning att TLS-uppkoppling är etablerad, d.v.s. TLS-förhandlingstid tillkommer vid start av ny TLS-session. Angivna krav på svarstid utgår ifrån mätning från Tjänsteplattformen mot Katalogtjänsten, och exklusive den tid som tjänsteplattformen behöver för att förmedla fråga och svar.
Svarstid ska kunna garanteras upp till angiven last.

| Metod | Svarstider måste garanteras upp till följande last | Svarstid för 95 % av alla anrop ligger inom |
| :--- | :--- | :--- |
| GetHealthCareUnit | 10 anrop/s | 100 ms |

###### Logiska fel
Logiska fel hanteras enligt:
Om angiven sökbas inte finns i katalogen, returneras ett tomt svar.
Om sökt enhet inte kan hittas i katalogen, så returneras tomt svar.
Om sökt enhet inte är en vårdenhet eller kopplad till en vårdenhet, så returneras tomt svar.
Om enheten, vårdenheten eller vårdgivaren saknar obligatorisk uppgift så returneras tomt svar. Dvs om Namn, HSA-id, Organisationsnummer hos vårdgivaren eller korrekt utpekning av vårdgivare hos vårdenheten saknas så levereras tomt svar.
för kontroll av att returnerade attributvärden följer specificerad syntax, så rekommenderas använda den Schematron vi tillhandahåller.

#### Annan information om kontraktet
Information returneras endast om angiven enhet är kopplad till en vårdenhet, eller om enheten i sig själv är en vårdenhet.

### GetHealthCareUnitList
Söker fram och listar en angiven vårdgivares alla vårdenheter, definierade enligt PDL. Kan användas av tjänstekonsumenten för att t.ex. skapa en förvalslista i ett användargränssnitt.

#### Version
Version på detta kontrakt är 2.0.

#### Fältregler
Nedanstående tabell beskriver varje element i begäran och svar. Har namnet en * finns ytterligare regler för detta element och beskrivs mer i detalj i stycket Regler. Attributen som levereras beskrivs mer ingående i Informationsspecifikationen [R5], med avseende på t.ex. fältlängder och krav på innehållet.

| Namn | Typ | Typ | Beskrivning, Ref Informationsspec. | Kardinalitet |
| :--- | :--- | :--- | :--- | :--- |
| Begäran |  |  |  |  |
| healthCareProviderHsaId | String | String | Vårdgivarens HSA-id. / Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| searchBase *1) | DN | DN | Sökbas. Om ingen sökbas anges används c=SE som sökbas.

searchBase används både för sökning av den kopplade enheten, vårdenheten och vårdgivaren. | 0..1 |
| includeFeignedObject | boolean | boolean | true: om metoden ska leverera svar med fingerade objekt. Uteblivet värde tolkas som false, dvs inga fingerade objekt levereras. | 0..1 |
| Svar |  |  |  |  |
| healthCareUnitList | HealthCareUnitListType | HealthCareUnitListType |  | 0..1 |
| ..healthCareProviderHsaId | String | String | Vårdgivarens HSA-id 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| ..healthCareProviderName | String | String | Vårdgivarens namn 
Ref. organisationsnamn (o) resp.  enhetsnamn (ou) [R5] | 1..1 |
| ..healthCareProviderPublicName | ..healthCareProviderPublicName | String | Publikt officiellt namn.
Det publika namnet beräknas i första hand utifrån enhetens DN tillsammans med värdet i attributet displayOption.
Om displayOption saknas beräknas det publika namnet enligt:
enhetens namn <blanktecken> location / Ref. alternativ namnvisning (displayOption), organisationsnamn (o), enhetsnamn (ou), objektnamn (cn), resp geografisk plats (l, localityName) [R5] | 1..1 |
| ..healthCareProviderOrgNo | String | String | Vårdgivarens organisationsnummer 
Ref. organisationsnummer (orgNo) [R5] | 1..1 |
| ..healthCareProviderStartDate | dateTime | dateTime | Startdatum för vårdgivarens verksamhet. 
Ref. startdatum (startDate) [R5] | 0..1 |
| ..healthCareProviderEndDate | dateTime | dateTime | Slutdatum för vårdgivarens verksamhet. 
Ref. slutdatum (endDate) [R5] | 0..1 |
| ..feignedHealthCareProvider | Boolean | Boolean | true: om vårdgivaren är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| ..archivedHealthCareProvider | Boolean | Boolean | true: om vårdgivaren är ett arkiverat objekt 
Ref. hjälpklassen arkiverat objekt (hsaArchivedObject) [R5] | 0..1 |
| ..healthCareUnit | HealthCareUnitType | HealthCareUnitType | Ingående vårdenhet enligt PDL | 0..* |
| .. ..healthCareUnitHsaId | String | String | HSA-identitet ingående enhet 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| .. ..healthCareUnitName | String | String | Namn ingående enhet 
Ref. organisationsnamn (o) resp.  enhetsnamn (ou) [R5] | 1..1 |
| .. ..healthCareUnitPublicName | String | String | Publikt officiellt namn.
Det publika namnet beräknas i första hand utifrån enhetens DN tillsammans med värdet i attributet displayOption.
Om displayOption saknas beräknas det publika namnet enligt:
enhetens namn <blanktecken> location / Ref. alternativ namnvisning (displayOption), organisationsnamn (o), enhetsnamn (ou), objektnamn (cn), resp geografisk plats (l, localityName) [R5] | 1..1 |
| .. ..healthCareUnitStartDate | dateTime | dateTime | Startdatum för vårdenhetens verksamhet. 
Ref. startdatum (startDate) [R5] | 0..1 |
| .. ..healthCareUnitEndDate | dateTime | dateTime | Slutdatum för vårdenhetens verksamhet. 
Ref. slutdatum (endDate) [R5] | 0..1 |
| .. ..feignedHealthCareUnit | Boolean | Boolean | true: om vårdenheten är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| .. ..archivedHealthCareUnit | Boolean | Boolean | true: om vårdenheten är ett arkiverat objekt 
Ref. hjälpklassen arkiverat objekt (hsaArchivedObject) [R5] | 0..1 |

#### Tjänstekontraktsspecifika krav och regler
Till denna informationsmängd finns regler som ej uttrycks i schemafilerna och tabellen ovan. Dessa återfinns nedan.
*1) searchBase
För GetHealthCareUnitList används följande sökningar/sökbaser:
- Sök efter vårdgivaren: i anropet angiven sökbas
- Sök efter vårdenheter: i anropet angiven sökbas

##### Icke funktionella krav

###### SLA-krav
Krav på svarstider anges under förutsättning att TLS-uppkoppling är etablerad, d.v.s. TLS-förhandlingstid tillkommer vid start av ny TLS-session. Angivna krav på svarstid utgår ifrån mätning från Tjänsteplattformen mot Katalogtjänsten, och exklusive den tid som tjänsteplattformen behöver för att förmedla fråga och svar.
Svarstid ska kunna garanteras upp till angiven last.

| Metod | Svarstider måste garanteras upp till följande last | Svarstid för 95 % av alla anrop ligger inom |
| :--- | :--- | :--- |
| GetHealthCareUnitList | 1 anrop/s | 2000 ms |

###### Logiska fel
Logiska fel hanteras enligt:
Om angiven sökbas inte finns i katalogen, returneras ett tomt svar.
Om sökt vårdgivare inte kan hittas i katalogen, så returneras tomt svar.
Om sökt enhet inte är en vårdgivare, eller om vårdgivaren saknar någon obligatorisk uppgift (namn, HSA-id eller organisationsnummer), så returneras tomt svar.
Om en vårdgivare saknar någon obligatorisk uppgift (namn eller HSA-id) så returneras ingen information om den vårdenheten.
för kontroll av att returnerade attributvärden följer specificerad syntax, så rekommenderas använda den Schematron vi tillhandahåller.

#### Annan information om kontraktet
-

### GetHealthCareUnitMembers
Metoden söker fram alla kopplade enheter för den angivna vårdenheten. Kan användas av tjänstekonsumenten för att se vilka mottagningar och avdelningar som ingår i en klinik eller för att i ett användargränssnitt skapa en förvalslista med samtliga arbetsplatskoder kopplade till vårdenheten. Notera särskilt att alla enheter inte är kopplade till en vårdenhet och att samtliga arbetsplatskoder inte finns registrerade.

#### Version
Version på detta kontrakt är 2.1.

#### Fältregler
Nedanstående tabell beskriver varje element i begäran och svar. Har namnet en * finns ytterligare regler för detta element och beskrivs mer i detalj i stycket Regler. Attributen som levereras beskrivs mer ingående i Informationsspecifikationen [R5], med avseende på t.ex. fältlängder och krav på innehållet.

| Namn | Typ | Beskrivning, Ref Informationsspec. | Kardinalitet |
| :--- | :--- | :--- | :--- |
| Begäran |  |  |  |
| healthCareUnitHsaId | String | HSA-id för vårdenhet enligt PDL. 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| searchBase *1) | DN | Sökbas. Om ingen sökbas anges används c=SE som sökbas. | 0..1 |
| includeFeignedObject | boolean | true: om metoden ska leverera svar med fingerade objekt. Uteblivet värde tolkas som false, dvs inga fingerade objekt levereras. | 0..1 |
| Svar |  |  |  |
| healthCareUnitMembers | HealthCareUnitMembersType | Information om vårdenheten och dess kopplade enheter | 0..1 |
| ..healthCareUnitName | String | Vårdenhetens namn. 
Ref. organisationsnamn (o) resp.  enhetsnamn (ou) [R5] | 1..1 |
| ..healthCareUnitPublicName | String | Publikt officiellt namn.
Det publika namnet beräknas i första hand utifrån enhetens DN tillsammans med värdet i attributet displayOption.
Om displayOption saknas beräknas det publika namnet enligt:
enhetens namn <blanktecken> location / Ref. alternativ namnvisning (displayOption), organisationsnamn (o), enhetsnamn (ou), objektnamn (cn), resp geografisk plats (l, localityName) [R5] | 1..1 |
| ..healthCareUnitHsaId | String | Vårdenhetens HSA-id 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| ..healthCareUnitStartDate | dateTime | Startdatum för vårdenhetens verksamhet. 
Ref. startdatum (startDate) [R5] | 0..1 |
| ..healthCareUnitEndDate | dateTime | Slutdatum för vårdenhetens verksamhet. 
Ref. slutdatum (endDate) [R5] | 0..1 |
| ..healthCareUnitPrescriptionCode | String | Vårdenhetens arbetsplatskod(-er) 
Ref. arbetsplatskod (unitPrescriptionCode) [R5] | 0..* |
| ..telephoneNumber | String | Vårdenhetens publika direkttelefonnummer. 
Ref. direkttelefon (telephoneNumber) [R5] | 0..* |
| ..postalAddress | AddressType | Vårdenhetens postadress i ostrukturerat format. / Kommer på sikt att ersättas av structuredPostalAddress. / Ref. postadress (postalAddress) [R5] | 0..1 |
| .. ..addressLine | String | Adressrader | 1..* |
| ..structuredPostalAddress | structuredPostalAddressType | Vårdenhetens postadress i strukturerat format. / Kommer på sikt att ersätta postalAddress. / Ref. Strukturerad postadress (hsaPostalAddress) [R5] | 0..1 |
| .. .. addressee | String | Adressat | 1..* |
| .. .. street | String | Gata | 0..1 |
| .. .. premisesNumber | String | Adressplatsnummer | 0..1 |
| .. .. premisesLetter | String | Adressplatslittera | 0..1 |
| .. ..postCode | String | Postnummer | 1..1 |
| .. ..town | String | Postort | 1..1 |
| ..postalCode | String | Vårdenheten postnummer där verksamheten bedrivs / Ref. postnummer (postalCode) [R5] | 0..1 |
| ..feignedhealthCareUnit | Boolean | true: om vårdenheten är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| ..archivedHealthCareUnit | Boolean | true: om vårdenheten är ett arkiverat objekt 
Ref. hjälpklassen arkiverat objekt (hsaArchivedObject) [R5] | 0..1 |
| ..healthCareProvider | HealthCareProviderType | Den vårdgivare som vårdenheten tillhör | 1..1 |
| .. ..healthCareProviderName | String | Vårdgivarens namn. 
Ref. organisationsnamn (o) resp.  enhetsnamn (ou) [R5] | 1..1 |
| .. ..healthCareProviderPublicName | String | Publikt officiellt namn.
Det publika namnet beräknas i första hand utifrån enhetens DN tillsammans med värdet i attributet displayOption.
Om displayOption saknas beräknas det publika namnet enligt:
enhetens namn <blanktecken> location / Ref. alternativ namnvisning (displayOption), organisationsnamn (o), enhetsnamn (ou), objektnamn (cn), resp geografisk plats (l, localityName) [R5] | 1..1 |
| .. ..healthCareProviderHsaId | String | Vårdgivarens HSA-id 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| .. ..healthCareProviderOrgNo | String | Vårdgivarens organisationsnummer | 1..1 |
| .. ..healthCareProviderStartDate | dateTime | Startdatum för Vårdgivarens verksamhet. 
Ref. startdatum (startDate) [R5] | 0..1 |
| .. ..healthCareProviderEndDate | dateTime | Slutdatum för Vårdgivarens verksamhet. 
Ref. slutdatum (endDate) [R5] | 0..1 |
| .. ..healthCareProviderPrescriptionCode | String | Vårdgivarens arbetsplatskod(-er) 
Ref. arbetsplatskod (unitPrescriptionCode) [R5] | 0..* |
| .. ..telephoneNumber | String | Vårdgivarens publika direkttelefonnummer. 
Ref. direkttelefon (telephoneNumber) [R5] | 0..* |
| .. ..postalAddress | AddressType | Vårdgivarens postadress i ostrukturerat format. / Kommer på sikt att ersättas av structuredPostalAddress. / Ref. postadress (postalAddress) [R5] | 0..1 |
| .. .. ..addressLine | String | Adressrader | 1..* |
| ..structuredPostalAddress | structuredPostalAddressType | Vårdgivarens postadress i strukturerat format. / Kommer på sikt att ersätta postalAddress. / Ref. Strukturerad postadress (hsaPostalAddress) [R5] | 0..1 |
| .. .. addressee | String | Adressat | 1..* |
| .. .. street | String | Gata | 0..1 |
| .. .. premisesNumber | String | Adressplatsnummer | 0..1 |
| .. .. premisesLetter | String | Adressplatslittera | 0..1 |
| .. ..postCode | String | Postnummer | 1..1 |
| .. ..town | String | Postort | 1..1 |
| .. ..postalCode | String | Vårdgivarens postnummer där verksamheten bedrivs / Ref. postnummer (postalCode) [R5] | 0..1 |
| .. ..feignedHealthCareProvider | Boolean | true: om Vårdgivaren är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| .. ..archivedHealthCareProvider | Boolean | true: om Vårdgivaren är ett arkiverat objekt 
Ref. hjälpklassen arkiverat objekt (hsaArchivedObject) [R5] | 0..1 |
| ..healthCareUnitMember | HealthCareUnitMemberType | Information om en kopplad enhet | 0..* |
| .. .. healthCareUnitMemberName | String | Den kopplade enhetens namn 
Ref. organisationsnamn (o), enhetsnamn (ou) resp. objektnamn (cn) [R5] | 1..1 |
| .. ..healthCareUnitMemberPublicName | String | Publikt officiellt namn.
Det publika namnet beräknas i första hand utifrån enhetens DN tillsammans med värdet i attributet displayOption.
Om displayOption saknas beräknas det publika namnet enligt:
enhetens namn <blanktecken> location / Ref. alternativ namnvisning (displayOption), organisationsnamn (o), enhetsnamn (ou), objektnamn (cn), resp geografisk plats (l, localityName) [R5] | 1..1 |
| .. .. healthCareUnitMemberHsaId | String | Den kopplade enhetens HSA-id 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| .. ..healthCareUnitMember StartDate | dateTime | Startdatum för kopplade enhetens verksamhet. 
Ref. startdatum (startDate) [R5] | 0..1 |
| .. ..healthCareUnitMember EndDate | dateTime | Slutdatum för kopplade enhetens verksamhet. 
Ref. slutdatum (endDate) [R5] | 0..1 |
| .. .. healthCareUnitMember PrescriptionCode | String | Den kopplade enhetens arbetsplatskod(-er) 
Ref. arbetsplatskod (unitPrescriptionCode) [R5] | 0..* |
| .. ..healthCareUnitMember TelephoneNumber | String | Den kopplade enhetens publika direkttelefonnummer 
Ref. direkttelefon (telephoneNumber) [R5] | 0..* |
| .. .. healthCareUnitMember postalAddress | AddressType | Den kopplade enhetens postadress i ostrukturerat format. / Kommer på sikt att ersättas av structuredPostalAddress. / Ref. postadress (postalAddress) [R5] | 0..1 |
| .. .. ..addressLine | String | Adressrader | 1..* |
| .. .. healthCareUnitMember structuredPostalAddress | structuredPostalAddressType | Den kopplade enhetens postadress i strukturerat format. / Kommer på sikt att ersätta postalAddress. / Ref. Strukturerad postadress (hsaPostalAddress) [R5] | 0..1 |
| .. .. .. addressee | String | Adressat | 1..* |
| .. .. ..street | String | Gata | 0..1 |
| .. .. ..premisesNumber | String | Adressplatsnummer | 0..1 |
| .. .. ..premisesLetter | String | Adressplatslittera | 0..1 |
| .. .. ..postCode | String | Postnummer | 1..1 |
| .. .. ..town | String | Postort | 1..1 |
| .. .. healthCareUnitMember postalCode | String | Den kopplade enhetens postnummer för där verksamheten bedrivs. / Ref. postnummer (postalCode) [R5] | 0..1 |
| .. ..feignedHealthCareUnitMember | Boolean | true: om enheten är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| .. ..archivedHealthCareUnitMember | Boolean | true: om enheten är ett arkiverat objekt 
Ref. hjälpklassen arkiverat objekt (hsaArchivedObject) [R5] | 0..1 |

#### Tjänstekontraktsspecifika krav och regler
Till denna informationsmängd finns regler som ej uttrycks i schemafilerna och tabellen ovan. Dessa återfinns nedan.
*1) searchBase
För GetHealthCareUnitMembers används följande sökningar/sökbaser:
- Sök efter vårdenheten: i anropet angiven sökbas
- Sök efter kopplade enheter: här används sökbasen c=se

##### Icke funktionella krav

###### SLA-krav
Krav på svarstider anges under förutsättning att TLS-uppkoppling är etablerad, d.v.s. TLS-förhandlingstid tillkommer vid start av ny TLS-session. Angivna krav på svarstid utgår ifrån mätning från Tjänsteplattformen mot Katalogtjänsten, och exklusive den tid som tjänsteplattformen behöver för att förmedla fråga och svar.
Svarstid ska kunna garanteras upp till angiven last.

| Vårdenhet med kopplade enheter eller inte | Svarstider måste garanteras upp till följande last | Svarstid för 95 % av alla anrop ligger inom |
| :--- | :--- | :--- |
| Svarstid för vårdenhet utan kopplade enheter | 10 anrop/s | 100 ms |
| Svarstid för vårdenhet med kopplade enheter | 1 anrop/s | 1000 ms |

###### Logiska fel
Logiska fel hanteras enligt:
Om sökt vårdenhet inte kan hittas i katalogen, så returneras tomt svar
Om sökt enhet inte är en vårdenhet, eller saknar någon obligatorisk uppgift (namn, HSA-id eller korrekt utpekning av vårdgivartillhörighet), så returneras tomt svar
Om vårdgivaren saknar obligatorisk uppgift (Namn, HSA-id, Organisationsnummer) så returneras tomt svar.
Om en kopplad enhet saknar någon obligatorisk uppgift (namn eller HSA-id) så returneras ingen information om den enheten.
för kontroll av att returnerade attributvärden följer specificerad syntax, så rekommenderas använda den Schematron vi tillhandahåller.

#### Annan information om kontraktet
-

### GetUnit
GetUnit returnerar information om den angivna enheten (med enhet avses här alla typer av organisatoriska objekt, d.v.s. både organisation, enhet och funktion). Kan användas av tjänstekonsumenten för att presentera detaljerad information om en enhet i t.ex. en vårdsökning eller en kontaktlista. Notera särskilt att alla attribut inte är obligatoriska och att ytterst få enheter innehåller samtlig information enligt specifikationen nedan.

#### Version
Version på detta kontrakt är 5.0

#### Fältregler
Nedanstående tabell beskriver varje element i begäran och svar. Har namnet en * finns ytterligare regler för detta element och beskrivs mer i detalj i stycket Regler. Attributen som levereras beskrivs mer ingående i Informationsspecifikationen [R5], med avseende på t.ex. fältlängder och krav på innehållet.

| Namn | Typ | Beskrivning, Ref Informationsspec. | Kardinalitet |
| :--- | :--- | :--- | :--- |
| Begäran |  |  |  |
| unitHsaId | String | HSA-id för sökt organisatorisk enhet. 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| searchBase *1) | DN | Sökbas. Om ingen sökbas anges används c=SE som sökbas. | 0..1 |
| includeFeignedObject | boolean | true: om metoden ska leverera svar med fingerade objekt. Uteblivet värde tolkas som false, dvs inga fingerade objekt levereras. | 0..1 |
| Profile *2) | String | Anger hur mycket information om enheten som begärs. Följande värden finns definierade: / basic
Bara grundläggande information returneras. / extended
Även information som är relaterad till vård och omsorg returneras / extended2
nonPublicTelephoneNumber / all
Default. All tillgänglig information returneras. / Uteblivet värde tolkas som all, dvs all tillgänglig information returneras. / Profilvärdet extended2 måste kombineras med annat profilvärde. | 0..* |
| Svar |  |  |  |
| Unit | unitType | Information om den angivna organisatoriska enheten | 0..1 |
| ..alternateName *b) | String | Alternativt namn på enheten som används vid sidan av det officiella namnet (se även publicName). Ref. alternativt namn (ouShort) [R5] | 0..* |
| ..alternateText *b) | String | Beskrivande text till jpegPhoto/bild på enhet. Ref. [R5] | 0..1 |
| ..businessClassification *e) | BusinessClassificationType | Verksamhetskod | 0..* |
| .. ..businessClassificationName | String | Verksamhetskod(-er) i klartext / Ref. verksamhet (businessClassificationName) [R5] | 1..1 |
| .. ..businessClassificationCode | String | Verksamhetskod(-er) kod / Ref. verksamhetskod (businessClassificationCode) [R5] | 1..1 |
| ..businessType *e) | String | Klassificering av enhet (t.ex. sjukhus). / Ref. enhetstyp (hsaBusinessType) [R5] | 0..* |
| ..careType *e) | String | Vårdform. / Ref. vård- och omsorgsform (careType) [R5] | 0..* |
| ..countyName *b) | String | Namn på län. / Ref. länsnamn (countyName) [R5] | 0..1 |
| ..countyCode *b) | String | Kod för län. / Ref. länskod (countyCode) [R5] | 0..1 |
| ..description *e) | String | Allmän beskrivning för enheten. / Ref. beskrivning (description) [R5] | 0..1 |
| ..directoryContact *b) | String | Mailadress till ansvarig för informationen om enheten. Uppgiften hämtas från enheten eller från något överliggande objekt (det närmast överliggande objekt där det finns definierat). / Ref. innehållsansvarigs e-postadress / (hsaDirectoryContact) [R5] | 0..1 |
| ..displayOption *b) | String | Används för att beräkna enhetens publika / namn (publicName). / Ref. alternativ namnvisning (displayOption) [R5] | 0..1 |
| ..dropInHour *e) | TimeSpan | Tider för dropin-besök (utan tidbokning). / Ref. tid för dropin-besök utan tidsbokning / (dropInHours) [R5] | 0..* |
| .. ..fromDay | String | Från dag. Måndag (1) – Söndag (7). | 1..1 |
| .. ..fromTime | Time | Från tid. Format enligt ISO-8601. | 1..1 |
| .. ..toDay | String | Till dag. Måndag (1) – Söndag (7). | 1..1 |
| .. ..toTime | Time | Till tid. Format enligt ISO-8601. | 1..1 |
| .. ..comment | String | Information om aktuellt tidsintervall. | 0..1 |
| .. ..fromDate | String | Tiden gäller från och med detta datum | 0..1 |
| .. ..toDate | String | Tider gäller till och med detta datum | 0..1 |
| ..mail *b) | String | Mailadress till enheten. / Ref. e-postadress (mail) [R5] | 0..1 |
| ..facsimileTelephoneNumber *b) | Telefon | Faxnummer till enheten. / Ref. fax (facsimileTelephoneNumber) [R5] | 0..* |
| ..geographicalCoordinatesRt90 *e) | GeoCoordRt90Type | Geografiska koordinater för enhetens huvudsakliga fysiska placering. Koordinaterna anges enligt RT90. / Ref. geografiska koordinater RT90 (geographicalCoordinates) [R5] | 0..1 |
| .. ..xCoordinate | String | X-koordinat. | 1..1 |
| .. ..yCoordinate | String | Y-koordinat. | 1..1 |
| ..geographicalCoordinatesSWEREF99 (används ej) | GeoCoordSWEREF99Type | Geografiska koordinater för enhetens huvudsakliga fysiska placering. Koordinaterna anges enligt SWEREF99. / Ref. geografiska koordinater SWEREF 99 TM (geographicalCoordinatesSweref99TM) [R5] | 0..1 |
| .. ..nCoordinate | String | X-koordinat. | 1..1 |
| .. ..eCoordinate | String | Y-koordinat. | 1..1 |
| ..geographicalCoordinatesSWEREF99Latitude *e) | String | X-koordinat (N) för enhetens huvudsakliga fysiska placering enligt SWEREF99
Ref. geografiska koordinater SWEREF 99 TM (hsaSweref99Latitude) [R5] | 0..1 |
| ..geographicalCoordinatesSWEREF99Longitude *e) | String | Y-koordinat (E) för enhetens huvudsakliga fysiska placering enligt SWEREF99
Ref. geografiska koordinater SWEREF 99 TM (hsaSweref99Longitude) [R5] | 0..1 |
| ..destinationIndicator *e) | String | Anger vilka parter som får ta del av enhetens information. / Ref. visas för / (hsaDestinationIndicator) [R5] | 0..* |
| ..unitHsaId *b) | String | Enhetens HSA-id 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| ..jpegPhoto *a) | String | Bild för enheten. Base-64-format. / Ref. bild (jpegPhoto) [R5] | 0..1 |
| ..jpegLogotype *a) | String | Logotype för enheten. Base-64-format. / Ref. logotyp (hsaJpegLogotype) [R5] | 0..1 |
| ..alternateTextLogotype *a) | String | Beskrivande text till logotype för enheten. Ref. [R5] | 0..1 |
| ..labeledUri *b) | String | Fullständig webbadress (inklusive http:// eller https://) / Ref. webbadress (labeledURI) [R5] | 0..1 |
| ..location *b) | String | Namn på geografiskt område där enheten i huvudsak är placerad. / Ref. geografisk plats (l, localityName) [R5] | 0..1 |
| ..webPage1177 *b) | String | Länk till Enhetens sida på 1177.se (om enheten är publik och finns på 1177.se) / Ref. 1177-kontaktkortslänk (hsaVpwWebPage) [R5] | 0..1 |
| ..management *e) | String | Ägarform i klartext. / Ref. ägarform (management) [R5] | 0..* |
| ..municipalityName *b) | String | Namn på kommun. / Ref. kommunnamn (municipalityName) [R5] | 0..1 |
| ..municipalityCode *b) | String | Kod för kommun. / Ref. kommunkod (municipalityCode) [R5] | 0..1 |
| ..nonPublicTelephoneNumber *f) | Telefon | Tjänstetelefonnummer / Ref. tjänstetelefon (hsaTelephoneNumber) [R5] | 0..* |
| ..unitName *b) | String | Namnet på enheten 
Ref. organisationsnamn (o), enhetsnamn (ou) resp. objektnamn (cn) [R5] | 1..1 |
| ..patientInformation *e) | String | Informationstext till patienter. / Ref. [R5] | 0..1 |
| ..postalAddress *b) | Address | Postadress i ostrukturerat format. / Kommer på sikt att ersättas av structuredPostalAddress. / Ref. [R5] | 0..1 |
| .. ..addressLine | String | Adressrad. | 1..* |
| ..structuredPostalAddress *b) | structuredPostalAddressType | Postadress i strukturerat format. / Kommer på sikt att ersätta postalAddress. / Ref. Strukturerad postadress (hsaPostalAddress) [R5] | 0..1 |
| .. .. addressee | String | Adressat | 1..* |
| .. .. street | String | Gata | 0..1 |
| .. .. premisesNumber | String | Adressplatsnummer | 0..1 |
| .. .. premisesLetter | String | Adressplatslittera | 0..1 |
| .. ..postCode | String | Postnummer | 1..1 |
| .. ..town | String | Postort | 1..1 |
| ..postalCode *b) | String | Postnummer där verksamheten bedrivs / Ref. [R5] | 0..1 |
| ..publicName *b) | String | Publikt officiellt namn.
Det publika namnet beräknas i första hand utifrån enhetens DN tillsammans med värdet i attributet displayOption.
Om displayOption saknas beräknas det publika namnet enligt:
enhetens namn <blanktecken> location / Ref. alternativ namnvisning (displayOption), organisationsnamn (o), enhetsnamn (ou), objektnamn (cn), resp geografisk plats (l, localityName) [R5] | 1..1 |
| ..relatedUnitHsaId *e) | String | HSA-identitet på en enhet som på något sätt hör ihop med aktuell enhet. 
Ref. HSA-id (hsaIdentity) [R5] | 0..* |
| ..route *e) | String | Vägbeskrivning. / Ref. färdväg (route) [R5] | 0..1 |
| ..indoorRouteDescription *e) | String | Vägbeskrivning för att ta sig till en enhet inom en byggnad. / Ref. inre vägbeskrivning (indoorRouteDescription) [R5] | 0..1 |
| ..schoolType *e) | String | Kod för typ av skolform som bedrivs. / Ref. skolform (hsaSchoolType) [R5] | 0..* |
| ..street *e) | String | Besöksadress (gatuadress) i ostrukturerat format. / Kommer på sikt att ersättas av structuredVisitingAddress. / Ref. besöksadress (street) [R5] | 0..1 |
| ..structuredVisitingAddress *e) | structuredVisitingAddressType | Besöksadress (gatuadress i strukturerat format). / Kommer på sikt att ersätta street. / Ref. Strukturerad besöksadress (hsaVisitingAddress) [R5] | 0..1 |
| .. .. street | String | Gata | 1..1 |
| .. .. premisesNumber | String | Adressplatsnummer | 0..1 |
| .. .. premisesLetter | String | Adressplatslittera | 0..1 |
| .. ..town | String | Ortnamn | 0..1 |
| ..surgeryHour *e) | TimeSpan | Öppettider. / Ref. öppettider (surgeryHours) [R5] | 0..* |
| .. ..fromDay | String | Från dag. Måndag (1) – Söndag (7). | 1..1 |
| .. ..fromTime | Time | Från tid. Format enligt ISO-8601. | 1..1 |
| .. ..toDay | String | Till dag. Måndag (1) – Söndag (7). | 1..1 |
| .. ..toTime | Time | Till tid. Format enligt ISO-8601. | 1..1 |
| .. ..comment | String | Information om aktuellt tidsintervall. | 0..1 |
| .. ..fromDate | String | Tiden gäller från och med detta datum | 0..1 |
| .. ..toDate | String | Tider gäller till och med detta datum | 0..1 |
| ..switchboardNumber *b) | Telefon | Telefonnummer till växel / Ref. växeltelefon (hsaSwitchboardNumber) [R5] | 0..1 |
| ..telephoneHour *b) | TimeSpan | Telefontider / Ref. telefontid (telephoneHours) [R5] | 0..* |
| .. ..fromDay | String | Från dag. Måndag (1) – Söndag (7). | 1..1 |
| .. ..fromTime | Time | Från tid. Format enligt ISO-8601. | 1..1 |
| .. ..toDay | String | Till dag. Måndag (1) – Söndag (7). | 1..1 |
| .. ..toTime | Time | Till tid. Format enligt ISO-8601. | 1..1 |
| .. ..comment | String | Information om aktuellt tidsintervall. | 0..1 |
| .. ..fromDate | String | Tiden gäller från och med detta datum | 0..1 |
| .. ..toDate | String | Tider gäller till och med detta datum | 0..1 |
| ..telephoneNumber *b) | Telefon | Publikt direkttelefonnummer. / Ref. direkttelefon (telephoneNumber) [R5] | 0..* |
| ..textTelephoneNumber *b) | String | Adress till texttelefon. / Exempel på adress kan vara exempel@sip.nu eller exempel@etalk.se. / Ref. texttelefon (hsaTextTelephoneNumber) [R5] | 0..* |
| ..unitExtraInformation *e) | String | Kompletterande information om enheten / Ref. mer om (hsaVpwInformation1) [R5] | 0..1 |
| ..unitFunction *a) | UnitFunctionType | Information från direkt underliggande funktionsobjekt med ett fördefinierat reserverat funktionsnamn, t.ex. Avbokning eller Rådgivning. | 0..* |
| .. ..name | String | Funktionens namn. / Ref. objektnamn (cn) [R5], enligt kodverk för Reserverade funktionsnamn. | 1..1 |
| .. ..telephoneHour | TimeSpan | Telefontider för telefonnummer i parametern telephoneNumber. / Ref. telefontid (telephoneHours) [R5] | 0..* |
| .. .. ..fromDay | String | Från dag. Måndag (1) – Söndag (7). | 1..1 |
| .. .. ..fromTime | Time | Från tid. Format enligt ISO-8601. | 1..1 |
| .. .. ..toDay | String | Till dag. Måndag (1) – Söndag (7). | 1..1 |
| .. .. ..toTime | Time | Till tid. Format enligt ISO-8601. | 1..1 |
| .. .. ..comment | String | Information om aktuellt tidsintervall. | 0..1 |
| .. .. ..fromDate | String | Tiden gäller från och med detta datum | 0..1 |
| .. .. ..toDate | String | Tider gäller till och med detta datum | 0..1 |
| .. ..telephoneNumber | Telefon | Publikt direkttelefonnummer. / Ref. direkttelefon (telephoneNumber) [R5] | 0..* |
| ..unitTemporaryInformation *e) | DateSpan | Tillfällig information om enheten. / Ref. tillfällig information (hsaVpwInformation2) [R5] | 0..1 |
| .. ..fromDate | String | Från datum. Exempel: 20101123 | 0..1 |
| .. ..toDate | String | Till datum. Exempel: 20101131 | 0..1 |
| .. ..temporaryInformation | String | Tillfällig information | 1..1 |
| ..visitingHour *e) | TimeSpan | Besökstider för anhöriga. / Ref. besökstider för anhöriga (visitingHours) [R5] | 0..* |
| .. ..fromDay | String | Från dag. Måndag (1) – Söndag (7). | 1..1 |
| .. ..fromTime | Time | Från tid. Format enligt ISO-8601. | 1..1 |
| .. ..toDay | String | Till dag. Måndag (1) – Söndag (7). | 1..1 |
| .. ..toTime | Time | Till tid. Format enligt ISO-8601. | 1..1 |
| .. ..comment | String | Information om aktuellt tidsintervall. | 0..1 |
| .. ..fromDate | String | Tiden gäller från och med detta datum | 0..1 |
| .. ..toDate | String | Tider gäller till och med detta datum | 0..1 |
| ..videoPhone *b) | String | Uppgift om adress för kommunikation via bildtelefon för personer med hörsel-, röst- eller talrubbningar. Ref. bildtelefon (hsaVideoPhone) [R5] | 0..1 |
| ..visitingRuleAge *e) | AgeSpan | Åldersintervall på patienter som tas emot. / Ref. åldersregler för vårdkontakt (hsaVisitingRuleAge) [R5] | 0..* |
| .. ..fromAge | String | Från ålder. 00 för nyfödd. | 1..1 |
| .. ..toAge | String | Till ålder. 99 för ingen övre åldersgräns. | 1..1 |
| .. ..comment | String | Kommentar till åldersintervallet | 0..1 |
| ..referralRules *b) | String | Beskrivning av remisskrav. / Ref. remisskrav (hsaVisitingRuleReferral) [R5] | 0..1 |
| ..visitingRules *e) | String | Besöksregler / Ref. besöksregler för anhöriga (hsaVisitingRules) [R5] | 0..1 |
| ..unitStartDate *b) | dateTime | Startdatum för enhetens verksamhet 
Ref. startdatum (startDate) [R5] | 0..1 |
| ..unitEndDate *b) | dateTime | Slutdatum för enhetens verksamhet 
Ref. slutdatum (endDate) [R5] | 0..1 |
| ..feignedUnit *b) | Boolean | true: om enheten är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| ..financingOrganization *b) | String | Angivelse av organisationsnummer för de landsting eller kommuner som finansierar den vård som bedrivs av en enhet
(financingOrganization) [R5]. | 0..* |
| ..administrativeCareLevel *e) | String | Kod som anger nivå av specialisering i hälso- och sjukvård utifrån patienters vårdbehov och huvudmans organisation och som används för att administrera ersättning till verksamhet för utförd vård. Administrativ vårdnivå anges endast för vårdenheter. Samma vårdenhet kan bedriva vård på flera vårdnivåer, till exempel både regionsjukvård och nationell högspecialiserad vård. (hsaAdministrativeCareLevel) [R5]. | 0..* |

#### Tjänstekontraktsspecifika krav och regler
Till denna informationsmängd finns regler som ej uttrycks i schemafilerna och tabellen ovan. Dessa återfinns nedan.
*1) searchBase
För GetUnit används följande sökningar/sökbaser:
- Sök efter enheten: i anropet angiven sökbas
*2) profile
För att begränsa mängden information som returneras från GetUnit kan profile-parametern användas. Följande profiler finns definierade:
basic, bara grundläggande information returneras, dvs de attribut som markerats med *b) ovan.
extended, både grundläggande information och information som är relaterad till vård och omsorg returneras, dvs alla attribut som markerats med *b) eller *e) ovan returneras.
extended2, även nonPublicTelephoneNumber returneras, attribut marketat med *f), måste kombineras med ytterligare profilevärde.
all, som också är default (dvs om ingen profil-parameter anges, tolkas det som ”all”), all tillgänglig information returneras förutom nonPublicTelephoneNumber, dvs både de attribut som markerats med *b), *e) och *a) returneras.

##### Icke funktionella krav

###### SLA-krav
Krav på svarstider anges under förutsättning att TLS-uppkoppling är etablerad, d.v.s. TLS-förhandlingstid tillkommer vid start av ny TLS-session. Angivna krav på svarstid utgår ifrån mätning från Tjänsteplattformen mot Katalogtjänsten, och exklusive den tid som tjänsteplattformen behöver för att förmedla fråga och svar.
Svarstid ska kunna garanteras upp till angiven last.

| Metod | Svarstider måste garanteras upp till följande last | Svarstid för 95 % av alla anrop ligger inom |
| :--- | :--- | :--- |
| GetUnit | 10 anrop/s | 200 ms |

###### Logiska fel
Logiska fel hanteras enligt:
Om angiven sökbas inte finns i katalogen, returneras ett tomt svar.
Om sökt enhet inte kan hittas i katalogen, så returneras tomt svar.
Om enheten saknar obligatorisk uppgift (Namn och HSA-id) så returneras tomt svar.
För komplexa returvärden som inte följer specificerad syntax m a p sammansättningen, returneras inte det aktuella värdet. Detta gäller för:
- Verksamhetskod som utgår från separata attribut i HSA (kod och klartext) som behöver kunna matchas ihop.
- Län och Kommun som utgår från separata attribut i HSA (kod och klartext för Län samt kod och klartext för Kommun) som alla behöver kunna matchas ihop.
- Tider (dropInHour , surgeryHour, telephoneHour och visitingHour) ska innehålla 4 eller upp till 7 delar (från-dag, till-dag, från-tid, , till-tid, ev en kommentar, ev från-datum och ev till-datum) separerade med ”#”.
- Koordinater (geographicalCoordinatesRt90 och geographicalCoordinatesSWEREF99) som ska innehåll två delar (x och y resp n och e), separerade med ”,”.
- unitTemporaryInformation som ska innehålla 3 delar (från-dag, till-dag och text) separerade med ”;”.
- visitingRuleAge som ska innehålla 2 eller 3 delar (från-ålder, till-ålder och eventuell kommentar) separerade med ”;”.
för kontroll av att returnerade attributvärden följer specificerad syntax, så rekommenderas använda den Schematron vi tillhandahåller.

#### Annan information om kontraktet
-

### GetHealthCareProvider
Metoden söker ut och returnerar information om en vårdgivare. Kan användas av tjänstekonsumenten för att hämta information som HSA-id, organisationsnummer, namn, eller eventuella start- och slutdatum för en vårdgivare. Notera att det kan förekomma att en och samma vårdgivare (utgående från organisationsnummer) kan finnas registrerad flera gånger med olika HSA-id.

#### Version
Version på detta kontrakt är 1.0.

#### Fältregler
Nedanstående tabell beskriver varje element i begäran och svar. Har namnet en * finns ytterligare regler för detta element och beskrivs mer i detalj i stycket Regler. Attributen som levereras beskrivs mer ingående i Informationsspecifikationen [R5], med avseende på t.ex. fältlängder och krav på innehållet.

| Namn | Typ | Beskrivning, Ref Informationsspec. | Kardinalitet |
| :--- | :--- | :--- | :--- |
| Begäran |  |  |  |
| healthCareProviderHsaId | String | HSA-id för en vårdgivare enligt PDL. 
Ref. HSA-id (hsaIdentity) [R5] | 0..1 *1) |
| healthCareProviderOrgNo | String | Organisationsnummer för en vårdgivare | 0..1 *1) |
| searchBase *2) | DN | Sökbas. Om ingen sökbas anges används c=SE som sökbas. | 0..1 |
| includeFeignedObject | boolean | true: om metoden ska leverera svar med fingerade objekt. Uteblivet värde tolkas som false, dvs inga fingerade objekt levereras. | 0..1 |
| Svar |  |  |  |
| healthCareProvider | HealthCareProviderType |  | 0..* |
| ..healthCareProviderHsaId | String | Vårdgivarens HSA-id 
Ref. HSA-id (hsaIdentity) [R5] | 1..1 |
| ..healthCareProviderName | String | Vårdgivarens namn 
Ref. organisationsnamn (o) resp.  enhetsnamn (ou) [R5] | 1..1 |
| ..healthCareProviderOrgNo | String | Vårdgivarens organisationsnummer
Ref. organisationsnummer (orgNo) [R5] | 1..1 |
| ..healthCareProviderStartDate | dateTime | Startdatum för vårdgivarens verksamhet. / Ref. startdatum (startDate) [R5] | 0..1 |
| ..healthCareProviderEndDate | dateTime | Slutdatum för vårdgivarens verksamhet.
Ref. slutdatum (endDate) [R5] | 0..1 |
| ..feignedHealthCareProvider | Boolean | true: om vårdgivaren är ett fingerat objekt 
Ref. hjälpklassen Fingerat objekt (hsaFeignedObject) [R5] | 0..1 |
| ..archivedHealthCareProvider | Boolean | true: om vårdgivaren är ett arkiverat objekt 
Ref. hjälpklassen arkiverat objekt (hsaArchivedObject) [R5] | 0..1 |

#### Tjänstekontraktsspecifika krav och regler
Till denna informationsmängd finns regler som ej uttrycks i schemafilerna och tabellen ovan. Dessa återfinns nedan.
*1) healthCareUnitProviderHsaId och healthCareProviderOrgNo
Exakt ett av fälten ska anges.
*2) searchBase
För GetHealthCareProvider används följande sökningar/sökbaser:
- Sök efter vårdgivare: i anropet angiven sökbas

##### Icke funktionella krav

###### SLA-krav
Svarstider är specifika för respektive tjänstekontrakt.
Krav på svarstider anges under förutsättning att TLS-uppkoppling är etablerad, d.v.s. TLS-förhandlingstid tillkommer vid start av ny TLS-session. Angivna krav på svarstid utgår ifrån mätning från Tjänsteplattformen mot Katalogtjänsten, och exklusive den tid som tjänsteplattformen behöver för att förmedla fråga och svar.
Svarstid ska kunna garanteras upp till angiven last.

| Metod | Svarstider måste garanteras upp till följande last | Svarstid för 95 % av alla anrop ligger inom |
| :--- | :--- | :--- |
| GetHealthCareProvider | 10 anrop/s | 100 ms |

###### Logiska fel
Logiska fel hanteras enligt:
Om angiven sökbas inte finns i katalogen, returneras ett tomt svar.
Om sökt vårdgivare inte kan hittas i katalogen, så returneras tomt svar.
Om sökt vårdgivare inte är en vårdgivare, så returneras tomt svar.
Om fler än en av sökparametrarna healthCareUnitProviderHsaId och healthCareProviderOrgNo har angetts, så är anropet felaktigt och ett soap-fault returneras.
Om vårdgivaren saknar någon obligatorisk uppgift så returneras tomt svar. Dvs om Namn, HSA-id, eller organisationsnummer saknas eller inte följer specificerad syntax så returneras tomt svar.
För kontroll av att returnerade attributvärden följer specificerad syntax, så rekommenderas använda den Schematron vi tillhandahåller.

#### Annan information om kontraktet
-
