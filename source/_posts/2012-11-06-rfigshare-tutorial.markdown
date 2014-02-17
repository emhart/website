---
layout: post
title: "rfigshare tutorial"
date: 2012-11-06 10:23
comments: true
categories: R openscience opendata rOpenSci
---

Recently we at [rOpenSci](http://www.ropensci.org) released our [rfigshare](http://cran.r-project.org/web/packages/rfigshare/index.html) package up on cran (or you can check out the most up to date version on [github](http://github.com/ropensci/rfigshare). So what's so great about being able to create figshare articles through R?  For some time now I've been advocating the use of a workflow that involves documents written in R using either LaTeX or markdown with code integtated into the manuscript.  Then the manuscript is itself a "compilable" file that is formatted and converted into a pdf.  Once you're done with your document, you can run a little script and just upload it to [figshare.com](http://www.figshare.com).  Now your workflow is seemlessly embedded within R.  Even better you can use our other packages to actually download your data from within R, write your manuscript in R and then share it with rfigshare.  I've written up a little tutorial on how to do this and you can see the [figshare version](http://figshare.com/articles/An_rfigshare_tutorial/97207) or see the [raw markdown source version](https://github.com/ropensci/rfigshare/blob/master/inst/doc/rfigtutorial.Rmd) Other uses though could be beyond publishing documents.  You could also generate data from simulations and push it to figshare, or even perform various data aggretation or processing on your raw data and then upload it to figshare. Could you do this all via the great figshare web interface?  Of course, but we like to think this will make your life a little easier.  Many thanks to [Carl Boettiger](http://www.carlboettiger.info/) for taking the lead on developing the package and put in the bulk of the development work.


