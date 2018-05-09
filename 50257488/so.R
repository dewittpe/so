library(knitr)
library(kableExtra)
library(magrittr)

dt <- mtcars[1:5, 1:6]

kable(dt, "html") %>%
  kable_styling(bootstrap_options = c("striped", "hover")) %>%
  cat(., file = "df.html")






