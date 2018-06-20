library(ggplot2)

require(extrafont)
font_import(prompt = F, pattern = "arial.ttf")
font_import(prompt = F, pattern = "JOKERMAN.TTF")
loadfonts(device="win", quiet = T)
loadfonts(device="pdf", quiet = T)

plot <- ggplot(mtcars, aes(wt, mpg, colour = hp)) + geom_point()
jokerman_plot <- plot + theme_bw(base_family = "Jokerman")
arial_plot <- plot + theme_bw(base_family = "Arial")

ggsave("arial_plot.png", arial_plot)
ggsave("arial_plot.pdf", arial_plot)
embed_fonts("arial_plot.pdf")

ggsave("jokerman_plot.png", jokerman_plot)
ggsave("jokerman_plot.pdf", jokerman_plot)
embed_fonts("jokerman_plot.pdf")
