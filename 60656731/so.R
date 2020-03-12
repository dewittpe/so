reprex::reprex({
#'
#' First I'll create some random data sets so that this example can be
#' reproduced.   I will use the `replicate` function to generate 20
#' `data.frames` in a list
#'
set.seed(60656731)

files <-
  replicate(n = 20L,
            {data.frame("Var1" = rnorm(1000), "Var2" = runif(1000), "Var3" = rexp(1000))},
            simplify = FALSE)

#'
#' I am assuming you are using the `Winsorize` function from the
#' [DescTools](https://cran.r-project.org/package=DescTools) package.
library(DescTools)

#'
#' Use `lapply`, i.e., list apply, to apply the `Winsorize` function to the data
#' sets.  The below creates a new set of `data.frame`s where `Var1` of the data
#' sets have been winsorized.
#'
files_winsorized <- lapply(files, function(x) {x$Var1 <- Winsorize(x$Var1); x})

#'
#' A quick look at one of the results:
par(mfrow = c(2, 1))
hist(files[[1]]$Var1)
hist(files_winsorized[[1]]$Var1)

summary(files[[1]]$Var1)
summary(files_winsorized[[1]]$Var1)
}
,
"so")

