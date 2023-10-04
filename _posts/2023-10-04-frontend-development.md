---
date:   2023-10-04
description: My journey to frontend development
layout: post
title:  "Frontend development"
---

Like many aspiring software engineers, I learned early that the backend is where "serious" development happens: algorithms and data structures, advanced programming languages, data models and databases. Frontend development of user interfaces was for former graphic designers and other dilettantes. The best software engineers steered clear of all of that.

In grad school I studied concurrency architectures for high-performance web servers, then worked in industrial research, developing tools for cluster supercomputers. Software doesn't get much more "backend" than kernel-based file systems.

After a few years of that I'd had enough of staring at gnarly C and thinking about read optimization, and wanted to work closer to end users and the mainstream of the IT industry. I benchmarked web servers, integrated backend systems, and wrote compilers and runtimes for domain-specific languages. I used languages, frameworks, and development environments that amplified my productivity, so I could create more and higher-quality code faster.

I didn't do frontend development. The tools alone were enough to put me off of it: JavaScript for the web, desktop frameworks like Qt and Wx, Objective C on mobile devices. They felt like a huge step back from what Visual Basic had been in the mid-90s, although the comparison is not apples-to-apples: in that era you could get away with developing for one platform (Windows) and one type of computer (desktop PCs).

Eventually the frontend tools matured. TypeScript made JavaScript palatable to developers who don't think debugging mysterious issues in a browser console is a fun way to spend an evening. Frameworks like React mitigated some of the pain of dealing with cross-platform compatibility. New library support for old design patterns like copy-on-write and one-way data flows eliminated common bugs and supported saner software architectures.

In the interim I also realized that my refusal to do frontend development was holding me back. I had good ideas that I [couldn't execute]({% post_url 2023-09-27-good-ideas-execution %}) without frontend development skills.

A comprehensive data model, a clean API, and clever algorithms on the backend of a system are rarely worth much in the absence of a top-notch frontend that takes advantage of them. The vast majority of users judge your work by what they see on the screen. If the user interface doesn't do its job well, does the rest really matter?

Less technically sophisticated users also tend to be less forgiving of 80/20, "good enough" solutions in the frontend that might be sufficient in a backend system. The detail work of the last 20% is often the difference between making a negative and a positive impression on people who would like to use your software.

I wonder now why it took me so long to understand and accept the reality of this, and why so many serious software engineers continue to limit their own impact through over-specialization.

Even with the advances of the last 5 to 10 years, frontend development tools and practices are still relatively immature compared to their backend counterparts. Frontend development teams at all but the most prestigious companies still tend to draw less talent and less "serious" talent than backend teams. Most of the frontend code bases I've seen and worked with are poorly designed and maintained.

I view this situation as an opportunity for me and others like me to bring skills honed on "serious" development to an area that still needs them. Frontend development is software development. It needs decomposition and abstraction, [an emphasis on readability]({% post_url 2020-05-02-code-is-for-other-people-to-read %}), thorough automatic testing, and other modern software engineering practices. The ceiling of potential impact is high. More users are coming to expect better user experiences, but the number of developers and teams who can deliver those experiences consistently is not keeping pace. There is a market inefficiency between how valuable good user interfaces are and how much care and quality are put into them.
