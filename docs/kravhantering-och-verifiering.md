# Kravhantering och verifiering (operativisering av agentisk modell)

Detta dokument omsätter `docs/agentic-operating-model.md` till ett konkret arbetsupplägg för nästa steg i Etapp 1.

## Syfte

- Säkerställa att varje krav i `work/06-kravkatalog-utkast.md` kan drivas till normativ status.
- Knyta samman krav, källor, beslut, testfall och API-kontrakt.

## Arbetsflöde per krav

1. **Identifiera kravkandidat** i kravkatalog.
2. **Knyt minst en formell källa** i `work/02-kallkatalog.md`.
3. **Skriv normativ kravtext** (SHALL/SHOULD/MAY) i kravpost.
4. **Uttryck kravet i FHIR R5** (profil, binding, invariant, slicing).
5. **Definiera testfall** (minst 1 positivt + 1 negativt).
6. **Länka till beslut/risk** i `work/03-beslutslogg.md` och `work/09-risklogg.md`.
7. **Markera status**: Utkast -> Verifierad -> Normativ.

## Statusnivåer

- **Utkast**: saknar verifierad källa och/eller testfall.
- **Verifierad**: har källa + preliminärt FHIR-uttryck + testidé.
- **Normativ**: komplett DoD enligt agentic operating model.

## Spårbarhetsregler

Varje normativ kravpost ska innehålla:

- Krav-id enligt `HSACAT-<DOMÄN>-<NNN>`
- Käll-ID (`SRC-xxx`)
- Besluts-ID (`ADR-xxx`) vid relevant vägval
- Risk-ID (`RSK-xxx`) där riskhantering krävs
- Primärt FHIR-element/resurs

## Prioritering för nästa iteration

Följande krav prioriteras först:

1. `HSACAT-ORG-001` (HSA-id)
2. `HSACAT-ORG-005` (nivåklassificering för åtkomstbeslut)
3. `HSACAT-ORG-006` (traverserbar hierarki)
4. `HSACAT-LOC-002` (managingOrganization)
5. `HSACAT-SVC-001` (providedBy)

## Leverans i nästa commit

- Uppgradera minst 5 krav från Utkast till Verifierad.
- Lägga till kravspårningstabell med SRC/ADR/RSK-koppling.
- Lägga till första uppsättning negativa testidéer.
