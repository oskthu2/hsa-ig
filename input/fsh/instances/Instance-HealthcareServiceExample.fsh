// ─── Exempelinstans: HealthcareService ───────────────────────────────────────
// Visar HsaHealthcareService med verksamhetskod, vård-/omsorgsform,
// öppettider (availability) och koppling till vårdenhet och plats.

Instance: HealthcareServiceExample
InstanceOf: HsaHealthcareService
Usage: #example
Title: "Allmänmedicin – Exempelmottagningen"
Description: "Exempel på en HealthcareService med allmänläkarmottagning, öppettider och publik synlighet."

* id = "healthcareservice-example"

* active = true

* providedBy = Reference(VardenhetExample)

* location[0] = Reference(LocationExample)

// Verksamhetskod på category (Allmänmedicin, kod 1501)
* category[verksamhetskod]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.3"
    * code = #1501
    * display = "Allmänmedicin"

// Vård- och omsorgsform: Öppenvård (1 i HSA kodverk 1.2.752.129.2.2.1.13)
* type[care-type]
  * coding[0]
    * system = "urn:oid:1.2.752.129.2.2.1.13"
    * code = #1
    * display = "Öppenvård"

* name = "Allmänläkarmottagning"

* comment = "Vi erbjuder allmänläkarvård för listade patienter. Besök via bokning."

// Kontaktväg för tjänsten
* contact[0]
  * telecom[0]
    * system = #phone
    * value = "+46812345679"
    * use = #work

// Öppettider (availability i R5)
* availability[0]
  * availableTime[0]
    // Måndag–fredag 08:00–17:00
    * daysOfWeek[0] = #mon
    * daysOfWeek[+] = #tue
    * daysOfWeek[+] = #wed
    * daysOfWeek[+] = #thu
    * daysOfWeek[+] = #fri
    * allDay = false
    * availableStartTime = "08:00:00"
    * availableEndTime = "17:00:00"

* extension[destinationIndicator]
  * valueCoding
    * system = "urn:oid:1.2.752.29.23.1.11"
    * code = #03
    * display = "Internet/allmänheten"
