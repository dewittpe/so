library(ggplot2)
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point(pch="\u2605", size=10)
