---
categories: [projects]
date: 2024-10-09
description: With examples
layout: post
title: "SPARQL CONSTRUCT queries over RDF lists"
---

In a recent project I needed to use [SPARQL CONSTRUCT queries](https://www.w3.org/TR/rdf-sparql-query/#construct) to reconstruct an [RDF list](https://www.w3.org/TR/rdf-schema/#ch_collectionvocab) in triples. I needed to minimize the number of triples in the result and support additional graph patterns on list items. The solution did not need to handle empty lists.

RDF lists are notoriously unwieldy, and SPARQL 1.1 has no syntactic sugar to simplify working with them. I found a few web pages with hints on how to approach the problem:

- Bob DuCharme: ["RDF lists and SPARQL"](https://www.bobdc.com/blog/rdf-lists-and-sparql/)
- Andy Seaborne: ["Updating RDF Lists with SPARQL"](https://afs.github.io/rdf-lists-sparql)
- StackOverflow: ["How to write a SPARQL CONSTRUCT query that returns an RDF list?"](https://stackoverflow.com/questions/44221975/how-to-write-a-sparql-construct-query-that-returns-an-rdf-list)

None of the solutions addressed all my requirements, and I had to come up with my own query.

#### The query

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>

CONSTRUCT {
  <http://example.com/dummysubject> <http://example.com/dummypredicate> ?rdfList .
  ?rdfList rdf:first ?rdfListItem0 .
  ?rdfListItem0 schema:name ?rdfListItem0Name .
  ?rdfList rdf:rest ?rdfListRest0 .
  ?rdfListRestN rdf:first ?rdfListItemN .
  ?rdfListItemN schema:name ?rdfListItemNName .
  ?rdfListRestN rdf:rest ?rdfListRestNBasic .
} WHERE {
  <http://example.com/dummysubject> <http://example.com/dummypredicate> ?rdfList .
  ?rdfList rdf:first ?rdfListItem0 .
  ?rdfListItem0 <http://schema.org/name> ?rdfListItem0Name .
  ?rdfList rdf:rest ?rdfListRest0 .
  OPTIONAL {
    ?rdfListRest0 rdf:rest+ ?rdfListRestN .
    ?rdfListRestN rdf:first ?rdfListItemN .
    ?rdfListItemN schema:name ?rdfListItemNName .
    ?rdfListRestN rdf:rest ?rdfListRestNBasic .
  }
}
```

#### How it works (the WHERE graph patterns)

##### Setup: the list in a variable

```
<http://example.com/dummysubject> <http://example.com/dummypredicate> ?rdfList .
```

This could be any pattern, depending on the application.

##### Get the first item in the list

```
?rdfList rdf:first ?rdfListItem0 .
```

The query treats `rdf:first` and `rdf:rest` separately because the former points to a list item. We need that because we need to ...

##### Match additional triples on list items

```
?rdfListItem0 <http://schema.org/name> ?rdfListItem0Name .
```

This is application-specific, and could be any set of graph patterns.

##### Match the first tail of the list

```
?rdfList rdf:rest ?rdfListRest0 .
```

This is needed to reconstruct the list. One of the StackOverflow solutions was missing tihs.

##### OPTIONAL group

```
OPTIONAL { ... }
```

For lists with multiple items.

##### Match subsequent tails

```
?rdfList rdf:rest+ ?rdfListRestN .
?rdfListRestN rdf:rest ?rdfListRestNBasic .
```

The `rdf:rest+` one-or-more [property path](https://www.w3.org/TR/sparql11-query/#propertypaths) matches every object of `rdf:rest` reachable from the `?rdfList`. CONSTRUCT graph patterns can't contain property paths, so the second WHERE graph pattern ensures the `rdf:rest` triples are captured in the `CONSTRUCT`.

##### Match subsequent items

```
?rdfListRestN rdf:first ?rdfListItemN .
?rdfListItemN schema:name ?rdfListItemNName .
```

For every list tail, match its item and the additional graph pattern on items.

#### The query in action

Insert the following test data:

```sparql
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX schema: <http://schema.org/>

INSERT DATA {
 <http://example.com/2> schema:name "test2" .
 <http://example.com/1> schema:name "test1" .
 <http://example.com/dummysubject> <http://example.com/dummypredicate> (<http://example.com/1> <http://example.com/2>) .
}
```

which contains the following 7 triples (expanded from the RDF list syntactic sugar):

```turtle
<http://example.com/1> <http://schema.org/name> "test1" .
<http://example.com/dummysubject> <http://example.com/dummypredicate> _:ec9519d9f6cb0c9c81662fee09b4b6b3 .
<http://example.com/2> <http://schema.org/name> "test2" .
_:e5a3560dac4aee8d386839c6b568ada2 <http://www.w3.org/1999/02/22-rdf-syntax-ns#rest> <http://www.w3.org/1999/02/22-rdf-syntax-ns#nil> .
_:e5a3560dac4aee8d386839c6b568ada2 <http://www.w3.org/1999/02/22-rdf-syntax-ns#first> <http://example.com/2> .
_:ec9519d9f6cb0c9c81662fee09b4b6b3 <http://www.w3.org/1999/02/22-rdf-syntax-ns#rest> _:e5a3560dac4aee8d386839c6b568ada2 .
_:ec9519d9f6cb0c9c81662fee09b4b6b3 <http://www.w3.org/1999/02/22-rdf-syntax-ns#first> <http://example.com/1> .
```

Running the query produces exactly those triples.

#### Caveats

##### Empty lists

The query only handles non-empty lists, since I never serialize empty lists. To handle an empty list, you'd need to `UNION` the query with an `rdf:nil` pattern, similar to the following:

```sparql
{
  <http://example.com/dummysubject> <http://example.com/dummypredicate> rdf:nil .
}
UNION
{
  <http://example.com/dummysubject> <http://example.com/dummypredicate> ?rdfList .
  ?rdfList rdf:first ?rdfListItem0 .
  ?rdfListItem0 <http://schema.org/name> ?rdfListItem0Name .
  ?rdfList rdf:rest ?rdfListRest0 .
  OPTIONAL {
    ?rdfListRest0 rdf:rest+ ?rdfListRestN .
    ?rdfListRestN rdf:first ?rdfListItemN .
    ?rdfListItemN schema:name ?rdfListItemNName .
    ?rdfListRestN rdf:rest ?rdfListRestNBasic .
  }
}
```

##### Duplicate item patterns

The query has two variables for items: `item0` for the first item in the list and `itemN` for subsequent items. I wasn't able to find a solution that used a single `item` variable without producing extraneous triples. Unfortunately, that means that additional item patterns (like the one with `schema:name` above) must be duplicated for `item0` and `itemN`.
