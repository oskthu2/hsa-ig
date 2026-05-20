# Backlog – uppstart

## Sprint 0: Etablering

- [x] Bekräfta scope (organisationskatalog, ej full IAM i v1) – beslutat: stöd för åtkomstbeslut via trädstruktur och nivåklassificering för inre/yttre spärr
- [x] Bekräfta FHIR-version – beslutat: R5
- [x] Lista prioriterade användningsfall – beslutat: katalogsynk till EHR-system + NPÖ + 1177 (ej tjänsteadressering)
- [x] Definiera minsta API-scope – utkast framtaget i work/08-minsta-api-scope-vgr.md
- [x] Etablera krav-ID-konvention – beslutat: HSACAT-<DOMÄN>-<NNN>

## Sprint 1: Källinventering + första kravkatalog

- [x] Operativisera kravhantering enligt docs/kravhantering-och-verifiering.md
- [x] Upprätta kravspårningstabell (work/10-kravsparning-tabell.md)
- [x] Inventera HSA Schema 5.3 (organisationsträdet + tjänsteträdet) – SRC-001/002
- [x] Inventera servicekontrakt AB-dokument (SRC-004, v5.0)
- [x] Inventera TKB domänbeskrivning (SRC-003)
- [x] Dokumentera implicita regler från regional tillämpning (SRC-016/017/018) – work/12-regional-tillampning.md
- [x] Publicera kravlista 24 krav – work/06-kravkatalog-utkast.md

## Sprint 2: Kärnmodell (påbörjad)

- [x] Etablera sushi-config.yaml + FHIR IG-struktur
- [x] CI/CD pipeline (GitHub Actions, sushi + IG Publisher)
- [x] Definiera NamingSystems (HSA-id OID, org.nr OID)
- [x] Definiera CodeSystems (hsa-object-class, hsa-telecom-type)
- [x] Definiera ValueSets (6 st: org-type, ownership, destination-indicator, care-type, service-type, telecom-type)
- [x] Definiera Extensions (6 st: destination-indicator, admin-care-level, financing-org, temporary-info, navigation, telecom-type)
- [x] Definiera Invariants (11 st FHIRPath-constraints)
- [x] Fastställ kärnprofiler: HsaCatalogOrganization, HsaHealthcareProviderOrganization, HsaHealthcareUnitOrganization, HsaCatalogLocation, HsaHealthcareService
- [x] Definiera relationer (partOf 1..1 vårdenhet, managingOrganization 1..1 Location, providedBy 1..1 HealthcareService)
- [x] Definiera identifierarstrategi (HSA-id + org.nr i identifier-slices)
- [x] Skapa exempelinstanser (VardgivareExample, VardenhetExample, LocationExample, HealthcareServiceExample)
- [x] Rätta R5-inkompatibiliteter (Organization.contact, HealthcareService.availability)
- [x] Sushi build 0 errors

## Sprint 3: Terminologi + sökbarhet + konformansuttalanden (återstår)

- [ ] Hämta canonical URI:er från Terminologitjänsten (öppen fråga 6)
- [ ] Harmoniseringsmatris verksamhetskod vs eHM Nationella vårdtjänster (öppen fråga 7)
- [ ] SearchParameter-resurser för HSA-id, organization type, destination indicator
- [ ] CapabilityStatement (server + client)
- [ ] Negativa testinstanser (invalid HSA-id, saknad partOf, etc.)
- [ ] Etablera migreringsspår för HSA tjänstekontrakt EOL maj 2027
- [ ] Hantera tidplansrisk för uppskjuten HSA-schema 5.4 (change set-analys)
- [ ] IG Publisher full build grön (terminologivalidering, länkkontroll)
