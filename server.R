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
library(lubridate)

airport_map<-read.csv('L_AIRPORT_ID.csv')
airlines_map<-read.csv('L_AIRLINE_ID.csv')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
 
  # Push user input to Python script
  pythonCallResults <- eventReactive(input$button, {
    
    #map_airlines
    airline<-airlines_map[airlines_map$Description==input$Airline,]$Code
    depairport<-airport_map[airport_map$Description==input$DepAirport,]$Code
    arrairport<-airport_map[airport_map$Description==input$ArrAirport,]$Code
    
    #map date input to day of week, day of month and month
    dayofweek <- as.POSIXlt(input$depDate)$wday
    if(dayofweek==0) {dayofweek <- 7}
    dayofmonth <- day(input$depDate)
    month <- month(input$depDate)
    #print(arrairport)
    
    command<-paste("python FlightApp_main.py ",airline,depairport,arrairport,dayofweek,dayofmonth,dayofmonth,month) 
    ##command<-paste("python FlightApp_main.py 1 1 1 19805 11298 11433 11")
    result<-system(command,intern = TRUE)
    
    return(result)
      })
  
    output$my_image<-renderImage({
    if(pythonCallResults()=="['No Delay']")
    {list(src='yellow3.png')}
    else 
    {list(src='orange4.png')}
    },deleteFile = FALSE)
  
  output$est <- renderText({pythonCallResults()})
  
 
   
  
  
  })