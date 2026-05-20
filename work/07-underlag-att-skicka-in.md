# Underlag att skicka in (för att driva arbetet vidare)

> Uppdaterad 2026-05-20. Markerar vad som inkommit och vad som fortfarande behövs.

## A. Formella HSA-källor

| # | Underlag | Status |
|---|---|---|
| 1 | HSA Schema 5.3 (xlsx) – organisationsträdet | ✅ Inkommen (`docs/sources/hsa-schema_organisationstradet_version_5.3.xlsx`) |
| 2 | HSA Schema 5.3 (xlsx) – tjänsteträdet | ✅ Inkommen (`docs/sources/hsa-schema_tjanstetradet_version_5.3.xlsx`) |
| 3 | AB servicekontrakt 5.0 (docx) | ✅ Inkommen (`docs/sources/ServiceContracts_infrastructure_directory_organization_5.0/docs/AB_infrastructure_directory_organization.docx`) |
| 4 | TKB domänbeskrivning (docx) | ✅ Inkommen (`docs/sources/TKB_infrastructure_directory_organization.docx`) |
| 5 | HSA policy och regelverk | ❌ Behövs – normativa krav på livscykel, kvalitet, ansvar |
| 6 | HSA Admin-handbok/förvaltningsinstruktion | ❌ Behövs – skapande, redigering, arkivering av HSA-objekt |
| 7 | Kodverksspecifikationer med faktiska kodvärden | ⚠️ OID:er kända; faktiska värden kräver inloggning på Terminologitjänsten |

## B. Tillämpningskällor

| # | Underlag | Status |
|---|---|---|
| 8 | NPÖ – vilka HSA-fält används för visning/spårbarhet/åtkomst | ❌ Behövs – kräver kontakt med NPÖ-förvaltning |
| 9 | 1177 Hitta vård – HSA-fält för sökning/kontakt/publicering | ✅ Delvis täckt via EK (SRC-016), KIV (SRC-017), Uppsala LoKatt (SRC-018) |
| 10 | EHR-katalogsynk – minsta organisationsunderlag i mottagande system | ❌ Behövs – kräver underlag från EHR-förvaltning/integration |

## C. Terminologi (krävs för IG Publisher grön)

| # | Underlag | Status |
|---|---|---|
| 11 | Canonical URI per HSA-kodverk (Terminologitjänsten) | ❌ Krävs – logga in på terminologitjansten.inera.se och hämta canonical URL; öppen fråga 6 |
| 12 | Nationella vårdtjänster v.1.0.0 Excel (eHM/AFI) | ❌ Krävs – logga in på eHMs samarbetsyta; stänger öppen fråga 7 + ger harmoniseringsmatris |

---

## Snabbspår (lägsta tröskeln för nästa steg)

För att ta IG:n från `draft` till `active` och klara IG Publisher-validering räcker tre saker:

1. **Terminologitjänsten canonical URI:er** – ersätter `urn:oid:...`-bindningar med officiella HTTPS-URL:er
2. **Nationella vårdtjänster Excel** – möjliggör HSACAT-TERM-001 harmoniseringsmatris
3. **HSA policy/regelverk** – normativa livscykelkrav saknas helt i dagsläget
