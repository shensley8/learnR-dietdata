# importing data
prd_prey <- read.csv("Predator Data/maCa3fin.csv")
names(prd_prey)

# plotting trends in predator-prey consumption
plotAggPreytrend <- function(dat,prey){   #defines the name of the function and the required inputs
  
 dat %>% 
  filter(!is.na(mean),
           prey==prey) %>%          #take out the NA values (literally "not is NA")
  ggplot(aes(x=year, y=mean)) +     #year on x axis, %diet comp on y
  geom_point()+                               #proportion in each year is a point
  ecodata::geom_gls(warn = FALSE) + #prints lines if significant trend
  ecodata::theme_facet() +                   #a simpler theme, easier to read
  facet_wrap(~svspp,                 #separate by epu, season, and prey
               labeller = labeller(.multi_line = FALSE),
               scales="free") +      #format labels              
  theme(strip.text.x = element_text(size = 8)) +  #plot titles smaller
  labs(y = "consumption")               #add sensible labels
  
}  

plotAggPreytrend((prd_prey),"all")

