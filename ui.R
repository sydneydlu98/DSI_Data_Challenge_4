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
shinyUI(# Use a fluid Bootstrap layout
  fluidPage(
    # Give the page a title
    titlePanel("Streptomycin for TB Dataset Analysis"),
    
    # Generate a row with a sidebar
    sidebarLayout(
      # Define the sidebar with one input
      sidebarPanel(
        
        selectInput(
          inputId = "Case_VS_control",
          label = "Case or control:",
          choices = c("Case" = "Streptomycin",
                      "Control" = "Placebo")
        ),
        helpText("To see resistance to streptomycin plays an effect on treatment outcome"),
        helpText("Case = Streptomycin"),
        helpText("Control = Placebo"),
        helpText("For x-axis:"),
        helpText("1 = Death"),
        helpText("2-3 = Deterioration"),
        helpText("4 = No Change"),
        helpText("5-6 = Improvement"),

        
        selectInput(
          inputId = "improved",
          label = "Patients whose condition improved or not:",
          choices = c("Improved" = "TRUE",
                      "Not improved" = "FALSE")
        ),
        
        helpText("To see if streptomycin is affective to treat tuberculosis"),
        helpText("For x-axis:"),
        helpText("1 = Death"),
        helpText("2 = Considerable Deterioration"),
        helpText("3 = Moderate Deterioration"),
        helpText("4 = No Change"),
        helpText("5 = Moderate Improvement"),
        helpText("6 = Considerable Improvement"),
        
        selectInput(
          inputId = "baseline",
          label = "Baseline Variables:",
          list(
            "Baseline Condition" = list("1_Good", "2_Fair", "3_Poor"),
            "Baseline Temperature" = list("1_98-98.9F", "2_99-99.9F", "3_100-100.9F", "4_100F+"),
            "Baseline Sedimentation Rate" = list("1_1-10", "2_11-20", "3_21-50", "4_51+"),
            "Baseline Cavitation" = list("Yes", "No")
          )
        ),
        helpText("To see if gender plays an effect on this placebo-controlled clinical trial"),
        helpText("For y-axis:"),
        helpText("Baseline Condition = Condition of the Patient at Baseline"),
        helpText("Baseline Temperature = Oral Temperature at Baseline (Degrees F)"),
        helpText("Baseline Sedimentation Rate = Erythrocyte Sedimentation Rate at baseline (millimeters per hour)"),
        helpText("Baseline Cavitation = Cavitation of the Lungs on chest X-ray at baseline")

      ),
      
      
      # Create a spot for the bar plot
      mainPanel(plotlyOutput("plot1"),
                plotlyOutput("plot2"),
                plotlyOutput("plot3"))
    )
  )
)