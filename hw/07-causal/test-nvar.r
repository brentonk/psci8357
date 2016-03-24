################################################################################
###
### Test how big the sample needs to be for a particular number of variables to
### (mostly) assure there won't be any empty cells
###
################################################################################

library("foreach")
library("iterators")

smallest_cell <- function(n, k)
{
    ## Simulate n observations of k Bernoulli(0.5) variables
    x <- rbinom(n * k, 1, 0.5)
    x <- matrix(x, ncol = k)

    ## Simulate treatment variable
    pr_t <- (rowSums(x) + 4) / (k + 8)
    t <- rbinom(n, 1, pr_t)
    x <- cbind(x, t)

    ## Calculate the 2^(k+1) crosstab
    tab <- table(as.data.frame(x))

    min(tab)
}

dist <- foreach (icount(10000), .combine = "c") %do% {
    smallest_cell(500, 4)
}
