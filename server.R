#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(rsconnect)
library(readr)
library(medicaldata)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$plot <- renderPlot({
        
        strep_imp <- strep_tb %>%
            filter(improved == "TRUE") %>%
            select(-dose_PAS_g)
        
        ggplot.plot <- ggplot(data = strep_imp,
                              aes(x= input, 
                                  fill = arm)) +
            geom_bar()
        
        ggplotly(ggplot.plot) 
        
    })
    
})