    library(ggplot2)

    dat <- data.frame(effect_size = c(-0.1, -0.1),
                      lcl = c(-0.5, -0.2),
                      ucl = c(0.3, -0.01),
                      sla = c("SLA1", "SLA2"))

    ggplot(dat) +
      theme_classic() +
      aes(x = sla, y = effect_size, ymin = lcl, ymax = ucl, color = sla) +
      geom_pointrange() +
      geom_hline(yintercept = 0, linetype = 2) +
      scale_color_manual(values = c("SLA1" = "#66CD00",
                                    "SLA2" = "#cfefb0")) +
      coord_flip()

    packageVersion("ggplot2")
    # [1] ‘2.2.1.9000’

ggsave(filename = "so.png", width = 3, height = 2)


