library(reprex)
reprex({
#'
#' The ordering of the colums defaults to the order the levels of the factor.
#'
#' To illustrate this the `mtcars2` data frame is presented with the cylinders
#' column as a factor.  The example provided in the vignette intentionally
#' ordered the factor in a non-increaing order to demonstate the behavor.

library(dplyr)
library(qwraps2)
options(qwraps2_markup = "markdown")

mtcars2 <-
  dplyr::mutate(mtcars,
                cyl_factor = factor(cyl,
                                    levels = c(6, 4, 8),
                                    labels = paste(c(6, 4, 8), "cylinders")),
                cyl_character = paste(cyl, "cylinders"))


our_summary1 <-
  list("Miles Per Gallon" =
         list("min" = ~ min(.data$mpg),
              "max" = ~ max(.data$mpg),
              "mean (sd)" = ~ qwraps2::mean_sd(.data$mpg)),
       "Displacement" =
         list("min" = ~ min(.data$disp),
              "median" = ~ median(.data$disp),
              "max" = ~ max(.data$disp),
              "mean (sd)" = ~ qwraps2::mean_sd(.data$disp)),
       "Weight (1000 lbs)" =
         list("min" = ~ min(.data$wt),
              "max" = ~ max(.data$wt),
              "mean (sd)" = ~ qwraps2::mean_sd(.data$wt)),
       "Forward Gears" =
         list("Three" = ~ qwraps2::n_perc0(.data$gear == 3),
              "Four"  = ~ qwraps2::n_perc0(.data$gear == 4),
              "Five"  = ~ qwraps2::n_perc0(.data$gear == 5))
  )

by_cyl <- summary_table(dplyr::group_by(mtcars2, cyl_factor), our_summary1)
by_cyl


#' If we build the same table, but using the `cyl_character` to group by we will
#' get the columns in a different order based on the default coecersion from
#' character to factor.
summary_table(dplyr::group_by(mtcars2, cyl_character), our_summary1)
}
, venue = "so")
