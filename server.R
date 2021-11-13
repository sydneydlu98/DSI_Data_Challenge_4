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

shinyServer(function(input, output) {
  output$plot2 <- renderPlotly({
    strep_plot2 <- strep_tb %>%
      filter(improved == input$improved) %>%
      mutate(Case_VS_control = ifelse(arm %in% c("Streptomycin"), "Streptomycin", "Placebo")) %>%
      select(-dose_PAS_g)
    
    # second plot - bar plot
    p2 <- ggplot(data = strep_plot2,
                 aes(x = rad_num,
                     fill = Case_VS_control)) +
      geom_bar() +
      labs(title = "Case VS control for Improvement",
           x = "Numeric Rating of Chest X-ray at month 6",
           y = "Count") +
      guides(fill = guide_legend(title = "Streptomycin VS Placebo")) +
      theme(plot.title = element_text(
        hjust = 0.5,
        size = 15,
        face = "bold"
      ))
    
    ggplotly(p2)
  })
  
  # third plot - scatter plot
  output$plot3 <- renderPlotly({
    strep_plot3 <- strep_tb %>%
    mutate(Gender = ifelse(gender %in% c("M"), "Male", "Female")) %>%
    mutate(Baseline_Cavitation = ifelse(baseline_cavitation %in% c("yes"), "Yes", "No"))
    
    p3 <- ggplot(data = strep_plot3,
                 aes(
                   x = rad_num,
                   y = input$baseline,
                   col = Gender
                 )) +
      geom_point() +
      geom_jitter() +
      labs(x = "Numeric Rating of Chest X-ray at month 6",
           y = "Baseline Condition",
           title = "Improvement status vs. Baseline Condition") +
      theme(plot.title = element_text(
        hjust = 0.5,
        size = 15,
        face = "bold"
      ))
    
    ggplotly(p3)
  })
})