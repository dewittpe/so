#'
#' The graphic you are looking for can be generated with gridArrange from the
#' [gridExtra](https://cran.r-project.org/package=gridExtra) package.  Here is
#' an example using the `storms` data set from the
#' [dplyr](https://cran.r-project.org/package=dplyr).
#'
library(ggplot2)
library(gridExtra)
library(dplyr)
data(storms, package = 'dplyr')
str(storms)

#'
#' Let's create two graphics. The first graphic will be only form `category == -1`
#' storms (this would be the control group in your question).  The second
#' graphic will be a facteted graphic for the `category > -1` storm
#'
#' First, we'll build a generic ggplot object for the graphics.
graphic <-
  ggplot() + 
  aes(x = long, y = lat, color = category) +
  geom_point() +
  facet_wrap( ~ category) +
  scale_color_hue(breaks = levels(storms$category),
                  labels = levels(storms$category),
                  drop = FALSE)
#'
#' Next we build the two graphics as needed.
#'
g1 <- graphic %+% dplyr::filter(storms, category == -1) + theme(legend.position = "none")
g2 <- graphic %+% dplyr::filter(storms, category != -1)

#'
#' `gridExtra::grid.arrange` can take a layout matrix where the numbers 1 and 2
#' denote the first and second graphics passed to the function.  (This works for
#' a lot more than just two graphics, by the way.)  By repeating the values of 1
#' and 2 in the matrix we can control the relative size of the two graphics in
#' the graphics device.
png("47313736.png")
gridExtra::grid.arrange(g1, g2,
                        nrow = 1,
                        widths = c(3, 5))
dev.off()

egg::ggarrange(g1, g2, nrow = 1)

#'
#' The result is:
#'
