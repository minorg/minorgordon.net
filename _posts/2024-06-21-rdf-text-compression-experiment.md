---
categories: [projects]
date: 2024-06-21
description: Summary of the experiment and key results
layout: post
title: "RDF text compression experiment"
---

Large [RDF](https://www.w3.org/RDF/)-based datasets such as the National Library of Medicine's [Medical Subject Headings (MeSH)](https://www.ncbi.nlm.nih.gov/mesh/) controlled vocabulary thesaurus are often encoded in machine-friendly formats such as [N-Triples](https://www.w3.org/TR/n-triples/) and compressed with standard methods such as [gzip](https://en.wikipedia.org/wiki/Gzip). As a regular producer and consumer of RDF datasets, I'm interested in how effective different off-the-shelf compression methods are when applied to text-based RDF encodings such as N-Triples. N-Triples is the preferred encoding for programmatic use of RDF triples, since it is line-based and can be streamed easily.

I developed a small experiment to evaluate several common compression methods ([Brotli](https://github.com/google/brotli), [bzip2](https://en.wikipedia.org/wiki/Bzip2), and [gzip](https://en.wikipedia.org/wiki/Gzip)) on representative N-Triples-encoded datasets:

- [AGROVOC Multilingual Thesaurus](https://agrovoc.fao.org/browse/agrovoc/en/)
- [HASSET Thesaurus](https://hasset.ukdataservice.ac.uk/hasset/en/)
- [MeSH](https://www.ncbi.nlm.nih.gov/mesh/)
- [UNESCO Thesaurus](https://vocabularies.unesco.org/browser/thesaurus/en/)

I measured the size of the uncompressed N-Triples file, the size of the N-Triples converted to [Turtle](https://www.w3.org/TR/turtle/) with common namespace prefixes, and the size of both encodings compressed using the above-mentioned methods. I tracked the time each method took to run on my laptop, and calculated compression ratios and space savings.

The code for the experiment and the raw results are available in [this GitHub repository](https://github.com/minorg/rdf-text-compression-experiment).

My key findings were:

- Brotli compression of N-Triples has a slightly higher compression ratio than bzip2, but takes 10-25 times as long to work on large datasets. Brotli compressed the 938.4 MiB AGROVOC dataset in N-Triples to 38.6 MiB and the 1.9GiB MeSH dataset in N-Triples to 65.1 MiB.
- bzip2 compression of N-Triples has a significantly higher compression ratio than gzip, and takes 5-10 times as long to work on large datasets.
- Turtle encodings of the datasets were approximately half the size of the N-Triples encodings. Brotli compression of the Turtle encodings reduced AGROVOC to 23.4 MiB and MeSH to 42.0 MiB.
