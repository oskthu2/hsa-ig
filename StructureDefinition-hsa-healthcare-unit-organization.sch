<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <!-- 
    This file contains just the constraints for the profile HsaCatalogOrganization
    It includes the base constraints for the resource as well.
    Because of the way that schematrons and containment work, 
    you may need to use this schematron fragment to build a, 
    single schematron that validates contained resources (if you have any) 
  -->
  <sch:pattern>
    <sch:title>f:Organization</sch:title>
    <sch:rule context="f:Organization">
      <sch:assert test="count(f:extension[@url = 'http://hl7.org/fhir/StructureDefinition/organization-period']) &lt;= 1">extension with URL = 'http://hl7.org/fhir/StructureDefinition/organization-period': maximum cardinality of 'extension' is 1</sch:assert>
      <sch:assert test="count(f:extension[@url = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice']) &lt;= 1">extension with URL = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-temporary-notice': maximum cardinality of 'extension' is 1</sch:assert>
      <sch:assert test="count(f:extension[@url = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info']) &lt;= 1">extension with URL = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-patient-info': maximum cardinality of 'extension' is 1</sch:assert>
      <sch:assert test="count(f:partOf) &gt;= 1">partOf: minimum cardinality of 'partOf' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>f:Organization/f:contact/f:telecom</sch:title>
    <sch:rule context="f:Organization/f:contact/f:telecom">
      <sch:assert test="count(f:extension[@url = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type']) &lt;= 1">extension with URL = 'https://hsa.inera.se/fhir/StructureDefinition/hsa-telecom-type': maximum cardinality of 'extension' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
