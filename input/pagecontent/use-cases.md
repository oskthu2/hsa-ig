# Användningsfall

Denna sida beskriver de primära integrationsscenarion som HSA-IG är utformad för. Varje användningsfall drivs av konkreta verksamhetskrav och styr vilka profiler och fält som är relevanta.

---

## UC-01: EHR-katalogsynk

**Aktör:** Regionalt vårdsystem (t.ex. COSMIC, TakeCare)  
**Syfte:** Synkronisera organisationsdata från HSA till lokalt cache för sökning och visning.  
**Frekvens:** Batch (nattlig) + händelsedriven (on-demand vid ändring)

Relevanta profiler: `HsaCatalogOrganization`, `HsaHealthcareProviderOrganization`, `HsaHealthcareUnitOrganization`

Typiska fält: `identifier[hsa-id]`, `name`, `active`, `partOf`, `type[hsa-class]`, `contact.telecom`, `contact.address`

---

## UC-02: NPÖ – GetHealthCareUnitMembers

**Aktör:** Nationell Patientöversikt (NPÖ)  
**Syfte:** Hämta vilka vårdenheter en patient har besökt via arbetsplatskod.  
**Nyckelkrav:** Arbetsplatskod (HSACAT-ORG-012) som `identifier[apk]` (OID preliminärt `1.2.752.29.4.71` — öppen fråga 8).

Relevanta profiler: `HsaHealthcareUnitOrganization`

Typiska fält: `identifier[apk]`, `identifier[hsa-id]`, `partOf`, `active`

---

## UC-03: 1177 Hitta vård

**Aktör:** 1177.se publiktjänst  
**Syfte:** Presentera sökbara, offentliga vårdenheter med kontaktuppgifter och kartvisning.  
**Nyckelkrav:** Filtrering på `meta.security[destination-indicator]` kod `03`.

Relevanta profiler: `HsaHealthcareProviderOrganization`, `HsaHealthcareUnitOrganization`, `HsaCatalogLocation`, `HsaHealthcareService`

Se [Klientrendering](client-rendering.html) för komplett publiceringschecklista.

---

## UC-04: VGR Encounter.type via verksamhetskod

**Aktör:** VGR:s journalsystem  
**Syfte:** Sätta `Encounter.type` baserat på verksamhetskod från den vårdenhet som besöket gäller.

Flöde: `Encounter.serviceType → HealthcareService.category[verksamhetskod]`

Verksamhetskod (OID `1.2.752.129.2.2.1.3`) modelleras på `HealthcareService.category` (ADR-011) vilket gör den direkt tillgänglig utan transformation.

---

## Ej täckt i version 1

- **Tjänsteadressering:** Endpoint-profilering för SKLTP TAK är planerad för v2.
- **Person och uppdrag:** Practitioner/PractitionerRole ingår inte — persondata kräver åtkomstkydd utöver katalogscope (ADR-007).
- **IAM/behörighetstilldelning:** Åtkomstkontrollslogik modelleras inte; IG:n stödjer enbart katalog-infrastrukturen för trädklättring (ADR-002).
