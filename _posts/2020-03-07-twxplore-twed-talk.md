---
layout: post
title: "A clean architecture for semantic web applications"
date: 2020-03-07
categories: work
---

On Wednesday evening I gave [a talk](https://youtu.be/uEg2rvnqhMs) about recent work I've done on user-facing applications of semantic technologies. The abstract:

> "User expectations of modern web applications continue to outpace the productivity of the software engineering process. The semantic web application stack of RDF, SPARQL, and related technologies, provides many benefits to users and developers, at the expense of additional complexity that impedes the engineering process. I will present a new software architecture that attempts to maximize the user-visible benefits of these technologies while minimizing their impact on developer productivity. I will also discuss an implementation of the architecture using off-the-shelf tools, such as TypeScript, GraphQL, and Scala, in conjunction with semantic web technologies. The result serves as a vehicle for delivering bespoke web applications for sponsored research projects, incorporating research into symbolic artificial intelligence, and helping students learn modern software engineering."

I've been working with students at RPI to implement a number of web applications using this framework, including:
* an interface for browsing, searching, and navigating wireless spectrum allocation policies for the [Dynamic Spectrum Allocation project](https://science.rpi.edu/itws/news/knowledge-representation-dynamic-spectrum-policy)
* map-based visualizations of wireless traffic, using public data sources such as amateur radio spots and the FCC license database
* a web application for navigating a knowledge graph about food, the [FoodKg](https://foodkg.github.io/), for the [HEALS project](https://science.rpi.edu/biology/news/ibm-and-rensselaer-team-research-chronic-diseases-cognitive-computing)

We've used industry best practices such as GitHub flows, code reviews, Continuous Integration, and test-driven development (including end-to-end testing with [Cypress](https://www.cypress.io/)). These practices are rare in sponsored research projects, but part of my job is helping my group do better software development. The students have enjoyed learning about how things are done in industry, and we've been very productive.
