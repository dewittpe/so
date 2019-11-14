library(reprex)
reprex({
#' Summaries are to be lists of lists of formulae, that is, the highest level
#' object is a list with each element being a list.  The elements of these lower
#' level lists are all to be formulae.  The provided summary:

summary_test <- list("Gender" = 
                       list("Female" = ~ qwraps2::n_perc0(.mydata$sex == "F"),
                            "Male"   = ~ qwraps2::n_perc0(.mydata$sex == "M")),
                     "Age" =
                       list("Mean" = ~ qwraps2::mean_sd(.mydata$age, denote_sd = "paren")),
                     "Comorbidities" =
                       list("HIV Positive"    == ~ qwraps2::n_perc0(.mydata$hiv == 1),
                            "Type 2 Diabetes" == ~ qwraps2::n_perc0(.mydata$diabetes == 1)))

#' has `==` in the definition for "Comorbidities" and thus logical statements,
#' not formulae.
str(summary_test) 

#' Also, the `.mydata` needs to be replaced with the correct tidyverse data
#' pronoun `.data`.  The correct syntax is:
summary_test <- list("Gender" = 
                       list("Female" = ~ qwraps2::n_perc0(.data$sex == "F"),
                            "Male"   = ~ qwraps2::n_perc0(.data$sex == "M")),
                     "Age" =
                       list("Mean" = ~ qwraps2::mean_sd(.data$age, denote_sd = "paren")),
                     "Comorbidities" =
                       list("HIV Positive"    = ~ qwraps2::n_perc0(.data$hiv == 1),
                            "Type 2 Diabetes" = ~ qwraps2::n_perc0(.data$diabetes == 1)))

str(summary_test)

}, venue = "so")
