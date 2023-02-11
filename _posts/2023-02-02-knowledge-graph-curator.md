---
layout: post
title:  "Knowledge graph curator"
date:   2023-02-02
description: "Web extension for curating RDF knowledge graph statements from sites like Wikidata and Wikimedia Commons"
---

In 2021 I spent most of my personal project time developing tools for generating digital exhibitions from Linked Data. At the end of the year [I curated several test exhibitions]({% post_url 2021-12-30-bildungsroman %}), primarily from Wikidata, Wikimedia Commons, and Wikipedia. I had scripts to automatically extract and transform a Wikidata concept into the RDF expected by the site generator, but getting comparable snippets from Wikimedia Commons and Wikimedia meant writing RDF by hand. That's quite tedious, no matter which RDF syntax you use.

This year I plan to continue working on those exhibitions and start several others, so I've been looking for ways to make the process more efficient. Automating the curation process I used for the test exhibitions was the most obvious short-term gain, so I decided to develop a Chrome web extension for that.

I thought it might be a 40-50 hour project, but it turned out to be much easier than that. Google's developer [documentation](https://developer.chrome.com/docs/extensions/) for web extensions is excellent, as is [Mozilla's](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions). I found a nice example extension, [wwwyzzerdd](https://github.com/derenrich/wwwyzzerdd), built with TypeScript and [Parcel](https://parceljs.org/). I'd never used Parcel, but I like it much better than webpack. All told, I went from knowing almost nothing about web extensions to having the main functionality I wanted (generating RDF snippets from Wikidata and Wikimedia Commons) in less than 8 hours. The result is [on GitHub](https://github.com/minorg/knowledge-graph-curator).
