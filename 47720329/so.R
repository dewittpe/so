    # devtools::install_github("tidyverse/ggplot2")
    library(ggplot2)
    library(maps) 
    library(maptools)
    library(rgeos)
    library(sf)

    world1 <- sf::st_as_sf(map('world', plot = FALSE, fill = TRUE))

    with_boundary <-
      ggplot() +
        geom_sf(data = world1, mapping = aes(fill = ID)) +
      theme(legend.position = "none") +
      ggtitle("With Country Boundaries")

    without_boundary <-
      ggplot() +
        geom_sf(data = world1, mapping = aes(fill = ID), lwd = 0) +
      theme(legend.position = "none") +
      ggtitle("Without Country Boundaries")
     
png("so.png")
gridExtra::grid.arrange(with_boundary, without_boundary)
dev.off()

