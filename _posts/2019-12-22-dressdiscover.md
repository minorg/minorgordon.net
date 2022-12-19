---
layout: post
title:  "DressDiscover"
date:   2019-12-22
description: Revisiting one of my personal projects, DressDiscover, a suite of open source web applications for digital collections of historic clothing
---

Over the winter break I've been reviving [DressDiscover](https://github.com/minorg/dressdiscover), a suite of open source web applications for digital collections of historic clothing. I started this project in 2015 as a collaboration with [Arden Kirkland](https://www.ardenkirkland.com/work/), a digital librarian and former costume collection manager, after I read her article in _Dress_, ["Sharing Historic Costume Collections Online"](https://www.tandfonline.com/doi/abs/10.1080/03612112.2015.1130394).

The first web application was a [union catalog](https://en.wikipedia.org/wiki/Union_catalog) of a few existing digital collections, such as [Historic Dress](http://historicdress.org/), the [Texas Fashion Collection](https://tfc.unt.edu/), and [the Europeana Fashion collection](https://www.europeana.eu/portal/en/collections/fashion). In order to support extract-transform-load into the catalog I created several auxiliary projects, such as a [Python client for the Omeka Classic API](https://github.com/minorg/yomeka) and a [Python library for reading PastPerfect exports](https://github.com/minorg/pastpy). I later incorporated the PastPerfect library into a separate open source tool to [generate static web sites from PastPerfect databases](https://github.com/minorg/ppsite).

The second DressDiscover application was a web-based worksheet for describing garments using visual workflows. Arden described this project and her underlying Costume Core vocabulary in a [recent article for the Visual Resources Association Bulletin](https://online.vraweb.org/vrab/vol45/iss2/6/).

I often use my passion projects as a way of learning new technologies and techniques. The worksheet web application is implemented entirely in the browser with no bespoke server support, so that the whole application can be copied and embedded in other web sites and served as a set of static files. The current incarnation is written in TypeScript with React.js. It can store worksheet state in Google Sheets, which required me to support browser-only OAuth and Google API access.

The original union catalog (ca. 2015-2016) was implemented with [Vaadin](https://vaadin.com/), a front end framework built around the Google Web Toolkit for translating Java to JavaScript. The Vaadin user interface was connected to Java-based microservices in the middle tier, with a MongoDB and ElasticSearch storage tier. 

The new union catalog I've been working on consists of:
* a set of React+TypeScript [micro frontends](https://martinfowler.com/articles/micro-frontends.html)
* a [GraphQL](https://graphql.org/) API that's stitched together from multiple back end microservice GraphQL APIs that are implemented using the [Play framework](https://www.playframework.com/) with Scala
* an [Apache Jena Fuseki](https://jena.apache.org/documentation/fuseki2/) RDF triple store

I've been developing a framework to map RDF to Scala case class domain models, which can be exported easily via the GraphQL API with [Sangria](https://sangria-graphql.org/). It's graphs all the way down.
