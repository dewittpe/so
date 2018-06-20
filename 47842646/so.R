    library(ggplot2)
    set.seed(42)

    PERCENT   <- rnorm(50, sd = 3)
    WAVE      <- sample(6, 50, replace = TRUE)
    AGE_GROUP <- rep(c("21-30", "31-40", "41-50", "51-60", "61-70"), 10)
    COUNTRY   <- rep(c("Country A", "Country B"), 25)
    N         <- rnorm(50, mean = 200, sd = 2)

    df <- data.frame(PERCENT, WAVE, AGE_GROUP, COUNTRY, N)

    ggplot(df) +
      aes(x = factor(WAVE),
          y = PERCENT,
          fill = factor(COUNTRY)) +
      geom_boxplot(alpha = 0.3) +
      geom_point(aes(color = AGE_GROUP, group = factor(COUNTRY)), position = position_dodge(width=0.75)) + 

      geom_text(aes(group = interaction(WAVE, COUNTRY),
                    label = ifelse(test = PERCENT > median(PERCENT) + 1.5*IQR(PERCENT)|PERCENT < median(PERCENT) -1.5*IQR(PERCENT),
                                   yes  = paste(AGE_GROUP, ",", round(PERCENT, 1), "%, n =", round(N, 0)),
                                   no   = '')),
                position = position_dodge(width = 0.75),
                hjust = -.2,
                size = 3)
  


ggsave("so.png")
