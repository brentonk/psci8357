# Final Paper
PSCI 8357, Spring 2016  
February 25, 2016  


Four deadlines are relevant:

* The *proposal* for your final paper is due at the start of class on March 17.
* The *initial draft* of your final paper is due to me and your assigned peer reviewer at the start of class on April 7.
* Your *peer review* of a classmate's initial draft is due to me and your assigned peer reviewee at the start of class on April 14.
* Your *final paper* is due at noon on April 29.

This handout will first lay out the guidelines for the final paper itself, then the proposal, and finally the peer review.


## Final Paper

You will begin by identifying a political science publication[^ahem] that includes a regression analysis.  A good choice would be a piece that is published in a good journal and has publicly available replication data, but that hasn't been analyzed to death.[^death]  From there, your task is threefold:

1. To *reproduce* the main findings in the original paper.  Can you obtain the exact same coefficient and standard error estimates as reported in the original paper?  If not, identify the differences between your findings and the original paper's, and explain whether these differences are important for the conclusions we would draw from the analysis.

2. To examine the *robustness* of the main findings.  We have seen that researchers have many choices in the way they analyze data.  Would slightly different choices have led to wildly different conclusions?  Focus on areas where the assumptions of the original analysis strike you as doubtful.

3. To *extend* the original analysis in a theoretically motivated way.  Think of some additional hypotheses that would speak to the theory put forth in the original paper, and test them.  At this stage you may (but don't have to) bring in additional data from outside the replication file---if you choose to do so, be sure that the files can be merged!

[^ahem]: If you are not a political scientist, you may choose a piece from your own field.

[^death]: Examples of papers that have been analyzed to death include Oneal and Russett's "The Classical Liberals Were Right" and Fearon and Laitin's "Ethnicity, Insurgency, and Civil War."

Given that we have largely focused on the linear model in this class, I strongly recommend choosing to reanalyze a paper that employs linear models (which typically means the response variable is continuous).  If you decide to neglect this advice and analyze a paper that uses a nonlinear model, please highlight this on your proposal so we can talk through it first.

An assignment like this is often called a *replication* project.  True replication, however, entails collecting new data and running the same tests on it---a task that requires resources beyond what is available to you at the current stage of your careers.

Some notes on formatting and submission:

* Your paper must be written as if intended for publication as a research note in a political science journal.  You may use R Markdown to write it, but there should be no raw R code or raw output in the paper itself.  Now is the time to become familiar with the **xtable** and **stargazer** packages.

    Examples of papers like this include:
    * Andrew Reeves, Lanhee Chen, and Tiffany Nagano, "A Reassessment of 'The Methods behind the Madness: Presidential Electoral College Strategies, 1988--1996'" (2004, *Journal of Politics*)
    * Kosuke Imai, "Do Get-Out-the-Vote Calls Reduce Turnout?" (2005, *American Political Science Review*)
    * Vipin Narang and Rebecca Nelson, "Who Are These Belligerent Democratizers? Reassessing the Impact of Democratization on War" (2009, *International Organization*)

* You must submit all of the following material along with a PDF copy of your paper:
    * The raw replication data from the paper you are reanalyzing
    * A script or set of scripts that perform all the analysis in your paper, from initial data wrangling to final reported results

    I *will* attempt to reproduce your analysis using the files you have provided.  You *will* fail the assignment if I cannot reproduce your findings in this manner.  Every table, every graph, and every reported finding must emanate from your replication script(s).  Let me reiterate: **Every table, every graph, and every reported finding must emanate from your replication script(s).**


## Proposal

Your proposal is a short (1--2 page) document that lays out what you intend to do in your final paper.  The purpose of the proposal is to avoid problems arising at the last minute---to allow me to verify that what you're thinking of doing is appropriate and has a good chance of becoming a successful final paper.

Your proposal needs to address a few key points:

* The publication you intend to reanalyze.
* Verification that you *have already obtained* the replication data for the publication in question.
* A brief summary of the hypotheses, methods, and conclusions of the article.
* Your initial ideas about how to robustness-check and extend the original analysis.


## Peer Review

A few weeks before the due date, you will turn in an initial draft to me and to a designated reviewer (see below).  A week later, you will write a review to circulate to me and to your designated reviewee.  Your tasks as a reviewer are twofold:

1. To assess whether you were able to reproduce all of the findings in the initial draft, and if not, which findings you could not reproduce.
2. To evaluate the initial draft's choices of robustness checks and extensions.  Are they well motivated by the theory being studied?  Do they follow statistical best practices?  Does the initial draft correctly interpret their findings?  What other analyses would you suggest the author run?

In the interests of fairness, I have assigned reviewers randomly in round-robin fashion.  You can see the code I used and your own designated reviewer and reviewee below.


```r
set.seed(77)
students <- c("Nicole", "Dave", "Spencer", "HeeJu",
              "Sebastian", "Ginny", "Michael", "Adam")
students <- sample(students)
students <- c(tail(students, 1), students, head(students, 1))

for (i in seq(2, length(students) - 1)) {
    cat(students[i],
        "reviews",
        students[i - 1],
        "and is reviewed by",
        students[i + 1],
        "\n")
}
```

```
## Spencer reviews Nicole and is reviewed by Ginny 
## Ginny reviews Spencer and is reviewed by Michael 
## Michael reviews Ginny and is reviewed by Sebastian 
## Sebastian reviews Michael and is reviewed by Adam 
## Adam reviews Sebastian and is reviewed by Dave 
## Dave reviews Adam and is reviewed by HeeJu 
## HeeJu reviews Dave and is reviewed by Nicole 
## Nicole reviews HeeJu and is reviewed by Spencer
```
