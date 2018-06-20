    library(ggplot2)

    item1 <- list(1:5)
    item2 <- list(5:10)
    item3 <- list(ggplot(mtcars, aes(x=as.factor(cyl) )) + geom_bar())

    mylist <- list("item1"=item1, "item2"=item2, "item3.plt"=item3)

    print_plots <- function(x) { 
      plts <- sapply(x, function(obj) "ggplot" %in% class(obj))
      print(plts)

      if (any(plts)) {
        message(sprintf("Plots in %s are:", deparse(substitute(x)))) 
        lapply(which(plts), function(i) {y <- unlist(x[i], recursive = FALSE); print(y)}) 
      } else {
        message(sprintf("There are no plots in %s.", deparse(substitute(x)))) 
      }
      invisible(NULL)
    }

    print_plots(mylist)
    # Plots in mylist are:
    # $item3.plt


