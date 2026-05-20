# Exekvering Etapp 1 – Scope och källbas

## Statusöversikt (2026-05-20)

- **Mål:** Starta faktisk kravinsamling och låsa kritiska vägval.
- **Status:** Pågående med beslutade vägval (scope, FHIR-version, användningsfall, krav-ID).
- **Blockerare:** Primära HSA-källor saknas i repo.

## Genomfört nu

- [x] Agentisk arbetsmiljö etablerad (`docs/`, `work/`, `templates/`, `artifacts/`).
- [x] Initial backlog, källkatalog och beslutslogg skapad.
- [x] Första ADR beslutad: kravinventering före FSH.

## Nästa exekverbara aktiviteter (48h)

1. Översätta beslut till uppdaterad kravkatalog (IAM-avgränsning + åtkomststöd via struktur).
2. Uppdatera källlista för användningsfall: EHR-katalogsynk, NPÖ, 1177 (ej tjänsteadressering).
3. Importera och registrera minst 8 prioriterade primärkällor.
4. Höja utkastkrav med tydlig R5-inriktning och verifieringsstatus.

## Inmatning som behövs från beställare/förvaltning

Följande måste tillföras för att undvika antaganden:

- Gällande version av HSA schema och tekniska specifikationer.
- Gällande HSA policy/regelverk samt tillämpningsanvisningar.
- Kodverksunderlag (verksamhetskod, organisationstyper, kontaktvägar etc.).
- Referens till hur EHR-katalogsynk, NPÖ och 1177 använder HSA-data idag.

## Leveranskriterier för Etapp 1

- Källkatalog med ägare, version och status för minst 8 källor.
- Beslutade vägval: scope + FHIR-version.
- Minst 10 krav i spårbart format (krav-id, källa, FHIR-uttryck, testidé).

## Nya externa signaler (2026-05-20)

- Inera har kommunicerat end-of-life för sex tjänstekontraktsversioner för HSA i **maj 2027**.
- Inera har också kommunicerat att HSA-schemaversion **5.4 skjuts upp ett halvår**.

Konsekvens för arbetet:

1. Vi behöver planera en tydlig migrerings- och kompatibilitetslinje i API-kontraktet (kapitel Migration/Conformance).
2. Källprioritering för Etapp 1 ska fokusera på 5.3 som gällande baslinje.
3. Risklogg ska få tidsrisk kopplad till versionsförskjutning och kontrakts-EOL 2027.

