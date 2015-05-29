---
layout: post
title: "Misadventures in CRAN submission"
date: 2015-05-28
comments: true
tags: [software development, R]
---

Submitting packages to CRAN is a [notoriously finicky](http://ironholds.org/blog/dont-use-the-mailing-lists-a-love-letter-to-the-r-community/) process that can lead to tremendous headaches over seemingly unimportant minutiae (although it does inspire [epic twitter debates](https://twitter.com/ucfagls/status/600493818476015616)). Lately for me the real hurdle in the submission process is the DESCRIPTION file.

<center><figure><img src = "http://i.ytimg.com/vi/paze9Z2BWnA/0.jpg">
<figcaption>How I feel when I'm about to submit to CRAN</figcaption></figure></center>

I've read the large section in the [CRAN WRE](http://cran.r-project.org/doc/manuals/r-release/R-exts.html#The-DESCRIPTION-file), and but often I still miss things (my most common sin is that I forget to update the date field) that don't throw warnings in `R CMD CHECK --as-cran`.  I don't agree with these enforced minutiae, or the fact that my CRAN checks are different from the maintainers.  However I accept the fact that if I want to use CRAN, I need to conform to their policies.  A flaw in their policies though is they are not enforced by a computer and therefore the same person can give you conflicting interpretations of the policy.  Here is my tale of woe with the package [`biorxivr`](http://cran.r-project.org/web/packages/biorxivr/index.html)

I won't bore you with the whole story.  Suffice to say originally the package was called `biorxiv`, it let you search the [bioRxiv preprint](www.biorxiv.org) server from R.  The initial problem was that the package has the same name as the service is searched. Now the CRAN DESCRIPTION policy states:

> Refer to other packages and external software in single quotes, and to book titles (and similar) in double quotes.

So in my initial submission where I used '' in referring to the package and not when referring to the website. However after many back and forth's with CRAN maintainers I just acquiesced and changed the package name. The package was successfully submitted and all was well with the world.  Until I got a notice it wasn't building last night.  I quickly made a patch and submitted it. When I saw the e-mail from Brian Ripley this morning, I knew that bad news awaited.  Here is what he said:

>Please do check as per the policies.  You missed

>Possibly mis-spelled words in DESCRIPTION:
   PDFs (11:177, 11:275)
   bioRxiv (3:44, 11:18)

>The Date field is over a month old.

>In future single-quote 'bioRxiv' (see the manual) and pay attention to
dates.

First, in the previous submission I did not quote 'bioRxiv', nor did I get any note. Secondly the policy clearly states that single quotes are used for software or other packages, but bioRxiv is a website. Also this was the exact same text from my first successful submission that I got a one line e-mail from Kurt saying "Thanks, on CRAN now." So why was not quoting it fine in the first submission but in the second submission I was told it violated CRAN policies? The only difference was that the first time Kurt responded to my submission vs. Ripley in the second. I don't have a good answer to this save it is an example of two different maintainers interpreting the same policy differently.  

Second, you'll see two "possibly mis-spelled words". As before nothing was said about these in the first submission that was successful. But here's the curious thing.  An initial submission was written saying "PDF's", however Ripley responded to my submission informing me:

>The plural of PDF is PDFs

I corrected it to "PDF's" and my submission went on CRAN successfully. So early on he said "here's how you spell PDFs", but in my latest submission he calls it out as a mis-spelled word. So which is it?  Why was it ok in the first submission but not the second?  Finally why does `R CMD CHECK --as-cran` not tell me these as warnings but it does for Ripley?

I doubt there's any malice in these discrepancies, but to me it highlights one of the shortcomings of using such human based submission system. In fact at this point I've probably spend almost as much time reworking the DESCRIPTION file as I have writing the package (to be fair it's a small package). So I can't help but wonder is this the best way to create a vibrant open source community?  Where a few gate keepers inconsistently enforce policy on a package that is completely unrelated to the software's functionality?  I'm all for consistent package metadata, but that only works when the submission system is consistent and here is a case where it wasn't.
