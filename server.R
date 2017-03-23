#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(png)

airport_map<-read.csv('L_AIRPORT_ID.csv')
airlines_map<-read.csv('L_AIRLINE_ID.csv')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$Delay <- renderText({
    
    #map_airlines
    airline<-airlines_map[airlines_map$Description==input$Airline,]$Code
    airport<-airport_map[airport_map$Description==input$Airport,]$Code
    
    #map date input to day of week, day of month and month
    dayofweek <- as.POSIXlt(input$depDate)$wday
    if(dayofweek==0) {dayofweek <- 7}
    dayofmonth <- day(input$depDate)
    month <- month(input$depDate)
    #print(dayofweek)
  })

  output$my_image<- renderImage({
    if (1==1)
    {return(list(src='green1.png',contentType='image/png',alt='All is well. Your flight will not be delayed.'))}
    else if (1==2)
    {return(list(src='green2.png',contentType='image/png',alt='Your flight will be delayed, but no more than 30 minutes.'))}
    else if (1==3)
    {return(list(src='yellow3.png',contentType='image/png',alt='Your flight will be more than 30 minutes delayed, but no more than 60 minutes.'))}
    else if (1==3)
    {return(list(src='orange4.png',contentType='image/png',alt='Your flight will be significantly delayed - more than one hour, but no more than 90 minutes'))}
    else if (1==3)
    {return(list(src='red5.png',contentType='image/png',alt='You flight will be significantly delayed - more than 90 minutes.'))}
    else
    {return(NULL)}
  },deleteFile=FALSE)
  

    #print(command)
  # Push user input to Python script
  pythonCallResults <- eventReactive(input$button, {
    ##command<-paste("python FlightApp_main.py ",input$DayOfWeek,input$ArrTime,airport,airline )
    command<-paste("python FlightApp_main.py 1 1 1 19805 11298 11433 11")
    result<-system(command,intern = TRUE)
    print(result)
    paste0("Delay in minutes: ", result)
  })
  
  output$est <- renderText({
    pythonCallResults()
  })
  })