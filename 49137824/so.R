    library(ggplot2)
    library(gridExtra)

    set.seed(42)

    dat <- data.frame(x = rlnorm(1000, meanlog = -4, sdlog = 1))

    ggplot(dat) +
      geom_histogram(mapping = aes(x = x), stat = "density")  +
      stat_function(fun = "dlnorm",
                    args = list(meanlog = -4, sdlog = 1),
                    n = 501,
                    color = "red")

ggsave("1.png")

    ggplot(dat) +
      geom_histogram(mapping = aes(x = log(x)), stat = "density")  +
      stat_function(fun = "dnorm",
                    args = list(mean = -4, sd = 1),
                    n = 501,
                    color = "red")

ggsave("2.png")

    ggplot(dat) +
      geom_histogram(mapping = aes(x = x), stat = "density")  +
      stat_function(fun = function(x, ...) {dnorm(log(x), ...) },
                    args = list(mean = -4, sd = 1),
                    n = 501,
                    color = "red") +
      scale_x_continuous(trans = "log",
                         breaks = exp(seq(-6, 0, by = 2)),
                         labels = paste("exp(", seq(-6, 0, by = 2), ")"))

ggsave("3.png")
