# Adressövergång - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* **Adressövergång**

## Adressövergång

# Adressövergång: HSA 5.2+ strukturerade adresser

Denna sida dokumenterar övergången från HSA:s äldre ostrukturerade adressattribut till strukturerade komponenter. Sidan är relevant för konsumenter som integrerar mot äldre HSA-instanser (t.ex. LDAP-kataloger) och för producenter som migrerar data.

-------

## Bakgrund

HSA-schemat i version 5.2 (publicerat 2024) introducerade strukturerade adressattribut som på sikt ersätter de äldre:

| | | |
| :--- | :--- | :--- |
| Besöksadress | `streetAddress`(fritext) | `hsaVisitingAddress`(strukturerat) |
| Postadress | `postalAddress`(fritext) | `hsaPostalAddress`(strukturerat) |

Schema 5.3 (vår baslinje) har stöd för **båda formerna**. Övergångsperioden slutar **september 2026**, varefter de äldre attributen kan tas bort ur schemat.

-------

## FHIR-mappning

### Normativ form (strukturerade komponenter)

```
hsaVisitingAddress → Location.address (type = physical)
  .line       ← gatuadress + eventuell tilläggsinformation
  .city       ← ort/lokalitet (obligatorisk)
  .postalCode ← 0..0 (besöksadress ska aldrig ha postnummer)

hsaPostalAddress → Organization.contact.address (type = postal)
  .line       ← postbox, c/o, gatuadress
  .city       ← ort
  .postalCode ← postnummer (obligatoriskt för postadress)

```

### Övergångsform (legacy → Address.text)

Under övergångsperioden mappas fritext-attributen till `Address.text`:

```
streetAddress (fritext) → Location.address.text
postalAddress (fritext) → Organization.contact.address.text

```

**Konsumenter ska aldrig förutsätta att `.text` är satt** och aldrig förutsätta att strukturerade komponenter saknas. Robusta implementationer hanterar båda fallen.

-------

## Konsumentrekommendation

Föredragsordning för adressläsning:

1. Läs strukturerade komponenter (`.line`,`.city`,`.postalCode`) om de finns.
1. Fall tillbaka på`.text`om komponenterna saknas.
1. Varna i applikationsloggen om varken komponenter eller`.text`finns.

-------

## Uppsala-regeln (besöksadress utan postnummer)

Profilen begränsar `Location.address.postalCode` till `0..0`. Postnummer tillhör postadressen på `Organization`, inte besöksadressen. Skälen:

* Besöksadressens postnummer matchar sällan postutdelningsadressen.
* GPS-system och kartapplikationer använder gatuadress + stad för geokodning, inte postnummer.
* Postservicens postnummer-till-adress-databas är optimerad för postutdelning, inte besöksnavigering.

-------

## Producenter: migrationsplan

Producenter (HSA-administratörer) bör senast **2026-09-01**:

1. Fylla i`hsaVisitingAddress`och`hsaPostalAddress`med strukturerade komponenter.
1. Verifiera att gamla fritext-attribut inte innehåller information som saknas i strukturerade attribut.
1. Säkerställa att postnummer inte ingår i besöksadressobjektet.

HSA-IG:ns validator rapporterar varning om `Address.text` är satt men strukturerade komponenter saknas, efter att övergångsperioden avslutats.

