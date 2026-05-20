# Beslutslogg

| Datum | Beslut-ID | Beslut | Alternativ | Rationale | Konsekvens |
|---|---|---|---|---|---|
| 2026-05-19 | ADR-001 | Uppstart med kravinventering före FSH | Starta direkt i profiler | Minskar feltolkning och implicit semantik | Fördröjer initial kod men höjer kvalitet |
| 2026-05-20 | ADR-002 | Full IAM ingår inte i v1 | Inkludera full IAM | Fokus på katalog, men stöd för åtkomstbeslut krävs | Trädstruktur och nivåklassificering modelleras för inre/yttre spärr |
| 2026-05-20 | ADR-003 | FHIR-version R5 | R4B | R5 ger bättre långsiktig modellering och målinriktad design | Profiler/invariants/Search/API designas mot R5 |
| 2026-05-20 | ADR-004 | Prioriterade användningsfall: katalogsynk till EHR, NPÖ, 1177 | Inkludera tjänsteadressering i v1 | Avgränsar första leveransen till största informationsbehov | Endpoint för tjänsteadressering blir ej primärdrivare i v1 |
| 2026-05-20 | ADR-005 | Krav-ID-konvention: HSACAT-<DOMÄN>-<NNN> | Fri namnsättning | Säkerställer spårbarhet och konsekvens | Alla nya krav ska följa konventionen |
| 2026-05-20 | ADR-006 | Minsta SPI-scope utgår från VGR-behov: EHR-katalogsynk, uppföljning, remiss, 1177 | Bredare nationellt scope direkt | Ger levererbar v1 med tydlig nytta | API- och kravarbete prioriterar dessa användningsfall först |
| 2026-05-20 | ADR-007 | Person (Practitioner) och uppdrag (PractitionerRole) ingår inte i v1 | Inkludera person och uppdrag i v1 | Persondata medför krav på åtkomstskydd, sekretess och PDL-hantering som inte hanteras i katalog-API:t; scope hålls till org/plats/tjänst | HsaPractitioner och HsaPractitionerRole profileras inte i v1; deras FHIR-resurser kan förekomma som externa referenser men normativa krav läggs i ett senare tillägg |

