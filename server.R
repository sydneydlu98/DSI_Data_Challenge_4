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
    output$plot <- renderPlotly({
        
        strep_imp <- strep_tb %>%
            filter(improved == input$improved) %>%
            rename(Case_VS_control = arm) %>%
            select(-dose_PAS_g)
        
        ggplot.plot <- ggplot(data = strep_imp,
                              aes(x = rad_num,
                                  fill = Case_VS_control)) +
            geom_bar() +
            labs(title = "Improvement Result based on \n Numeric Rating of Chest X-ray at month 6",
                 x = "Numeric Rating of Chest X-ray at month 6",
                 y = "Count") +
            theme(plot.title = element_text(hjust = 0.5,
                                            size = 12)) +
            guides(fill=guide_legend(title="Case VS control"))
        
        ggplotly(ggplot.plot)
        
    })
    
})