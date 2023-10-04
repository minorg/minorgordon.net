---
date:   2023-10-04
description: Comparing and contrasting backend and frontend development
layout: post
title:  "Frontend development is software development"
---

Like many aspiring software engineers, I learned early that the backend is where "serious" development happens: algorithms and data structures, advanced programming languages, data models and databases. Frontend development of user interfaces was for former graphic designers and other dilettantes. The best software engineers steered clear of all of that.

In grad school I studied concurrency architectures for high-performance web servers, then took a job in industrial research, working with cluster supercomputers. Software doesn't get much more "backend" than kernel-based file systems.

After a few years I'd had enough of staring at gnarly C and thinking about read optimization, and moved closer to end users and the mainstream of the IT industry. I benchmarked web servers, integrated backend systems, and wrote compilers and runtimes for domain-specific languages. I worked with languages, frameworks, and development environments that amplified my productivity, so I could create more and higher-quality code faster.

I didn't do frontend development. The tools alone were enough to put me off of it: JavaScript for the web, desktop frameworks like Qt and Wx, Objective C on mobile devices. They felt like a huge step back from what Visual Basic had been in the mid-90s. Granted, in that era you could get away with developing for one platform (Windows) and one type of computer (desktop PCs).

Eventually the frontend tools got better. TypeScript made JavaScript palatable to developers who don't think debugging mysterious issues in a browser console is a fun way to spend an evening. Frameworks like React mitigated some of the pain of dealing with cross-platform compatibility. New library support for old design patterns like copy-on-write and one-way data flows eliminated common bugs and enabled saner decomposition.

In the interim I also realized that my refusal to do frontend development was holding me back. I had good ideas that I [couldn't execute]({% post_url 2023-09-27-good-ideas-execution %}) without frontend development skills.

A comprehensive data model, a clean API, and clever algorithms on the backend of a system are rarely worth much in the absence of a top-notch frontend that takes advantage of them. The vast majority of users judge your work by what they see on the screen. If the user interface doesn't do its job well, does the rest really matter?

Users also tend to be less forgiving of 80/20, "good enough" solutions that might be sufficient in an invisible backend system. The detail work of the last 20% is often the difference between making a negative and a positive impression on the user.