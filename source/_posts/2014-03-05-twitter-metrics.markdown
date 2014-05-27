---
layout: post
title: "Twitter Metrics From #scio14, a Brief Overview"
date: 2014-03-05 15:51:03 -0700
comments: true
categories: [R,programming, science]
---

While I was at [#scio14](https://twitter.com/search?q=%23scio14) last week I attended a session hosted by [David Shiffman](http://www.southernfriedscience.com/?author=3), better known as [@whysharksmatter](https://twitter.com/WhySharksMatter).  The session was about using [social media as a research tool](http://scio14.sched.org/event/20f24d41cee973a70bbe53d9d6a7cb1a), with the hash tag [#scioResearch](https://twitter.com/search?q=%20%23scioResearch).  In the session people talked about how to access twitter data, and I blithely remarked "Just use the twitter API, it's pretty easy to access". <!--more-->
I said "Just buy your favorite programmer a beer, better yet, buy me a beer and I'll do it."
<center><blockquote class="twitter-tweet" lang="en"><p>Test the waters with &#39;low hanging metrics&#39; and buy <a href="https://twitter.com/DistribEcology">@DistribEcology</a> a beer! <a href="https://twitter.com/search?q=%23scioResearch&amp;src=hash">#scioResearch</a></p>&mdash; Laksamee Putnam (@LibrarianLaks) <a href="https://twitter.com/LibrarianLaks/statuses/439495603199180800">February 28, 2014</a></blockquote></center>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
Sadly, no one offered to buy me a beer :( .  However, I figured I should eat my own dog food and actually accept the challenge.  But another attendee, [Helen Chappell](https://twitter.com/helenchappell), said she was interested in using basic twitter metrics to understand what people were saying about the museum she works for [the North Carolina Museum of Natural Sciences](http://naturalsciences.org/).  After the session I said I would give it a crack.  So without further ado....

First if you're thinking "I don't want to walk through someone else's code", [enjoy my gist of it all.](https://gist.github.com/emhart/9399250) A caveat before we begin, this will work because we're looking through a relatively small number of tweets.  I haven't tried this on a large scale, but you probably won't grab all the tweets if there are 10,000+.  I'll showing this example in R, but there's [no shortage of libraries](https://dev.twitter.com/docs/twitter-libraries) out there for grabbing twitter data.  I've grabbed tweets in both python and R, and while the R one is more user friendly, the python interfaces are more powerful (maybe more on that later).  
For this though, we'll use the [twitteR](http://cran.r-project.org/web/packages/twitteR/index.html) package to grab some data.  Just a note, you'll need to go through the hassle of creating your [own api key](https://dev.twitter.com/discussions/631) for any of this to work.  The code below will authorize us to search twitter, and then grab our query of interest.  In this case it's *@naturalsciences* because we are interested in all tweets that mention the museum.

```r Authorizing with twitter and searching for tweets start:1
library(twitteR)
# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
#### This is all the code you want to authorize with the twitter API and then grab tweets!

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

consumerKey <- "YOUR_KEY"
consumerSecret <- "YOUR_SECRET"

twitCred <- OAuthFactory$new(consumerKey=consumerKey,consumerSecret=consumerSecret,requestURL=reqURL,accessURL=accessURL,authURL=authURL)

twitCred$handshake()

registerTwitterOAuth(twitCred)

## Do the actual search  
scioSearch <- searchTwitter(searchString = "@naturalsciences",n=1000)

##Check how many tweets there were
print(length(scioSearch))
```
Great, so now we have an R list with all of our tweets.  If we check the length of our search results, it's 260, so there were 260 tweets that mentioned @naturalsciences in the last week or so.  What do we do with it? Well a pretty quick way to visualize what we got is with a word cloud. Creating [word clouds in R](http://www.rdatamining.com/examples/text-mining) is boiler plate stuff, so I wrote a simple function that will extract the full text of all of our search results and [make a word cloud](https://gist.github.com/emhart/9399250#file-naturalsciencestwitter-r-L40-L86).
<center> <a href = "http://emhart.info/images/TotalWordcloud.png"><img src = "http://emhart.info/images/TotalWordcloud.png" height = 350 width = 350></a></center>
If we look at this absolute word cloud, we can see that several twitter folks were mentioned a lot (probably via retweets), especially *whysharksmatter*, [*DNLee*](https://twitter.com/DNLee5), and [*ehmee*](https://twitter.com/ehmee).  This makes sense because between the 3 of them, they have ~45k followers.  People were also talking about stormfest, scio14, and skinning squirrels.  In fact if we were to look at which tweet was retweeted the most, we'd see it's this one.
<center>
<blockquote class="twitter-tweet" data-cards="hidden" lang="en"><p>Skinned an albino grey squirrel for the <a href="https://twitter.com/naturalsciences">@naturalsciences</a> today! &lt;3 <a href="http://t.co/pqVuA0UHLF">pic.twitter.com/pqVuA0UHLF</a></p>&mdash; Emily Graslie (@Ehmee) <a href="https://twitter.com/Ehmee/statuses/439554994879344640">March 1, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</center>
So it's no wonder this is what comes out in the word cloud.  In fact of the last 260 tweets, I calculated that ~50% were retweets, not original tweets.

Now, this gives us a big picture of what is going on, but let's say we want to drill down a bit.  Obviously when it comes to analyzing tweets, the major shortcoming is often not getting the data, it's what to do with it. One thing we might be interested is seeing a topics "velocity" on twitter.  That is, how rapidly people are tweeting about something.  So let's clean up our data, and then do a plot of the cumulative number of tweets vs time.

```r create data frame and plot tweets vs time
library(plyr)
library(ggplot2)

 ## Grab data from search results, put it into a nice dataframe
fullText <- ldply(scioSearch, function(x) return(x$text))
retweets <- ldply(scioSearch, function(x) return(x$retweetCount))
wasRetweet <- ldply(scioSearch, function(x) !is.na(grep("RT",x$text)[1]))
# Extract user names
screenName <- ldply(scioSearch, function(x) return(x$screenName))
### Extract time stamps
dates <- ldply(scioSearch, function(x) return(as.POSIXct(x$created)))

### View the fraction of retweets
print(sum(was_retweet)/length(scioSearch))

### We could also see the rate of tweeting
### Create tweet date data frame

tweetDF <- data.frame(screenName,dates,fullText)
### Add accumulation
tweetDF$tweetN <- dim(tweetDF)[1]:1
tweetDF$diffs <- rapidTweets(dates$V1,thresh=2500)
colnames(tweetDF) <- c("screenName","date","fullText","tweetN","groups")

ggplot(tweetDF,aes(x=date,y=tweetN))+geom_point() + theme_bw(20) + xlab("Date") + ylab("Cumulative tweet number")

```
<center> <a href = "http://emhart.info/images/CumuTweet.png"><img src = "http://emhart.info/images/CumuTweet.png" height = 382 width = 700></a></center>

Now we can see there are a few areas where a lot of tweets are happening with long periods of not much going on.  To quantify this, [I wrote a quick little algorithm](https://gist.github.com/emhart/9399250#file-naturalsciencestwitter-r-L15-L37) that will label tweets based on group size, and tweet time interval.  I applied that to the search results, grouping by tweet speed, and then I text mined each group.  In the results below, groups were formed by tweets where more than 10 tweets in a row happened in less than 2500 seconds (~40 minutes).  I then color coded the groups, and plotted the 4 most frequent words associated with each group. I won't put all this code in the post, but you can (find it here in the gist)[https://gist.github.com/emhart/9399250#file-naturalsciencestwitter-r-L146-L192].  Here's the resulting figure:

<center> <a href = "http://emhart.info/images/grouPlot.png"><img src = "http://emhart.info/images/grouPlot.png" height = 382 width = 700></a></center>

Now we have a bit of insight into what was driving traffic when, and how that relates to events at the museum.  So on Thursday Feb 27th, lot's of folks were talking about *@whysharksmatter* and *@DNLee*, #scio14, and maybe something to do with sharks.  If I examine the time stamps of the next two groups, I can see that the blue group is the morning, and the red is the afternoon of Feb. 28th.  I know that in the afternoon is when the squirrel skinning happened, and that is reflected in all the twee.  It seems like in the morning (blue group), people were really interested in something to do with arthropods and weather.  By classifying tweets with this "velocity", we can also look at what's happening when these big traffic driving events weren't happening.  Below is the word cloud of all the non color coded points (tweets probably not spurred by one big event).
<center> <a href = "http://emhart.info/images/Index0WC.png"><img src = "http://emhart.info/images/Index0WC.png" height = 350 width = 350></a></center>

In those non big traffic tweets it looks like people were still excited about the squirrel skinning, something happening on Thursday, and an exhibit on storms, or live storms. One last *caveat emptor*. When dealing with text mining twitter data, it's an iterative process.  In text mining you often have to pull out stop words, so for instance I had to pull out "naturalsciences" because that was always the biggest word.  Also people's screen names often stand out if you have lot's of retweets, so it helps to know who some of your biggest retweeters are. So there you have it, a few low hanging twitter metrics that anyone can grab.  If there's enough interest in this, I could write a basic package that would make these a bit easier, and if you have others feel free to suggest them.
