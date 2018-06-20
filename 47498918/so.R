library(ggplot2)
data(iris)

## Datasets to imitate the shapefile layers
ds1 <- subset(iris, Species == "setosa")
ds2 <- subset(iris, Species == "versicolor")

## Example how the basemap function works at the moment:

ggplot() +
  geom_point(data = ds1, aes(x = Sepal.Length, y = Sepal.Width), color = "red") +
  geom_point(data = ds2, aes(x = Sepal.Length, y = Sepal.Width), color = "blue") +
  scale_x_continuous("Longitude", breaks = seq(3, 8, by = 0.5)) +
  scale_y_continuous("Latitude", breaks = seq(1,5, by = 1)) + theme_bw()


    plot_glaciers <- function(keep_glaciers = TRUE) {
      layers <- vector('list')

      layers$land    <- geom_point(data = ds1, aes(x = Sepal.Length, y = Sepal.Width), color = "red")
      layers$def     <- list(scale_x_continuous("Longitude", breaks = seq(3, 8, by = 0.5)),
                        scale_y_continuous("Latitude", breaks = seq(1,5, by = 1)),
                        theme_bw())

      if (keep_glaciers) {
        layers$glacier <- geom_point(data = ds2, aes(x = Sepal.Length, y = Sepal.Width), color = "blue")
      } 

      ggplot() + layers
    }

    plot_glaciers(TRUE)
    plot_glaciers(FALSE)




## Now I would like to plot ds2 only if user defines "keep.glaciers = TRUE"

land <- ggplot() + geom_point(data = ds1, aes(x = Sepal.Length, 
y = Sepal.Width), color = "red")

glacier <- geom_point(data = ds2, aes(x = Sepal.Length, y = Sepal.Width), color = "blue")

def <- scale_x_continuous("Longitude", breaks = seq(3, 8, by = 0.5)) +
scale_y_continuous("Latitude", breaks = seq(1,5, by = 1)) + theme_bw() ## Error!
# Error in +scale_x_continuous("Longitude", breaks = seq(3, 8, by = 0.5)) :
#  invalid argument to unary operator

## The ultimate goal:
keep.glaciers = TRUE

if(keep.glaciers) {
  land + glacier + def # error, see above
} else {
  land + def
}

## Alternative approach

land <- "ggplot() + geom_point(data = ds1, aes(x = Sepal.Length, y = Sepal.Width),
 color = 'red')"

glacier <- "geom_point(data = ds2, aes(x = Sepal.Length, y = Sepal.Width),
 color = 'blue')"

def <- "scale_x_continuous('Longitude', breaks = seq(3, 8, by = 0.5)) +
 scale_y_continuous('Latitude', breaks = seq(1,5, by = 1)) + theme_bw()"


eval(parse(text=land)) ## Works

eval(parse(text=paste(land, glacier, sep = " + "))) ## Works

eval(parse(text=paste(land, glacier, out, sep = " + "))) ## Error :(
#  Error: Don't know how to add o to a plot 
