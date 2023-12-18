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


<!-- Hodgson, R.; Polikoff, I. SNOMED-CT Expo 2020—SNOMED-CT-SHAPES: A Simpler Approach to Working with SNOMED in RDF. 2020. Available online: https://www.youtube.com/watch?v=mrlNn3oYH3k (accessed on 2 June 2023). -->

SNOMED Clinical Terminology (SNOMED CT) is a comprehensive, multilingual clinical healthcare terminology maintained by SNOMED International, an international non-profit organization. SNOMED CT is widely used in electronic health records (EHRs) for consistent representation of clinical content.

Recently there has been increasing demand for SNOMED CT in other contexts, such as [data governance](https://en.wikipedia.org/wiki/Data_governance). A number of these applications are underpinned by graph database technology, which is not directly compatible with the tabular format of SNOMED CT releases.

The Resource Description Framework (RDF) is a W3C-standard model for data interchange, based on a graph data model. The Shapes Constraint Language (SHACL) is used to validate RDF and provide hints to user interface tools on how to render RDF data. RDF and SHACL are foundational technologies for many graph-based systems, such as the TopBraid EDG data governance platform.

In order for these systems to work with SNOMED CT, the terminology must be transformed from its bespoke tabular format into RDF and SHACL. The Simple Knowledge Organization System (SKOS) provides a standard way to represent knowledge organization systems such as SNOMED CT in RDF.

We have developed an automatic process for transforming SNOMED CT releases into RDF and SHACL for downstream consumption by tools such as TopBraid EDG. In the following sections we will give a brief overview of the SNOMED CT data model, identify some of the challenges in transforming SNOMED CT into RDF and SHACL, and describe our transformation process in detail.

##### SNOMED CT

SNOMED CT content is represented by three types of [*components*](https://confluence.ihtsdotools.org/display/DOCSTART/4.+SNOMED+CT+Basics):

* *Concepts* that represent clinical meaning, are uniquely identified by number (the *SCTID*), and organized into a polyhierarchy
* *Descriptions* that link concepts to appropriate human-readable terms
* *Relationships* that link a concept to other related concepts

The figure below shows a representative SNOMED concept we will use for demonstration purposes. The same concept can be viewed in the [official SNOMED CT browser](https://browser.ihtsdotools.org/?perspective=full&conceptId1=53627009&edition=MAIN/2023-12-01&release=&languages=en).

<figure class="my-4" style="text-align: center">
<img src="/assets/images/projects/snomed-ct/snomed-ct-53627009.svg" style="max-width: 100%" />
<figcaption class="mt-2" style="font-size: small">SNOMED CT concept 53627009: Closed fracture of radius AND ulna (disorder)</figcaption>
</figure>

Concept 53627009 is described by the English-language term Closed fracture of radius AND ulna (disorder)". The "(disorder)" suffix in the description is a [semantic tag](https://confluence.ihtsdotools.org/display/DOCEG/Semantic+Tag) indicating the domain to which the concept belongs.

Concept 53627009 is part of a hierarchy of other concepts linked by is-a (child->parent) relationships, indicated by blue arrows in the figure. A concept may also have *attribute* relationships (shown as red arrows) with other concepts or scalars as values. In the example, "Closed fracture of radius AND ulna (disorder)" has a "Finding site" attribute of "Bone structure of radius (body structure)", corresponding to concept 62413002. 

Concept-attribute relationships are further organized into *relationship groups*, which indexed per-concept from 0. The attribute relationship groups for concept 53627009 are shown in the figure as dotted boxes and in the official SNOMED CT browser as nested boxes.

Relationship types such as is-a and "Finding site" are considered concepts themselves, with their own hierarchy. For example, all attribute relationship types descend from the same root concept. This allows relationship types to reuse the same machinery afforded to other concepts, such as multilingual descriptions.

##### The transformation process

Conceptually the relationships outlined in the preceding section can be represented as triples:

```
(Closed fracture of radius AND ulna (disorder), is-a, Fracture of radius AND ulna (disorder))
(Closed fracture of radius AND ulna (disorder), Finding site, Bone structure of radius (body structure))
```

which naturally correspond to `(subject, predicate, object)` triples in the RDF graph data model. At a high level, transforming SNOMED CT to RDF is the process of transforming between two physical models, the SNOMED CT release format and an RDF encoding such as [Turtle](https://www.w3.org/TR/turtle/), that both correspond to a graph conceptual model.

