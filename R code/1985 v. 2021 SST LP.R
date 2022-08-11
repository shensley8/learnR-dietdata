# making SST line plots for 1985 v. 2021

# loading libraries
library(tidyverse)
library(ggplot2)
library(readr)
library(dplyr)
library(lubridate)
library(here)

# read in data file
sst2021 <- readRDS(here("data-rawgridded-sst-data/sst2021.rds"))
sst1985 <- readRDS(here("data-rawgridded-sst-data/sst1985.rds"))
sst<-rbind(sst1985,sst2021)

# finding averages for each day & adding to new dataframe
avg_sst <-sst %>%
  group_by(year, month, day) %>%
  summarise_at(vars(sst), list(average.sst = mean))

avg_sst

# adding continuous scale for date
avg_sst_total <- data.frame(date.num=rep(NA, nrow(avg_sst)))
avg_sst <- cbind(avg_sst, avg_sst_total)

avg_sst$date.num[which(avg_sst$year == 1985)]<-paste(as.numeric(1:365))
avg_sst$date.num[which(avg_sst$year == 2021)]<-paste(as.numeric(1:365))

# plotting line graph based on season averages
lp_sst <- ggplot(aes(y=average.sst, x=as.numeric(date.num), group = year), data=avg_sst) +
  geom_line(aes(color=year), stat="identity") +
  geom_point(aes(color=year), size=1) +
  #geom_smooth(method=lm, color="tan1", alpha=0.5) +
  scale_x_continuous(breaks=seq(1, 365, 30), expand=c(0.005,0.005)) + 
  scale_color_manual(values=c("deepskyblue4", "coral2")) +
  theme(axis.text.x = element_text(angle = 0, family="sans", size = 10),
        axis.text.y = element_text(size = 10, color = "black", family="sans"),
        axis.title = element_text(size = 15, family="sans")) +
  theme(panel.background = element_rect(fill="white", colour="white", size=0, 
                                        linetype="solid", color="black"))

line_plot_sst <-lp_sst+ labs(title = "1985 vs. 2021 Sea Surface Temperature", face="bold",
                                        x="Day", y="Temperature (C)")

line_plot_sst

## save plot
ggsave(plot = line_plot_sst, filename = "1985 v 2021 SST LP.jpg", width = 8, height = 4, units = "in")

