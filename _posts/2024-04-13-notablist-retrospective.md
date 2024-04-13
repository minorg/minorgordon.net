---
categories: [projects]
date:   2024-04-13
description: Reflecting on a startup experience
layout: post
title:  "Notablist retrospective"
---

Notablist was an email newsletter search engine used by sales teams in the email marketing industry for lead generation and qualification. The system indexed hundreds of millions of email newsletters in order to provide web-based dashboards with insight into the technology use and sending practices of hundreds of thousands of email senders.

Notablist evolved from [Mike Johnston's](https://www.linkedin.com/in/michaelrjohnston/) idea of collecting email newsletters and seeing what value could be derived from analyzing them. Other companies had tried to do this before we did, but never at scale. That required a way of crawling the web / Common Crawl, identifying email newsletter signup forms, submitting them, opting in to subscriptions, and processing newsletters that came in. The latter involved numerous steps:

* DKIM and SPF verification
* spam checking
* storing SMTP transaction metadata such as IPs
* storing the raw RFC 822 email
* indexing newsletter contents (text, HTML) for full-text search
* archiving images referenced by HTML img tags
* rendering and screenshotting versions of the newsletter as they would appear in Google Mail or another email client
* tracking changes in sender metadata, such as reverse DNS lookups, whois records, Alexa, Quantcast, and Majestic Million ranks, and Clearbit profiles
* analyzing email headers and bodies for technology "fingerprints"
* triggering real-time and digest email and Slack alerts for end users

Mike developed an initial prototype of the Notablist system in 2013 using Python for the backend, MongoDB to store newsletters and metadata, Elasticsearch for full-text indexing, and Backbone.js for the user interface. I joined the company in 2014 and worked on it for sweat equity while I paid the bills with other projects. [Jim Pavoldi](https://www.linkedin.com/in/pavoldi/) joined later to help with sales and marketing. We never sought external funding, but paid operating expenses and occasionally ourselves from revenue. In 2022 Notablist's assets, primarily the code and accumulated data, were acquired by an established company in the email marketing space.

When I started working on Notablist in 2014 my initial focus was on the newsletter analysis process, but soon expanded to include the entire software stack. I rewrote Mike's prototype into a productionq-quality system, replacing the Python with Java and JavaScript and Backbone.js with TypeScript and Knockout.js while retaining MongoDB and Elasticsearch. Mike had his hands full with a plethora of non-technical work, from product management to sales, but continued to help me with release deployment using Docker and Kubernetes.

Over the lifetime of the company we pivoted several times, from a focus on email designers and marketers to serving sales teams within the email marketing industry itself. Before starting Notablist, Mike had some experience managing email newsletters, but neither of us was an expert on the industry ecosystem. We learned as we went along, making some big mistakes and many small ones in the process. In hindsight some of those were probably avoidable at the time, but on the whole I believe we acquitted ourselves well enough with the knowledge that we had.

I've put together a list of what I thought we did well and a list of things we could have done better. Although I have and had opinions about the business side of Notablist the company, the focus of my lists is on the engineering side, where I spent most of my time and effort.

#### What we did well

###### Java

Java was and is a "boring" technology for the enterprise, and not usually associated with startups. In 2014 I was primarily a backend developer. Java had become my go-to backend language when I started doing freelance work in 2012 and needed to expand my toolkit beyond C++, which had been my focus since 2004.

The Notablist backend I developed in Java proved to be very robust. There were high-quality Java libraries for much of the functionality we needed, with the major exception of data analysis. Over the ~6 year lifetime of the system the backend processed hundreds of millions of newsletters, executed numerous database migrations and other asynchronous processes, and supported APIs for end user and administration interfaces. Almost all of the technical issues we experienced were the result of mishaps at (manual) deployment time, and not in the course of day-to-day operation.

###### TypeScript 

Although I've done web development off and on since the mid-1990s, I stayed away from JavaScript for many years because of the poor development experience compared to backend languages such as C++ and Java. When TypeScript emerged around 2012, I finally felt like I could maintain my standards (and sanity) as a full-stack developer. I was still a novice at TypeScript when I rewrote the Notablist web interface in it, but the choice meant I spent much less time staring at browser consoles than I would have otherwise.

###### Code generation

I was a big proponent of code generation, and had developed an open source framework, Thryft, for generating code in multiple languages from Apache Thrift interface definitions. (The framework itself wasn't based on Apache Thrift, and the code it generated was substantially different.) I relied on Thryft to supercharge Notablist development, using the framework to generate RPC clients in TypeScript, RPC server stubs in Java, validating and logging service wrappers, immutable data classes in Java and TypeScript that could be serialized in multiple formats, and database models for MongoDB and Elasticsearch, among other things. My use of code generation also encouraged me to put more effort into up-front design generally and API-first design specifically.

###### Observability

The Notablist backend was heavily instrumented with the Java Metrics framework and SLF4J logging. We sent measurements to InfluxDB and built Grafana dashboards that helped us understand steady state performance and identify bottlenecks. It was a worthwhile investment.

###### Optimizing for operating expense

As a company Notablist was the definition of "scrappy" from the day we started until the day our assets were acquired. We rarely had enough cash on hand to pay for third party services we didn't absolutely need. We had to implement and/or maintain many components ourselves on a shoestring budget, self-hosting the entire system on bare mental rented from Hetzner. I learned to design feature-rich software in a way that minimized our day-to-day operating expenses, something I'd rarely had to do before.

After Notablist's assets were acquired, the new owners paid me to update the code to use Amazon Web Services such as DocumentDB (i.e., managed MongoDB) and SQS (in lieu of a bespoke SMTP server). Those changes eliminated huge swathes of code and drastically simplified others, but increased operating expenses.


#### What we could have done better

###### Databases

MongoDB was a popular choice for startups at the time the Notablist prototype was developed, due in large part to its compatibility with the JSON data model and schemaless collections. It was less suited to a robust production system. The loose data model was a frequent headache, complicating migrations and forcing me to implement post hoc validation. MongoDB's runtime performance was frequently an issue as well, especially when we needed to traverse the entire database in order to rebuild the Elasticsearch full-text indices.

In retrospect I should have migrated the data in MongoDB to a more robust relational database such as PostgreSQL. PostgreSQL has supported JSON columns since 2012, and I could have easily used them as a stepping stone to a normal relational database. Given our relatively light use of Elasticsearch features, we might have dispensed with Elasticsearch as well in favor of PostgreSQL's rudimentary full-text search capabilities.

###### Knockout.js

2013 and 2014 saw the initial releases of React.js and Vue.js, respectively. At the time it wasn't clear these frameworks would become as entrenched as they've become today. There were many other contenders back then. Backbone.js was popular, and used in the Notablist prototype. I felt the most popular "framework" at the time, jQuery, had no future. For the Notablist frontend I chose Knockout.js, a framework I'd recently learned after getting to know the Model-View-ViewModel architecture elsewhere.

I obviously bet on the wrong horse. As React and Vue took off, support for Knockout and other frameworks fell off a cliff. Knockout had design weaknesses as well, and scaled poorly as I added features and code to the Notablist frontend.

###### Testing

The high-level architecture of the Notablist system held up remarkably well through multiple pivots and rapidly changing requirements. I was ruthless in eliminating code we no longer needed and refactoring what remained to reflect the current design instead of allowing it to rot. Unfortunately, thorough test coverage was often a casualty of these changes. Unit test coverage was fairly good, but higher levels of the test pyramid were poor to nonexistent. The Notablist system had many moving parts (databases, third party services, et al.) and I could only spend so much time developing test doubles, so I often resorted to haphazard integration testing on my development machine. My attempts at end-to-end testing with Selenium were mired in waits and other hacks; better tools like Cypress wouldn't appear until several years after I started.

###### Deployment

We were relatively early converts to Docker in 2014. For the first few years of Notablist we "deployed" our Docker images by building the code on the host, copying it into various images, and running containers in a screen with Docker Compose. After an abortive attempt to scale Docker Swarm across multiple machines, we eventually switched to Kubernetes, but the end-to-end deployment process was still tedious and error-prone.

DevOps is a more mature discipline and DevOps tools are much more productive today than they were in 2014, but I still think it would have been worth the effort to automate the deployment process or even implement Continuous Deployment.

###### Product management

Finally, I wish I had taken a more active role in product management than I did. Mike did a credible job of it on his own, but good product management requires close collaboration between the business and engineering sides of a company. At the time I had the all-too-common engineer's attitude of "I don't make the business decisions, I just execute them." I didn't participate in many user interviews or sales calls. I spent too much time writing code without really understanding why or even if it was needed.
