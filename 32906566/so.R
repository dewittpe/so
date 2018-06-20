library(ggplot2)
library(base64enc)
tmpfile <- tempfile()

x <- ggplot(mtcars, aes(x = mpg, y = hp)) + geom_point(shape = 1)
ggsave(filename = tmpfile, dev = "png", plot = x)

out <- base64encode(what = tmpfile)
nchar(out)

