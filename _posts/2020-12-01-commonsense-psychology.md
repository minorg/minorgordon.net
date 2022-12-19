---
layout: post
title:  "Commonsense psychology"
date:   2020-12-01
description: Notes on Andrew Gordon and Jerry Hobbs's series of papers on commonsense psychology
---

I've been reading Andrew Gordon and Jerry Hobbs's [series of papers](https://people.ict.usc.edu/~gordon/cprp.html) on commonsense psychology. Their research agenda was to develop formal theories covering concepts related to human mental states and processes, with the eventual goal of supporting automated commonsense reasoning. The theories are sets of axioms in first-order predicate calculus.

Their results are fascinating, but I found their methods even more interesting. The 2004 _AI Magazine_ paper "Formalizations of Commonsense Psychology" outlines the methodology, which built on earlier work by the same authors.

> Gordon (2001b) devised a methodology for outlining the full scope of representational requirements for planning strategies. This methodology involved the collection and analysis of a large corpus of planning strategies across many different planning domains. Three hundred seventy-two strategies were collected in ten different planning domains (business, counting, education, Machiavellian politics, performance, relationships, scientific practice, warfare, and the anthropomorphic domains of animal behavior and cellular immunology). These 372 strategies were collected by analyzing texts that were encyclopedic of strategies within the domains, by interviewing domain practitioners, and through the interpretive observation of activities within domains. Preformal representations of the strategies were authored to identify the concepts that participated in all instances of each of the strategies, regardless of the specifics of the planning situation.

The concepts were grouped into 48 representational areas. Eighteen of the areas were set aside because they were well covered by other formal theories (e.g., of time or notions of agency). The remaining 30 areas related to the mental states and processes of people. Those areas are the purview of commonsense psychology.

Starting from the representational areas, Gordon & Hobbs created a new methodology to support the formal theories:
1. _Expression elicitation_: "identify an initial set of natural language words, expressions, and whole sentences that native speakers judge to be expressive of concepts related to the given representational area"
1. _Lexical expansion_: "use the initial expressions to seed a more thorough search for related words and expressions in a range of linguistic reference resources"
1. _Corpus analysis_: "collect a large database of real examples of the use of language related to the representational area by encoding the relevant vocabulary into finite-state automata that can be applied to large text corpora"
1. _Model building_: "review the results of the corpus analysis step to identify the conceptual distinctions made in real language use" in order to "identify a set of conceptual primitives to be used in an axiomatic theory"

The paper goes on to present the results of this process for one of the representational areas, Memory.
