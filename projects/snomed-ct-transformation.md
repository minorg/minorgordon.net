---
layout: page
---

<h4 style="text-align: center">Transforming SNOMED CT into SKOS and SHACL</h4>
<h6 style="text-align: center">Minor Gordon and Ralph Hodgson</h6>

<br/>

<!-- 4-sentence Kent Beck abstract -->
[SNOMED CT's](https://www.snomed.org/) low-level [Release Format 2 (RF2)](https://confluence.ihtsdotools.org/display/DOCRELFMT/SNOMED+CT+Release+File+Specifications) presents a significant barrier to SNOMED CT adoption in systems based on graph data models. We have developed software to automatically transform RF2 data into [SKOS](https://www.w3.org/2004/02/skos/) and [SHACL](https://www.w3.org/TR/shacl/) for use in [W3C](https://w3.org/) standards-compliant tools such as [GraphDB](https://graphdb.ontotext.com/), [Stardog](https://www.stardog.com/), and [TopBraid EDG](https://www.topquadrant.com/). In contrast to the canonical [OWL](https://www.w3.org/OWL/) representation of SNOMED CT, our software produces relatively few classes and many instances. The resulting idiomatic [RDF](https://www.w3.org/RDF/) is easy to validate and lends itself to presentation as a taxonomy.

<br/>

##### Introduction


<!-- Hodgson, R.; Polikoff, I. SNOMED-CT Expo 2020—SNOMED-CT-SHAPES: A Simpler Approach to Working with SNOMED in RDF. 2020. Available online: https://www.youtube.com/watch?v=mrlNn3oYH3k (accessed on 2 June 2023). -->

SNOMED Clinical Terminology (SNOMED CT) is a comprehensive, multilingual clinical healthcare terminology maintained by [SNOMED International](https://www.snomed.org/), a non-profit organization. SNOMED CT is widely used in electronic health records (EHRs) for consistent representation of clinical content.

Recently there has been increasing demand for SNOMED CT in other contexts, such as [data governance](https://en.wikipedia.org/wiki/Data_governance). A number of these applications are underpinned by graph database technology, which is not directly compatible with the tabular format of SNOMED CT releases.

The Resource Description Framework (RDF) is a W3C-standard model for data interchange. The Shapes Constraint Language (SHACL) is used to validate RDF and provide hints to user interface tools on how to render RDF data. RDF and SHACL are foundational technologies for many graph-based systems.

In order for these systems to work with SNOMED CT, the terminology must be transformed from its bespoke tabular format into RDF and SHACL. The Simple Knowledge Organization System (SKOS) provides a standard way to represent knowledge organization systems such as SNOMED CT in RDF.

We have developed an automatic process for transforming SNOMED CT releases into SKOS and SHACL for downstream consumption by W3C standards-compatible tools. In the following sections we will give a brief overview of the SNOMED CT data model, identify some of the challenges in transforming SNOMED CT into RDF and SHACL, and describe our transformation process in detail.

<br/>

##### SNOMED CT

SNOMED CT content is represented by three types of [*components*](https://confluence.ihtsdotools.org/display/DOCSTART/4.+SNOMED+CT+Basics):

* *Concepts* that represent clinical meaning, are uniquely identified by number (the *SCTID*), and organized into a polyhierarchy
* *Descriptions* that link concepts to appropriate human-readable terms
* *Relationships* that link a concept to related concepts

The figure below shows a representative SNOMED concept we will use for demonstration purposes. The same concept can be viewed in the [official SNOMED CT browser](https://browser.ihtsdotools.org/?perspective=full&conceptId1=53627009&edition=MAIN/2023-12-01&release=&languages=en).

<figure class="my-4" style="text-align: center">
<img src="/img/projects/snomed-ct-transformation/snomed-ct-53627009.svg" style="max-width: 100%" />
<figcaption class="mt-2" style="font-size: small">SNOMED CT concept 53627009: Closed fracture of radius AND ulna (disorder)</figcaption>
</figure>

Concept 53627009 is described by the English-language term "Closed fracture of radius AND ulna (disorder)". The "(disorder)" suffix in the description is a [semantic tag](https://confluence.ihtsdotools.org/display/DOCEG/Semantic+Tag) indicating the domain to which the concept belongs.

Concept 53627009 is part of a polyhierarchy of concepts linked by is-a (child -> parent) relationships, indicated by blue arrows in the figure. A concept may also have *attribute* relationships (shown as red arrows) with other concepts or scalars as values. In the example, "Closed fracture of radius AND ulna (disorder)" has a "Finding site" attribute of "Bone structure of radius (body structure)", corresponding to concept 62413002. 

Concept-attribute relationships are further organized into *relationship groups*, indexed per-concept from 0. The attribute relationship groups for concept 53627009 are shown in the figure as dotted boxes and in the official SNOMED CT browser as nested boxes.

Relationship types such as "is-a" and "Finding site" are considered concepts themselves, with their own polyhierarchy. For example, all attribute relationship types descend from the same root attribute concept. This allows relationship types to reuse the same machinery afforded to other concepts, such as multilingual descriptions.

<br/>

##### The transformation process

Conceptually, the relationships outlined in the preceding section can be represented as triples such as:

```
("Closed fracture of radius AND ulna (disorder)", "is-a", "Fracture of radius AND ulna (disorder)")
```

and

```
("Closed fracture of radius AND ulna (disorder)", "Finding site", "Bone structure of radius (body structure)")
```

These triples intuitively correspond to `(subject, predicate, object)` triples in the RDF graph data model. Transforming SNOMED CT to RDF is the process of transforming between two physical models, the SNOMED CT release format and an RDF encoding such as [Turtle](https://www.w3.org/TR/turtle/), that both correspond to a graph logical model.

The figure below illustrates the transformation process, with subsequent sections describing the steps in detail.

<figure class="my-4" style="text-align: center">
<img src="/img/projects/snomed-ct-transformation/snomed-ct-transformation-process.svg" style="max-width: 100%" />
<figcaption class="mt-2" style="font-size: small">SNOMED CT transformation process</figcaption>
</figure>

###### Step 1: mapping SNOMED CT release files to Python data structures

Tab-separated value (TSV) files are extracted from a SNOMED CT release .zip. For example, the row corresponding to concept 53627009 is:

```tsv
id	effectiveTime	active	moduleId	definitionStatusId
53627009	20020131	1	900000000000207008	900000000000073002
```

The rows in different files are mapped directly to low-level data structures in Python, like the following `Rf2Concept` [Pydantic](https://pydantic.dev/) model corresponding to a row in the RF2 concepts TSV file:

```py
from pydantic import BaseModel, Field


class Rf2Concept(BaseModel):
    """
    Model of rows in the RF2 Concept file.
    https://confluence.ihtsdotools.org/display/DOCRELFMT/4.2.1+Concept+File+Specification?src=sidebar
    """

    active: int
    effectiveTime: int
    definitionStatusId: int
    id: int = Field(..., ge=1)
    moduleId: int
```

<br/>

###### Step 2: indexing low-level data structures into compact index data structures

`Rf2Concept`, `Rf2Description`, and other row-level Pydantic models from the previous step are transformed into index data structures, like the one shown below. The index data structures are persisted to files in order to reuse them when the input RF2 files haven't changed.

```py
@dataclass(frozen=True)
class IndexedRelationship:
    """
    Metadata about an indexed relationship.

    The fields have the same semantics as the source RF2 fields.
    """

    characteristic_type_id: int
    effective_time: int
    relationship_group: int
```

<br/>

###### Step 3: starting from a leaf concept, recursively and lazily transform concepts to Python rdflib Graphs: one graph for SKOS instances, one for SHACL shapes.

The main transformation logic works concept-by-concept, using high-level interfaces over the indices built in the previous step to navigate the SNOMED CT polyhierarchy. For example, the children of a concept can be obtained from an index of SNOMED CT relationships in `(object, predicate, subject)` order in the abridged snippet below:

```py
class LogicalConcept:
    """
    High-level logical representation of a SNOMED CT concept.

    Concepts represent both "nouns" (e.g., a specific disease) and relationships (e.g., has-a or is-a).
    """

    @property
    def child_ids(self) -> frozenset[int]:
        """
        Descend the concept tree one level get all of the child id's of this concept.
        """

        return self.__child_ids(self.id)

    def __child_ids(self, parent_id: int) -> frozenset[int]:
        """
        The id's of any immediate children of the parent_id.
        """

        return frozenset(
            concept_id
            for concept_id in self.__model.indices.relationships_o_p_s.get(  # type: ignore
                parent_id, {}
            ).get(
                self.__IS_A_ID, []
            )
        )
```

The transformation logic determines how a SNOMED CT concept should be transformed to RDF triples. The latter process is delegated to more specific [builder](https://en.wikipedia.org/wiki/Builder_pattern) classes, which add triples to an [rdflib](https://rdflib.readthedocs.io/) `Graph`.

The table below summarizes the mappings:

<table class="table table-bordered">
    <thead>
        <tr>
            <th>SNOMED Source</th>
            <th>RDF Target(s)</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Concept at depth 0 (root) or 1 in the polyhierarchy</td>
            <td><a href="https://www.w3.org/TR/rdf-schema/">RDF Schema</a> <code>Class</code>, SHACL <code>NodeShape</code></td>
        </tr>
        <tr>
            <td>Concept corresponding to a semantic tag (e.g., <a href="https://browser.ihtsdotools.org/?perspective=full&conceptId1=64572001&edition=MAIN/2023-12-01&release=&languages=en">Disease (disorder) 64572001</a>)</td>
            <td>RDF Schema <code>Class</code>, SHACL <code>NodeShape</code></td>
        </tr>
        <tr>
            <td>Concept corresponding to an attribute relationship type</td>
            <td>RDF Schema <code>Property</code>, SHACL <code>PropertyShape</code></td>
        </tr>
        <tr>
            <td>Concept not corresponding to an attribute relationship type</td>
            <td>SKOS <code>Concept</code></td>
        </tr>
        <tr>
            <td>Attribute relationship group</td>
            <td>Bespoke instance resource, SHACL <code>NodeShape</code></td>
        </tr>
    </tbody>
</table>

A single SNOMED CT concept may have multiple mappings into RDF. For example, the root concept is mapped to an RDF Schema `Class`, a SHACL `NodeShape`, and a SKOS `Concept`. Schema and instance subjects have different IRIs, so that the RDF Schema `Class` corresponding to the SNOMED CT root concept has a different IRI than the SKOS `Concept` mapped from the same.

SNOMED CT descriptions (human-readable terms) of a concept are mapped to RDF Schema `label`, SKOS `prefLabel`, SKOS `altLabel`, or SHACL `name` statements depending on the type of the description (definition, name, synonym), its acceptability (acceptable, preferred, unacceptable), and the mapping(s) of the concept from the table above.

Transforming attribute relationship groups presents a challenge. In principle, any SNOMED CT concept can have any number of attributes, arbitrarily grouped. Mapping every concept-relationship group combination to a SHACL `NodeShape` leads to a combinatorial explosion, and few SHACL processors are prepared to deal with hundreds of thousands of `NodeShape`s. Fortunately, many relationship groups have the same attribute (types), so there can be fewer relationship group `NodeShape`s than there are relationship group instances.

<br/>

###### Step 4: serialize the rdflib Graphs to files in Turtle syntax.

Finally, the resulting RDF triples are serialized to two different files:

1. A schemas file that contains RDF Schema `Class`es and `Property`s as well as SHACL shapes
2. An instances file that contains SKOS `Concept`s and associated relationship group triples

Although both files contain RDF in Turtle syntax, and could be combined, most downstream tools expect RDF schemas/ontologies to be loaded separately from instance data.

<br/>

##### Results

Using the process outlined above, we transformed the June 30th, 2023 SNOMED CT International release into SKOS and SHACL. We validated the generated SKOS with the generated SHACL using the [pySHACL](https://github.com/RDFLib/pySHACL) library. The transformation produced 8750658 RDF triples spread across multiple RDF resource types. The following sections show examples of the different resource types along with the counts of each type in the final dataset.

###### SNOMED CT concept -> SKOS `Concept` instance

Count: `361018`

Example:

```turtle
snomed-ct:INSTANCE_53627009 a snomed-cts:CLASS_138875005,
        snomed-cts:CLASS_404684003,
        snomed-cts:CLASS_64572001 ;
    snomed-cts:normativeReference "http://snomed.info/id/53627009"^^xsd:anyURI ;
    snomed-cts:relationshipGroup snomed-ct:RELATIONSHIP_GROUP_53627009_1,
        snomed-ct:RELATIONSHIP_GROUP_53627009_2 ;
    snomed-cts:sctid "53627009"^^xsd:string ;
    vaem:effectiveStartDate "2002-01-31"^^xsd:date ;
    skos:altLabel "Closed fracture of radius AND ulna"@en,
        "Closed fracture of the radius and ulna"@en ;
    skos:broader snomed-ct:INSTANCE_111640008,
        snomed-ct:INSTANCE_71555008,
        snomed-ct:INSTANCE_75857000 ;
    skos:prefLabel "Closed fracture of radius AND ulna (disorder)"@en .
```

<br/>

###### Per-SNOMED CT concept, per-relationship group instance

Count: `371975`

Example:

```turtle
snomed-ct:RELATIONSHIP_GROUP_53627009_1 a snomed-cts:NODE_SHAPE_RELATIONSHIP_GROUP_WITH_ATTRIBUTES_116676008_363698007 ;
    rdfs:label "53627009 Relationship Group 1"@en ;
    snomed-cts:PROPERTY_116676008 snomed-ct:INSTANCE_20946005 ;
    snomed-cts:PROPERTY_363698007 snomed-ct:INSTANCE_62413002 .
```

<br/>

###### SNOMED CT concept -> RDF Schema `Class`

Count: `60`

Example:

```turtle
snomed-cts:CLASS_64572001 a rdfs:Class ;
    rdfs:label "Disease (disorder)"@en ;
    snomed-cts:normativeReference "http://snomed.info/id/64572001"^^xsd:anyURI ;
    vaem:effectiveStartDate "2002-01-31"^^xsd:date ;
    rdfs:subClassOf snomed-cts:CLASS_404684003 .
```

<br/>

###### Reusable relationship group SHACL `NodeShape`

Count: `630`

Example:

```turtle
snomed-cts:NODE_SHAPE_RELATIONSHIP_GROUP_WITH_ATTRIBUTES_116676008_363698007 a rdfs:Class,
        sh:NodeShape ;
    rdfs:subClassOf snomed-cts:NODE_SHAPE_RELATIONSHIP_GROUP ;
    sh:property snomed-cts:PROPERTY_SHAPE_ATTRIBUTE_116676008,
        snomed-cts:PROPERTY_SHAPE_ATTRIBUTE_363698007 .
```

<br/>

###### Attribute RDF Schema `Property`

Count: `107`

Example:

```turtle
snomed-cts:PROPERTY_116676008 a rdf:Property ;
    rdfs:label "Associated morphology (attribute)"@en ;
    snomed-cts:normativeReference "http://snomed.info/id/116676008"^^xsd:anyURI ;
    vaem:effectiveStartDate "2011-01-31"^^xsd:date ;
    rdfs:subPropertyOf snomed-cts:PROPERTY_762705008 .
```

<br/>

###### Attribute SHACL `PropertyShape`

Count: `107`

Example:

```turtle
snomed-cts:PROPERTY_SHAPE_ATTRIBUTE_116676008 a sh:PropertyShape ;
    snomed-cts:normativeReference "http://snomed.info/id/116676008"^^xsd:anyURI ;
    vaem:effectiveStartDate "2011-01-31"^^xsd:date ;
    sh:class snomed-cts:CLASS_138875005 ;
    sh:name "Associated morphology (attribute)"@en ;
    sh:path snomed-cts:PROPERTY_116676008 .
```

<br/>

##### Conclusion and future work

We have developed a system to automatically transform SNOMED CT RF2 data into idiomatic SKOS and SHACL for use in graph-based applications. The process minimizes the processing burden on downstream tools while accounting for nuances in the SNOMED CT data model such as relationship groups and semantic tags.

The designs of the transformation process and the RDF it produces emerged incrementally as we experimented with different alternatives. Python was an excellent tool for that experimentation, but has relatively high runtime performance overhead. Even with a few obvious optimizations, such as reusing indices, the code needs over 10 minutes to produce RDF graphs in memory and serialize them to files on a standard laptop. Now that we've settled on a design, we intend to port the code to a more performant language such as Scala in order to speed up the transformation process.

Our initial efforts focused on the core components of SNOMED CT: concepts, descriptions, and relationships. In the future we would incorporate other parts of the source data, such as text definitions, multilingual descriptions, and cardinality constraints. 

Finally, we plan to refine the SHACL shapes we produce by e.g., adding `sh:closed` statements, composing relationship group shapes with common subsets of attributes, and adding [DASH Data Shapes Vocabulary](https://datashapes.org/dash) statements in order to give hints to downstream tools about how to render the SNOMED CT polyhierarchy.
