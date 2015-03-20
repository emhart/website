---
layout: post
title: "March Madness all over again"
date: 2015-03-19
comments: true
tags: [sports, R, statistics, bayes]

---

It's that time of year again, when I try with all my nerd might to outwit the people in my office in NCAA March Madness pools. I'm not much of basketball fan, let alone a college basketball fan, but the fun challenge of March Madness is trying to accurately predict the outcome.  This has become big business, you could even try your hand at [Kaggle's $15,000 prize](https://www.kaggle.com/c/march-machine-learning-mania-2015).  Their approach allows you to pull data from a large number of sources and combine it using a machine learning algorithm. However I took an approach more similar to that of the [538 blog](http://fivethirtyeight.com/interactives/march-madness-predictions-2015/#mens) where I attempt to integrate multiple rankings into a single statistical model.

In a way, a statistical model of rankings is in some ways similar to combining output of different machine learning models. Experts like [Ken Pomeroy](http://kenpom.com) all consider a variety of factors in their rankings that a machine learning model would have to account for such as strength of schedule, offense, defense etc...  The [538 model](http://fivethirtyeight.com/features/march-madness-predictions-2015-methodology/) accounts for 7 different ranking systems, but Nate Silver doesn't really get into the specifics of it. I use an approach that integrates 3 different ranking systems using a simple Bayesian model.  In this post I'll walk through my approach (I'll note that after the first day I've already busted, but I'll get to that later.)

**Show me the data!**

The model works by running simulations of every game in the tournament 10,000 times and there's a lot of code involved just in running the simulations.  The guts of the model are actually quite simple.  It uses a Bayesian beta-binomial conjugate model to simulate each game.  At this point you might be asking: "But Ted, how do you simulate all those different games with no data?". A reasonable question. The data I actually use are the [pythagorean rankings](http://kenpom.com/blog/index.php/weblog/entry/ratings_explanation) from Ken Pomeroy. You simply take the raking of team a and the ranking of team b  and use the equation below to get a binomial probability that team a will beat team b.

<div>
$$
\begin{align*}
log_5 odds = \frac{p_a-(p_a p_b)}{(p_a+p_b) - (2p_a p_b)}
\end{align*}
$$
</div>

Using the probability from the above equation, I simulate data as if the teams played each other *x* number of times.  The number of fake games any two teams play in the simulation is a way of weighting the Ken Pomeroy rankings. I have some binomial simulated data now I want to combine that with other power rankings.  The other two I use are rankings from [Jeff Sagarin](http://www.usatoday.com/sports/ncaab/sagarin/) and [Sonny Moore](http://sonnymoorepowerratings.com/m-basket.htm).  Given that my simulated data is binomial, a convenient way to combine data is with beta-binomial model.  

**The model**

The beta-binomial model is probably one of the first you'll learn about in a Bayesian statistics class.  It's convenient because the likelihood and the prior are [conjugate](http://en.wikipedia.org/wiki/Conjugate_prior) (e.g. the posterior distribution is the same family as the prior).  The basic model takes the following shape.

<div>
$$
P(\theta|n,k,\alpha ,\beta  ) \propto P(k|n,\theta)P(\theta|n,\alpha,\beta)
$$
</div>

When you muliply this all through you get the [beta-binomial posterior](http://en.wikipedia.org/wiki/Beta-binomial_distribution)

<div>
$$
\theta|n,k,\alpha ,\beta \sim Beta(\alpha + k,\beta + n-k)
$$
</div>

I use each set of power rankings to calculate  \\(\alpha\\) and \\(\beta\\), average them and use them as the posterior.  The model contains a tuning parameter that controls how diffuse the prior is, giving it more or less weight.

**How does it actually work?**

Let's walk through a single simulated game between two teams, Purdue and Cincinnati. Cincinnati's pythagorean ranking is 0.8242 and Purdue's  is 0.7825.  If I apply the log5odds formula we the odds of a Cincinnati victory are 0.565.  Next I'll simulate 20 games, in this case Cincinnati wins 13 and loses 7, e.g. in the model \\(n=20\\) and \\(k=13\\).  Then I combine the power rankings into a [beta distribution](https://github.com/emhart/ncaaModel/blob/master/ncaaModel.R#L24-L49).  In this case I calculated \\(\alpha = 10 ~~ \beta = 15.5\\).  It's probably easiest to visualize this so here's a plot of the likelihood, prior and posterior for this single match up:

<center><img src = "/assets/img/Posterior.png"></center>

The model simulates each game in this way, with the winner chosen by a random draw from the posterior.  The output is a [team by round matrix of probabilities that each team advances to a given round.](https://docs.google.com/spreadsheets/d/1Pw0WI5tU5xFOkH-TPuXJ4unfpKvBllMnMnOoljLmE3k/edit?usp=sharing)

**How does it do?**

Last time I ran this model, in 2012 (I've been doing it since 2010), it picked 45 of 63 games correctly.  So not too badly, but not stellar either.  The real problem is choosing upsets.  Some are chosen by the model because the data disagree with the AP rankings, but other than that an upset will never be picked.  One way would be to pick edge cases. For instance W. Virginia advances only 65% of the time versus Buffalo, so maybe that is an opportunity for picking an upset.  However picking a 14-3 upset like UAB over Iowa remains much harder to predict (in my model UAB won only 11% of the time).  This year though, after just one day my bracket isn't quite busted, but it's definitely in the middle of the pack in my office pool.  That probably won't change until I improve my upset picking. [(Here's the full model for this year)](https://github.com/emhart/ncaaModel)
