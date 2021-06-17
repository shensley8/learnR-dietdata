# demonstrate interactive R

2+2

mean(c(2,3,4))

# this is a comment

# read in the data

library(here)

dietdat1 <- read.csv(here("data/allwt2.csv"))

# exploratory commands

head(dietdat1)

tail(dietdat1)

names(dietdat1)

# commands to visualize the data using "tidyverse"

libary(tidyverse)  #for data wrangling and plotting

# make a new dataset called ntows from dietdat1 that sums tows into a variable called anntows

ntows <- dietdat1 %>% # a pipe operator that strings the commands together
  group_by(comname, year, epu) %>% # for each predator/year/epu combo
  summarise(anntows = sum(num_tows, na.rm = TRUE)) # sum the tows

# see the top of the dataset

ntows

# ggplot is a quick way to look across lots of things
# the aes statement sets up x and y axis variable
# with color differentiating area, 
# line plot is defined with geom_line, and
# using facet_wrap does a plot for each predator (comname)

ntows %>%
  ungroup() %>%
  ggplot(aes(x=year, y=anntows, color=epu)) + 
  geom_line() + 
  facet_wrap(~comname)

# filter allows us to only look at a few species
# otherwise code is the same as above

ntows %>%
  ungroup() %>%
  filter(comname %in% c("SUMMER FLOUNDER",
                        "SILVER HAKE",
                        "LITTLE SKATE",
                        "ATLANTIC COD"
  )) %>%
  ggplot(aes(x=year, y=anntows, color=epu)) + 
  geom_line() + 
  facet_wrap(~comname)


