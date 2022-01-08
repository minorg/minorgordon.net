---
layout: post
title:  "Lessons from the Turing lectures"
date:   2021-11-03
categories: reading
---


## [Maurice Wilkes, "Computers then and now" (1967)](https://dl.acm.org/doi/abs/10.1145/321439.321440)

> A source of strength in the early days was that groups in various parts of the world were prepared  to construct experimental computers without necessarily intending them to be the prototype for serial production. As a result, there became available a body of knowledge about what would work and what would not work, about what it was profitable to do and what it was not profitable to do. While looking around at the computers commercially available today, one cannot feel that all the lessons were  learned, there is  no  doubt that this diversity of research in the early days has paid good dividends.

## [Richard Hamming, "One man's view of computer science" (1968)](https://dl.acm.org/doi/abs/10.1145/321495.321497)

> I am sure you have all heard that our scientific knowledge has been doubling every 16 to 17 years. I strongly suspect that the rate in now much higher in computer science; certainly it was higher during the past 15 years. In all of our plans we must take this growth of information into account and recognize that in a very real sense we a "semi-infinite" amount of knowledge. In many respects the classical concept of a scholar who knows at least 90 percent of the relevant knowledge in his field is a dying concept. Narrower and narrower specialization is *not* the answer, since in part the difficulty is in the rapid growth of the interrelationships between fields. It is my private opinion that we need to put relatively more stress on quality and less on quantity and that the careful, critical, considered survey articles will often be more significant in advancing the field than new, nonessential material.

## [Marvin Minsky, "Form and content in computer science" (1969)](https://dl.acm.org/doi/10.1145/1283920.1283924)

> What is a compiler for? The usual answers resemble "to translate from one language to another" or "to take a description of an algorithm and assemble it into a program, filling in many small details." For the future, a more ambitious view is required. Most compilers will be systems that "produce an algorithm, given a description of its effect." This is already the case for modern picture-format systems; they do all the creative work, while the user merely supplies examples of the desired formats: here the compilers are more expert than the users.

## [Edsger Dikstra, "The humble programmer" (1972)](https://dl.acm.org/doi/10.1145/355604.361591)

> I observe a cultural tradition, which in all probability has its roots in the Renaissance ... to regard the human mind as the supreme and autonomous master of its artifacts. But if I start to analyze the thinking habits of myself and of my fellow human beings, I come, whether I like it or not, to a completely different conclusion, viz. that the tools we are trying to use and the language or notation we are using to express or record our thoughts are the major factors determining what we can think or express at all! The analysis of the influence that programming languages have on the thinking habits of their users, and the recognition that, by now, brainpower is by far our scarcest resource, these together give us a new collection of yardsticks for comparing the relative merits of various programming languages. The competent programmer is fully aware of the strictly limited size of his own skull; therefore he approaches the programming task in full humility, and among other things he avoids clever tricks like the plague.

## [Allen Newell and Herbert Simon, "Computer science as empirical inquiry: symbols and search" (1975)](https://dl.acm.org/doi/abs/10.1145/360018.360022)

> We build computers and programs for many reasons. We build them to serve society and as tools for carrying out the economic tasks of society. But as basic scientists we build machines and programs as a way of discovering new phenomena and analyzing phenomena we already know about. Society often becomes confused about this, believing that computers and programs are to be constructed only for the economic use that can be made of them (or as intermediate items in a developmental sequence leading to such use). It needs to understand that the phenomena surrounding computers are deep and obscure, requiring much experimentation to assess their nature. It needs to understand that, as in any science, the gains that accrue from such experimentation and understanding pay off in the permanent acquisition of new techniques and that it is these techniques that will create the instruments to help society in achieving its goals.

## [Robert Floyd, "The paradigms of programming" (1978)](https://dl.acm.org/doi/10.1145/359138.359140)

> If the advancement of the general art of programming requires the continuing invention and elaboration of paradigms, the advancement of the art of the individual programmer requires that he expand his repertory of paradigms. In my own experience of designing difficult algorithms, I find a certain technique most helpful in expanding my own capabilities. After solving a challenging problem, I solve it again from scratch, retracing only the insight of the earlier solution. I repeat this until the solution is as clear and direct as I can hope for. Then I look for a general rule for attacking similar problems, that would have led me to approach the given problem in the most efficient way the first time. Often, such a rule is of permanent value.
>
> ...
>
> Most of the classic algorithms to be found in texts on computer programming can be viewed as instances of broader paradigms. Simpson's rule is an instance of extrapolation to the limit. Gaussian elimination is problem solution by recursive descent, transformed into iterative form. Merge sorting is an instance of the divide-and-conquer paradigm. For every such classic algorithm, one can ask, "How could I have invented this," and recover what should be an equally classic paradigm. To sum up, my message to the serious programmer is: spend a part of your working day examining and refining your own methods. Even though programmers are always struggling to meet some future or past deadline, methodological abstraction is a wise long term investment.

## [Tony Hoare, "The emperor's old clothes" (1980)](https://dl.acm.org/doi/10.1145/358549.358561)

> I conclude that there are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies and the other way is to make it so complicated that there are no obvious deficiencies.
>
> The first method is far more difficult. It demands the same skill, devotion, insight, and even inspiration as the discovery of the simple physical laws which underlie the complex phenomena of nature. It also requires a willingness to accept objectives which are limited by physical, logical, and technological constraints, and to accept a compromise when conflicting objectives cannot be met. No committee will ever do this until it is too late.

## [Dennis Ritchie, "Reflections on software research" (1983)](https://dl.acm.org/doi/10.1145/358198.358207)

> Philosophically [computer science] differs from the physical sciences because it seeks not to discover, explain, or exploit the natural world, but instead to study the properties of machines of human creation. In this it is analogous to mathematics, and indeed the "science" part of computer science is, for the most part, mathematical in spirit. But an inevitable aspect of computer science is the creation of computer programs: objects that, though intangible, are subject to commercial exchange.
>
> More than anything else, the greatest danger to good computer science research today may be excessive relevance. Evidence for the worldwide fascination with computers is everywhere, from the articles on the financial, and even the front pages of the newspapers, to the difficulties that even the most prestigious universities experience in finding and keeping faculty in computer science. The best professors, instead of teaching bright students, join start-up companies, and often discover that their brightest students have preceded them. Computer science is in the limelight, especially those aspects, such as systems, languages, and machine architecture, that may have immediate commercial applications. The attention is flattering, but it can work to the detriment of good research.
>
> As the intensity of research in a particular area increases, so does the impulse to keep its results secret. This is true even in the university (Watson's account of the discovery of the structure of DNA provides a well-known example), although in academia there is a strong counterpressure: unless one publishes, one never becomes known at all. In industry, a natural impulse of the establishment is to guard proprietary information. Researchers understand reasonable restrictions on what and when they publish, but many will become irritated and flee elsewhere, or start working in less delicate areas, if prevented from communicating their discoveries and inventions in suitable fashion.
> ...
> Another danger is that commercial pressures of one sort or another will divert the attention of the best thinkers from real innovation to exploitation of the current fad, from prospecting to mining a known lode. These pressures manifest themselves not only in the disappearance of faculty into industry, but also in the conservatism that overtakes those with well-paying investments -- intellectual or financial -- in a given idea.

## [Niklaus Wirth, "From programming language design to computer construction" (1984)](https://dl.acm.org/doi/10.1145/2786.2789)

> ... complexity has and will maintain a strong fascination for many people. It is true that we live in a complex world and strive to solve inherently complex problems, which often do require complex mechanisms. However, this should not diminish our desire for elegant solutions, which convince by their clarity and effectiveness. Simple, elegant solutions are more effective, but they are harder to find than complex ones, and they require more time, which we too often believe to be unaffordable.
> ...
> [It is] mandatory to distinguish early between what is essential and what ephemeral. I have always tried to identify and focus in on what is essential and yields unquestionable benefits. For example, the inclusion of a coherent and consistent scheme of data type declarations in a programming language I consider essential, whereas the details of varieties of for-statements, or whether the compiler distinguishes between upper- and lowercase letters, are ephemeral questions. ... Even more important is ensuring that the ephemeral never impinges on the systematic, structured design of the central facilities. Rather, the ephemeral must be added fittingly to the existing, well-structured framework.
>
> Rejecting pressures to include all kinds of facilities that "might also be nice to have" is sometimes hard. The danger that one's desire to please will interfere with the goal of consistent design is very real. I have always tried to weigh the gains against the cost. For example, when considering the inclusion of either a language feature or the compiler's special treatment of a reasonable frequent construct, one must weigh the benefits against the added cost of its implementation and its mere presence, which results in a larger system. Language designers often fail in this respect.

## [John Hopcroft, "Computer science: the emergence of a discipline" (1986)](https://dl.acm.org/doi/abs/10.1145/214748.214750)

> With computer technology advancing so quickly, it's easy to lose sight of the importance of developing the underlying science base for computing. There is too great a temptation to focus simply on writing software. As we build larger and more complex systems, we must develop the conceptual tools that will allow us to comprehend the essence of a task and to develop the software tools needed to create complete systems. We have not been able to utilize fully the benefits of computing precisely because we have failed to develop the science base necessary for constructing reliable and user-friendly software systems quickly and economically.

## [Fernando Corbato, "On building systems that will fail" (1990)](https://dl.acm.org/doi/10.1145/114669.114686)

> First, it is important to emphasize the value of simplicity and elegance, for complexity has a way of compounding difficulties and as we have seen, creating mistakes. My definition of elegance is the achievement of a given functionality with a minimum of mechanism and a maximum of clarity.
>
> Second, the value of metaphors should not be underestimated. Metaphors have the virtue of an expected behavior that is understood by all. Unnecessary communication and misunderstandings are reduced. Learning and education are quicker. In effect, metaphors are a way of internalizing and abstracting concepts allowing one's thinking to be on a higher plane and low-level mistakes to be avoided.
>
> Third, use of constrained languages for design or synthesis is a powerful methodology. By not allowing a programmer or designer to express irrelevant ideas, the domain of possible errors becomes far more limited.
>
> Fourth, one must try to anticipate both errors of human usage and of hardware failure and properly develop the necessary contingency paths. This process of playing "what if" is not as easy as it may sound, since the need to attach likelihoods of occurrence to events and to address issues of the independence of failures is implicit.
>
> Fifth, it should be assumed in the design of a system, that it will have to be repaired or modified. The overall effect will be a much more robust system, where there is a high degree of functional modularity and structure, and repairs can be made easily.
>
> Sixth, and last, on a large project, one of the best investments that can be made is the cross edtccation of the team so that nearly everyone knows more than he or she needs to know. Clearly, with educational redundancy, the team is more resilient to unexpected tragedies or departures. But in addition, the increased awareness of team members can help catch global or systemic mistakes early. It really is a case of "more heads are better than one."

 ## [Ed Feigenbaum, "How the 'what' becomes the 'how'" (1994)](https://dl.acm.org/doi/10.1145/1283920.1283951)

> As a logician, Turing was a penetrating theorist, beyond perhaps all who have worked since. But we know him also, through his work on early computers and computational cryptography, as an applier, a builder of engineering prototypes, a designer who designed down to deep levels of detail.
>
> This duality, which is common in physical science but not in computer science, enriched both aspects of Turing’s work, as it did mine. The citation for this Turing Award mentions the work of Reddy’s and mine in applied AI, but those applications are just one side of the coin. Tightly bound on the other are theoretical insights into the nature of knowledge-based systems, reasoning engines for using the knowledge bases, and even learning processes for automatic acquisition of new knowledge. In my view, there is no tension between experimental science that exploits applications and theoretical science -- between the empirical and the conceptual work.
>
> Getting deeply involved in the world of a complex application is a voyage of discovery. The real world helps us to discover real and important issues, questions and problems. Perhaps some of us could invent such insights, but I find that discovery is usually easier than invention.

## Alan Kay, "First Courses in Computing Should be Child's Play"

> ... whenever we say "computer science" or "software engineering," and especially whenever we think we're teaching it, the worst thing we could ever do is to pretend to the students that we know what it is, because the students are going to be the ones that are going to save us. So we should teach the students what I was taught when I was in graduate school in the '60s, and that is: it isn't done yet. It's not even close to done. We have to understand what the actual scope of the computing is going to be, and you have to help us invent it.
> ...
> if we can't get kids interested in the romance of why this is an unbelievably beautiful new art form, then we're not living up to what our duty is of enjoying this stuff ourselves. We have to reach deeply inside of ourselves to remember what it was that first got us interested in the wonderful new thing.
