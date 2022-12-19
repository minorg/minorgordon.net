---
layout: post
title:  "Code is for other people to read"
date:   2020-05-02
description: Thoughts on consistency in software engineering
---

In my presentations about software engineering best practices I like to quote Abelson's _Structure and Interpretation of Computer Programs_:

"Programs must be written for people to read, and only incidentally for machines to execute."

Martin Fowler said it, too:

"Any fool can write code that a computer can understand. Good programmers write code that humans can understand."

The person who has to read your messy code is probably going to be you, six months from now, when you've forgotten why you wrote the code the way you did. Be considerate of your future self, and empathetic for other people who have to understand your work.

In my experience the most important aid to readibility is consistency. Consistent structure. Consistent naming. Consistent order. Consistent formatting. Consistent testing. Consistent source control. To paraphrase Tolstoy: "Clean code bases are all alike; each messy code base is messy in its own way."

I try to automate as much of this consistency as possible, with editors and other tools. It's easy for machines to be consistent, and challenging for humans to do it day after day. Software engineering requires enough thought to solve the problems at hand; we should exert our mental energy on those problems, and not on things that shouldn't require thought, like tracking inconsistent parameter names.

I've heard others call this approach "radical mediocrity": resisting the temptation to show how clever and unique you are, and embodying the principle of least astonishment.
