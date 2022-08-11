library(tidyverse)
library(here)
library(DT)
library(FishStatsUtils)
library(sf)
library(raster)
library(terra)
library(nngeo)
library(data.table)
library(ggplot2)
library(gganimate)
library(glue)

here()
ecodata::epu_sf

# visualizing SST data
sst2021 <- readRDS(here("data-rawgridded-sst-data/sst2021.rds"))
oneday <- sst2021[sst2021$month=="07" & sst2021$day=="04",] 
jan15 <- sst2021[sst2021$month=="01" & sst2021$day=="15",] 
mar15 <- sst2021[sst2021$month=="03" & sst2021$day=="15",]
may15 <- sst2021[sst2021$month=="05" & sst2021$day=="15",]
jul15 <- sst2021[sst2021$month=="07" & sst2021$day=="15",]
sep15 <- sst2021[sst2021$month=="09" & sst2021$day=="15",]
nov15 <- sst2021[sst2021$month=="11" & sst2021$day=="15",]

dailysstplot <- function(oneday){
  ggplot() +
    geom_tile(data = sst2021, aes(x = Lon, y = Lat, fill = sst)) +
    geom_sf(data = ecodata::coast) +
   # geom_point(data = sst, aes(x = Lon, y = Lat), size=0.05, alpha=0.1) +
    scale_fill_gradientn(name = "Temp C",
                         limits = c(0.5, 31),
                         colours = c(scales::muted("blue"), "white",
                                     scales::muted("red"), "black")) +
    coord_sf(xlim = c(-77, -65), ylim = c(35, 45)) + 
    ggtitle(paste("SST, mm dd yyyy:", unique(sst2021$month),
                  unique(sst2021$day), unique(sst2021$year), sep = " ")) 
}

# adding column that groups day, month and year
sst2021$date <-paste(sst2021$month, sst2021$day, sst2021$year)

# building function that calls each day and saves a plot of each day
sstplots <- function(oneday){
  ggplot() +
    geom_tile(data=sst2021, aes(x = Lon, y = Lat, fill = sst)) +
    geom_sf(data = ecodata::coast) + 
    #geom_point(data = sst2021, aes(x = Lon, y = Lat), size=0.05, alpha=0.1) +
    scale_fill_gradientn(name="Temp C", limits = c(0.5,31), 
                         colours = c(scales::muted("blue"), "white",
                                     scales::muted("red"), "black")) +
    coord_sf(xlim = c(-77,-65), ylim = c(35, 45)) +
    ggtitle(paste("SST, mm dd yyyy:", unique(sst2021$date), sep = " ")) 
}

#dailysstplot(oneday)

par(mfrow=c(2,3))
dailysstplot(jan15)
dailysstplot(mar15)
dailysstplot(may15)
dailysstplot(jul15)
dailysstplot(sep15)
dailysstplot(nov15)

sstplots(jan02)

p <-ggplot() +
  geom_tile(data = sst2021, aes(x = Lon, y = Lat, fill = sst)) +
  geom_sf(data = ecodata::coast) +
  # geom_point(data = sst, aes(x = Lon, y = Lat), size=0.05, alpha=0.1) +
  scale_fill_gradientn(name = "Temp C",
                       limits = c(0.5, 31),
                       colours = c(scales::muted("blue"), "white",
                                   scales::muted("red"), "black")) +
  coord_sf(xlim = c(-77, -65), ylim = c(35, 45)) + 
  ggtitle(paste("SST, mm dd yyyy:", unique(sst2021$month),
                unique(sst2021$day), unique(sst2021$year), sep = " ")) 

plot(p)
gganimate(p, aes(frame~date))
q <- p + transition_time(sst2021$month) +
     ggtitle('Date:{frame_time}')
num_dates <- max(sst2021$month) - min(sst2021$month) + 1
animate(q, nframes = num_dates)

library(patchwork)
gganimate(dailysstplot)
temp_plot <- dailysstplot(sst2021$date)+
  ggplot(data = sst2021, aes(frame ~date))
gganimate(temp_plot)

#---------------------------------------------------------------------------------------------------
library(tidyverse)
library(here)
library(DT)
library(FishStatsUtils)
library(sf)
library(raster)
library(terra)
library(nngeo)
library(data.table)
library(ggplot2)
library(gganimate)
library(glue)
library(tidyverse)
library(rnaturalearth)
library(lubridate)
library(sf)
library(raster)
library(ggthemes)
library(gifski)
library(showtext)
library(sysfonts)

# import dataset
sst2021 <- readRDS(here("data-rawgridded-sst-data/sst2021.rds"))
sst2021$date <-paste(sst2021$month, sst2021$day, sst2021$year)

# make plot
sst_plots <- for(i in 1:479610) {
    ggplot() +
      geom_tile(data = sst2021, aes(x = Lon, y = Lat, fill = sst)) +
      geom_sf(data = ecodata::coast) +
      # geom_point(data = sst, aes(x = Lon, y = Lat), size=0.05, alpha=0.1) +
      scale_fill_gradientn(name = "Temp C",
                       limits = c(0.5, 31),
                       colours = c(scales::muted("blue"), "white",
                                   scales::muted("red"), "black")) +
      coord_sf(xlim = c(-77, -65), ylim = c(35, 45)) + 
      ggtitle(paste("SST, mm dd yyyy:", unique(sst2021$month),
                unique(sst2021$day), unique(sst2021$year), sep = " ")) 

      ggsave(date[i], width = 8.5, height = 7.5, type = "cairo")
      plot_dev()
  }

# converting data to data frame
sst2021_df <- as.data.frame(sst2021, c("Lon", "Lat", "year", "month", "day", "sst", str_c("date", 1:479610)))

