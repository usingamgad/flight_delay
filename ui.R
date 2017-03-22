#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# create choices for choice selection
choice <- c("one", "two", "three")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Flight Delays in the US in January 2016"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("DayOfWeek",
                   "Day of Week:",
                   min = 1,
                   max = 7,
                   value = 1)
       ,
       sliderInput("ArrTime","arrival time", dragRange=FALSE, value=0, min=0,max=24,step=0.5)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      # plotOutput("distPlot")
       ##textOutput("Delay"),
      #img(src="/Users/mm186160/Documents/Bootcamp/Team_Umizumi/green.png", alt="dinosaur")
      #img(src='green.png', align = "right")
      
      imageOutput("my_image")
 
    )
  )
))
