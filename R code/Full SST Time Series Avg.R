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

here()

# visualizing SST data
sst2021 <- readRDS(here("data-rawgridded-sst-data/sst2021.rds"))
sst2020 <- readRDS(here("data-rawgridded-sst-data/sst2020.rds"))
sst2019 <- readRDS(here("data-rawgridded-sst-data/sst2019.rds"))
sst2018 <- readRDS(here("data-rawgridded-sst-data/sst2018.rds"))
sst2017 <- readRDS(here("data-rawgridded-sst-data/sst2017.rds"))
sst2016 <- readRDS(here("data-rawgridded-sst-data/sst2016.rds"))
sst2015 <- readRDS(here("data-rawgridded-sst-data/sst2015.rds"))
sst2014 <- readRDS(here("data-rawgridded-sst-data/sst2014.rds"))
sst2013 <- readRDS(here("data-rawgridded-sst-data/sst2013.rds"))
sst2012 <- readRDS(here("data-rawgridded-sst-data/sst2012.rds"))
sst2011 <- readRDS(here("data-rawgridded-sst-data/sst2011.rds"))
sst2010 <- readRDS(here("data-rawgridded-sst-data/sst2010.rds"))
sst2009 <- readRDS(here("data-rawgridded-sst-data/sst2009.rds"))
sst2008 <- readRDS(here("data-rawgridded-sst-data/sst2008.rds"))
sst2007 <- readRDS(here("data-rawgridded-sst-data/sst2007.rds"))
sst2006 <- readRDS(here("data-rawgridded-sst-data/sst2006.rds"))
sst2005 <- readRDS(here("data-rawgridded-sst-data/sst2005.rds"))
sst2004 <- readRDS(here("data-rawgridded-sst-data/sst2004.rds"))
sst2003 <- readRDS(here("data-rawgridded-sst-data/sst2003.rds"))
sst2002 <- readRDS(here("data-rawgridded-sst-data/sst2002.rds"))
sst2001 <- readRDS(here("data-rawgridded-sst-data/sst2001.rds"))
sst2000 <- readRDS(here("data-rawgridded-sst-data/sst2000.rds"))
sst1999 <- readRDS(here("data-rawgridded-sst-data/sst1999.rds"))
sst1998 <- readRDS(here("data-rawgridded-sst-data/sst1998.rds"))
sst1997 <- readRDS(here("data-rawgridded-sst-data/sst1997.rds"))
sst1996 <- readRDS(here("data-rawgridded-sst-data/sst1996.rds"))
sst1995 <- readRDS(here("data-rawgridded-sst-data/sst1995.rds"))
sst1994 <- readRDS(here("data-rawgridded-sst-data/sst1994.rds"))
sst1993 <- readRDS(here("data-rawgridded-sst-data/sst1993.rds"))
sst1992 <- readRDS(here("data-rawgridded-sst-data/sst1992.rds"))
sst1991 <- readRDS(here("data-rawgridded-sst-data/sst1991.rds"))
sst1990 <- readRDS(here("data-rawgridded-sst-data/sst1990.rds"))
sst1989 <- readRDS(here("data-rawgridded-sst-data/sst1989.rds"))
sst1988 <- readRDS(here("data-rawgridded-sst-data/sst1988.rds"))
sst1987 <- readRDS(here("data-rawgridded-sst-data/sst1987.rds"))
sst1986 <- readRDS(here("data-rawgridded-sst-data/sst1986.rds"))
sst1985<- readRDS(here("data-rawgridded-sst-data/sst1985.rds"))

sst<-rbind(sst1985,sst1986,sst1987,sst1988,sst1989,sst1990,sst1991,
           sst1992,sst1993,sst1994,sst1995,sst1996,sst1997,sst1998,
           sst1999,sst2000,sst2001,sst2002,sst2003,sst2004,sst2005,
           sst2006,sst2007,sst2008,sst2009,sst2010,sst2011,sst2012,
           sst2013,sst2014,sst2015,sst2016,sst2017,sst2018,sst2019,
           sst2020,sst2021)

# finding averages for each day & adding to new dataframe
avg_sst <-sst %>%
  group_by(year, month, day) %>%
  summarise_at(vars(sst), list(average.sst = mean))

avg_sst

# making all values numeric
avg_sst$year <- as.numeric(as.character(avg_sst$year))
avg_sst$month <- as.numeric(as.character(avg_sst$month))
avg_sst$day <- as.numeric(as.character(avg_sst$day))
avg_sst$average.sst <- as.numeric(as.character(avg_sst$average.sst))

# finding averages for each year
avg_sst_year <-avg_sst %>%
  group_by(year) %>%
  summarise_at(vars(average.sst), list(average.sst.yearly = mean))

avg_sst_year

# plotting line graph based on season averages
lp_sst <- ggplot(aes(y=average.sst.yearly, x=year), data=avg_sst_year) +
  geom_line(color="black", stat="identity") +
  geom_point(color="black", size=1) +
  geom_smooth(method=lm, color="tan1", alpha=0) +
  scale_x_continuous(breaks=seq(1985, 2021, 5), expand=c(0.005,0.005)) + 
  theme(axis.text.x = element_text(angle = 0, family="sans", size = 13),
        axis.text.y = element_text(size = 13, color = "black", family="sans"),
        axis.title = element_text(size = 15, family="sans")) +
  theme(panel.background = element_rect(fill="white", colour="white", size=0, 
                                        linetype="solid", color="black"))

sst_average_lp <-lp_sst+ labs(title = "Average Sea Surface Temperature", face="bold",
                             x="Year", y="Temperature (C)")

sst_average_lp

## save plot
ggsave(plot = sst_average_lp, filename = "Avg SST Full Time Scale LP.jpg", width = 7, height = 4, units = "in")



