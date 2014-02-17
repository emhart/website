---
layout: post
title: "Discrete colors in ggplot"
date: 2012-09-01 11:19
comments: true
categories: R ggplot2 visualization
---

Have you ever wanted an easy way to generate continuous color pallettes for a discrete factor?  I came across a question over on [Stackoverflow](http://stackoverflow.com/questions/12229969/specifying-the-colour-scale-for-maps-in-ggplot/12230207#12230207) about how add color to a ggplot figure. I often find myself with lot's of categories that are discrete when I want a continuous color plot. 
This can be achieved by writing a quick little function for your colors as:
```r
gs.pal <- colorRampPalette(c("#FFFFFF","#000000"),bias=.1,space="rgb")
```
Now you've got a function called `gs.pal` that accepts the number of colors you want evenly spaced between the two hex code, e.g. `gs.pal(5)` will generate 5 different evenly spaced color codes.  Here it goes between black and white, but you could do between any colors you want.  You can put in as many colors as you want in your color vector.  Bias controls how much spacing happens between your parameters. Here's low spacing, with your pallete function set as  going from red to blue to yellow.`gs.pal <- colorRampPalette(c("#AF1E2D","#0147FA","#FFFF00"),bias=.1,space="rgb")
`

![small bias parameter](http://emhart.github.com/images/smallbias.png)

You can get more smoothing (depending on how many different categories you have) by adjusting the bias parameter, here I'll set it to 1, and you'll see much better smoothing. `gs.pal <- colorRampPalette(c("#AF1E2D","#0147FA","#FFFF00"),bias=1,space="rgb")
<!--more-->

![large bias parameter](http://emhart.github.com/images/largebias.png)

Now if you have multiple factors that you want to have continuous like labeling for, all you need to do is create this little function with the colors you want spaced between and then use it in base graphics or `ggplot2`.  For instance in `ggplot2` you can just use the line `scale_colour_manual(values=gs.pal(5))` to generate discrete color values that appear continuous. This code will generate a nice figure with 5 levels moving from red to blue
{% gist 3836105 %}
![ggplot example](http://emhart.github.com/images/ggplotcont.png)