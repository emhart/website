---
layout: post
title: "Sheep cyclone problem...a start."
date: 2012-02-24
comments: false
tags:
 - code example
 - blog response
 - netlogo
---

<div class='post'>
The other day the <a href="http://oikosjournal.wordpress.com/">Oikos blog</a> posed <a href="http://oikosjournal.wordpress.com/2012/02/23/modeling-challenge-explain-sheep-cyclones/">this problem</a> from the <a href="http://theartofmodelling.wordpress.com/2012/02/22/blog-challenge-sheep-cyclone/">"Just simple enough" blog</a> by Amy Hurford.  I'll quote the problem here.   <br /><br /><table cellpadding="0" cellspacing="0" class="tr-caption-container" style="float: left; margin-right: 1em; text-align: left;"><tbody><tr><td style="text-align: center;"><a href="http://semprecool.com/wp-content/uploads/2012/02/sheep-cyclone-1.jpg" imageanchor="1" style="clear: left; margin-bottom: 1em; margin-left: auto; margin-right: auto;"><img border="0" height="145" src="http://semprecool.com/wp-content/uploads/2012/02/sheep-cyclone-1.jpg" width="200" /></a></td></tr><tr><td class="tr-caption" style="text-align: center;">Sheepclone!</td></tr></tbody></table><b>"What type of individual movement rules are needed to produce a <a href="http://www.youtube.com/watch?v=4u96YfOB48Q">Sheep cyclone</a>?"</b><br /><b><br /></b><br />Well, I decided this would be a good time to refresh my <a href="http://ccl.northwestern.edu/netlogo/">Netlogo</a> knowledge and give it crack.  I'll be the first to admit this is a sub-optimal solution.  But I thought with the combination of flocking behavior and avoidance rules I might be able to recreate the cyclones. Well, it turns out that was not the case.  I built upon the preexisting flocking model in Netlogo.  I added a car and some walls and the avoidance behavior.  I controlled how far and wide the sheep could see in front of them and how many degrees off their current heading they would turn.  I also differentially weighted their perception of "walls" and "cars".  They would turn away from a car earlier than they would a wall.  Unfortunately I didn't quite get the cyclone effect.  Mostly it seemed to generate some sheep in front and some behind the car just sort of buzzing around with the occasional circle.  <br><br>So what did I learn from this?  The rules are a bit more complicated than I first thought.  Of course I could just program the sheep to run around the car, but really what's the point of that?  The purpose of agent based modeling is to reproduce a given pattern with a plausible set of underlying rules, not just recreate a specific behavior.  I believe that two things need to happen to generate the behavior.  One is change in flocking rules.  The idea would be to create a panic state where the sheep no longer flock the way they nornally do but always follow their nearest neighbor.  Next they need an escape behavior by turning away from a wall next to them.  This behavior would generate the left turn around the car after the sheep has passed it but still has the alley to its right. I haven't had time to program these more complicated rules, but I'll get around to it.  You can see a couple of youtube videos I made <a href="http://www.youtube.com/watch?v=ElWg0m4UlSM">here</a> and <a href="http://www.youtube.com/watch?v=jzLCUJu-s0E">here</a>, and then download and run my Netlogo <a href="https://github.com/emhart/Misc_Func/blob/master/blogmod.nlogo">code from Github</a>.</div>
<h2>Comments</h2>
<div class='comments'>
<div class='comment'>
<div class='author'>Alex Kennedy</div>
<div class='content'>
Better to have a pedestrian lane for sheep then :)<br /><br /><a href="http://www.findthebestdeals.com/go.php/search=car+parts" rel="nofollow">Car Parts</a> </div>
</div>
<div class='comment'>
<div class='author'>Amy Hurford</div>
<div class='content'>
This is so cool!</div>
</div>
</div>
