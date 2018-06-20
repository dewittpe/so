# A workaround for this issue: run the `servr::httd` server in a subprocess.

    # Find the file path for the R binary:
    R_binary <- function () {
      R_exe <- ifelse (tolower(.Platform$OS.type) == "windows", "R.exe", "R")
      return(file.path(R.home("bin"), R_exe))
    }

    # start R vanilla as a subprocess.
    subR <- subprocess::spawn_process(R_binary(), c("--vanilla"))

    # start the HTTP server in the subprocess
    subprocess::process_write(subR, 'servr::httd(".", browser = FALSE, port = 4321)\n')
    ## [1] 47
    subprocess::process_read(subR)$stderr
    ## [1] "Serving the directory /home/dewittpe/so/my-servr-question at http://127.0.0.1:4321"


    session <- rvest::html_session("http://127.0.0.1:4321")
    session
    ## <session> http://127.0.0.1:4321/
    ##   Status: 200
    ##   Type:   text/html
    ##   Size:   1054

    # kill the subprocess
    subprocess::process_kill(subR)

