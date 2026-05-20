# Backlog – uppstart

## Sprint 0: Etablering

- [x] Bekräfta scope (organisationskatalog, ej full IAM i v1) – beslutat: stöd för åtkomstbeslut via trädstruktur och nivåklassificering för inre/yttre spärr
- [x] Bekräfta FHIR-version – beslutat: R5
- [x] Lista prioriterade användningsfall – beslutat: katalogsynk till EHR-system + NPÖ + 1177 (ej tjänsteadressering)
- [~] Definiera minsta API-scope – utkast framtaget i work/08-minsta-api-scope-vgr.md
- [x] Etablera krav-ID-konvention – beslutat: HSACAT-ORG-001

## Sprint 1: Källinventering + första kravkatalog

- [x] Operativisera kravhantering enligt docs/kravhantering-och-verifiering.md
- [~] Upprätta kravspårningstabell (work/10-kravsparning-tabell.md)
- [~] Inventera HSA Schema + tekniska specifikationer – källor efterfrågade
- [ ] Inventera HSA policy + tillämpningsanvisningar
- [ ] Dokumentera implicita regler från vårdtillämpning
- [ ] Publicera första kravlista (10–25 krav)

## Sprint 2: Kärnmodell

- [ ] Etablera migreringsspår för HSA tjänstekontrakt EOL maj 2027
- [ ] Hantera tidplansrisk för uppskjuten HSA-schema 5.4

- [ ] Fastställ kärnprofiler (Organization, Location, HealthcareService, Endpoint)
- [ ] Definiera relationer (`partOf`, `managingOrganization`, `providedBy`)
- [ ] Definiera identifierarstrategi (HSA-id i `identifier`)
