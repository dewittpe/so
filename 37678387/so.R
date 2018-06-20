library(ggplot2)

ggplot(data = data.frame(x = 1:10, y = seq(1, 2, l = 10)*1000), aes(x,y)) + geom_line()

