x <- data.frame(EBITDA.EUR.Last.avail..yr = sample(c(1:12, "n.a."), 100, replace = TRUE),
                EBITDA.EUR.Year...1 = 12,
                stringsAsFactors = FALSE)
x
x$EBITDA.EUR.Last.avail..yr <- as.numeric(




ggplot(x, aes(x = ((EBITDA.EUR.Last.avail..yr - EBITDA.EUR.Year...1) / EBITDA.EUR.Year...1)),
              y = ((Fixed.assets.EUR.Last.avail..yr - Fixed.assets.EUR.Year...1) / Fixed.assets.EUR.Year...1)),
              color = "red")) + 
      geom_point()
