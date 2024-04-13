---
categories: [projects]
date:   2024-04-13
description: Reflecting on a personal project
layout: post
title:  "Paradicms retrospective"
---

Since my [2023 LD4 presentation](https://paradicms.github.io/blog/2023/07/12/ld4-2023) on [Paradicms]({% post_url 2020-08-23-paradicms %}) I've been focusing on other personal projects, such as [diveintoschema.org]({% post_url 2024-01-04-dive-into-schema-org %}). I haven't been actively developing the Paradicms or [DressDiscover]({% post_url 2019-12-22-dressdiscover %}) code bases, but have been considering how or if to continue doing so. On the one hand, those projects have as much potential as they ever did, with many good ideas left to investigate. On the other hand, I feel like I've accomplished what I set out to do, namely:

* Exploring the intersection between my passions for history, libraries and museums, and technologies
* Learning new technology I can apply in other projects, particularly semantic technologies such as the [RDF/JS ecosystem](https://paradicms.github.io/blog/2023/06/05/javascript-rdf-techniques)
* Getting to know the library and museum technology community and sharing my ideas with them

The nature of personal projects means there's rarely a decisive stopping point. Whether I continue with Paradicms development or not, this feels like an appropriate juncture to consider the project retrospectively.

#### What I did well

###### End-to-end Linked Data

Paradicms de-emphasizes the laborious aspects of data models, APIs, and serialization formats, on the assumption that few end users are as interested in the underlying technologies. Instead it seeks to answer the question, “What can those technologies do for the user?” and explores ways in which Linked Data can empower user interfaces, from faceted and fulltext search to digital exhibitions and beyond.

###### Minimal computing

Systems that incorporate Linked Data often have many moving parts, such as graph databases, extract-transform-load pipelines, SPARQL endpoints, and web applications. Complexity makes the systems hard to sustain: they are brittle, expensive, and require frequent upkeep by people with advanced technical skills.

Paradicms leverages commodity tools (spreadsheets, Markdown), freemium services (Airtable, GitHub), Semantic Web technologies (JSON-LD, RDF/JS), existing knowledge bases (Wikidata), and static website generation, making it possible to build lightweight workflows and applications that show off the advantages of end-to-end Linked Data without most of the baggage.

In hindsight I feel like I struck a good balance between reusing third party tools and not being limited by them. Many tools in the library and museum technology space inhabit one extreme or the other, with too much invention or too little.

###### Documentation

Paradicms was the first personal project I've tried to document well, instead of spending all of my development time coding. I used [Docusaurus](https://docusaurus.io/) to build a basic static website with a home page, blog posts, and documentation organized according to the [Divio documentation system](https://documentation.divio.com/).

######


#### What I could have done better 

###### Balancing goals

With personal and academic projects there is always a tradeoff between autonomy and relevance. Doing whatever you feel like doing decreases the odds the result will be useful to many people. Conversely, only doing what other people want can be a recipe for frustration and sap your desire to spend your personal time on a project.

I usually err on the side of autonomy at the expense of collaboration. [As I've written before]({% post_url 2020-05-23-personal-projects %}), my primary goal on these projects is personal growth and exploration, and not delivering working software in the mode of my day job.

Most of the learning takes places at the beginning of a project. Eventually it reaches a point of diminishing returns. At that point a personal project starts to feel like tedious work, and it's time to either wrap the project up or find some other reason to continue.

In hindsight I wish I had done a better job of managing that transition. I wanted to continue working on Paradicms, but I should have focused less on coding and more on other pursuits, like collaborating and communicating with people in the library and museum technology communities. I enjoyed those experiences, and the exercise of presenting my work at LD4 forced me to clarify Paradicms's value proposition. I wish I had done that earlier.


###### Doing fewer things better

###### Focusing on TypeScript

###### Using SPARQL instead of RDF/JS Datasets

