# test examples of plotting regions with sf

# This script takes a pre processed set of maps with Dairy stats data and plots it

library(tidyverse)
library(sf)
library(ggrepel) # ensures labels don't overlap
library(ggsflabel) # makes ggrepel work with sf
#library(gghighlight) #not used

NZ_TLA <- readRDS("NZ_TLA.RDS")
colnames(NZ_TLA)

#make and map Dairy Stats districts, from RDS ####----------------------------------------
NZ_TLA_DS <- NZ_TLA %>% 
  group_by(DistrictDairyStatistics_2018) %>% 
  summarize()

ggplot()+
  geom_sf(data = NZ_TLA_DS, aes(fill=DistrictDairyStatistics_2018))+
  #geom_sf(data = NZ_TLA, aes(fill=LAND_AREA_))+
  #geom_sf(data = NZ_TLA_cent)+
  geom_sf_label_repel(data = NZ_TLA_DS, aes(label = DistrictDairyStatistics_2018, 
                                            colour = DistrictDairyStatistics_2018),
                      force = 1, seed = 10, size = 2)+
  scale_y_continuous(expand = expansion(mult = 0.5))+
  scale_x_continuous(expand = expansion(mult = 0.5))+
  theme_void()+
  theme(legend.position = "none")#+
#scale_fill_distiller(palette = "Blues")
#scale_fill_gradient(low = "red",high = "yellow")

ggsave("NZ Dairy Statistics district map with direct label.png", width = 10, height = 10)
warnings()



#make and map Dairy Stats regions ####-------------------------------------------------
NZ_TLA_DS_regions <- NZ_TLA %>% 
  group_by(RegionDairyStatistics_2018) %>% 
  summarize()

ggplot()+
  geom_sf(data = NZ_TLA_DS_regions, aes(fill=RegionDairyStatistics_2018))+
  #geom_sf(data = NZ_TLA, aes(fill=LAND_AREA_))+
  #geom_sf(data = NZ_TLA_cent)+
  geom_sf_label_repel(data = NZ_TLA_DS_regions, aes(label = RegionDairyStatistics_2018, 
                                                    colour = RegionDairyStatistics_2018),
                      force = 1, seed = 10, size = 2)+
  scale_y_continuous(expand = expansion(mult = 0.5))+
  scale_x_continuous(expand = expansion(mult = 0.5))+
  theme_void()+
  theme(legend.position = "none")#+
#scale_fill_distiller(palette = "Blues")
#scale_fill_gradient(low = "red",high = "yellow")
ggsave("NZ Dairy Statistics region map with direct label.png", width = 10, height = 10)
warnings()

#make and map TLAs (1995) ####-------------------------------------------------------

ggplot()+
  geom_sf(data = NZ_TLA, aes(fill=TLA_1995))+
  #geom_sf(data = NZ_TLA, aes(fill=LAND_AREA_))+
  geom_sf(data = NZ_TLA_cent)+
  geom_sf_label_repel(data = NZ_TLA, aes(label = TLA_1995, colour = TLA_1995 ),
                      force = 1, seed = 10, size = 2)+
  scale_y_continuous(expand = expansion(mult = 0.5))+
  scale_x_continuous(expand = expansion(mult = 0.5))+
  theme_void()+
  theme(legend.position = "none")#+
#scale_fill_distiller(palette = "Blues")
#scale_fill_gradient(low = "red",high = "yellow")
ggsave("NZ TLA map with direct label.png", width = 10, height = 10)
warnings()


#make and map Economic Survey regions ####----------------------------------------------------
colnames(NZ_TLA)
NZ_TLA_Econ_regions <- NZ_TLA %>% 
  group_by(RegionEconomicSurvey_2018) %>% 
  summarize()

ggplot()+
  geom_sf(data = NZ_TLA_Econ_regions, aes(fill=RegionEconomicSurvey_2018))+
  #geom_sf(data = NZ_TLA, aes(fill=LAND_AREA_))+
  #geom_sf(data = NZ_TLA_cent)+
  geom_sf_label_repel(data = NZ_TLA_Econ_regions, aes(label = RegionEconomicSurvey_2018, colour = RegionEconomicSurvey_2018 ),
                      force = 1, seed = 10, size = 2)+
  scale_y_continuous(expand = expansion(mult = 0.5))+
  scale_x_continuous(expand = expansion(mult = 0.5))+
  theme_void()+
  theme(legend.position = "none")#+
#scale_fill_distiller(palette = "Blues")
#scale_fill_gradient(low = "red",high = "yellow")
ggsave("NZ Economic Survey region map with direct label.png", width = 10, height = 10)
warnings()