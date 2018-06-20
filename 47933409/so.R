library(ggplot2)
library(gridExtra)
library(ggmap)

spots_df <- data.frame(lat = c(38.6938, 38.4262, 32.7607, 37.0830, 39.4619, 41.0042),
                  lon = c(-9.20587, -8.90007, -16.9595, -8.90918, -8.38391, -7.9699),
                  views = c(13565, 27020, 74420, 18550, 73253, 14615),
                  challenge = c("SPOT CIDADE", "SPOT NATUREZA I", "SPOT NATUREZA II",
                                "SPOT ROMACE", "SPOT PATRIMONIO", "SPOT GASTRONOMIA"))

mapa_spots <- get_map(location = c(lon = mean(spots_df$lon),
                                   lat = mean(spots_df$lat)),
                      zoom = 6,
                      maptype = "terrain",
                      scale = 2)

plot_spots <-
  ggmap(mapa_spots) +
  geom_point(data = spots_df,
             aes(x = lon, y = lat, fill = "red", alpha = 0.8, size = views), shape = 21) +
  facet_wrap( ~ challenge) +
  guides(fill = FALSE, alpha = FALSE, size = FALSE) 
plot_spots 




maps <-
  Map(function(lon, lat) {
        get_map(location = c(lon = lon, lat = lat),
                zoom = 5, maptype = "terrain", scale = 2)
             },
        lon = spots_df$lon,
        lat = spots_df$lat)

spots_df$scaled_views <- 
  1 + 5 * (spots_df$views - min(spots_df$views) ) / diff(range(spots_df$views))

grobs <-
  Map(function(map, pts) {
        g <-
        ggmap(map) +
          geom_point(data = pts,
                     aes(x = lon, y = lat, fill = "red", alpha = 0.8),
                     size = pts$scaled_views,
                     shape = 21) +
          facet_wrap( ~ challenge) +
          guides(fill = FALSE, alpha = FALSE, size = FALSE) 
        ggplotGrob(g)
        },
      map = maps,
      pts = split(spots_df, row(spots_df)[, 1]))

grid.arrange(grobs = c(ggplotGrob(plot_spots), grobs),
             layout_matrix = matrix(c(1, 1, 1, 2, 3, 4, 5, 6, 7), ncol = 3))
