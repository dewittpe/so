a<-url("http://www-personal.umich.edu/~ajing/Files/TestData.RData")
load(a)

library(ggplot2)
p1<-ggplot(myd, aes(x=xvar,y=yvar)) + stat_density2d(aes(fill=..level..), geom="polygon")
gt <- ggplot_gtable(ggplot_build(p1))


