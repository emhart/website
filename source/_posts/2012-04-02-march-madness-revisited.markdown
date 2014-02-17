---
layout: post
title: "March Madness revisited"
date: 2012-04-02
comments: false
categories:
 - Null Models
 - NCAA
 - modeling
---

<div class='post'>
<table cellpadding="0" cellspacing="0" class="tr-caption-container" style="float: right; margin-left: 1em; text-align: right;"><tbody><tr><td style="text-align: center;"><a href="http://chicitysportsfan.com/wp/wp-content/uploads/2012/03/DukeDouches.jpg" imageanchor="1" style="clear: right; margin-bottom: 1em; margin-left: auto; margin-right: auto;"><img border="0" height="138" src="http://chicitysportsfan.com/wp/wp-content/uploads/2012/03/DukeDouches.jpg" width="200" /></a></td></tr><tr><td class="tr-caption" style="text-align: center;">Duke blew it this year</td></tr></tbody></table>Well, March Madness has come and gone again.  If only Ohio had beaten Kansas, I think I would have won my bracket pool, but alas!  I was curious though, how can you tell if your bracket was good or bad?  I decided to create a little null model of the tournament to see.  There are 63 possible wins in the tournament, so at first you might think random guesses would lead a distribution with a mean of 31.5.  That of course neglects the fact that the tournament has a tree like structure so errors early in the tournament propagate throughout it.  A fancy way to say this is that its a non-Markov process, a less fancy way would be to simply say that outcomes at deeper nodes in tournament are dependent on  earlier outcomes.  From a simulation perspective this is pretty easy to handle, albeit a bit of a pain to code. Below you can see the null distribution.  Its very closely approximated by a Poisson distribution with lamda = 21.357. Therefore on average if you just chose randomly you would have only gotten 21 correct picks   <br /><table align="center" cellpadding="0" cellspacing="0" class="tr-caption-container" style="margin-left: auto; margin-right: auto; text-align: center;"><tbody><tr><td style="text-align: center;"><a href="http://4.bp.blogspot.com/-i0qvCr51ALE/T3oZjgHnnQI/AAAAAAAADCc/ez0eRVHnJdk/s1600/NullMod.png" imageanchor="1" style="margin-left: auto; margin-right: auto;"><img border="0" height="328" src="http://4.bp.blogspot.com/-i0qvCr51ALE/T3oZjgHnnQI/AAAAAAAADCc/ez0eRVHnJdk/s400/NullMod.png" width="400" /></a></td></tr><tr><td class="tr-caption" style="text-align: center;">Null Model results</td></tr></tbody></table><br />The vertical lines all represent different correct game picks.  The dashed black line is the 95% confidence interval.  Its drawn at 31, so if you had 31 or fewer choices correct on your bracket, it basically means a monkey could have done better than you, or really animal since you did no better than just randomly choosing teams.  The solid black line is 40, the number of correct choices you would have had if you simply followed the seedings of the teams.  In my bracket most people did worse than this.  My number of correct picks is the blue line, 43, achieved with my model you can see in <a href="http://currentecology.blogspot.com/2012/03/march-is-mad-again.html">my previous post</a>.  Finally the red line the best bracket chosen from the <a href="http://games.espn.go.com/tournament-challenge-bracket/en_CA/leaderboard">ESPN bracket challenge</a> (its 51).  So there you have it, a way you can statistically prove that your friends are no better than monkeys and you are a genius when it comes to NCAA brackets!</div>
<h2>Comments</h2>
<div class='comments'>
<div class='comment'>
<div class='author'>Mkaproth</div>
<div class='content'>
Cool post Ted - Bravo on a great bracket this year! I was getting nervous about how I&#39;d do against a model this year... seems that KenPom.com knows what he is doing.<br /><br />Sad that some people in this year&#39;s challenge couldn&#39;t make it beyond 31 correct choices. I&#39;ll have to pester Ryan Brand about his sub-monkey performance. <br /><br />If KY wins tonight you&#39;ll get to 43 correct picks. Here&#39;s hoping for KU to win though (and for me to place #1 in two bracket challenges)!<br /><br />Matt</div>
</div>
</div>
