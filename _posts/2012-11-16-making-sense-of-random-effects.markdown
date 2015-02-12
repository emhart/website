---
layout: post
title: "Making sense of random effects"
date: 2012-11-16 13:27
comments: true
tags: R statistics analysis ecology
---


The other night in my office I got into a discussion with my office mate, the brilliant scientist  / amazing skier [Dr. Thor Veen](http://www.zoology.ubc.ca/~veen/thorubc/thor.html) about how to understand the random effect variance term in a [mixed-effects model](http://en.wikipedia.org/wiki/Mixed_model).  Thor teaches the R statistics course here at UBC, and last night a student came to the office to ask a question about how to interpret that returned from a mixed model object (in this case lmer from the package [lme4](http://lme4.r-forge.r-project.org/).  <!-- more --> The question surrounded a dataset where individual stickleback fish had been measured for a trait at different light wavelengths.  Because the individual fish had been measured multiple times, a mixed-model was fit with a fixed factor for wavelength and a random effect of individual fish.  In this case the random effects variance term came back as 0 (or very close to 0), despite there appearing to be variation between individuals.  The quesiton is under what circumstances do we expect that variance to increase, and how do we interpret it vs the residual variance.  I'll illustrate this with two simulated data sets.    
For the first example I generated some data where I imagine that same nine individuals (random effect) were measured at five different levels of some treatment (fixed effect).  In the first data set I include strong individual effects.  Here's a plot of the data:



![plot of chunk unnamed-chunk-2](http://emhart.info/images/unnamed-chunk-2.png) 


Now we can fit this model using lmer and look at the variance term


~~~~~~~~~r

m1 <- lmer(size ~ levs - 1 + (1 | ind), data = idf)
summary(m1)
~~~~~~~~~

~~~~~~~~~
## Linear mixed model fit by REML 
## Formula: size ~ levs - 1 + (1 | ind) 
##    Data: idf 
##   AIC  BIC logLik deviance REMLdev
##  84.8 97.5  -35.4       62    70.8
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  ind      (Intercept) 7.7864   2.790   
##  Residual             0.0748   0.274   
## Number of obs: 45, groups: ind, 9

~~~~~~~~~


The key component here is ~~~ind (Intercept)~~~ term and the residual variance. It should be around 7, and much higher than the residual variance.  We can see how much better our fit is compared to a fit that ignores individual effects with AIC.

~~~~~~~~~r
m2 <- aov(size ~ levs - 1, data = idf)
~~~~~~~~~

Clearly the mixed model is a much better fit because it has a much lower AIC (~~~84.8383~~~ for the mixed model vs ~~~227.1915~~~ for the model ignoring individual effects)

But what happens when you keep the exact same levels of variance within each treatment level, but randomize the individuals.  This means that the same amount of variance is there between individuals at each level, but the individuals no longer vary consistently across treatment levels.

![plot of chunk unnamed-chunk-5](http://emhart.info/images/unnamed-chunk-5.png) 



Now let's fit the same set of models


~~~~~~~~~r
m3 <- lmer(size ~ levs - 1 + (1 | ind), data = idf_rand)
m4 <- aov(size ~ levs - 1, data = idf_rand)
summary(m3)
~~~~~~~~~

~~~~~~~~~
## Linear mixed model fit by REML 
## Formula: size ~ levs - 1 + (1 | ind) 
##    Data: idf_rand 
##  AIC BIC logLik deviance REMLdev
##  221 234   -103      215     207
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  ind      (Intercept) 2.42e-11 4.92e-06
##  Residual             7.86e+00 2.80e+00
## Number of obs: 45, groups: ind, 9

~~~~~~~~~


When you examine the variance in the individual random effect, it should be close to 0 or 0, with all the variance in the residual term now.  Also, the fit between a mixed-model vs a normal ANOVA should be almost the same when we look at AIC (~~~220.9788~~~ for the mixed model vs ~~~227.1915~~~ for the model ignoring individual effects)

The variance in random factor tells you how much variability there is between individuals across all treatments, not the level of variance between individuals within each group.  If you compare the total variance between the strong indivdual effects vs the randomized data set, they have the same variance, the difference is in how it's partitioned.  In the case the randomized data, the residual variance is telling you how much variability there is within a treatment, and the variance for the random effect of indivdual tells you how much of that within treatment variance is explained by individual differences.  However if individuals don't vary consistently across treatments, that term will approach 0, and at the very least be less than the residual term.



I'm actually sort of anti-mixed model, probably because I've come up learning stats from reading [Andrew Gelman](http://andrewgelman.com/) and he has rather [strong opinions](http://andrewgelman.com/2010/12/so-called_fixed/) on the matter. I think it's often easier to just understand everything in terms of random effects and look at effect sizes.  However I'm probably in the minority in ecology when it comes to that view. I hope this helps some folks get a better understanding of understanding the random effects term in mixed models.  You can see my full code at a [gist](https://gist.github.com/4091050) where you can see how I generated the data and play around with it yourself.
