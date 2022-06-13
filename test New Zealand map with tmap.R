#test New Zealand Map with tmap interactive

library(tidyverse)
library(sf)
library(tmap)

tmap_mode("view") #sets tmap to be interactive

# Plot NZ shape on basemap, interactive 
nz_shape <-  read_sf("NZL_adm0.shp") # adm0 -> national admin level
tmap_mode("view")
tm_shape(st_geometry(nz_shape)) +  tm_polygons()  # note Chatham Islands are over the date line (180 longitude) so it is zoomed out

# Plot NZ region shapes on basemap, interactive 
nz_regions <- read_sf("NZL_adm1.shp") # adm1 -> regional admin level
tm_shape(st_geometry(nz_regions)) +  tm_polygons()

# Plot Waikato  shape on basemap, interactive 
waikato <- nz_regions %>% 
  filter(NAME_1 == "Waikato") # filter to get Waikato only
tm_shape(st_geometry(waikato)) +  tm_polygons()
