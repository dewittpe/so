#'---
#'title: "summary table"
#'output: rmarkdown::word_document
#'---
#'
#' To get the summary table from the
{{ qwraps2::CRANpkg(qwraps2)}}
#' package to render in a word document you need to *not* pass the return from
{{ qwraps2::backtick(summary_test)}}
#' to
{{ paste0(qwraps2::backtick(knitr::kabel), ".")}}
#'
#' The reason is that
{{ qwraps2::backtick(summary_test)}}
#' returns a character matrix and a
{{ qwraps2::backtick(print)}}
#' method is reasponsible for generating either the markdown or LaTeX table.
#'
#+ label = "install_cran", include = FALSE
# remotes::install_cran is similar to your check_and_install function.
remotes::install_cran("kableExtra")
remotes::install_cran("dplyr")
remotes::install_cran("qwraps2")

#+ label = "namespaces"
library(kableExtra)
library(dplyr)
library(qwraps2)

#'
#' By default
{{ qwraps2::CRANpkg(qwraps2)}}
#' will format results for LaTeX.  Set the default markup language to markdown
#' to change this behavior.
options(qwraps2_markup = "markdown")

#'
#' Build the test summary for the example.  I strongly recommned using the
{{ qwraps2::backtick(.data) }}
#' data pronoun so no scoping issues arise when building the table.  I have
#' added the pronoun below.
#+ label = "define_summary_test"
summary_test  <-
  list("Cylindres" =
     list("Huit"   = ~ qwraps2::n_perc0(.data$cyl == 8, show_symbol = TRUE),
          "Six"    = ~ qwraps2::n_perc0(.data$cyl == 6, show_symbol = TRUE),
          "Quatre" = ~ qwraps2::n_perc0(.data$cyl == 4, show_symbol = TRUE)),
   "Vitesses" =
     list("Cinq"   = ~ qwraps2::n_perc0(.data$gear == 5, show_symbol = TRUE),
          "Quatre" = ~ qwraps2::n_perc0(.data$gear == 4, show_symbol = TRUE),
          "Trois"  = ~ qwraps2::n_perc0(.data$gear == 3, show_symbol = TRUE))
  )

#'
#' Finally, build the table and look at the structure of the object.
#'
#+ label = 'tabtest2'
tabtest2 <- summary_table(dplyr::group_by(mtcars, am), summary_test)
str(tabtest2)

#'
#' Note that the object is a
{{ qwraps2::backtick(qwraps2_summary_table) }}
#' is a character matrix with attributes for the row, column, and row group
#' names.  Using the default print method in R we see a character matrix.
print.default(tabtest2)

#'
#' Using the print method for
{{ qwraps2::backtick(qwraps2_summary_table) }}
#' objects (done impliclity here) gives the markdown:
#+ results = "markup"
tabtest2

#'
#' To get the table to render nicely use the "asis" value for the results chunk
#' option:
#+ results = "asis"
tabtest2



