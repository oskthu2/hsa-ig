# Källkatalog

| ID | Källa | Typ | Ägare | Version/Datum | Status | Kommentar |
|---|---|---|---|---|---|---|
| SRC-001 | HSA-schema organisationsträdet (xlsx) | Normativ | Inera/HSA-förvaltning | 5.3, 2026-03-16 | Inläst | `docs/sources/hsa-schema_organisationstradet_version_5.3.xlsx`; 133 attribut, 18 objektklasser, OID-förteckning |
| SRC-002 | HSA-schema tjänsteträdet (xlsx) | Normativ | Inera/HSA-förvaltning | 5.3, 2026-03-16 | Inläst | `docs/sources/hsa-schema_tjanstetradet_version_5.3.xlsx`; DC Koder, DC HOSP, objektklasser |
| SRC-003 | TKB infrastructure directory organization (docx) | Bakgrund | Inera (ej verifierat) | Ej angiven | Inkommen | `docs/sources/TKB_infrastructure_directory_organization.docx`; domän och informationsutbyte |
| SRC-004 | AB infrastructure directory organization 5.0 (docx) | Bakgrund | Inera (ej verifierat) | 5.0 | Inkommen | `docs/sources/ServiceContracts_.../AB_infrastructure_directory_organization.docx` |
| SRC-005 | hsa_fhir_ig_agentisk_plan.md | Analysunderlag | HSA-IG projektet | Ej versionsatt | Inläst | Extraherad analys av schema, OID:er, FHIRPath-invarianter, resurskarta |
| SRC-006 | HSA kodverk (Confluencesida) | Normativ | Inera/HSA-förvaltning | Gäller fr.o.m. 2026-03-16 | Blockerad (HTTP 403) | URL: https://inera.atlassian.net/wiki/spaces/OIKH/pages/346560593; kräver inloggning |
| SRC-007 | Terminologitjänsten (terminologitjansten.inera.se) | Normativ | Inera | 2026 | Blockerad (HTTP 403) | FHIR-baserat API; kräver inloggning; primär källa för canonical URI per kodverk |
| SRC-008 | HSA OID-förteckning (i SRC-001 xlsx) | Normativ | Inera/HSA-förvaltning | 5.3 | Inläst | OID:er för kodverk extraherade: verksamhetskod 1.2.752.129.2.2.1.3, enhetstyp 1.2.752.129.2.2.1.12, m.fl. |
| SRC-009 | Ineras spärrhanteringsmodell (Confluence) | Styrande | Inera | 2026 | Inkommen (publik) | URL: https://inera.atlassian.net/wiki/spaces/SRFS2/pages/3742621; beskriver inre/yttre spärr |
| SRC-010 | HSA-schemaversion 5.4 skjuts upp ett halvår | Styrande omgivning | Inera | 2026 | Inkommen | Påverkar versionsplan; baslinje förblir 5.3 |
| SRC-011 | EOL för sex tjänstekontraktsversioner maj 2027 | Styrande omgivning | Inera | 2026 | Inkommen | Påverkar integrations- och migreringsplan; IG behöver migrationskapitel |
| SRC-012 | HL7Sweden basprofiler-r4 (GitHub) | Referens | HL7 Sweden | v1.1.0 | Refererad | https://github.com/HL7Sweden/basprofiler-r4; beroenden och harmonisering |
| SRC-013 | eHMs Nationell katalog-IG (GitHub/CI-build) | Normativ jmf. | E-hälsomyndigheten | v0.1.0, ci-build | Inläst | GitHub: danka74/verksamhet-och-organisation; canonical: http://electronichealth.se/fhir/katalog; FHIR R4; paket: ehalsomyndigheten.se.katalog; beror på hl7se.fhir.base 1.0.0; innehåller HSAServiceTypeValueSet |
| SRC-014 | Nationella vårdtjänster v.1.0.0 (Excel, eHM/AFI-samarbetsyta) | Normativ jmf. | E-hälsomyndigheten | v1.0.0 | Blockerad (HTTP 403) | URL: https://samarbetsyta.ehalsomyndigheten.se/.../Nationella+vårdtjänster+v.+1.0.0.xlsx; kräver inloggning; kodverk för nationell vårdtjänsttyp |
| SRC-015 | Utbudstjänsten (avveckling) | Historisk kontext | Inera | Pausad 2023, avvecklas | Dokumenterad | Inera pausade juni 2023; ansvar till eHM; ersätts av eHMs Nationell katalog |
| SRC-016 | EK Användarhandbok – Region Stockholm (Elektroniska katalogen) | Implicit tillämpning | Region Stockholm / SLL IT | 2026-01-16 | Delvis inläst (403) | Bekräftar obligatoriska fält för 1177: Egennamn, Besöksadress, Telefon, Lokalitet, Vårdtyp, Ägarform, Kartposition; `visas för = 03` |
| SRC-017 | KIV Vårdgivarguide – VGR (Katalog i Väst) | Implicit tillämpning | Västra Götalandsregionen | 2024-09-20 | Delvis inläst (403/webb) | Krav för 1177: finansierande org, visas för allmänheten, vårdform, verksamhetskod, koordinater; bekräftar careType-koder 01/02/03 |
| SRC-018 | Lokal HSA katalog instruktion – Region Uppsala (LoKatt, DocPlusSTYR-35033) | Implicit tillämpning | Region Uppsala / Marie Sundin | v2, 2025-11-17 | Inläst | Bekräftar: HSA-id auto-genererat; Heroma-synk nattlig; öppettider/telefontider/drop-in; tillfällig info med slutdatum; adressregler (postadress vs besöksadress); direkttelefon+växeltelefon obligatorisk (ej privata) |
| SRC-019 | HSA Manual för 1177 synlighet (Inera Confluence) | Implicit tillämpning | Inera/Hitta vård | Ej daterad | Delvis inläst (403/webb) | Bekräftar `visas för = 03` och 6 obligatoriska attribut för 1177-publicering |
