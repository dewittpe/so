library(reprex)
reprex(
{
#'
#' @phi answer is correct.  To explain it in more detail: the summary is
#' expected to be a list of lists.  That is, a list where each element of is a
#' list.
#'
#' Let's look at the structure of the provided summary:
#'
summary_tbl1 <-  
  list("Gender" =  
       list("Female" = ~ qwraps2::n_perc0(.data$gender == 0),  
            "Male"   = ~ qwraps2::n_perc0(.data$gender == 1)
           ),  
       "Mean age (sd)" = ~ qwraps2::mean_sd(.data$inage),  
       "Age categories" =  
         list("65-74" = ~ qwraps2::n_perc0(.data$age_cat == 1),  
              "75-84" = ~ qwraps2::n_perc0(.data$age_cat == 2),  
              "> 85"  = ~ qwraps2::n_perc0(.data$age_cat == 3)
             )  
       )

str(summary_tbl1, max.level = 1)

#'
#' The first and thrid elements are lists, but the second element is a formula.
#' The correct specification for the summary is:
summary_tbl1 <-  
  list("Gender" =  
       list("Female" = ~ qwraps2::n_perc0(.data$gender == 0),  
            "Male"   = ~ qwraps2::n_perc0(.data$gender == 1)
           ),  
       "inage" =
        list("Mean age (sd)" = ~ qwraps2::mean_sd(.data$inage)
            ), 
       "Age categories" =  
        list("65-74" = ~ qwraps2::n_perc0(.data$age_cat == 1),  
             "75-84" = ~ qwraps2::n_perc0(.data$age_cat == 2),  
             "> 85"  = ~ qwraps2::n_perc0(.data$age_cat == 3)
            )  
       )

str(summary_tbl1, max.level = 1)
},
venue = "so")
