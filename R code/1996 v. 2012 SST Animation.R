# SST Animation for coldest (1996) and warmest (2012) years
library(tidyverse)
library(here)
library(DT)
library(sf)
library(raster)
library(terra)
library(nngeo)
library(data.table)
library(ggplot2)
library(gganimate)
library(glue)
library(gifski)

here::here()

# visualizing SST data
sst2012 <- readRDS(here::here("data-rawgridded-sst-data/sst2012.rds"))
sst1996<- readRDS(here::here("data-rawgridded-sst-data/sst1996.rds"))
sst<-rbind(sst1996,sst2012)

# looping data to go through all of the days in the year
sst <- as.data.table(sst)
myday <-c()
for(iyear in c(1996,2012)) {
  for(imonth in 1:12) {
    for(iday in 1:31) {
      oneday <- sst[as.numeric(year)==iyear & as.numeric(month)==imonth & as.numeric(day)==iday,]
      if(nrow(oneday)>0){
        myday <- rbindlist(list(myday, oneday))
      }
    }
  }
}


#Bind the data and add a column for each group
myday[,Group := paste(myday$month,myday$day,sep="-")]

p<-ggplot() +
  geom_tile(data = myday, aes(x = Lon, y = Lat, fill = sst)) +
  geom_sf(data = ecodata::coast) +
  #geom_point(data = northwest_atlantic_grid, aes(x = Lon, y = Lat), size=0.05, alpha=0.1) + (don't need to layer this data)
  scale_fill_gradientn(name = "Temp C",
                       limits = c(0.5, 31),
                       colours = c(scales::muted("blue"), "white",
                                   scales::muted("red"), "black")) +
  coord_sf(xlim = c(-77, -65), ylim = c(35, 45)) + 
  
  transition_states(Group,transition_length=1, state_length=3) +
  labs(title='{closest_state}') +
  facet_wrap(~year)

sst_gif <- animate(p, renderer = gifski_renderer(), fps = 15, duration = 50)
anim_save(sst_gif, filename="SST extreme years gif.gif", width = 10, height = 7, units="in")
