There appears to be an `~` omitted from the line `"n" = sum(death_vs_gender$Deaths),`.

Try the following:

    our_summary1 <- 
      list("Table 2: Summary Statistics for Mass Shooting Deaths in American between 1966-2017 by Men & Women" = 
           list(
                "n"         = ~ sum(.data$Deaths),
                "Min"       = ~ min(.data$Deaths),
                "Max"       = ~ max(.data$Deaths),
                "Median"    = ~ median(.data$Deaths),
                "Mean"      = ~ mean(.data$Deaths),
                "Std. Dev." = ~ sd(.data$Deaths)
               )
          )

Note that the name `death_vs_gender` has been replaced with `.data`, the data
pronoun in the tidyverse.  This is an important change.  Using the pronoun will
will help prevent errant results due to scoping issues.
