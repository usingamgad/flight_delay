#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

##loading airline/airport maps
airport_map<-read.csv('L_AIRPORT_ID.csv')
airlines_map<-read.csv('L_AIRLINE_ID.csv')

library(shiny)
# create choices for choice selection
choice <- c("one", "two", "three")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Flight Delays in the US"),
  
  # Sidebar with a slider input for number of bins 
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      # Date of flight selection
      dateInput("depDate","Date of Departure:")
      ,
      # time of departure or arrival input
      radioButtons(
        "deparr", "Please select:",
        c("Departure Time",
          "Arrival Time"), inline = TRUE)
      ,
      conditionalPanel(
        condition = "input.deparr == 'Departure Time'",
        h5("Time of Departure:"),
        bootstrapPage(
          div(style="display:inline-block",selectInput("depTimeH", "Hours:", c(0:23), selected = 1, multiple = FALSE,
                                                       selectize = TRUE, width = 80)),
          div(style="display:inline-block",selectInput("depTimeM", "Minutes:", c(0:59), selected = 00, multiple = FALSE,
                                                       selectize = TRUE, width = 80))
        ))
      ,
      conditionalPanel(
        condition = "input.deparr == 'Arrival Time'",
        h5("Time of Arrival:"),
        bootstrapPage(
          div(style="display:inline-block",selectInput("arrTimeH", "Hours:", c(0:23), selected = 1, multiple = FALSE,
                                                       selectize = TRUE, width = 80)),
          div(style="display:inline-block",selectInput("arrTimeM", "Minutes:", c(0:59), selected = 00, multiple = FALSE,
                                                       selectize = TRUE, width = 80))
        ))
      ,
      # Airlines
      selectInput('Airline', 'Select Airline:', airlines_map$Description, selected = NULL, multiple = FALSE)
      ,
      # Airport
      selectInput('DepAirport', 'Select Departure Airport:', airport_map$Description, selected = NULL, multiple = FALSE)
      ,
      selectInput('ArrAirport', 'Select Arrival Airport:', airport_map$Description, selected = NULL, multiple = FALSE)
      ,
      # Button to pass inputs to Python script
      actionButton("button", "Calculate Delay")
      ),
    
    # Show a plot of the generated distribution
    mainPanel(
    
      imageOutput("my_image"),
      textOutput("est")
    )
  )
))
