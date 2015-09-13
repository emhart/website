---
layout: post
title: "Conference tweet API: data sharing the hard way"
date: 2015-09-13
comments: true
tags: [software development, API, javascript, node, analytics]
---

<center>__TL;DR__<br>
_download tweet data via [API]( http://emhart.info/tweets/ESA/2015?sn=ESA_org&limit=10) or download the full [sqlite db's](https://github.com/emhart/tweetDBapi/tree/master/data)_
</center>


I love twitter.  I think it's a great tool to build community, and in my case it's the software/ecology/data science community.  While day to day twitter is certainly interesting, conferences make great short term experiments of how the scientists communicate about a specific topic.  This is for a couple of reasons, but 1). people become a lot more active during a conference than they normally are 2). everyone will use the same hashtag in their tweets.  So when people tweet about ecology they rarely use the same hashtag, but when ESA (Ecological Society of America conference) is happening, everyone is using the meeting hashtag.  This wealth of data is quickly lost unless you buy it from a 3rd party like [Topsy](http://www.topsy.com) or archive it yourself.  Given that these conferences are still relatively small, it's easy to archive yourself.  Last year I built a tool to semi-easily do this, [tweetDB](https://github.com/emhart/tweetDB).  

I now have a couple conferences worth of twitter data so for fun I wanted to create my own API to share that data.  This post is just to quickly share the documentation for the API, in another post I can share the nuts and bolts but if you want you can check out the [repo for the API here.](https://github.com/emhart/tweetDBapi). Currently you can access data by conference and year.  Within each combination you can download tweets by screen name or date, or a combination of the two.  The current conferences I have data for are ESA and JSM (the ASA joint statistical meeting).  I have ESA data for 2014 and 2015, and JSM for 2015.

### List all available screen names
__Resource URL:__ http://emhart.info/screen_name/:conferce/:year

Resource Parameters

* conference - A conference acronym, either JSM or ESA.
* year - A valid conference year, either 2014 or 2015

_Example call:_ [http://emhart.info/screen_name/ESA/2014](http://emhart.info/screen_name/ESA/2014)

_Example result:_

```javascript
[{"screen_name":"ESA_org"},
{"screen_name":"desert_ecology"},
{"screen_name":"carlyziter"}]
```

### List all available dates
__Resource URL:__ http://emhart.info/date/:conferce/:year

Resource Parameters

* conference - A conference acronym, either JSM or ESA.
* year - A valid conference year, either 2014 or 2015

_Example call:_ [http://emhart.info/dates/JSM/2015](http://emhart.info/dates/JSM/2015)

_Example result:_

```javascript
[{"rptg_dt":"2015-08-06"},
{"rptg_dt":"2015-08-05"},
{"rptg_dt":"2015-08-04"}]
```

### Get twitter data
__Resource URL:__ http://emhart.info/tweets/:conferce/:year?sn=<screen_name>&date=<date>&limit=<limit>

Resource Parameters

* conference - A conference acronym, either JSM or ESA.
* year - A valid conference year, either 2014 or 2015

Query Parameters

* sn - A twitter screen name, e.g. emhrt_
* date - A well formed ISO date, e.g. 2015-08-11
* limit - The number of records to return

Queries can have either `sn` to get all tweets for a given screen name or `date` to get all tweets on a valid date (see above for how to get valid dates).  Alternatively both can be included to access a specific screen name's tweets on a given date.  The `limit` parameter is not necessary, only a convenience.

_Example call:_ [http://emhart.info/tweets/ESA/2015?date=2015-08-10&limit=1](http://emhart.info/tweets/ESA/2015?date=2015-08-10&limit=1)

_Example result:_

```javascript
[{"id":"630602610156945408",
"created_at":"Mon Aug 10 04:52:32 +0000 2015",
"user_name":"Kristen DeAngelis",
"screen_name":"kristenobacter",
"tweet_text":"RT @Rainb0w_Dashie: Anypony else look into that #ESA100 thing? They act all coy on twitter asking bronies to come yet reg is $500!. Ecologi…",
"favorites":0,
"retweets":10,
"location":"None",
"expanded_url":"None",
"in_reply_to_tweet_id":null,
"in_reply_to_user_id":null,
"rptg_dt":"2015-08-10",
"timestamp":"2015-08-10 04:52:32"}]
```

I created the API mostly because I thought it would be a fun learning experience.  If you want, you can grab the full sqlite3 databases from the git repo in the TL;DR.
