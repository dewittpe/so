library(ggplot2)
library(plotly)

#### prepare data ####
adv <- read.csv("http://www-bcf.usc.edu/~gareth/ISL/Advertising.csv")

fit_tv <- lm(sales ~ TV, data = adv)  

adv_plot <- data.frame(adv, fit = fit_tv$fitted.values)

#### ggplot ####
p1 <- ggplot(adv_plot, aes(x = TV, y = sales)) + 
        geom_segment(aes(x = TV, xend = TV, y = sales, yend = fit), size = 0.5, color = "lightgrey") + 
        geom_point(color = "red") + 
        geom_point(aes(y = fit), color = "blue") 

p1


ggplotly(p1)
