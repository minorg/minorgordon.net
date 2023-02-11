---
layout: post
title:  "My colors are blush and bashful"
date:   2023-02-10
description: "Home page revamp"
---

[Teaching this semester]({% post_url 2023-02-09-teaching-machine-learning %}) hasn't left a lot of time for personal projects, so I've been focusing on things I can get done in short order, like the [knowledge graph curator web extension]({% post_url 2023-02-02-knowledge-graph-curator %}). Redoing my home page -- [the index page on this site, minorgordon.net]({{ "/" | prepend: site.baseurl }}) -- was another small item on my TODO list. It's one of the first pages you see if you search for my name, but the page wasn't representing me very well.

I added new images, sections about "What I do" and "What I value", and a proper contact form. I changed the Bootstrap theme to use my favorite color, royal pink.

All of the HTML is hand-coded. I generate the site with [Jekyll](https://en.wikipedia.org/wiki/Jekyll_(software)) and deploy it to AWS: S3 for static file hosting, CloudFront as a CDN, and Route 53 for DNS.

I've had a personal web site almost as long as I've been on the net, approaching 30 years now. The current iteration is more professional than its predecessors, though like its creator, the site has its share of quirks.
