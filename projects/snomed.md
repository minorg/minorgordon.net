---
layout: page
---

<h4 style="text-align: center">Transforming SNOMED CT into SKOS and SHACL</h4>
<h6 style="text-align: center">In collaboration with Ralph Hodgson</h6>

<br/>

<!-- 4-sentence Kent Beck abstract -->
[SNOMED CT's](https://www.snomed.org/) low-level data format presents a significant barrier to its adoption among the graph database community. We have developed a system to transform [SNOMED CT Release Format 2 (RF2)](https://confluence.ihtsdotools.org/display/DOCRELFMT/SNOMED+CT+Release+File+Specifications) data into [SKOS](https://www.w3.org/2004/02/skos/) and [SHACL](https://www.w3.org/TR/shacl/) for use in [W3C](https://w3.org/) standards-compliant tools such as [GraphDB](https://graphdb.ontotext.com/), [Stardog](https://www.stardog.com/), and [TopBraid EDG](https://www.topquadrant.com/). In contrast to the canonical [OWL](https://www.w3.org/OWL/) representation of SNOMED CT, our system produces far more instances than classes. The resulting [RDF](https://www.w3.org/RDF/) is more tractable to validate and easier to present users.

<br/>

##### Introduction

<!-- <figure class="my-4" style="text-align: center">
<img src="/assets/images/projects/searchsci/searchsci-landing.png" style="max-width: 100%" />
<figcaption class="mt-2" style="font-size: small">SearchSci landing page</figcaption>
</figure> -->

<!-- Hodgson, R.; Polikoff, I. SNOMED-CT Expo 2020—SNOMED-CT-SHAPES: A Simpler Approach to Working with SNOMED in RDF. 2020. Available online: https://www.youtube.com/watch?v=mrlNn3oYH3k (accessed on 2 June 2023). -->

SNOMED Clinical Terminology (SNOMED CT) is a comprehensive, multilingual clinical healthcare terminology maintained by SNOMED International, an international non-profit organization. SNOMED CT is widely used in electronic health records (EHRs) for consistent representation of clinical content.

Recently there has been increasing demand for SNOMED CT in other contexts, such as [data governance](https://en.wikipedia.org/wiki/Data_governance). A number of these applications are underpinned by graph database technology, which is not directly compatible with the tabular format of SNOMED CT releases.

The Resource Description Framework (RDF) is a W3C-standard model for data interchange, based on a graph data model. The Shapes Constraint Language (SHACL) is used to validate RDF and provide hints to user interface tools on how to render RDF data. RDF and SHACL are foundational technologies for many graph-based systems, such as the TopBraid EDG data governance platform.

In order for these systems to work with SNOMED CT, the terminology must be transformed from its bespoke tabular format into RDF and SHACL. The Simple Knowledge Organization System (SKOS) provides a standard way to represent knowledge organization systems such as SNOMED CT in RDF.

We have developed an automatic process for transforming SNOMED CT releases into RDF and SHACL for downstream consumption by tools such as TopBraid EDG. In the following sections we will give a brief overview of the SNOMED CT data model, identify some of the challenges in transforming SNOMED CT into RDF and SHACL, and describe our transformation process in detail.

##### SNOMED CT
