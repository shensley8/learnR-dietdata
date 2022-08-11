#This is the server file of your Shiny App.
library(plyr)


#setwd('/Users/crb/Documents/projects/lab/INFISH/sarah_generic')
#Copy and paste your dataset file into the www/data/ folder.
#Import your datasets
sst2012<- readRDS("www/data/sst2012.rds")
sst1996<- readRDS("www/data/sst1996.rds")
sst<-rbind(sst1996,sst2012)

#code months as numbers to match slider
sst$month<-as.numeric(sst$month)

#sst Plot function
dailysstplot <- function(month,year){
  
  #subset the data based on the parameters
  oneday <- sst[sst$month==month & sst$day=="15" & sst$year==year,] 
  ggplot() +
    geom_tile(data = oneday, aes(x = Lon, y = Lat, fill = sst)) +
    geom_sf(data = ecodata::coast) +
    #geom_point(data = northwest_atlantic_grid, aes(x = Lon, y = Lat), size=0.05, alpha=0.1) + (don't need to layer this data)
    scale_fill_gradientn(name = "Temp C",
                         limits = c(0.5, 31),
                         colours = c(scales::muted("blue"), "white",
                                     scales::muted("red"), "black")) +
    coord_sf(xlim = c(-77, -65), ylim = c(35, 45)) + 
    ggtitle(paste("Date:", unique(oneday$month),
                  unique(oneday$day), unique(oneday$year), sep = " "))
}

#plot1<-dailysstplot("07","1985")
#plot2<-dailysstplot("07","2021")

######### Start of the Server Function (Real-time Brains of the operation)
function(input, output,session){
  
### Create a copy of the dataset(df) that is subset based on the user's actions with sliders, checboxes, etc.  
  #This changing dataset (reactive) we will name selData.
  
  # selData<-reactive({
  #   
  #   #Create variables that hold the current position of the sliders
  #   slide1<-input$month
  #  
  #   
  #   #subset df based on the years selected with the sliders
  #   selData<-df[(df$Year>=slide1 & df$Year<=slide2),]
  # })
  
  
  ##################### Button Section ################
  # #Wait for button to be pressed and then do something when that happens.
  # observeEvent(input$warn,{
  #   alert("I thought I said not to click that!")
  # })
  
  
  ########################## Slider Section
  
#Wait for changes to the sliders and then do something when that happens  
observeEvent(input$month,{
        #holds the value of the slider
        
        slide1<-as.numeric(which(month.name==input$month))
        print(slide1)
        ##################### Plot Section ################
        #make graph of frequencies
        output$plot1 <- renderPlot({
          p <- dailysstplot(slide1,"1985")
          p
        })
        
        output$plot2 <- renderPlot({
          p <- dailysstplot(slide1,"2021")
          p
        })
        ##End of Plot
    
})
###################################################
  
########################## Make a Data Table using selData  ##############
  
  #output$table1 <- DT::renderDataTable(selData(),server=FALSE,rownames = FALSE,options = list(dom = 't'))
  
#####################################################
  
  #Control for when the user closes a browser, stop the app.
  session$onSessionEnded(function(){
    stopApp()
  })
  #######


} ### End of Server 
