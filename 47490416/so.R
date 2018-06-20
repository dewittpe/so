library(ggplot2)
ggplot(mpg) + aes(x = hwy, y = ..count../sum(..count..)) + geom_histogram()
ggsave("f1.png")
ggplot(mpg) + aes(x = hwy, y = ..count../sum(..count..)) + geom_density(stat = 'bin')
ggsave("f2.png")


