# HSA Kontaktvägstyp - HSA Katalog Implementation Guide v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **HSA Kontaktvägstyp**

## CodeSystem: HSA Kontaktvägstyp 

| | |
| :--- | :--- |
| *Official URL*:https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type | *Version*:0.1.0 |
| Active as of 2026-05-20 | *Computable Name*:HsaTelecomType |

 
Klassificering av kontaktvägar (telecom) i HSA för att skilja på direkttelefon, växeltelefon, e-post, m.fl. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [HSA Kontaktvägstyp](ValueSet-hsa-telecom-type-vs.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "hsa-telecom-type",
  "url" : "https://hsa.inera.se/fhir/CodeSystem/hsa-telecom-type",
  "version" : "0.1.0",
  "name" : "HsaTelecomType",
  "title" : "HSA Kontaktvägstyp",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-05-20",
  "publisher" : "Inera AB / HSA-IG projekt",
  "contact" : [{
    "name" : "Inera AB / HSA-IG projekt",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.inera.se/"
    }]
  }],
  "description" : "Klassificering av kontaktvägar (telecom) i HSA för att skilja på\ndirekttelefon, växeltelefon, e-post, m.fl.",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "SE",
      "display" : "Sweden"
    }]
  }],
  "caseSensitive" : true,
  "content" : "complete",
  "count" : 6,
  "concept" : [{
    "code" : "direct-phone",
    "display" : "Direkttelefon",
    "definition" : "Direkt telefonnummer till enheten (telephoneNumber)."
  },
  {
    "code" : "switchboard",
    "display" : "Växeltelefon",
    "definition" : "Växeltelefonnummer (obligatoriskt för offentliga enheter)."
  },
  {
    "code" : "public-phone",
    "display" : "Publik telefon",
    "definition" : "Telefonnummer avsett för allmänheten (hsaPublicTelephone)."
  },
  {
    "code" : "fax",
    "display" : "Telefax",
    "definition" : "Faxnummer."
  },
  {
    "code" : "email",
    "display" : "E-post",
    "definition" : "E-postadress (mail/rfc822Mailbox)."
  },
  {
    "code" : "directory-contact",
    "display" : "Innehållsansvarig e-post",
    "definition" : "Funktionsbrevlåda för innehållsfrågor (hsaDirectoryContact)."
  }]
}

```
