#' 
#' I'm working on a project that requires accessing webpages and I do this via
#' `rvest::html_session()`.  For documentation and training I would like to set
#' up a reproducible example and have considered the following.
#'
#' 1. Use `servr::httd(system.file("egwebsite", package = "<pkgname>"), daemon =
#' TRUE, browser = FALSE)` to set up a  simple HTTP server
#' 
#' 2. Use `rvest::html_session("http://127.0.0.1:4321")` to set up the html
#' session.
#' 
#' However, the following simple example behaves differently on Linux (Debian 9)
#' and Windows 10.  (I do not have easy access to OSx and have not tested on
#' that OS).
#'
#'
    # On Windows
    servr::httd(daemon = TRUE, browser = FALSE, port = 4321) 
    ## Serving the directory /home/dewittpe/so/my-servr-question at http://127.0.0.1:4321
    ## To stop the server, run servr::daemon_stop("94019719908480") or restart your R session

    R.utils::withTimeout(
                        {
                          s <- rvest::html_session("http://127.0.0.1:4321")
                        },
                        timeout = 3,
                        onTimeout = "error") 

    s 
    ## <session> http://127.0.0.1:4321/
    ##   Status: 200
    ##   Type:   text/html
    ##   Size:   2352
    servr::daemon_stop()

#'
#' However, on my Linux box (Debian 9) I get the following 
#'
    servr::httd(daemon = TRUE, browser = FALSE, port = 4321) 
    ## Serving the directory /home/dewittpe/so/my-servr-question at http://127.0.0.1:4321
    ## To stop the server, run servr::daemon_stop("94019719908480") or restart your R session

    R.utils::withTimeout(
                        {
                          s <- rvest::html_session("http://127.0.0.1:4321")
                        },
                        timeout = 3,
                        onTimeout = "error") 
    ## Error: reached elapsed time limit
    ## Error in curl::curl_fetch_memory(url, handle = handle) :
    ##   Operation was aborted by an application callback

#'
#' That is, I am unable to create a `html_session` in the same R interactive
#' session that spawned the http server.  If, however, I inter a second R
#' session while the leaving the initial session running, I am able to create
#' the `html_session` without error.
#' 
#' What can I do so that I can create an `html_session` based on a `servr::httd`
#' HTTP server within the same R session on Linux?
#'



    devtools::session_info()
    #  setting  value                       
    #  version  R version 3.4.3 (2017-11-30)
    #  system   x86_64, linux-gnu           
    #  ui       X11                         
    #  language (EN)                        
    #  collate  en_US.UTF-8                 
    #  tz       Navajo                      
    #  date     2018-02-07                  
    # 
    #  package   * version date       source        
    #  base      * 3.4.3   2017-12-01 local         
    #  colorout  * 1.2-0   2018-02-05 local         
    #  compiler    3.4.3   2017-12-01 local         
    #  curl        3.1     2017-12-12 CRAN (R 3.4.3)
    #  datasets  * 3.4.3   2017-12-01 local         
    #  devtools    1.13.4  2017-11-09 CRAN (R 3.4.3)
    #  digest      0.6.15  2018-01-28 CRAN (R 3.4.3)
    #  graphics  * 3.4.3   2017-12-01 local         
    #  grDevices * 3.4.3   2017-12-01 local         
    #  httr        1.3.1   2017-08-20 CRAN (R 3.4.3)
    #  magrittr    1.5     2014-11-22 cran (@1.5)   
    #  memoise     1.1.0   2017-04-21 CRAN (R 3.4.3)
    #  methods   * 3.4.3   2017-12-01 local         
    #  nvimcom   * 0.9-56  2018-02-07 local         
    #  R6          2.2.2   2017-06-17 CRAN (R 3.4.3)
    #  Rcpp        0.12.15 2018-01-20 CRAN (R 3.4.3)
    #  rvest       0.3.2   2016-06-17 CRAN (R 3.4.3)
    #  stats     * 3.4.3   2017-12-01 local         
    #  tools       3.4.3   2017-12-01 local         
    #  utils     * 3.4.3   2017-12-01 local         
    #  withr       2.1.1   2017-12-19 CRAN (R 3.4.3)
    #  xml2        1.2.0   2018-01-24 CRAN (R 3.4.3)
