# Agentic Operating Model

Detta dokument operationaliserar målbilden till ett körbart arbetssätt.

## Roller

- **Huvudagent**: planering, prioritering, kvalitetssäkring, integrationsbeslut.
- **Källinventeringsspår**: samlar formella och informella källor.
- **Modelleringsspår**: begreppsmodell, profilering, regler.
- **Terminologispår**: kodverk, bindings, ConceptMaps.
- **API/spårbarhetstest**: CapabilityStatement, testfall, negativtest.

## Arbetscykel (veckovis)

1. Planera (mål + tydliga leverabler)
2. Extrahera (källor, regler, semantik)
3. Modellera (FHIR-profiler, bindings, invariants)
4. Verifiera (valideringskörning + negativa testfall)
5. Publicera (artefakt + beslutslogg + spårbarhet)

## Definition of Done per krav

Ett krav räknas som klart när följande finns:

- Krav-id och källa
- Normativ text (SHALL/SHOULD/MAY)
- FHIR-uttryck (profil/binding/invariant)
- Testfall (minst ett positivt + ett negativt)
- Motivering och påverkan
