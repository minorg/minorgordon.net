---
layout: post
title:  "Sampo model"
date:   2020-12-03
description: Semantic portals for digital humanities
---

I've been slowly making my way through the publications of the [Semantic Computing Research Group (SeCo)](https://seco.cs.aalto.fi/) in Helsinki, focusing on Eero Hyvönen's work on semantic portals ("sampos") for digital humanities: CultureSampo, BookSampo, BiographySampo, et al. His 2020 paper "'Sampo' Model and Semantic Portals for Digital Humanities on the Semantic Web" is a succinct overview of these projects.

I'm impressed by what SeCo has been able to do with rich, highly-interlinked datasets about Finnish cultural heritage. Some of the portals have also incorporated event-based ontologies such as [CIDOC-CRM]({% post_url 2020-09-10-cidoc-crm %}).

In contrast, the majority of the English-language humanities data I've seen is much flatter, sparser, and more static, relying heavily on vocabularies like Dublin Core.

I'm less convinced by the way SeCo chose to implement the portal web applications, relying on servers and SPARQL endpoints. Servers inevitably go down at some point after a project and its funding end; and academic groups rarely have the time to maintain a slew of older sites.

That's part of why I've started using [Next.js and static site generation]({% post_url 2020-08-23-paradicms %}). Keeping a static site available is a far simpler proposition than maintaining a server and a SPARQL endpoint.

The main challenge is supporting site search -- the prototypical navbar search form. Statically-generated sites often rely on a browser-side search engine such as `lunr.js`. In order to make it work there has to be at least one page that ships the entire dataset to the browser for `lunr.js` to index.

With compression and a terse serialization you can still fit thousands or even tens of thousands of text-based records in less than 10 MB, small enough to avoid creating usability issues for typical desktop clients. (Images are loaded on demand.) Fortunately many digital humanities datasets fit well within that range.

Above that size you need a server, or a search-as-a-service provider such as Algolia or hosted ElasticSearch. I think that having a server or service for global search alone is still a better approach than having every page rely on server data. Most of the pages on the site can continue to rely on statically-generated data alone. If the search server becomes unavailable, then the site gracefully degrades to disable the search functionality, rather than becoming completely unavailable

Of course a site doesn't have to support site search at all, but can simply rely on Google and other search engines to index pages. Static site generators make it easy to include structured data in page headers (e.g., schema.org markup) and other search engine optimizations. On the other hand, using Google as a primary search engine means the search function is ad-supported, which some academic institutions are wary of. Site search can also do more than the usual fulltext search results interface. You can support faceted search, for example, or have domain- and application-specific functionality, as the "sampo" portals do.