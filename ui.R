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

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Case control study outcome bar chart"),
  
  sidebarLayout(
    sidebarPanel(
      characterInput("ggplot.plot", "Create plot")
    ),
    
    mainPanel(
      plotOutput("plot")
    )
  )
))
