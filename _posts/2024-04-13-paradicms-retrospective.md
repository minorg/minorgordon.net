---
categories: [projects]
date: 2024-04-13
description: Reflecting on a personal project
layout: post
title: "Paradicms retrospective"
---

Since my [2023 LD4 presentation](https://paradicms.github.io/blog/2023/07/12/ld4-2023) on [Paradicms]({% post_url 2020-08-23-paradicms %}) I've been focusing on other personal projects, such as [diveintoschema.org]({% post_url 2024-01-04-dive-into-schema-org %}). I haven't been actively developing the Paradicms or [DressDiscover]({% post_url 2019-12-22-dressdiscover %}) code bases, but have been considering how or if to continue doing so. On the one hand, those projects have as much potential as they ever did, with many good ideas left to investigate. On the other hand, I feel like I've accomplished what I set out to do, namely:

- Exploring the intersection between my passions for history, libraries and museums, and technology
- Learning new technologies I can apply in other projects, particularly semantic technologies such as the [RDF/JS ecosystem](https://paradicms.github.io/blog/2023/06/05/javascript-rdf-techniques)
- Getting to know the library and museum technology community and sharing my ideas with them

The nature of personal projects means there's rarely a decisive stopping point. Whether I continue with Paradicms development or not, this feels like an appropriate juncture to consider the project retrospectively. With that in mind, I've created
lists of things I feel I did well in Paradicms and things I could have done better.

#### What I did well

###### Emphasizing user-visible benefits of Linked Data

Paradicms de-emphasizes data models, APIs, and serialization formats, on the assumption that few end users are interested in the underlying technologies. Instead I tried to answer the question, “What can those technologies do for the user?” and
explore ways in which Linked Data can empower user interfaces.

###### Minimal computing

Systems that incorporate Linked Data often have many moving parts, such as graph databases, extract-transform-load pipelines, SPARQL endpoints, and web applications. Complexity makes the systems hard to sustain: they are brittle, expensive, and require frequent upkeep by people with advanced technical skills.

Paradicms leverages commodity tools (spreadsheets, Markdown), freemium services (Airtable, GitHub), Semantic Web technologies (JSON-LD, RDF/JS), existing knowledge bases (Wikidata), and static website generation, making it possible to build lightweight workflows and applications that show off the advantages of end-to-end Linked Data without most of the baggage.

In hindsight I believe I struck a good balance between reusing third party tools and not being limited by them. Many tools in the library and museum technology space inhabit one extreme or the other, with too much invention or too little.

###### Documentation

Paradicms was the first personal project I've tried to document well, instead of spending all of my development time coding. I used [Docusaurus](https://docusaurus.io/) to build a static website with a home page, blog posts, and documentation organized according to the [Divio documentation system](https://documentation.divio.com/).

#### What I could have done better

###### Balancing project goals

With personal and academic projects there is always a tradeoff between autonomy and relevance. Doing whatever you feel like doing decreases the odds the result will be useful to many people. Conversely, only doing what other people want can be a recipe for frustration and sap your desire to spend your personal time on a project.

I usually err on the side of autonomy at the expense of collaboration. [As I've written before]({% post_url 2020-05-23-personal-projects %}), my primary goal on these projects is personal growth and exploration, and not delivering working software in the mode of my day job.

Most of the learning takes places at the beginning of a project. Eventually it reaches a point of diminishing returns. At that point a personal project starts to feel like tedious work, and it's time to either wrap up the project or find some other reason to continue.

In hindsight I wish I had done a better job of managing that transition. I wanted to continue working on Paradicms, but I should have focused less on coding and more on other pursuits, like collaborating and communicating with people in the library and museum technology communities. I enjoyed those experiences, and the exercise of presenting my work at LD4 forced me to clarify Paradicms's value proposition. I wish I had embraced that much earlier.

###### Doing fewer things better

Getting feedback on my work earlier might have helped me limit the project's scope. Like many projects involving libraries, museums, and/or Linked Data, Paradicms tried to do too much. It was a union catalog, then a tool for creating digital exhibitions, then a minimalist Collections Management System, and so on. I would have been better off [following the Unix philosophy](http://www.catb.org/esr/writings/taoup/html/ch01s06.html) and doing one thing well. If I wanted to keep going from there I'm sure I could have found ways to do another thing well while reusing code. Instead I did a lot of things well enough to demo but no better, and veered dangerously close to kitchen sink territory.

###### Focusing on JavaScript/TypeScript

[Since 2015]({% post_url 2021-01-16-sharing-historic-costume-collections-online %}) I've used my personal projects in the library and museum space to learn and improve my skill with a number of new technologies like Scala. When I started almost a decade ago my day job mostly involved backend development in Java. I had a lot to learn about frontend development for the web using modern JavaScript and TypeScript.

Paradicms and its predecessor projects were excellent vehicles for that, but I still wrote the "backend" parts of them in Java, Scala, and then Python. I didn't feel any need or desire to deal with Node in the backend. In retrospect, passing up the opportunity to develop Paradicms as a full-stack TypeScript application was shortsighted. I ended up creating too much redundant code e.g., model classes in Python and [TypeScript](https://paradicms.github.io/blog/2023/06/07/rdf-backed-models-in-typescript). I had to build bespoke machinery to orchestrate the Python-based extract-transform-load process and the TypeScript-based static site generation process. Finally, I failed to recognize Python and Java are no longer first-class citizens in the present Linked Data tool ecosystem. For various reasons (e.g., the Solid project) most new Linked Data-related development is done in JavaScript or TypeScript.

Instead of cutting my losses and rewriting the backend Python in TypeScript, I compounded the mistake by shifting work into the frontend. That inevitably led to performance issues managing larger volumes of data in the browser with RDF/JS libraries that weren't designed for that. By the time I realized I'd designed myself into a corner, it was too late to do much about it before the LD4 presentation. I still believe that abstract, RDF-backed models in TypeScript are better than working with directly with RDF, but in newer projects I've developed multiple implementations of the model interfaces: one set of implementations backed by RDF/JS `DatasetCore`s in browser memory, the other backed by SPARQL queries to a (usually remote) endpoint. I can imagine hybrid models as well, like backing a `DatasetCore` with HTML5 LocalStorage.
