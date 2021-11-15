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
  # first plot - bar plot
  output$plot1 <- renderPlotly({
    strep_plot1 <- strep_tb %>%
      # rename the column arm
      mutate(Case_VS_control = ifelse(arm %in% c("Streptomycin"), "Streptomycin", "Placebo")) %>%
      # filter by the new column Case_VS_control 
      filter(Case_VS_control == input$Case_VS_control)
    
    # create the scatter plot
    p1 <- ggplot(
      data = strep_plot1,
      aes(
        x = rad_num,
        y = strep_resistance,
        col = Case_VS_control,
        group = Case_VS_control
      )
    ) +
      geom_point() +
      geom_jitter() +
      labs(title = "Strep resistance VS Improvement status",
           x = "Numeric Rating of Chest X-ray at month 6",
           y = "Resistance to Streptomycin at 6m") +
      theme(plot.title = element_text(
        hjust = 0.5,
        size = 15,
        face = "bold"
      ))
    
    ggplotly(p1)
  })
  
  # second plot - bar plot
  output$plot2 <- renderPlotly({
    strep_plot2 <- strep_tb %>%
      # filter by the column improved
      filter(improved == input$improved) %>%
      mutate(Case_VS_control = ifelse(arm %in% c("Streptomycin"), "Streptomycin", "Placebo")) %>%
      select(-dose_PAS_g)
    
    # create the bar plot
    p2 <- ggplot(data = strep_plot2,
                 aes(x = rad_num,
                     fill = Case_VS_control)) +
      geom_bar() +
      labs(title = "Case VS Placebo for Improvement Status",
           x = "Numeric Rating of Chest X-ray at month 6",
           y = "Count") +
      # rename the legend
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
      # rename the column baseline_cavitation
      mutate(Baseline_Cavitation = ifelse(baseline_cavitation %in% c("yes"), "Yes", "No"))
    
    # create the scatter plot
    p3 <- ggplot(data = strep_plot3,
                 aes(
                   x = rad_num,
                   y = input$baseline,
                   col = Gender
                 )) +
      geom_point() +
      geom_jitter() +
      labs(x = "Numeric Rating of Chest X-ray at month 6",
           y = "Baseline Variables",
           title = "Does gender alter study result?") +
      theme(plot.title = element_text(
        hjust = 0.5,
        size = 15,
        face = "bold"
      ))
    
    ggplotly(p3)
  })
})