    library(ggplot2)
    library(ggmap)
    library(sf)

    nc_shp <- st_read(system.file("shape/nc.shp", package = "sf"))
    nc_map <- get_map("north carolina", maptype = "satellite", zoom = 6, source = "google")

    st_crs(nc_map)
    # Coordinate Reference System: NA

    # assume the coordinate refence system is 3857
    plot(st_transform(nc_shp, crs = 3857)[1], bgMap = nc_map)



plot(nc_shp, bgMap = nc_map)




ggmap(nc_map) + 
  geom_sf(data = st_transform(nc, 3857),
          mapping = aes(geometry = geometry, fill = AREA),
          inherit.aes  = FALSE)

geom_sf




a <- unlist(attr(map,"bb")[1, ])
bb <- st_bbox(nc)


class(map)
class()

ggmap(map)  + geom_sf(data = nc, mapping = aes(fill = AREA))

ggplot() + 
  annotation_raster(map, xmin = a[2], xmax = a[4], ymin = a[1], ymax = a[3]) + 
  # xlim(c(bb[1], bb[3])) + ylim(c(bb[2], bb[4])) + 
  geom_sf(data = nc, aes(fill = AREA))

