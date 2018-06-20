Details on how to render mathematics in plots and elsewhere in R are documented in `?plotmath`.

A simple example, plotting the city gas millage by engine squared engine displacement.

    library(ggplot2)
    ggplot(mpg) +
      aes(x = displ^2, y = cty) +
      geom_point() +
      xlab(expression(displ^2)) +
      ylab("City Miles Per Gallon")

ggsave("so.png")
