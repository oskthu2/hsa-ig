# Målbild och genomförandeplan för HSA-katalog som FHIR IG

## Målbild

Specifikationen ska inte bara bli en teknisk FHIR-mappning av HSA-attribut. Den ska fånga tre saker samtidigt:

1. Vilken kataloginformation som måste finnas för att svensk vård ska fungera säkert och korrekt.
2. Vilka strukturregler som i dag ligger implicit i HSA, HSA Admin, anslutningsrutiner, katalogförvaltning och regional tillämpning.
3. Hur detta uttrycks som ett modernt, validerbart och resursorienterat FHIR API.

Resultatet bör bli en IG som fungerar både som kravspecifikation, informationsmodell, valideringspaket och API-kontrakt.

## Föreslagen arbetsprincip

Utgå inte från ”HSA som databas”. Utgå från ”HSA som informationsförsörjning för vårdens organisatoriska verklighet”.

Modellen behöver beskriva:

| Fråga | Exempel |
|---|---|
| Vem ansvarar? | Vårdgivare, huvudman, juridisk organisation, organisatorisk enhet |
| Var bedrivs vård? | Fysisk plats, mottagning, enhet, digital kontaktväg |
| Vilken vård erbjuds? | Verksamhetsinriktning, vårdtjänst, specialitet, målgrupp |
| Hur når man dit? | Adress, telefon, e-tjänst, teknisk adress, öppettider |
| Vad får informationen användas till? | Vårdsökning, remiss, patientöversikt, behörighetsstyrning, tjänsteadressering |
| Vilka regler gäller? | Obligatoriska attribut, kodverk, hierarki, ansvar, publicering, spärr mot felaktiga kombinationer |

## Nödvändig informationsinventering

### 1) HSA:s explicita informationsmodell

Samla allt som är formellt beskrivet.

| Källa | Vad som ska hämtas |
|---|---|
| HSA Schema | Objektklasser, attribut, datatyper, kardinaliteter |
| HSA Tekniska specifikationer | Identifierare, LDAP-struktur, formatregler |
| HSA Admin och förvaltningsdokumentation | Regler för hur objekt skapas och underhålls |
| HSA Policy och regelverk | Krav på kvalitet, ansvar, ägarskap och aktualitet |
| Kodverksdokumentation | HSA verksamhetskoder, organisationstyper, adressändamål, kontaktvägar |
| Tillämpningsanvisningar | Särskilda regler för vårdgivare, vårdenheter, enheter, personer och uppdrag |

Output från detta steg bör vara en rå kravkatalog.

### 2) HSA:s implicita vårdtillämpning

Många krav finns som etablerad användning snarare än fältregler.

Exempel på frågor:

| Område | Fråga |
|---|---|
| Regional katalogförvaltning | Vilka objekt skapas faktiskt och varför? |
| NPÖ och sammanhållen journal | Vilka HSA-uppgifter används för åtkomst, visning och spårbarhet? |
| 1177 | Vilka uppgifter används för invånarsökning, mottagningssidor och kontaktvägar? |
| Tjänsteplattformen | Vilka HSA-uppgifter används för tjänsteadressering? |
| Behörighet och medarbetaruppdrag | Vilka organisatoriska strukturer används för åtkomstbeslut? |
| Remiss och vårdförmedling | Vilken kataloginformation behövs för att hitta mottagande part? |
| Vårdval och uppdrag | Hur syns uppdrag, avtal, vårdutbud och målgrupper? |

Output bör vara en semantisk kravkatalog: “Detta attribut används i praktiken för detta beslut eller denna funktion.”

### 3) Objekt och begrepp som måste särskiljas

| HSA eller vårdbegrepp | FHIR-kandidat |
|---|---|
| Vårdgivare | Organization |
| Huvudman | Organization |
| Vårdenhet | Organization, ibland HealthcareService beroende på semantik |
| Mottagning | Ofta kombination av Organization, Location, HealthcareService |
| Verksamhet | Ofta HealthcareService.type, ibland Organization.type |
| Fysisk plats | Location |
| Digital mottagning | Location med virtuell typ eller HealthcareService med kontaktkanal |
| Kontaktväg | Organization.telecom, HealthcareService.telecom, eventuellt Endpoint |
| Teknisk tjänsteadress | Endpoint |
| Tjänsteutbud | HealthcareService |

Central regel: samma verkliga företeelse får representeras av flera FHIR-resurser, men varje resurs ska beskriva en egen aspekt.

### 4) Kodverksanalys

Eget arbetspaket med analys per kodverk:

- vad koden klassificerar,
- hierarki,
- tidsstabilitet,
- överlapp med andra kodverk,
- intern styrning vs extern publicering,
- nationell/regional/HSA-specifik användning,
- mappbarhet till internationella kodverk.

Särskilt viktigt: HSA-verksamhetskod ska inte automatiskt användas överallt.

### 5) Harmonisering med E-hälsomyndighetens vårdgivarkatalog

Använd som jämförelsepunkt, inte styrande källa.

| Fråga | Princip |
|---|---|
| Finns motsvarande begrepp hos E-hälsomyndigheten? | Mappa och dokumentera |
| Är begreppet svagare/grövre? | Bevara HSA-kravet i Inera IG |
| Finns konflikt mellan modellerna? | Prioritera vårdens etablerade HSA-krav |
| Finns gemensamma identifierare? | Återanvänd där det är säkert |
| Finns API/katalogprinciper att harmonisera? | Anpassa där det inte försvagar modellen |

## Föreslagen agentisk process

1. **Källinventeringsagent** – källkatalog, kravextrakt, osäkerhetslista.
2. **Attribut- och strukturagent** – objektmatris, kardinaliteter, strukturregler, kandidatmappning.
3. **Tillämpningsagent** – användningsfall, informationsbehov, beslutsberoenden, riskanalys.
4. **Terminologiagent** – kodverkskatalog, bindningsförslag, ConceptMaps, kodverksrisker.
5. **FHIR-modelleringsagent** – profilkarta, relationer, sökmodell, API-kontrakt.
6. **Regel- och invariantagent** – FHIRPath-regler, slicing, mustSupport.
7. **API- och REST-agent** – interaktioner, sökparametrar, include/revInclude, felhantering.
8. **Test- och conformance-agent** – positiva/negativa testfall, valideringspaket, leverantörsmatris.

## Föreslagen IG-struktur

- Introduction
- Design principles
- Use cases
- Conceptual model
- HSA alignment
- Profiles
- Terminology
- Invariants and rules
- REST API
- Examples
- Conformance
- Migration guide
- eHM comparison

## Viktiga modelleringsbeslut tidigt

- FHIR-version: R4, R4B eller R5.
- Nationell norm vs Inera API-kontrakt.
- Om person/uppdrag är i scope.
- Om teknisk adressering ingår.
- Hantering av publiceringsstatus/historik.
- Hantering av regionala tillägg.
- HSA-id som identifier (inte nödvändigtvis FHIR id).
- Läsmodell vs masterdata-API.

## Arbetsflöde i etapper

1. Scope och källbas
2. Begreppsmodell och resursval
3. Terminologi och kodverk
4. Profilering
5. REST API-kontrakt
6. Testpaket och leverantörskrav
7. Harmonisering och remiss

## Rekommenderad första aktivitet

Börja inte med FSH. Börja med en krav- och begreppsinventering som uttryckligen skiljer mellan:

- HSA:s formella informationsmodell,
- HSA:s faktiska tillämpning i vården,
- den FHIR-resurs som bäst representerar respektive informationsbehov.
