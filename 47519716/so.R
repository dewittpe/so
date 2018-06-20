    data(airquality)
    library(quantreg)
    library(ggplot2)
    library(data.table)
    library(devtools)


    # source Quantile LOESS
    source("https://www.r-statistics.com/wp-content/uploads/2010/04/Quantile.loess_.r.txt")    

   airquality2 <- na.omit(airquality[ , c(1, 4)])

    #'' quantreg::rq
    rq_fit <- rq(Ozone ~ Temp, 0.95, airquality2)
    rq_fit_df <- data.table(t(coef(rq_fit)))
    names(rq_fit_df) <- c("intercept", "slope")

    #'' quantreg::lprq
    lprq_fit <- lapply(1:3, function(bw){
      fit <- lprq(airquality2$Temp, airquality2$Ozone, h = bw, tau = 0.95)
      return(data.table(x = fit$xx, y = fit$fv, bw = paste0("bw=", bw), fit = "quantreg::lprq"))
    })

    #'' Quantile LOESS
    ql_fit <- Quantile.loess(airquality2$Ozone, jitter(airquality2$Temp), window.size = 10,
                             the.quant = .95,  window.alignment = c("center"))
    ql_fit_df <- data.table(x = ql_fit$x, y = ql_fit$y.loess, bw = "bw=1", fit = "Quantile LOESS")


ggplot(airquality2) +
  aes(x = Temp, y = Ozone) + 
  geom_point() +
  geom_smooth(method = 'rq', se = FALSE, mapping = aes(color = "rq")) +
  geom_smooth(method = "lprq", se = FALSE, mapping = aes(color = "lprq"))
