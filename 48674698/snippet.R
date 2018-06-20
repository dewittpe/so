for (pkg in c("servr", "R.utils", "rvest")) {
  if (!(pkg %in% rownames(installed.packages()))) {
    install.packages(pkg, repo = "https://cran.rstudio.com")
  }
  library(pkg, character.only = TRUE)
}


e1 <- new.env()

with(e1,
     {
       srv <- servr::httd(daemon = TRUE, browser = FALSE, port = 4321) 
     })

# ?servr::httd
ls(all.names = TRUE)
# ?ls

R.utils::withTimeout(
                    {
                      s <- rvest::html_session("http://127.0.0.1:4321", httr::verbose())
                    },
                    timeout = 3,
                    onTimeout = "error") 

s 


servr::httd
servr::server_config
servr::daemon_stop
servr::daemon_list

??servrEnv


help.start()

R.utils::withTimeout(
                    {
                      s <- rvest::html_session("http://127.0.0.1:24589")
                    },
                    timeout = 3,
                    onTimeout = "error") 



?httpuv::startDaemonizedServer





library(subprocess)
is_windows <- function () (tolower(.Platform$OS.type) == "windows")

R_binary <- function () {
  R_exe <- ifelse (is_windows(), "R.exe", "R")
  return(file.path(R.home("bin"), R_exe))
}

subR <- spawn_process(R_binary(), c("--vanilla"))

process_read(subR)
process_write(subR, 'rnorm(10)\n')
process_read(subR, PIPE_STDOUT)
process_state(subR)
process_write(subR, 'q()\n')
process_state(subR)


# server
subR <- spawn_process(R_binary(), c("--vanilla"))
process_write(subR, 'servr::httd(browser = FALSE, port = 4321)\n')
process_read(subR)
process_read(subR, PIPE_BOTH)
process_state(subR)
process_kill(subR)
process_state(subR)

process_write(subR, 's <- rvest::html_session("http://127.0.0.1:4321")\n')
process_write(subR, "print(s)\n")
process_read(subR, PIPE_BOTH)

R.utils::withTimeout(
                    {
                      s <- rvest::html_session("http://127.0.0.1:4321")
                    },
                    timeout = 3,
                    onTimeout = "error") 
s
# <session> http://127.0.0.1:3521/
#   Status: 200
#   Type:   text/html
#   Size:   838



subR <- spawn_process(R_binary(), c("--vanilla"))
process_write(subR, 'R.utils::withTimeout( { s <- rvest::html_session("http://127.0.0.1:4321") }, timeout = 3, onTimeout = "error") \n')
process_read(subR)
process_read(subR, PIPE_BOTH)
process_write(subR, 's\n')
process_state(subR)
process_write(subR, 'q()\n')
process_state(subR)





interactive
??vanillia
?callr::r_vanilla


rbg <- callr::r_bg(function() servr::httd(browser = FALSE, port = 4321))

rbg <- callr::r_bg(function() 1 + 2)

rbg$wait()
rbg$is_alive()
rbg$get_result()

?callr::r_bg

rp <- r_process$new(list("--vanilla"))



R.utils::withTimeout(
                    {
                      s <- rvest::html_session("http://127.0.0.1:4321")
                    },
                    timeout = 3,
                    onTimeout = "error") 
s
