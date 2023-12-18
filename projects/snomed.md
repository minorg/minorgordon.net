---
layout: page
---

<h4 style="text-align: center">Transforming SNOMED CT into SKOS and SHACL</h4>
<h6 style="text-align: center">In collaboration with Ralph Hodgson</h6>

<br/>

<!-- 4-sentence Kent Beck abstract -->
[SNOMED CT's](https://www.snomed.org/) low-level data format presents a significant barrier to its adoption among the graph database community. We have developed a system to transform [SNOMED CT Release Format 2 (RF2)](https://confluence.ihtsdotools.org/display/DOCRELFMT/SNOMED+CT+Release+File+Specifications) data into [SKOS](https://www.w3.org/2004/02/skos/) and [SHACL](https://www.w3.org/TR/shacl/) for use in W3C standards-compliant tools such as [GraphDB](https://graphdb.ontotext.com/), [Stardog](https://www.stardog.com/), and [TopBraid EDG](https://www.topquadrant.com/). In contrast to the canonical [OWL](https://www.w3.org/OWL/) representation of SNOMED CT, our system produces far more instances than classes. The resulting [RDF](https://www.w3.org/RDF/) is more tractable to validate and easier to present users.

<br/>

##### Introduction

<!-- <figure class="my-4" style="text-align: center">
<img src="/assets/images/projects/searchsci/searchsci-landing.png" style="max-width: 100%" />
<figcaption class="mt-2" style="font-size: small">SearchSci landing page</figcaption>
</figure> -->

<!-- Hodgson, R.; Polikoff, I. SNOMED-CT Expo 2020—SNOMED-CT-SHAPES: A Simpler Approach to Working with SNOMED in RDF. 2020. Available online: https://www.youtube.com/watch?v=mrlNn3oYH3k (accessed on 2 June 2023). -->
