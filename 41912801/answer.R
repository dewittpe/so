#' ---
#' title: "My Doc"
#' author: "ME"
#' date: "January 28, 2017"
#' ---
#+ label = "setup", include = FALSE
library(ggplot2)
myFun = function(){
  for(i in seq(from=1,to=3, by=1)){
    cat("\n\n\n## This is title", i, "\n\n\n")
    plot = ggplot(aes(x=mpg,y=cyl),data=mtcars) +
      geom_point(color = i)
    print(plot)
  }
}

#' Generate three plots:

#+ echo = FALSE, results = "asis"
myFun()


# /* build this file via
knitr::spin("answer.R", knit = FALSE)
rmarkdown::render("answer.Rmd")
# */
