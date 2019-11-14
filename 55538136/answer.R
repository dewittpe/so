library(reprex)
reprex({

#' First, I will create an example data set to match the provided summary
set.seed(42)
df <- data.frame(sex     = sample(c("M", "F"), size = 100, replace = TRUE),
                 age_d   = runif(100, 18, 80),
                 d       = sample(1:5, size = 100, replace = TRUE),
                 dis_dur = runif(100, 20, 43),
                 stringsAsFactors = FALSE)
str(df)

#' load and attach the qwraps2 namespace
library(qwraps2)

#' by defualt qwraps2 formats output in LaTeX.  To have the default switched to
#' markdown set the following option
options(qwraps2_markup = "markdown")

stats_summary1 <-
  list("Sex (female)" =
         list("number (%)" = ~ qwraps2::n_perc(.data$sex=="F", digits = 1)),
       "Age" =
         list("min" = ~ min(.data$age_d, digits = 1),
              "max" = ~ max(.data$age_d, digits = 1),
              "median (IQR)" = ~ qwraps2::median_iqr(.data$age_d, digits = 1)),
       "Disease" =
         list("A" = ~ qwraps2::n_perc(.data$d==1, digits = 1),
              "B" = ~ qwraps2::n_perc(.data$d==2, digits = 1),
              "C" = ~ qwraps2::n_perc(.data$d==3, digits = 1),
              "D" = ~ qwraps2::n_perc(.data$d==4, digits = 1),
              "E" = ~ qwraps2::n_perc(.data$d==5, digits = 1)),
       "Disease duration" =
         list("min" = ~ min(.data$dis_dur, digits = 1),
              "max" = ~ max(.data$dis_dur, digits = 1),
              "median (IQR)" = ~ qwraps2::median_iqr(.data$dis_dur, digits = 1)) 
    )
whole <- summary_table(df, stats_summary1)
whole

#' This sould resolve the issue with the forward slash on the percentage sign
#' (needed escape for LaTeX).  Make sure you have the `results = "asis"` chunk
#' option set so the table will render nicely in your final document.
#'
#' As for the omitted subheadings, the `qwraps2_summary_table` object is a
#' character matrix with the class attrtibute set accordingly and has the
#' additional attribute `rgroups` witch is used by the printing methods to
#' format the output correctly.
str(whole)
},
venue = 'so')
