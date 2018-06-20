rp <- processx::run("R", "--vanilla")

rp <- processx::process$new("R", "--vanilla")
rp$is_alive()




servr::httd(daemon = TRUE, browser = FALSE, port = 4321)
R.utils::withTimeout(
                    {
                      s <- rvest::html_session("http://127.0.0.1:4321")
                    },
                    timeout = 3,
                    onTimeout = "error") 
s
