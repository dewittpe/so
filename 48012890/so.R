library(ggplot2)

ggplot(ToothGrowth) + 
  aes(x = factor(dose), y = len) +
  stat_boxplot(geom = "errorbar",
               aes(col = supp, fill = supp),
               position = position_dodge(width = 0.85)) + 
  geom_boxplot(aes(col = supp, fill = supp),
               notch = TRUE,
               notchwidth = 0.75,
               outlier.size=2,
               position = position_dodge(width = 0.85)) +
  stat_summary(fun.y = mean,
               aes(supp,dose),
               geom="point",
               shape=20,
               size=7,
               color="violet",
               fill="violet") +
  scale_color_manual(name = "SUPP", values = c("blue", "darkgreen")) +
  scale_fill_manual(name = "SUPP", values = c("lightblue", "green"))

