---
categories: [learning]
date:   2021-10-15
description: Impressions of Martin Kleppmann's <i>Designing Data-Intensive Applications</i> and projects at Ink & Switch
layout: post
title:  "Designing data-intensive applications"
---

This week I finished reading Martin Kleppmann's _Designing Data-Intensive Applications: The Big Ideas Behind Reliable, Scalable, and Maintainable Systems_. Most of the concepts were familiar -- consensus algorithms, replication, publish/subscribe -- but it's been over a decade since I was into those subjects, and I felt like I'd lost touch with them. The fundamentals are much the same, but there are many more variations and freely-available implementations than there were ten years ago. The emergence of [conflict-free replicated data types (CRDTs)](https://en.wikipedia.org/wiki/Conflict-free_replicated_data_type), the mainstream acceptance of [dataflow programming](https://en.wikipedia.org/wiki/Dataflow_programming), and the wider use of event sourcing in distributed systems are particularly exciting developments.

Kleppmann's book led me to his work at [Ink & Switch](https://www.inkandswitch.com/) on [local-first sofware](https://www.inkandswitch.com/local-first/), which shares some common ground with the [Solid web decentralization project](https://en.wikipedia.org/wiki/Solid_(web_decentralization_project)). Ruben Verborgh has written eloquently on the latter in a [series of blog posts](https://ruben.verborgh.org/blog/), which I've also caught up on recently.

Ink & Switch has a number of other fascinating projects, including [Capstone](https://www.inkandswitch.com/capstone/), "an experimental tool for creative professionals to develop their ideas", which feels like an answer to Bret Victor's ideas on ["Media for Thinking the Unthinkable"](http://worrydream.com/MediaForThinkingTheUnthinkable/).

I find myself drawn to the idealism on display in these projects, and not just the technology. I'm heartened that these people are thinking about the ["Big Here and Long Now"](https://longnow.org/essays/big-here-long-now/), beyond market opportunities and local maxima.