library(reprex)

reprex({

#' The reason the `group_by` call does not appear to do anything is because the
#' data pronoun `.data` is not being used in the summary definition.    As
#' written, the summary table is constructed based on the whole `iris` data set,
#' regardless of any grouping or subsetting.  The `.data` pronoun is needed so
#' that the the `tidyverse` tools behind `summary_table` use the correct
#' scoping.

library(datasets)
library(qwraps2)
library(dplyr)

data("iris")
options(qwraps2_markup = "markdown")

our_summary1 <-
  list("Sepal Length" =
       list("min" = ~ min(.data$Sepal.Length),
            "max" = ~ max(.data$Sepal.Length),
            "mean (sd)" = ~ qwraps2::mean_sd(.data$Sepal.Length)),
       "Sepal Width" =
       list("min" = ~ min(.data$Sepal.Width),
            "median" = ~ median(.data$Sepal.Width),
            "max" = ~ max(.data$Sepal.Width),
            "mean (sd)" = ~ qwraps2::mean_sd(.data$Sepal.Width)),
       "Petal Length" =
       list("min" = ~ min(.data$Petal.Length),
            "max" = ~ max(.data$Petal.Length),
            "mean (sd)" = ~ qwraps2::mean_sd(.data$Sepal.Length)),
       "Petal Width" =
       list("min" = ~ min(.data$Petal.Width),
            "max" = ~ max(.data$Petal.Width),
            "mean (sd)" = ~ qwraps2::mean_sd(.data$Petal.Width)),
        "Species" =
       list("Setosa" = ~ qwraps2::n_perc0(.data$Species == "setosa"),
            "Versicolor"  = ~ qwraps2::n_perc0(.data$Species == "versicolor"),
            "Virginica"  = ~ qwraps2::n_perc0(.data$Species == "virginica"))
       )


bytype <- qwraps2::summary_table(dplyr::group_by(iris,Species),our_summary1)
bytype

},
venue = "so")

