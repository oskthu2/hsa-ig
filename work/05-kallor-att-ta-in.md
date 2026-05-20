# Källor att ta in (prioriterad lista)

> Uppdaterad 2026-05-20. Reflekterar vad som är intaget vs. fortfarande saknas.

## P1 – obligatoriska primärkällor

| Prioritet | Källa | Status | Notering |
|---|---|---|---|
| P1 | HSA Schema 5.3 – organisationsträdet | ✅ Inläst | SRC-001; `docs/sources/hsa-schema_organisationstradet_version_5.3.xlsx`; 133 attribut, OID-förteckning |
| P1 | HSA Schema 5.3 – tjänsteträdet | ✅ Inläst | SRC-002; `docs/sources/hsa-schema_tjanstetradet_version_5.3.xlsx`; DC Koder, DC HOSP |
| P1 | AB-dokumentation servicekontrakt 5.0 | ✅ Inkommen | SRC-004; `docs/sources/ServiceContracts_infrastructure_directory_organization_5.0/docs/AB_infrastructure_directory_organization.docx` |
| P1 | TKB domänbeskrivning | ✅ Inkommen | SRC-003; `docs/sources/TKB_infrastructure_directory_organization.docx` |
| P1 | OID-förteckning / kodverk OID:er | ✅ Inläst | SRC-008; extraherat via Python från xlsx; 8 kodverk dokumenterade i work/11-kodverkskatalog.md |
| P1 | HSA policy och formellt regelverk | ❌ Saknas | Kräver tillgång via beställare/HSA-förvaltning |
| P1 | HSA Admin-handbok/förvaltningsinstruktion | ❌ Saknas | Praktiska skapande- och livscykelregler; kräver tillgång |
| P1 | Kodverksinnehåll (faktiska kodfärden) | ⚠️ OID känd; värden blockerade | SRC-006/007; terminologitjansten.inera.se kräver inloggning; tills vidare används `urn:oid:...` |

## P2 – kritiska tillämpningskällor

| Prioritet | Källa | Status | Notering |
|---|---|---|---|
| P2 | 1177 / EK Region Stockholm – obligatoriska fält | ✅ Delvis inläst | SRC-016; implicit via webb; 6 obligatoriska attribut bekräftade; work/12-regional-tillampning.md |
| P2 | KIV Vårdgivarguide VGR | ✅ Delvis inläst | SRC-017; implicit via webb; careType-koder 01/02/03 bekräftade; finansierande org-krav |
| P2 | Uppsala LoKatt (DocPlusSTYR-35033 v2) | ✅ Inläst | SRC-018; fullständig; adressregler, öppettider, telefontider, drop-in, tillfällig info |
| P2 | eHMs Nationell katalog-IG (R4) | ✅ Inläst | SRC-013; GitHub danka74/verksamhet-och-organisation; FHIR R4; jämförelse ADR-008 |
| P2 | Nationella vårdtjänster v.1.0.0 (Excel) | ❌ Blockerad | SRC-014; kräver inloggning på eHMs samarbetsyta AFI; krävs för HSACAT-TERM-001 |
| P2 | NPÖ – vilka HSA-fält används | ❌ Ej inhämtat | Kräver kontakt med NPÖ-förvaltning |
| P2 | EHR-katalogsynk – minsta organisationsunderlag | ✅ Täckt av regional tillämpning | SRC-016/017/018 täcker EHR-behoven: HSA-id, namn, org.nr, besöksadress, kontaktvägar, hierarki via partOf, verksamhetskod, ägarform. Inga ytterligare EHR-specifika krav förväntas. |

## P3 – terminologi och harmonisering

| Prioritet | Källa | Status | Notering |
|---|---|---|---|
| P3 | Terminologitjänsten canonical URI:er per kodverk | ❌ Blockerad | Kräver inloggning; öppen fråga 6 i kravkatalogen |
| P3 | HL7 Sweden basprofiler R4 | ✅ Refererad | SRC-012; harmoniseringsanalys planerad i v2 |
