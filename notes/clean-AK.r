################################################################################
###
### Clean the Angrist and Krueger (1990) data
###
################################################################################

library("dplyr")
library("foreign")
library("AER")

AK <- read.dta("AK1991.dta")

## Rename variables and drop unused columns
AK <- select(AK,
             year = v27,
             quarter = v18,
             educ = v4,
             wage = v9,
             age = v2)

## Only keep observations with 1920s birth years
AK <- filter(AK,
             1920 <= year,
             1929 >= year)

## Check that OLS and TSLS estimates match the ones reported in the log file
fit_ols <- lm(wage ~ educ + age + I(age^2) + factor(year),
              data = AK)
fit_iv <- ivreg(wage ~ educ + age + I(age^2) + factor(year) |
                    . - educ + factor(year) * factor(quarter),
                data = AK)
coef(fit_ols)
coef(fit_iv)

## Output to CSV
write.csv(AK,
          row.names = FALSE,
          file = "AK1991-clean.csv")
