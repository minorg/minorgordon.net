---
layout: post
title:  "Things worth learning: functional programming"
date:   2021-09-18
categories: thingsworth
---

### [What](#what)

> In computer science, functional programming is a programming paradigm where programs are constructed by applying and composing functions. It is a declarative programming paradigm in which function definitions are trees of expressions that map values to other values, rather than a sequence of imperative statements which update the running state of the program.

([Wikipedia](https://en.wikipedia.org/wiki/Functional_programming))

### [Why](#why)

> As software becomes more and more complex, it is more and more important to structure it well. Well-structured software is easy to write and to debug, and provides a collection of modules that can be reused to reduce future programming costs. In this paper we show that two features of functional languages in particular, higher-order functions and lazy evaluation, can contribute significantly to modularity. ... We conclude that since modularity is the key to successful programming, functional programming offers important advantages for software development.

John Hughes, from the abstract of his seminal 1990 paper ["Why Functional Programming Matters"](https://dl.acm.org/doi/10.1093/comjnl/32.2.98)

### [How](#how)

I first learned about Lisp toward the end of high school, around 1999, when I heard a lecture at the University of Tulsa. [Common Lisp](https://en.wikipedia.org/wiki/Common_Lisp) was very different from the kind of programming I'd done before, in BASIC, Pascal, C, and C++. I didn't understand the significance of that at the time.

A few years later I took the standard course in programming languages, which focuses on functional programming and recursive algorithms. We learned [Standard ML](https://en.wikipedia.org/wiki/Standard_ML) from [Jeffrey Ullman's](https://en.wikipedia.org/wiki/Jeffrey_Ullman) _Elements of ML Programming_.

In grad school I read [Paul Graham's](https://en.wikipedia.org/wiki/Paul_Graham_(programmer)) essays on Lisp, and became aware of Haskell and the programming language research that was being done with it. Those things were appealing on an intellectual level, but the actual tools still seemed too arcane to be of much practical use for the kind of work I wanted to do. I continued to focus on more mainstream programming languages like Java, C++, and Python.

It was only after I'd been developing software professionally for almost a decade that I decided to give functional programming another try. That coincided with renewed interest across the IT industry in functional languages as an answer to the challenges of concurrent and distributed programming. The tools had improved significantly in the interim, with the maturation of older functional languages and the emergence of new languages such as Clojure.

I got my feet wet by learning Scala, which has a clear transition path from Java. Since then, I've learned some Clojure and Haskell as well. I appreciate their simplicity compared to Scala, which tends to the baroque.

In recent years Java, Python, TypeScript, and other procedural languages I use regularly have incorporated numerous features from functional languages, like Java's streams and Python's list, set, and dictionary comprehensions. I try to use these features pragmatically. It can be challenging to find the right balance between readability and concision in a language that wasn't designed for functional idioms, but it's worth the effort.

Nowadays there are many more ways to learn these technologies than there were when I started: online courses, books, interactive tutorials. You can quickly pick up the concepts in the abstract, but you still have to apply them in order to actually learn the practical skill. The best way to do that is by using the tools to solve problems that are both challenging and meaningful to you.
