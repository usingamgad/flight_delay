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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$Delay <- renderText({
    
    #map_airlines
    airline<-airlines_map[airlines_map$Description==input$Airline,]$Code
    airport<-airlport_map[airlport_map$Description==input$Airport,]$Code
    
    delay<-predict(lm,data.frame(DayOfWeek=input$DayOfWeek,ArrTime=input$ArrTime,Airport=airport,Airline=airline))
    print(delay)
    
  })
  
  output$my_image<- renderImage({
    if (1==3)
    {return(list(src='green.jpg',contentType='image/jpg',alt='Face'))}
    else if (1==2)
    {return(list(src='red.jpg',contentType='image/jpg',alt='Face'))}
    else if (1==1)
    {return(list(src='yellow.jpg',contentType='image/jpg',alt='Face'))}
    else
    {return(NULL)}
  },deleteFile=FALSE)
  
})
