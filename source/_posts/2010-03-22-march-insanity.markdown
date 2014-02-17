---
layout: post
title: "March insanity"
date: 2010-03-22
comments: false
categories:
 - code example
 - Bayesian
 - MCMC
 - R
---

<div class='post'>
So I took a brief break from ecology yesterday to pursue another project, modeling the NCAA bracket.  I decided to run a stochastic simulation of the tournament.  I know this has nothing to do with ecology, but I believe its a good exercise in modeling.  Modeling has very little to do with the specifics of a process or problem and everything to do with the abstract framework you put those details into.  Data is data be it from an experiment or the NCAA, and this is an exercise in being given a problem, and using the information and tools you have to solve that problem.  Ok, enough pontificating, on with the modeling.<br /><br />So here's what I did.  I used data from the <a href="http://kenpom.com/rate.php">Pomeroy rankings </a> and the <a href="http://www.diamond-mind.com/articles/playoff2002.htm">Log 5 rule</a> to calculate a binomial probability of one team beating another.  The problem with this is that you don't have any data to actually model, its only a predictive probability.  What I wanted to do was use a simple Bayesian <a href="http://en.wikipedia.org/wiki/Beta-binomial_model">Beta-Binomial</a> model and integrate prior information from my more NCAA savy friends.  I used this model to simulate the NCAA bracket 10,000 times for each friend and with a flat prior.  So here's what I did 10,000 times.<br /><br />First I used the Pomeroy probability to simulate 34 games between any two teams meeting in the tournament.   I used that simulated data in the beta binomial model as my number of successes and failures.  I then asked my friends to provide me with two probabilities for each team, a probability of them making it to the final four and a probability of a team winning it all.   When teams encountered each other in the simulation I calculated the odds of one team beating another and then converted those odds into a probability and then used an algorithm to solve for the parameters of a beta-distribution.  I scaled the beta parameters to reflect the confidence my experts had in their picks.   In the tables you can see that priors can have a pretty heavy influence on picks.  Here are my tables, each number represents the probability that a team makes it to a given round of the tournament.<br /><br /><a href="http://spreadsheets.google.com/ccc?key=0AvM0mgmVJAKUdGxFclgwNk9YTGhGRzg2Q2RacXFGV3c&hl=en">Flat priors.</a><br /><br /><a href="http://spreadsheets.google.com/ccc?key=0AvM0mgmVJAKUdGdXV2xxM1E2bmd1SVpnYkZoNlBPdmc&hl=en">Combined priors</a><br /><br />Here is the <a href="http://docs.google.com/Doc?docid=0AfM0mgmVJAKUZGRnZ3hkeG5fMzhjM3Q1YnNjOA&hl=en">code in R for the model</a></div>
