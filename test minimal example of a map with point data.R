# test minimal example of a map with point data, and some distance calculations

# Static testing of gps collars, compare actual to reported points

library(tidyverse)
library(sf)
library(ggmap)
library(readxl)
library(geosphere) # calculate distance location

# register_google
register_google("AIzaSyBixzP6TzjYXBMIAXkMTJktQ4jeuACYH_A", write = TRUE) # key for R4DS, will be deleted 1/7/2022
# To obtain an API key and enable services, go to https://cloud.google.com/maps-platform/.

# Read base points of static testing from shape file
rtk_base_points_shp <- st_read("point.shp")
# class(rtk_base_points_shp)
# st_crs(rtk_base_points_shp)

# Plot!
ggplot(rtk_base_points_shp)+
	geom_sf()

# Read base points of static testing from excel file
base_points <- read_excel("static testing.xlsx", sheet = "RTK locations")
base_points
class(base_points)

# Convert to google standard projection
base_points_sf <- st_as_sf(base_points, coords = c("Longitude", "Latitude"), crs = 4326)

ggplot(base_points_sf)+
	geom_sf()

# Read reported locations of static testing from excel file
reported_points <- read_excel("static testing.xlsx", sheet = "locations")
reported_points

# Convert to google standard projection
reported_points_sf <- st_as_sf(reported_points, coords = c("Longitude", "Latitude"), crs = 4326)

ggplot(reported_points_sf)+
	geom_sf()

# my google API key may be needed for others to access the background maps

# Option 1: Get base map at a location manually by getting centre point and approximate zoom from googlemaps in a browser
# static_background_map <- get_map(location=c(lon = 172.537346, lat = -43.339372), zoom=14, maptype = 'hybrid') #n.b. these numbers are wrong!

# option 2: Get base map with code based on bounding box, a box that contains all the data
bounding_box <- st_bbox(rtk_base_points_shp)
class(bounding_box)

names(bounding_box) <- c("left", "bottom", "right", "top") # need to rename for ggmap

static_background_map <- get_map(location = bounding_box, maptype = 'hybrid', zoom=17) #zoom is still set manually, an integer.
class(static_background_map)
st_crs(static_background_map)

# note to combine ggmap and sf object: inherit.aes = FALSE
# https://stackoverflow.com/a/49628142/4927395

#plot together, base map, reported points, and base points
ggmap(static_background_map)+
	geom_sf(data = reported_points_sf, aes(colour = as.factor(deviceName)), inherit.aes = FALSE)+
	geom_sf(data = base_points_sf, aes(colour = as.factor(deviceName)), shape = 2, inherit.aes = FALSE)

ggsave("static test.png")

# # an alternative interactive mapping approach, maybe leaflet or tmap would be easier to learn?
# mapview(list(reported_points_sf, rtk_base_points_shp)) #doesn't work?


## Calculate distances of base points to reported points
# Calculate distance from true ####---------------------------------------------------
static_data_joined <- full_join(base_points, reported_points,
								by = c("deviceName"))

# Add column for distance between projected and true location
static_data_joined <- static_data_joined %>%
	mutate(Distance = distHaversine(cbind(Longitude.x, Latitude.x),
									cbind(Longitude.y, Latitude.y)))

ggplot(static_data_joined)+
	geom_jitter(aes(x=as.factor(deviceName), y=Distance))+
	geom_boxplot(aes(x=as.factor(deviceName), y=Distance))+
	labs(x=NULL)

static_data_joined %>%
	group_by(deviceName) %>%
	summarise(median = median(Distance))

