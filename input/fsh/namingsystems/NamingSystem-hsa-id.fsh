Instance: hsa-identity
InstanceOf: NamingSystem
Usage: #definition
* name = "HsaIdentity"
* title = "HSA-identitet (HSA-id)"
* status = #active
* kind = #identifier
* date = "2026-05-20"
* publisher = "Inera AB / HSA-förvaltning"
* description = """
  Unik identifierare för organisationer, enheter, funktioner, uppdrag och
  personer i HSA-katalogen. Tilldelas automatiskt av HSA-systemet vid skapande
  och ska aldrig ändras. Används som stabil nyckel i nationella e-tjänster
  (NPÖ, Pascal, 1177 Hitta vård m.fl.).
"""
* jurisdiction = urn:iso:std:iso:3166#SE
* uniqueId[+]
  * type = #oid
  * value = "1.2.752.29.4.19"
  * preferred = true
* uniqueId[+]
  * type = #uri
  * value = "urn:oid:1.2.752.29.4.19"

Instance: organisation-nummer
InstanceOf: NamingSystem
Usage: #definition
* name = "OrganisationsnummerSE"
* title = "Organisationsnummer (Sverige)"
* status = #active
* kind = #identifier
* date = "2026-05-20"
* publisher = "Skatteverket / Bolagsverket"
* description = """
  Unikt nummer för juridiska personer i Sverige, tilldelat av Skatteverket
  eller Bolagsverket. Obligatoriskt för organisationer som representerar
  vårdgivare (hsaHealthCareProvider).
"""
* jurisdiction = urn:iso:std:iso:3166#SE
* uniqueId[+]
  * type = #oid
  * value = "2.5.4.97"
  * preferred = true
* uniqueId[+]
  * type = #uri
  * value = "urn:oid:2.5.4.97"
