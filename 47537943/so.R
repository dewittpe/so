Do not rely on the automatic conversion of strings to factors.  In the code provided the levels are given in alpha order.

    df <- data.frame(fac = c("Obey the Cowgod", "Three Little Pigs", "Cereal Killer"),
                     val = c(10, 4, 7))

    levels(df$fac)
    # [1] "Cereal Killer"     "Obey the Cowgod"   "Three Little Pigs"

By  explicityly setting `df$fac` as a factor with the levels in the order you want your ggplot code will not need to change.

    df <- data.frame(fac = c("Obey the Cowgod", "Three Little Pigs", "Cereal Killer"),
                     val = c(10, 4, 7),
                     stringsAsFactors = FALSE)


    df$fac <- factor(df$fac, levels = c("Obey the Cowgod", "Three Little Pigs", "Cereal Killer"))

    levels(df$fac)
    # [1] "Obey the Cowgod"   "Three Little Pigs" "Cereal Killer"    


no need to change the ggplot code

    library(ggplot2)
    ggplot(data = df, aes(x = fac, y = val, fill = fac)) +
           geom_bar(stat="identity", width=0.9) +
           scale_fill_manual(values=c("blue", "red", "orange")) +
           scale_x_discrete(limits = c("Obey the Cowgod", "Three Little Pigs", "Cereal Killer"))

