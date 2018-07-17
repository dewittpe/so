#' # subroutine not available for .Fortran() for package ...
#'
#' An old project of mine has started showing a new behavior, a fortran
#' subroutine that has been available for use by the R package no longer
#' available.  The package has both C++ and Fortran code in the `src/` directory.
#' Apparently the C++ methods are available but the Fortran subroutines are not.
#'
#' You can view the code base on my
#' [github](https://github.com/dewittpe/sccm/tree/72375b2f347667119215eab708ebdfdec78fdfb2)
#' page.
#'
#' The specifics needed to reproduce the error are as follows 
#'
# Install the specific version of the sccm package (including dependencies)
devtools::install_github("dewittpe/sccm@72375b2f347667119215eab708ebdfdec78fdfb2")

#'
#' We load the shared objects from the sccm package and an example data set.
dyn.load(list.files(system.file("libs", package = "sccm"), full.names = TRUE))

# Example data set
data("HexagonalFish", package = "sccm")
hf_pg <- sccm::polygon(HexagonalFish[, c("x", "y")])

#'
#' To help illustrate the issue there is a C++ method for determining if a point
#' is on the interior of a polygon.  The symbol name is `_sccm_is_in_cpp` and,
#' as seen here, is loaded
is.loaded("_sccm_is_in_cpp")
# [1] TRUE

.Call("_sccm_is_in_cpp", PACKAGE = "sccm", 0.2, 0.4, hf_pg$vertices) # expect 0
## [1] 0
.Call("_sccm_is_in_cpp", PACKAGE = "sccm", 156, 178, hf_pg$vertices) # expect 1
## [1] 1

#'
#' One of the Fortran subroutines that is causing an error is: `scmap_`.  The
#' sysbmol, however, is loaded.
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

#'
#' The error is the same if I use `.C` or `.Fortran`.  `.Call`, which I don't
#' believe is appropriate to use in this case, results in a segmentation fault.
#'
#' The use of the method in the package can be found in a call to `scmap`
sccm::scmap(hf_pg)

## Error in .C("scmap_", n = as.integer(n), w = as.double(w), wc = as.double(wc),  :
##   "scmap_" not resolved from current namespace (sccm)

#'
#' Just to be pedantic, here is some proof that the objects are in the shared
#' object.
system(sprintf("nm -g %s | grep -P 'is_in|scmap'",
               list.files(system.file("libs", package = "sccm"),
                          full.names = TRUE)))
## 000000000000afb0 T _sccm_is_in_cpp
## 000000000001c400 T scmap_
## 0000000000014550 T _Z9is_in_cppN4Rcpp6VectorILi14ENS_15PreserveStorageEEES2_NS_6MatrixILi14ES1_EE

#'
#' My session info
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

#'
#' Also, I have the following Makevars file that might be contributing to this
#' issue.

system("cat ~/.R/Makevars")
## CC=ccache clang -Qunused-arguments
## CXX=ccache clang++ -Qunused-arguments
## CCACHE_CPP=yes

