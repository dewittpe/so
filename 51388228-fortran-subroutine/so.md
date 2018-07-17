An old project of mine has started showing a new behavior, a fortran
subroutine that has been available for use by the R package no longer
available.  The package has both C++ and Fortran code in the `src/` directory.
Apparently the C++ methods are available but the Fortran subroutines are not.

You can view the code base on my
[github](https://github.com/dewittpe/sccm/tree/72375b2f347667119215eab708ebdfdec78fdfb2)
page.

The specifics needed to reproduce the error are as follows 

    # Install the specific version of the sccm package (including dependencies)
    devtools::install_github("dewittpe/sccm@72375b2f347667119215eab708ebdfdec78fdfb2")


We load the shared objects from the sccm package and an example data set.
    dyn.load(list.files(system.file("libs", package = "sccm"), full.names = TRUE))

    # Example data set
    data("HexagonalFish", package = "sccm")
    hf_pg <- sccm::polygon(HexagonalFish[, c("x", "y")])


To help illustrate the issue there is a C++ method for determining if a point
is on the interior of a polygon.  The symbol name is `_sccm_is_in_cpp` and,
as seen here, is loaded

    is.loaded("_sccm_is_in_cpp")
    # [1] TRUE

    .Call("_sccm_is_in_cpp", PACKAGE = "sccm", 0.2, 0.4, hf_pg$vertices) # expect 0
    ## [1] 0
    .Call("_sccm_is_in_cpp", PACKAGE = "sccm", 156, 178, hf_pg$vertices) # expect 1
    ## [1] 1


One of the Fortran subroutines that is causing an error is: `scmap_`.  The
symbol, however, is loaded.

    is.loaded("scmap_")
    ## [1] TRUE

    # need values for the .Fortran call below
    n <- nrow(hf_pg$vertices)
    betam <- -hf_pg$beta/pi
    w <- as.vector(t(hf_pg$vertices))
    wc <- colMeans(hf_pg$vertices)
    nptsq <- 12

    .Fortran(
       "scmap_", n = as.integer(n), w = as.double(w), wc = as.double(wc),
       betam = as.double(betam), nptsq = as.integer(nptsq),
       tol = double(1), errest = double(1), c = double(2), z = double(2 * n),
       qwork = double(nptsq * (2 * n + 3)),
       PACKAGE = "sccm")

    ## Error in .Fortran("scmap_", n = as.integer(n), w = as.double(w), wc = as.double(wc),  :
    ##   "scmap_" not available for .Fortran() for package "sccm"


The error is the same if I use `.C` or `.Fortran`.  `.Call`, which I don't
believe is appropriate to use in this case, results in a segmentation fault.

The use of the method in the package can be found in a call to `scmap`

    sccm::scmap(hf_pg)

    ## Error in .C("scmap_", n = as.integer(n), w = as.double(w), wc = as.double(wc),  :
    ##   "scmap_" not resolved from current namespace (sccm)


Just to be pedantic, here is some proof that the objects are in the shared
object.

    system(sprintf("nm -g %s | grep -P 'is_in|scmap'",
                   list.files(system.file("libs", package = "sccm"),
                              full.names = TRUE)))
    ## 000000000000afb0 T _sccm_is_in_cpp
    ## 000000000001c400 T scmap_
    ## 0000000000014550 T _Z9is_in_cppN4Rcpp6VectorILi14ENS_15PreserveStorageEEES2_NS_6MatrixILi14ES1_EE

I don't understand what is causing this error or how to try to fix it.  A successful build, one that included tests that would have thrown this error, was done in [Travis-ci.org](https://travis-ci.org/dewittpe/sccm/jobs/204402817).  

My current session info

    devtools::session_info()
    ##  Session info ---------------------------------------------------------
    ##  setting  value
    ##  version  R version 3.5.1 (2018-07-02)
    ##  system   x86_64, linux-gnu           
    ##  ui       X11                         
    ##  language (EN)                        
    ##  collate  en_US.UTF-8                 
    ##  tz       America/Denver              
    ##  date     2018-07-17                  
    ## 
    ##  Packages ------------------------------------------------------------
    ##  package   * version date       source                            
    ##  base      * 3.5.1   2018-07-12 local                             
    ##  colorout  * 1.2-0   2018-07-12 Github (jalvesaq/colorout@cc5fbfa)
    ##  compiler    3.5.1   2018-07-12 local                             
    ##  datasets  * 3.5.1   2018-07-12 local                             
    ##  devtools    1.13.6  2018-06-27 CRAN (R 3.5.1)                    
    ##  digest      0.6.15  2018-01-28 CRAN (R 3.5.1)                    
    ##  graphics  * 3.5.1   2018-07-12 local                             
    ##  grDevices * 3.5.1   2018-07-12 local                             
    ##  memoise     1.1.0   2017-04-21 CRAN (R 3.5.1)                    
    ##  methods   * 3.5.1   2018-07-12 local                             
    ##  nvimcom   * 0.9-64  2018-07-12 local                             
    ##  Rcpp        0.12.17 2018-05-18 cran (@0.12.17)                   
    ##  sccm        0.1.2   2018-07-17 Github (dewittpe/sccm@72375b2)    
    ##  stats     * 3.5.1   2018-07-12 local                             
    ##  tools       3.5.1   2018-07-12 local                             
    ##  utils     * 3.5.1   2018-07-12 local                             
    ##  withr       2.1.2   2018-03-15 CRAN (R 3.5.1)                    


Also, I have the following Makevars file that might be contributing to this
issue.

    system("cat ~/.R/Makevars")
    ## CC=ccache clang -Qunused-arguments
    ## CXX=ccache clang++ -Qunused-arguments
    ## CCACHE_CPP=yes

The session info from the successful [Travis-ci.org](https://travis-ci.org/dewittpe/sccm/jobs/204402817) is

    Session info 

    -------------------------------------------------------------------
     setting  value                       
     version  R version 3.3.2 (2016-10-31)
     system   x86_64, linux-gnu           
     ui       X11                         
     language (EN)                        
     collate  en_US.UTF-8                 
     tz       <NA>                        
     date     2017-02-22                  
    Packages -----------------------------------------------------------------------
     package       * version     date       source         
     assertthat      0.1         2013-12-06 cran (@0.1)    
     backports       1.0.5       2017-01-18 cran (@1.0.5)  
     base64enc       0.1-3       2015-07-28 cran (@0.1-3)  
     BH              1.62.0-1    2016-11-19 cran (@1.62.0-)
     bitops          1.0-6       2013-08-17 cran (@1.0-6)  
     boot            1.3-18      2016-02-23 CRAN (R 3.3.2) 
     caTools         1.17.1      2014-09-10 cran (@1.17.1) 
     class           7.3-14      2015-08-30 CRAN (R 3.3.2) 
     cluster         2.0.5       2016-10-08 CRAN (R 3.3.2) 
     codetools       0.2-15      2016-10-05 CRAN (R 3.3.2) 
     covr            2.2.2       2017-01-05 cran (@2.2.2)  
     crayon          1.3.2       2016-06-28 cran (@1.3.2)  
     curl            2.3         2016-11-24 CRAN (R 3.3.2) 
     DBI             0.5-1       2016-09-10 cran (@0.5-1)  
     devtools        1.12.0      2016-12-05 CRAN (R 3.3.2) 
     digest          0.6.12      2017-01-27 CRAN (R 3.3.2) 
     dplyr           0.5.0       2016-06-24 cran (@0.5.0)  
     evaluate        0.10        2016-10-11 cran (@0.10)   
     foreign         0.8-67      2016-09-13 CRAN (R 3.3.2) 
     git2r           0.18.0      2017-01-01 CRAN (R 3.3.2) 
     highr           0.6         2016-05-09 cran (@0.6)    
     htmltools       0.3.5       2016-03-21 cran (@0.3.5)  
     httr            1.2.1       2016-07-03 CRAN (R 3.3.2) 
     jsonlite        1.2         2016-12-31 CRAN (R 3.3.2) 
     KernSmooth      2.23-15     2015-06-29 CRAN (R 3.3.2) 
     knitr           1.15.1      2016-11-22 cran (@1.15.1) 
     lattice         0.20-34     2016-09-06 CRAN (R 3.3.2) 
     lazyeval        0.2.0       2016-06-12 cran (@0.2.0)  
     magrittr        1.5         2014-11-22 cran (@1.5)    
     markdown        0.7.7       2015-04-22 cran (@0.7.7)  
     MASS            7.3-45      2016-04-21 CRAN (R 3.3.2) 
     Matrix          1.2-7.1     2016-09-01 CRAN (R 3.3.2) 
     memoise         1.0.0       2016-01-29 CRAN (R 3.3.2) 
     mgcv            1.8-15      2016-09-14 CRAN (R 3.3.2) 
     mime            0.5         2016-07-07 CRAN (R 3.3.2) 
     nlme            3.1-128     2016-05-10 CRAN (R 3.3.2) 
     nnet            7.3-12      2016-02-02 CRAN (R 3.3.2) 
     openssl         0.9.6       2016-12-31 CRAN (R 3.3.2) 
     praise          1.0.0       2015-08-11 cran (@1.0.0)  
     R6              2.2.0       2016-10-05 CRAN (R 3.3.2) 
     Rcpp            0.12.9      2017-01-14 cran (@0.12.9) 
     RcppArmadillo   0.7.700.0.0 2017-02-08 cran (@0.7.700)
     rex             1.1.1       2016-12-05 cran (@1.1.1)  
     rmarkdown       1.3         2016-12-21 cran (@1.3)    
     rpart           4.1-10      2015-06-29 CRAN (R 3.3.2) 
     rprojroot       1.2         2017-01-16 cran (@1.2)    
     rstudioapi      0.6         2016-06-27 CRAN (R 3.3.2) 
     spatial         7.3-11      2015-08-30 CRAN (R 3.3.2) 
     stringi         1.1.2       2016-10-01 cran (@1.1.2)  
     stringr         1.1.0       2016-08-19 cran (@1.1.0)  
     survival        2.39-5      2016-06-26 CRAN (R 3.3.2) 
     testthat        1.0.2       2016-04-23 cran (@1.0.2)  
     tibble          1.2         2016-08-26 cran (@1.2)    
     whisker         0.3-2       2013-04-28 CRAN (R 3.3.2) 
     withr           1.0.2       2016-06-20 CRAN (R 3.3.2) 
     yaml            2.1.14      2016-11-12 cran (@2.1.14)
'
