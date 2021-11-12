#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws the second plot
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(
  
  # Give the page a title  
  titlePanel("Streptomycin for TB Dataset Analysis"),
  
  # Generate a row with a sidebar
  sidebarLayout(
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput(inputId = "improved",
                  label = "Improvement",
                  choices = c("Improved" = "TRUE",
                              "Not improved" = "FALSE")),
      helpText("1 = Death"),
      helpText("2 = Considerable Deterioration"),
      helpText("3 = Moderate Deterioration"),
      helpText("4 = No Change"),
      helpText("5 = Moderate Improvement"), 
      helpText("6 = Considerable Improvement"),
    
    selectInput(inputId = "gender",
                label = "Gender",
                choices = c("Male" = "M",
                            "Female" = "F")),
    helpText("M = Male"),
    helpText("F = Female"),
    ),
    
    
    # Create a spot for the bar plot
    mainPanel(
      plotlyOutput("plot2"), 
      plotlyOutput("plot3"))
  )
))