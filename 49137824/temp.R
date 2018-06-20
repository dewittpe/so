fit <- lm(mpg ~ wt, data = mtcars)
save(fit, file = "fit.rda")

fit <- lm(mpg ~ hp, data = mtcars)
load("fit.rda")
fit ### This fit will be for the model of mpg ~ wt, not mpg ~ hp
# 
# Call:
# lm(formula = mpg ~ wt, data = mtcars)
# 
# Coefficients:
# (Intercept)           wt
#      37.285       -5.344



fit2 <- lm(mpg ~ wt + hp, data = mtcars)
saveRDS(fit2, file = "fit2.rds")
ls()
# [1] "fit"  "fit2"

readRDS("fit2.rds")
ls()
# [1] "fit"  "fit2"

rm(fit2)
ls()
# [1] "fit"


readRDS("fit2.rds")
ls()
# [1] "fit"

fit2 <- readRDS("fit2.rds")
ls()
# [1] "fit"  "fit2"
