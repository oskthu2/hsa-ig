# hsa-ig

Detta repo bootstrappar ett **agentiskt arbetssätt** för att ta fram en svensk FHIR IG för HSA-kataloginformation.

## Syfte

Repo:t ska stödja fyra parallella mål:

1. Kravspecifikation
2. Informationsmodell
3. Valideringspaket
4. API-kontrakt

Den övergripande målbilden finns i:
- `Malbild-och-genomforandeplan.md`

## Agentisk miljö (v1)

Följande struktur är uppsatt för att komma igång:

- `docs/` – styrande dokumentation
- `work/` – backlog, beslut, risker, körplan
- `artifacts/` – leverabler per etapp
- `templates/` – mallar för krav och spårbarhet

## Starta arbetet

1. Läs målbilden i `Malbild-och-genomforandeplan.md`.
2. Öppna `work/01-backlog.md` och prioritera första sprintens aktiviteter.
3. Fyll i källor i `work/02-kallkatalog.md`.
4. Dokumentera första beslut i `work/03-beslutslogg.md`.
5. Påbörja kravspårning med `templates/kravpost.md`.

## Bygga och publicera IG

- Push och pull requests kör SUSHI-kompilering via `.github/workflows/ci.yml`.
- Push till `main` och manuell körning via `workflow_dispatch` kör även IG Publisher.
- Den genererade webbversionen i `output/` publiceras till GitHub Pages från samma workflow.
- För att deployment ska fungera måste repo-inställningen för GitHub Pages vara satt till **GitHub Actions**.

## Föreslaget första sprintutfall

- Scope beslutat.
- Källkatalog påbörjad.
- Initial kravkatalog med minst 10 normerbara krav.
- Identifierade osäkerheter/risker loggade.
