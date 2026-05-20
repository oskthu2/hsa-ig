# Minsta API-scope (SPI) – VGR-inriktning, utkast v0.1

> Status: Utkast (beslutat verksamhetsfokus, tekniska detaljer verifieras mot källor)

## Beslutad inriktning

Det minsta scope som ska stödjas i första iterationen utgår från VGR:s behov av kataloginformation för:

1. Dokumentation av vård och vårdkontakter i EHR-system
2. Regionens uppföljning av utförd vård
3. Remissflöden
4. 1177 vårdutbud för invånare

Detta dokument konkretiserar minsta REST- och informationsscope för ovan användningsfall.

## Resurser i scope (R5)

- `Organization` – ansvar, organisatorisk nivå, hierarki
- `Location` – vårdplats/fysisk eller virtuell plats
- `HealthcareService` – vårdutbud/tjänstekategori
- `Endpoint` – med förbehåll; inte primärdrivare i denna avgränsning

Stödjande konsumtion i andra system kan omfatta referenser från t.ex. `Encounter` och `ServiceRequest`, men dessa profileras inte som primära katalogresurser i v1.

## Minsta API-interaktioner

### Läsning och sökning

- `GET /Organization/{id}`
- `GET /Organization?identifier={system|value}`
- `GET /Organization?partof={id}`
- `GET /Location/{id}`
- `GET /Location?organization={id}`
- `GET /HealthcareService/{id}`
- `GET /HealthcareService?organization={id}`
- `GET /HealthcareService?location={id}`

### Hierarki för åtkomstbeslut (inre/yttre spärr)

- `GET /Organization?partof={id}` för stegvis traversering
- Stöd för `_include=Organization:partof` för att hämta överordnad nod
- Stöd för stabil paginering vid större träd

### Synk till EHR-system

Minst följande måste kunna hämtas konsekvent:

- Organisationens identifierare (inkl. HSA-id)
- Organisationstyp/nivåklassificering
- Över-/undernodsrelation (`partOf`)
- Koppling till plats (`Location.managingOrganization`)
- Koppling till vårdutbud (`HealthcareService.providedBy` + `location`)

## Relationer i minsta domänmodell

Nedanstående relationer prioriteras i v1:

1. `Organization.partOf -> Organization` (organisationshierarki)
2. `Location.managingOrganization -> Organization` (ansvarig organisation för plats)
3. `Location.partOf -> Location` (platsstruktur, vid behov)
4. `HealthcareService.providedBy -> Organization` (tillhandahållare)
5. `HealthcareService.location -> Location` (var tjänsten ges)

## R5-notering (i förhållande till äldre R4-analys)

Tidigare skisser med R4-fält behöver uppdateras till R5-semantik där relevant. Särskilt:

- Kodning ska modelleras konsekvent med R5:s datatyper och bindningar.
- När äldre material använder förenklade eller felaktigt placerade kodverk måste bindning verifieras mot faktisk semantik (organisationstyp, verksamhet, specialitet, plats).
- Referenser från vårdkontakter/remisser till kataloginformation ska beskrivas som konsumtionsmönster, inte nödvändigtvis som primär katalogprofilering i v1.

## Öppna punkter som kräver källor

1. Exakta nivåklassificeringar för åtkomstbeslut (inre/yttre spärr)
2. Vilka fält i EHR-synk som är SHALL vs SHOULD
3. Exakta NPÖ/1177 beroenden per attribut
4. Identifierarsystem (URI/OID) som ska vara normativa
