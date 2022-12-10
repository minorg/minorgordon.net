---
layout: post
title:  "ThingsWorth"
date:   2020-10-25
categories: work
---

I've been thinking about migrating some of my older personal projects to Next.js, which I'm using on [paradicms]({% post_url 2020-08-23-paradicms %}). I've come to appreciate the ease of development and hosting.

[ThingsWorth]({% post_url 2019-03-19-thingsworth %}) is an obvious candidate for migration. The project started out ca. 2018 as a set of Markdown files with a similar structure. I created the "real" implementation as a three-tier web application with a Knockout.js front end, Java middleware, MongoDB as a ground-truth database, and ElasticSearch for full-text search. Later I re-implemented the middleware in Scala, as an excuse to learn that better. I also migrated the databases to PostgreSQL with full-text search, because I wanted to learn that. I often do this with [personal projects]({% post_url 2020-05-23-personal-projects %}).

In retrospect I wish I'd stuck with Markdown and a simpler web application stack. Most of the web applications I'd built until that point were designed for scale and robustness, with large databases and a lot of moving parts. My default hammer turned out to be overkill for a personal project.

My plan is to migrate the "things" in the current ThingsWorth web application to Jekyll-compatible Markdown on this blog. The posts will show up here, but I'll also use Next.js to create an interface out of just those "things". It's a similar approach to what I'm doing in paradicms, rendering the same underlying data in different interfaces.