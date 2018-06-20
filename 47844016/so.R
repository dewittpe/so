library(ggplot2)

data <- data.frame(ID = c(LETTERS[1:26], paste0("A",LETTERS[1:26])),
                   Group = rep(c("Control","Treatment"),26),
                   x = rnorm(52,50,20),
                   y = rnorm(52,50,10))

p <- ggplot(data, aes(y=y,x=x, label=ID, color=Group)) + 
     geom_point() + 
     scale_color_manual(values=c("blue","red")) +
     theme(legend.text = element_text(color = c('blue', 'red')))

p
