---
layout: post
title: "How I learned stop worrying and love testing"
date: 2015-04-01
comments: true
tags: [software development]
---


Ahhh...Testing, the flossing of software development.  Everybody knows they should do it, but so few of us do. And just like not flossing (or not eating your broccoli) it eventually comes back to haunt you in the end. I am even worse for not testing.  I've stood in front of rooms full of [software carpentry](http://software-carpentry.org) students and proselytized  the virtues of unit testing but never done it in any meaningful way until my [newest software project.](http://ecosimr.org). As a scientist who masquerades as a developer, here is how I learned to love testing and how I think it is useful in almost every situation where code is involved.


<center><img src = "/assets/img/testing.jpg"></center>
<br>
*You test already you just don't know it*

Well, at least I'd bet you do.  At it's heart a test is a way of making sure your code does what you think it does. Maybe you step through that for loop once or twice to make sure it does what you think.  Or you run that algorithm with a simple use case you can calculate on paper and verify.  If you're like me, you probably do this throughout your coding process, mentally keeping track of what works. The downfall of this is that our brains aren't really great for keeping track of this at any scale (that's why we're using computers right?).

*Get flat abs from just 15 minutes of testing a day*

Ok, probably not.  But my point is that testing actually doesn't take that long, or so I discovered. Now you might think, 'well the prior ad-hoc testing in my head I've been doing is fine, why take the time to write more code?'.  To begin with, it actually doesn't take that much more time. In fact it probably takes less.  If your projects are small and you may think it's not worth the time to write tests. I'd answer: small projects, small tests.  So even less time needs to be spent writing tests.

*In testing size matters*

Size matters in testing.  The bigger your code base, the more complex it is likely to be.  More interacting parts means more dependency, which means that a "distant" change could result in breaking an unexpected part of your code. Therefore in your mental testing, if you forget to run a certain test after going back to edit a piece of code.  You can quickly see how complex this can become. But code complexity is just one way that size matters.  Perhaps more importantly the size of your group matters.  Most scientists don't work in large collaborations on code, but instead build code to analyze their own data. But the virtues of testing really shine through when you have multiple people working on a repository.  Working on EcoSimR there were just a couple other collaborators. However on multiple occasions changes they pushed caused tests to fail.  This meant quick fixes and faster coding.

*My romance with testing*

Testing definitely means more work up front.  The bigger the project, the more this pays off.  The small mental tests you do are more managable the smaller the project so there's less incentive to write formal tests. Going into writing EcoSimR I knew I should write tests because the project was big, it had multiple collaborators, and it was a rewrite of a project that already had a sizeable user base.  What I discovered was that testing was more than just a perfunctory exercise, it really sped up the coding process.  Secondly, it really didn't take that long. Packages like [testthat](https://github.com/hadley/testthat) and [nose](https://nose.readthedocs.org/en/latest/) make testing intuitive and quick. Therefore even on a small project I think it makes sense now. After this experience I plan on writing a lot more tests.
