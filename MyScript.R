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


