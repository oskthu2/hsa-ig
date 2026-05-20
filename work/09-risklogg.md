# Risklogg

| Risk-ID | Risk | Sannolikhet | Konsekvens | Åtgärd | Status |
|---|---|---|---|---|---|
| RSK-001 | EOL för sex HSA-tjänstekontraktsversioner i maj 2027 påverkar anslutna integrationer | Medel | Hög | Ta fram migreringskrav och kompatibilitetsprofil i IG (kapitel Migration/Conformance) | Öppen |
| RSK-002 | HSA-schema 5.4 beslutas okt 2026, lanseras prod mars 2027 – påverkar planerad modellering | Hög | Medel | Basera Etapp 1–2 på 5.3 som normativ baslinje; hantera 5.4 som framtida change set med diff-analys | Öppen |
| RSK-003 | eHMs Nationell katalog-IG (R4) och HSA-IG (R5) är parallella men ej synkroniserade | Hög | Medel | ADR-008: v1 R5, v2 lägger R4-bakåtkompatibilitetsguide; håll löpande kontakt med eHM-projektet | Öppen |
| RSK-004 | Nationella vårdtjänster v.1.0.0 (eHM/AFI) och HSA verksamhetskod kan divergera – IG binder fel system | Medel | Hög | ADR-009: jämför båda kodverken explicit; ta in Excel-filen, mappa mot HSA OID 1.2.752.129.2.2.1.3; besluta bindningsstrategi | Öppen – väntar på Excel-fil |
| RSK-005 | Utbudstjänsten avveckling skapar vakuum i kodverk för erbjudna vårdtjänster – gamla koder används felaktigt | Medel | Medel | Dokumentera avvecklingen i IG (historik + migration); hänvisa till eHMs kodverk som ersättare | Öppen |
