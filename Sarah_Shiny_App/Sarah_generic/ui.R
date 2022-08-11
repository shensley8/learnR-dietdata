# June 16, 2022 User Interface Script to create a Shiny App during INFISH Class

#### Load necessary packages
library(shinyWidgets)
library(ggplot2)
library(shinydashboard)
#library(leaflet)


### Start of Interface Layout

### Color Scheme and Title of Page

dashboardPage(skin="blue",
              
  dashboardHeader(title="INFISH - This is My App!",titleWidth = 500),

############################## #Sidebar of APP ##############################

  dashboardSidebar(width = 240
                   #,

      #actionButton(inputId = "warn", label = "Do not click"),
      
     # materialSwitch(inputId = "help1", label = "Show Movie", status = "primary", right = TRUE)
),


#####################################################################################
############ Body of App ####################

dashboardBody(

 tabBox( width=12,
         
    ########################### First Tab of Your App ##################### 
    tabPanel("Sea Surface Temperature Maps",
         fluidPage(h2("1996 (cold extreme) v. 2012 (warm extreme) Sea Surface Temperature Comparison"),
                   
                   
                   conditionalPanel(condition = "input.help1",       
                      
                                   HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/xvFZjo5PgG0?" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                   ),
                   
                   fluidRow(column(6,
                   #                 
                         fluidRow(h3("Select What Month to Display")),
                   # 
                          #fluidRow(sliderInput("month", "Select Month:",1,12,value = 1, sep="", step = 1)),
                          fluidRow(sliderTextInput(
                            inputId = "month",
                            grid=TRUE,
                            label = "Month range slider:",
                            choices = month.name,
                            selected = month.name[1]
                          )),
                   # 
                   ),
                   column(6,
                         # fluidRow(h3("Here is Another Control Element")),
                          # 
                         # fluidRow(column(3,checkboxInput('genre1box', tags$b('Graph On/Off'), value = 1, width = NULL))),
                          )), 
                   #conditionalPanel(condition = "input.genre1box", fluidRow(div(plotOutput('plot1',height="260px")))),
                    
                   fluidRow(column(6,div(plotOutput('plot1',height="500px"))),column(6,div(plotOutput('plot2',height="500px"))))
                   
                   
                   #fluidRow(column(10,DT::dataTableOutput("table1"))),
                   
                   #fluidRow(column(10,leafletOutput('mymap')))
                   
                   
            )
    ),
    ######### End of Tab 1 ############################
    ########################### 2nd Tab of Your App ##################### 
    tabPanel("About the Author",
             fluidPage(h2("Sarah Hensley"),
                       
                  fluidRow(
                    column(6,img(src = "Sarah.Hensley.picture (2).jpg", height = 400)),
                       
                    column(6,HTML("Hi everyone! My name is Sarah Hensley and I am going to be a junior this year at the University of Washington. I am currently pursuing a double degree with a B.S. in Marine Biology and a B.S. in Biology-Ecology, Evolution, and Conservation. 
                                  I am therefore very thrilled to be able to share my project with you! As I've been participating in the IN FISH internship I have been working on a project
                                  assessing the relationship between fish consumption trends and ocean temperature trends, from both a sea bottom temperature and a sea surface temperature 
                                  perspective. This website displays the sea surface aspect of our analysis work, displaying daily sea surface temperatures for every day of both the 1996 
                                  and 2012 year. These animations are displayed side by side to enable the user to compare sea surface temperatures from previous years to current years. This acts as 
                                  an index for how the sea surface temperature has been changing over time. The reason this comparison between temperature and fish consumption was assessed for my
                                  project is due to a growing need of analysis on how climate change is impacting ecosystems. Within that umbrella of work, visualizations like the temperature plots on
                                  this website enable users to develop a visual understanding of some of the data that we are processing and get a hands on expereince themselves.")))
              )
      )  ######### End of Tab 2 ############################    
    
  ) ######### End of Tab Box ############################
) ######### End of Body ############################
) ######### End of Page ############################


