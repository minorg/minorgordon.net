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

which naturally correspond to `(subject, predicate, object)` triples in the RDF graph data model. At a high level, transforming SNOMED CT to RDF is the process of transforming between two physical models, the SNOMED CT release format and an RDF encoding such as [Turtle](https://www.w3.org/TR/turtle/), that both correspond to a graph logical model.

The figure below illustrates the transformation process.

<figure class="my-4" style="text-align: center">
<img src="/assets/images/projects/snomed-ct/snomed-ct-transformation-process.svg" style="max-width: 100%" />
<figcaption class="mt-2" style="font-size: small">SNOMED CT transformation process</figcaption>
</figure>

###### Step 1: mapping SNOMED CT release files to Python data structures

Tab-separated value (TSV) files are extracted from a SNOMED CT release .zip. The rows in different files are mapped directly to low-level data structures in Python, like the following `Rf2Concept` [Pydantic](https://pydantic.dev/) model corresponding to a row in the RF2 concepts file:

```py
from pydantic import Field

from shared_snomed_ct.models._base_model import _BaseModel


class _Rf2BaseModel(_BaseModel):
    """
    Model of fields shared by all RF2 concrete models.
    """

    active: int = Field(
        ...,
        description="""\
The state of the identified model as at the specified effectiveTime .

If active = 1 (true) the model is part of the current version of the set, if active = 0 (false) the model is not part of the current version of the set.""",
    )

    effectiveTime: int = Field(
        ...,
        description="""\
The inclusive date or time at which this version of the identified model  became the current version.

Note: In distribution files the effectiveTime should follow the short ISO date format (YYYYMMDD) and should not include the hours, minutes, seconds or timezone indicator.""",
    )

    moduleId: int = Field(
        ...,
        description="""\
Identifies the SNOMED CT module that contains this reference set member as at the specified effectiveTime .

The value must be a subtype of 900000000000443000 | Module (core metadata concept)| within the metadata hierarchy.""",
    )


class _Rf2Component(_Rf2BaseModel):
    """
    Model of fields shared by all RF2 components (concepts, descriptions, et al.)
    """

    id: int = Field(..., ge=1)  # noqa: A003


class Rf2Concept(_Rf2Component):
    """
    Model of rows in the RF2 Concept file.
    https://confluence.ihtsdotools.org/display/DOCRELFMT/4.2.1+Concept+File+Specification?src=sidebar
    """

    definitionStatusId: int = Field(
        ...,
        description="""\
Specifies if the concept version is primitive or defined. Set to a descendant of 900000000000444006 | Definition status| in the metadata hierarchy.""",
    )
```

###### Step 2: indexing low-level data structures into compact index data structures

`Rf2Concept` and other `dataclass` instances from the previous step are mapped to index data structures in memory as needed. The index data structures are persisted to files in order to reuse them when the input RF2 files haven't changed.

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

###### Step 3: starting from a leaf concept, recursively and lazily transform concepts to Python rdflib Graphs: one graph for SKOS instances, one for SHACL shapes.

High-level interfaces  use the indices from the previous step to navigate the SNOMED CT polyhierarchy. For example, the children of a concept can be obtained from an index of SNOMED CT relationships in `(object, predicate, subject)` order in the abridged snippet below:

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

The main transformation logic works concept-by-concept. It uses high-level interfaces like the one above to determine how a SNOMED CT concept should be transformed to RDF triples. The latter process is delegated to more specific [builder](https://en.wikipedia.org/wiki/Builder_pattern) classes, which add triples to an rdflib `Graph`.

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
            <td>The root concept</td>
            <td><a href="https://www.w3.org/TR/rdf-schema/">RDF Schema</a> <code>Class</code>, SHACL <code>NodeShape</code></td>
        </tr>
        <tr>
            <td>Concepts at depth 1</td>
            <td>RDF Schema <code>Class</code>, SHACL <code>NodeShape</code></td>
        </tr>
        <tr>
            <td>Concepts that correspond to semantic tags (e.g., <a href="https://browser.ihtsdotools.org/?perspective=full&conceptId1=64572001&edition=MAIN/2023-12-01&release=&languages=en">Disease (disorder) 64572001</a></td>
            <td>RDF Schema <code>Class</code>, SHACL <code>NodeShape</code></td>
        </tr>
        <tr>
            <td>Concepts corresponding to attribute relationship types</td>
            <td>RDF Schema <code>Property</code>, SHACL <code>PropertyShape</code></td>
        </tr>
        <tr>
            <td>Concepts not corresponding to attribute relationship types</td>
            <td>SKOS <code>Concept</code>, SHACL <code>NodeShape</code></td>
        </tr>
        <tr>
            <td>Attribute relationship groups</td>
            <td>SHACL <code>NodeShape</code></td>
        </tr>
    </tbody>
</table>

A single SNOMED CT concept may have multiple mappings into RDF. For example, the root concept is mapped to an RDF Schema `Class`, a SHACL `NodeShape`, and a SKOS `Concept`. Each target has its own subject IRI, so that the RDF Schema `Class` corresponding to the SNOMED CT root concept has a different IRI than the SKOS `Concept` mapped from the same.

SNOMED CT descriptions (human-readable terms) of a concept are mapped to RDF Schema `label`, SKOS `prefLabel`, SKOS `altLabel`, or SHACL `name` statements depending on the type of the description (definition, name, synonym), its acceptability (acceptable, preferred, unacceptable), and the mapping(s) of the concept from the table above.

##### Step 4: serialize the rdflib `Graph`s to files in Turtle syntax.

Finally, the resulting RDF triples are serialized to two different files:

1. A schemas file that contains RDF Schema `Class`es and `Property`s as well as SHACL `Shape`s
2. An instances file that contains SKOS `Concept`s

Although both files contain RDF in Turtle syntax, and could be combined, most downstream tools expect RDF schemas/ontologies to be loaded separately from instance data.
