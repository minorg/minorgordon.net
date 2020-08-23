---
layout: post
title:  "Paradicms"
date:   2020-08-23
categories: work
---

Recently most of my personal project time has been dedicated to developing [Paradicms](https://github.com/minorg/paradicms), a new multi-paradigm [Collections Management System (CMS)](https://en.wikipedia.org/wiki/Collections_management_system) for small museums and archives.

I started this project over the Christmas break, nine months ago, as a way of experimenting with some new technologies: the [Play framework](https://www.playframework.com/) in Scala with [Sangria GraphQL](https://github.com/sangria-graphql/sangria). I combined these with technologies I already had experience with: storing named [RDF](https://www.w3.org/RDF/) graphs in a quad store, [Fuseki](https://jena.apache.org/documentation/fuseki2/); extracting, transforming, and loading RDF into the store via a simple Python framework; and exposing the Play server's GraphQL API to a TypeScript+React web-based front end. I subsequently used this stack in projects at work and taught students how to use it.

The "multi-paradigms" concept was that the same database of schemaless RDF could be interpreted in different ways (paradigms) for different applications. User interfaces tend to be useful in proportion to how application-specific they are. Exporting uninterpreted RDF graphs is rarely very useful. Instead my approach was to interpret a subset of low-level RDF statements in the database as high-level, domain-specific models (Scala case classes), and export these to an application-specific user interface.

The implementation has taken a few turns since then. I found that the data entry side of the system -- authentication, authorization, form-based interfaces, validation, et al. -- was taking a long time to implement, so I shifted focus to extracting, transforming, and loading collection data from existing sources, such as [Omeka](https://omeka.org/) and [PastPerfect](http://pastperfect.com/), and spreadsheets. Luckily I'd already developed some auxiliary libraries a few years ago for accessing the Omeka API ([yomeka](https://github.com/minorg/yomeka)) and reading PastPerfect databases ([pastpy](https://github.com/minorg/pastpy)).

Requirements on the "read" side also changed. Most small museums and archives aren't equipped to run their own servers, and I don't plan on getting into the hosting business. Instead I migrated the user-facing side of Paradicms to [Next.js](https://nextjs.org/), a hybrid static site generator built on React and TypeScript. (I tried [Gatsby.js](https://www.gatsbyjs.com/) as well, but found it cumbersome.) Hosting static pages with some client-side JavaScript is a far simpler proposition: the [Jamstack](https://jamstack.org/).

With that pivot the whole system became an [extract-transform-load pipeline](https://en.wikipedia.org/wiki/Extract,_transform,_load):
* **extract** collection data from a source such as Omeka
* **transform** the data into a set of standard models, which are based on common vocabularies such as [Dublin Core](https://en.wikipedia.org/wiki/Dublin_Core) and [VRA Core](https://www.loc.gov/standards/vracore/)
* **load** the models into various formats, including RDF, JSON, or a browsable web site

The "load" to a browsable web site uses Next.js to generate the site. I am building different Next.js site templates that take the standard models as input and interpret them in different ways. For example, there is a multi-institution union catalog for DressDiscover and a site for one-off digital exhibitions.

Museum CMSs are like [integrated library systems](https://en.wikipedia.org/wiki/Integrated_library_system). The space is dominated by a few vendors whose business model involves lock-in of non-technical users with very specific needs and idiosyncratic legacy databases. The vendors make money from software subscriptions, support contracts, and migration consulting fees. There are few good open source alternatives, in large part because few of the users can maintain their own software installations.

My goal is not to replace those service businesses, but provide an alternative stack for users who are technically sophisticated enough to run an extract-transform-load pipeline (via Docker or the command line) but may not have the time or expertise to develop an equivalent from scratch.

Eventually I plan to continue to implement my own editor, perhaps on the model of [Prose.io](http://prose.io/). Having an editor will enable more turnkey solutions.

Stay tuned.
