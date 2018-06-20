myData <- read.csv(text = 
"SAMPLE,O.D.600nm
I (D+G),0.3
II (D+G),0.3
III (D+G),0.28
VII (YPD),0.4
VIII(YPD),0.42
IX (YPD),0.388")

library(ggplot2)

ggplot(myData, aes(SAMPLE, O.D.600nm, fill=SAMPLE)) +
  geom_bar(stat = "identity", width = 0.5)+
  scale_fill_manual(values=c("lightblue", "lightblue", "lightblue", "orange", "orange", "orange"))+
  geom_text(aes(label=O.D.600nm),position="stack",vjust=1)+
  ylim(0,0.625) +

  geom_rect(data = NULL,
            xmin = -Inf, xmax = Inf,
            ymin = 0.30, ymax = 0.6,
            alpha = 0.2,
            inherit.aes = FALSE)
