library(ggplot2)
library(grid)
library(gridExtra)
x <- data.frame(x=c(1:100), y=c(1:100))
x_t1 <- data.frame(a = 1, b = 1)
x_t2 <- data.frame(a = 2, b = 2)
x_t3 <- data.frame(a = 3, b = 3)
x_grobs <- list(
  textGrob("text 1"),  # 1
  textGrob("text 2"),  # 1
  tableGrob(x_t1),     # 3
  textGrob("text 4"),  # 4
  tableGrob(x_t2),     # 5
  textGrob("text 6"),  # 6
  tableGrob(x_t3),     # 7
  ggplotGrob(ggplot(x, aes(x, y))+geom_point())  # 8
)

x_heights <- c(1, 1, 2, 1, 2, 1, 2, 14)

x_arrgorb <- arrangeGrob(grobs = x_grobs,
                         heights = x_heights)

png("so.png")
grid.newpage()
grid.draw(x_arrgorb)
dev.off()


