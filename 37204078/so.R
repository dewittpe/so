library(magrittr)

pg <- rvest::html_session("http://us.makemytrip.com/international/listing/exUs/RT/ORD-DEL-D-22May2016_JFK-DEL-D-25May2016/A-1/E?userID=90281463121653408")
pg

pg %>% xml2::read_html(.) %>% rvest::html_text(.) %>% grepl("want", .)


  rvest::html_nodes(., ".flight_info")
