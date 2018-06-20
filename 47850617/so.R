library(ggplot2)
library(dplyr)

nba <- read.csv("http://datasets.flowingdata.com/ppg2008.csv")

nba_m <-
  nba %>%
  dplyr::mutate_at(.vars = dplyr::vars(-Name),
                   .funs = dplyr::funs(scale(.))) %>%
  tidyr::gather(key = stat, value = value, -Name)


ggplot(nba_m) +
  aes(x = stat, y = Name, fill = value) +
  geom_tile(color = "white") +
  scale_fill_gradient(low = "white", high = "steelblue")


nba.m <- melt(nba)
nba.m <- ddply(nba.m, .(variable), transform, rescale = rescale(value))
(p <- ggplot(nba.m, aes(variable, Name)) + geom_tile(aes(fill = rescale),colour = "white") + scale_fill_gradient(low = "white",high = "steelblue"))
p
