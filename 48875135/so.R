library(ggplot2)
library(gridExtra)

plot_list <- vector("list", 8) 
plot_list[[1]] <- ggplot(mtcars) + aes(x = wt, y = mpg)   + geom_point() + ggtitle("This is plot 1")
plot_list[[2]] <- ggplot(mtcars) + aes(x = cyl, y = mpg)  + geom_point() + ggtitle("This is plot 2")
plot_list[[3]] <- ggplot(mtcars) + aes(x = disp, y = mpg) + geom_point() + ggtitle("This is plot 3")
plot_list[[4]] <- ggplot(mtcars) + aes(x = drat, y = mpg) + geom_point() + ggtitle("This is plot 4")
plot_list[[5]] <- ggplot(mtcars) + aes(x = drat, y = mpg) + geom_point() + ggtitle("This is plot 5")
plot_list[[6]] <- ggplot(mtcars) + aes(x = qsec, y = mpg) + geom_point() + ggtitle("This is plot 6")
plot_list[[7]] <- ggplot(mtcars) + aes(x = vs, y = mpg)   + geom_point() + ggtitle("This is plot 7")
plot_list[[8]] <- ggplot(mtcars) + aes(x = gear, y = mpg) + geom_point() + ggtitle("This is plot 8")


### Use your plot_list here:
m <- ggplot2::theme(plot.margin = unit(c(2, 2, 2, 2), "cm"))
plot_list <- lapply(plot_list, `+`, m)
glist <- lapply(plot_list, ggplotGrob)

ggsave("plots.pdf", marrangeGrob(glist, nrow = 2, ncol = 2))



