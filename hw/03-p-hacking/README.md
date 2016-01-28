# Assignment 3: You'll Just Run 300,000 Regressions
PSCI 8357, Spring 2016  
January 28, 2016  

This assignment must be turned in by the start of class on **Thursday, February 4**.  You must follow the [instructions for submitting an assignment](http://bkenkel.com/psci8357/submission-instructions.pdf).


## Main Task

In class this week, we discussed how replication with new data can help ameliorate the problems caused by publication bias and the statistical significance filter.  But what can we do if new data isn't forthcoming?

The literature on economic growth faced exactly this problem in the early 1990s.  Dozens of different variables had been found to be statistically significant correlates of growth, depending on the exact specification one used.  But we can't wait another 50 years to replicate these studies with another half-century of growth data.  To figure out which correlations were robust---i.e., which ones were not sensitive to a particular choice of specification--\-@levine-renelt regressed growth on every conceivable combination of covariates (within limits).  @sala, in the brilliantly titled article "I Just Ran Two Million Regressions," refined their approach.

In this assignment, you will only run a little more than 300,000 regressions.[^specifics]  The application is a political science topic as prominent and bedeviling as that of growth rates in economics: the correlates of civil war onset.  Your analysis will mirror that of @hegre-sambanis, who bring the millions-of-regressions approach to the civil war literature.  You will be working with the data file `hs-imputed.csv`, a cleaned version of the @hegre-sambanis data with missing values imputed.[^imputation]

[^specifics]: Specifically, you will run $3 \times \binom{87}{3} = 317,985$ regressions.

[^imputation]: See the file `clean-and-impute.r` for how I cleaned up their replication data and imputed missing values.  Because of the sheer number of variables involved relative to the time available to prepare a homework assignment, my approach was cursory and sloppy.  In your own manuscripts, including the final paper for this class, you should be considerably more inquisitive and careful about missing values than I am in `clean-and-impute.r`.

The data is in country-year format, with the following variables:

* `country` and `year`: Self-explanatory.
* `warstns`: Indicator for whether a civil war began.  This will be the response variable in all of your regressions.
* Three "core" covariates to include in every regression:
    * `ln_popns`: The natural logarithm of the country's population.
    * `ln_gdpen`: The natural logarithm of the country's GDP per capita.
    * `pt8`: $2^{t/8}$, where $t$ is the number of years the country has been at peace.
* Eighty-eight "concept" variables whose association with civil war onset you will be testing.  Descriptions of each appear in Table 1 of @hegre-sambanis.

You will select $J = 3$ of the 88 "concept" variables to test the robustness of their association with civil war onset.  One of these must be `ehet`, the ethnic heterogeneity index; the other two are up to you.  For each variable, we want to estimate the average probability of $\hat{\beta}_j > 0$, where the average is taken over the sampling distributions of each different regression specification.  For each of these variables, $j = 1, 2, 3$, you will do the following:

* Consider the set of $M = \binom{87}{3}$ combinations of three covariates from the 87 other concept variables.
* For each $m = 1, \ldots, M$, you will:
    * Regress `warstns` on your chosen variable $X_j$, the three core covariates, and the $m$'th combination of other concept variables.  (So every regression will have seven covariates, plus an intercept.)
    * Save the following quantities:
        * $\hat{\beta}_{jm}$: the estimated coefficient on $X_j$
        * $\hat{\sigma}_{jm}^2$: the estimated variance (squared standard error) of the coefficient on $X_j$
        * $R_{jm}^2$: the $R^2$ of the regression
* Using the results across each model, calculate the following:
    * A weight for each model, proportional to its $R^2$: $$\omega_{jm} = \frac{R_{jm}^2}{\sum_{l=1}^M R_{jl}^2}$$
    * The average estimated coefficient, $$\bar{\beta}_j = \sum_{m = 1}^M \omega_{jm} \hat{\beta}_{jm}.$$
    * The average estimated variance of the coefficient, $$\bar{\sigma}_j^2 = \sum_{m=1}^M \omega_m \hat{\sigma}_{jm}^2.$$
    * The so-called average $p$-value, $$\bar{p}_j = \sum_{m=1}^M \omega_{jm} \Phi(0 \,|\, \hat{\beta}_j, \hat{\sigma}_j^2),$$ where $\Phi(0 \,|\, \mu, \sigma^2)$ is the probability of drawing a value less than zero from a normal distribution with mean $\mu$ and variance $\sigma^2$.  This is *not* the average of the individual $p$-values, since direction matters.

In the last step, you're essentially answering the following: Suppose you drew a model at random, where the probability of choosing each model is proportional to its $R^2$.  Then, suppose you drew a value of $\beta_j$ from the estimated sampling distribution of the coefficients of this model.  What is the probability that the value you drew is less than zero?  A result close to 0 or 1 indicates a robust relationship.  A result close to 0.5 indicates that the sign of the estimated coefficient is highly dependent on the particular specification---and thus the relationship is not robust.

Interpret your results.  Which of the covariates you chose is robustly associated with civil war onset?  Which are not?  What are the limitations of this approach---what might we be missing by analyzing robustness this way?

Your results will not be exactly the same as in @hegre-sambanis.  First, you are assuming a linear model and using OLS, whereas they assume a logistic model and use its maximum likelihood estimator.  Second, missing values in the data have been imputed, so you do not need to worry about combinations of covariates that make the sample size too small.


## Weekly Visualization Challenge

Compare the estimated distribution of draws of $\hat{\beta}_j$ across the three variables you chose to study.


## Hints



Here are some R tips I found useful in completing this assignment myself.  You don't have to use them, but I bet you will find them useful too.

### Caching Output

It should take about 12 seconds to run a thousand regressions, which means about an hour to run 300,000.


```r
300000 * (12 / 1000) / 60
```

```
## [1] 60
```

You don't want to have to spend an hour recompiling your R Markdown document every time you make a tiny change.  I strongly recommend using the `cache = TRUE` chunk option for your major computations, as described in <http://yihui.name/knitr/demo/cache/>.

### Creating Combinations

You can use the `combn()` function in R to generate all possible combinations of a particular length from a particular set.  For example, here we have every combination of two letters from the first five letters in the alphabet.


```r
combn(x = letters[1:5], m = 2)
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
## [1,] "a"  "a"  "a"  "a"  "b"  "b"  "b"  "c"  "c"  "d"  
## [2,] "b"  "c"  "d"  "e"  "c"  "d"  "e"  "d"  "e"  "e"
```

### Set Difference

Suppose you have two vectors `a` and `b`, and you want to retrieve every element of `a` that is not an element of `b`.  You could do this the long way.


```r
a <- c("a", "b", "c", "d", "e")
b <- c("b", "d")

a[!(a %in% b)]
```

```
## [1] "a" "c" "e"
```

Or you could just use the set difference function, `setdiff()`.  Surely you remember set differences from the math boot camp.


```r
setdiff(a, b)
```

```
## [1] "a" "c" "e"
```

This is especially useful if `a` and `b` have long and unwieldy names.  While you're thinking about set operations, `union()` and `intersect()` work too.


```r
union(a, b)
```

```
## [1] "a" "b" "c" "d" "e"
```

```r
intersect(a, b)
```

```
## [1] "b" "d"
```

### Selecting Variables with a Character Vector

You can use **dplyr**'s `select(one_of(var_names))` to select variables according to the character vector `var_names`.


```r
library("dplyr")

fake_data <- data.frame(matrix(rnorm(30), ncol = 5))
names(fake_data) <- letters[1:5]
fake_data
```

```
##        a      b      c      d       e
## 1  0.436  0.350  0.937  1.906 -1.2629
## 2 -0.267 -0.489  0.164 -0.927  0.4763
## 3 -0.143  0.442 -0.499  0.357 -1.0801
## 4  1.967  0.639 -0.139 -0.979  0.0329
## 5 -1.060  1.969 -0.337 -0.287 -1.8218
## 6 -0.843 -1.465  0.472  0.103  0.9518
```

```r
var_names <- c("b", "d")
fake_data %>% select(one_of(var_names))
```

```
##        b      d
## 1  0.350  1.906
## 2 -0.489 -0.927
## 3  0.442  0.357
## 4  0.639 -0.979
## 5  1.969 -0.287
## 6 -1.465  0.103
```

### Regress on All Variables

Suppose you have a data frame with a bunch of variables in it, and you want to regress one of those variables on all the others.  You can do this without writing out a long formula.  Just use a formula like `y ~ .`, where `y` is the name of your response variable.


```r
linear_fit <- lm(a ~ ., data = fake_data)
summary(linear_fit)
```

```
## 
## Call:
## lm(formula = a ~ ., data = fake_data)
## 
## Residuals:
##      1      2      3      4      5      6 
##  0.317  0.615  0.384  0.299 -0.739 -0.876 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)     1.45       1.37    1.06     0.48
## b               3.96       2.91    1.36     0.40
## c              -1.63       2.64   -0.62     0.65
## d               2.77       2.53    1.09     0.47
## e               5.12       3.92    1.31     0.42
## 
## Residual standard error: 1.42 on 1 degrees of freedom
## Multiple R-squared:  0.661,	Adjusted R-squared:  -0.695 
## F-statistic: 0.488 on 4 and 1 DF,  p-value: 0.775
```

### Extract Regression Details

R makes it unnecessarily hard to extract the estimated standard errors and other interesting quantities from regression results.  The [**broom**](https://cran.r-project.org/web/packages/broom/index.html) package does the hard work for you.  Just use the `tidy()` function to get a data frame with the information you want.


```r
library("broom")
tidy(linear_fit)
```

```
##          term estimate std.error statistic p.value
## 1 (Intercept)     1.45      1.37     1.059   0.482
## 2           b     3.96      2.91     1.361   0.403
## 3           c    -1.63      2.64    -0.618   0.647
## 4           d     2.77      2.53     1.094   0.471
## 5           e     5.12      3.92     1.306   0.416
```

The output is a data frame, which means we can use all our favorite **dplyr** tools on it.


```r
tidy(linear_fit) %>%
    filter(term == "d") %>%
    select(estimate, std.error)
```

```
##   estimate std.error
## 1     2.77      2.53
```

You can extract additional information, including the $R^2$, with the `glance()` function.  Its output looks like a vector, but it's actually a one-row data frame.


```r
glance(linear_fit)
```

```
##   r.squared adj.r.squared sigma statistic p.value df logLik  AIC  BIC
## 1     0.661        -0.695  1.42     0.488   0.775  5  -5.26 22.5 21.3
##   deviance df.residual
## 1     2.03           1
```

```r
glance(linear_fit) %>% select(r.squared)
```

```
##   r.squared
## 1     0.661
```


## References
