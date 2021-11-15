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
    
    # Description of the dataset
    h4(strong("1) Streptomycin for TB Dataset Description")), 
    p(strong("Abstract:"),
      "This data set contains reconstructed records of 107 participants with",
      "pulmonary tuberculosis. In 1948, collapse therapy (collapsing the lung",
      "by puncturing it with a needle) and bedrest in sanitariums were the standard",
      "of care. The Streptomycin for Tuberculosis trial in 1948 is considered the first",
      "modern randomized, placebo-controlled clinical trial, which could be done in part",
      "because there were very limited supplies of streptomycin in the UK after World War II.",
      "While patients on streptomycin often improved rapidly, streptomycin resistance",
      "developed, and many participants relapsed. There was still a significant difference",
      "in the death rate between the two arms. A similar effect was seen with PAS,",
      "another new therapy for tuberculosis, and the authors rapidly figured out that",
      "combination therapy was needed, which was tested in two subsequent trials, which",
      "were published in 1952."),
    p(strong("Study Design:"),
      "Prospective, Randomized, Multicenter Placebo-Controlled Clinical Trial"),
    p(strong("Background:"),
      "This data set is reconstructed from a study published on October 30, ",
      "1948 in the British Medical Journal, reported by the Tuberculosis Trials ",
      "Committee of the MRC. Presented are the results of a randomized, ",
      "placebo-controlled, prospective 2-arm trial of streptomycin 2 grams ",
      "daily (Streptomycin) vs. placebo (Control) to treat tuberculosis in 107 ",
      "young patients."),
    p(strong("Aim:"), 
      "The randomized trial was helpful to prevent rationing and black market ",
      "selling of streptomycin, and helped with allocation of limited hospital",
      "isolation beds for bedrest therapy (the control arm, and standard of care",
      "at the time)."),
    p(strong("Limitation:"),
      "This publication seems a bit primitive today, without standard features like a",
      "proper Table 1, and some creative use of graphs to display baseline characteristics",
      "of the study sample. The authors were publishing the first formal RCT, and had no",
      "modern CONSORT standards to go by. Their Table 1 is essentially three 2xN tables",
      "pasted together horizontally. There is also no ethics committee approval, nor any consent,", 
      "which is consistent with practices in 1948."),

    p(strong("Codebook:")),
    p(code("patient_id"), "Participant ID"),
    p(code("arm"), "Study Arm"),
    p(code("dose_strep_g"), "Dose of Streptomycin in Grams [grams]"),
    p(code("gender"), "Gender (M = Male, F = Female)"),
    p(code("baseline_condition"), "Condition of the Patient at Baseline (1_Good, 2_Fair, 3_Poor)"),
    p(code("baseline_temp"), "Oral Temperature at Baseline (1_98-98.9F, 2_99-99.9F, 3_100-100.9F, 4_100F+ [Degrees F])"),
    p(code("baseline_esr"), "Erythrocyte Sedimentation Rate at baseline (1_1-10, 2_11-20, 3_21-50, 4_51+ [millimeters per hour])"),
    p(code("baseline_cavitation"), "Cavitation of the Lungs on chest X-ray at baseline (Yes, No)"),
    p(code("strep_resistance"), "Resistance to Streptomycin at 6m (1_sens_0-8, 2_mod_8-99, 3_resist_100+)"),
    p(code("radiologic_6m"), "Radiologic outcome at 6m (1_Death, 2_Considerable Deterioration, 3_Moderate_deterioration, 4_No_change, 5_Moderate_improvement, 6_Considerable_improvement

)"),
    p(code("radnum"), "Numeric Rating of Chest X-ray at month 6 (1-6)"),
    p(code("improved"), "Dichotomous Outcome of Improved (TRUE, FALSE)"),
    
    # Description of how my app works in the Shiny app
    h4(strong("2) 3 plots for this Shiny app")), 
    p(strong("Plot 1 Scatter Plot: To see if resistance to streptomycin plays an effect on treatment outcome.")),
    p("Scatter plot is filtered by case and placebo group for study outcome.",
      "Select any of the case or placebo group will show study participant's", 
      "resistance to streptomycin status and its improvement status accordingly."),
    p(strong("Plot 2 Bar plot:"),
      "To see if streptomycin is effective to treat tuberculosis."),
    p(strong("Plot 3 Scatter Plot: to see if gender plays an effect on study outcome.")),
    p("Scatter plot is filtered by 4 baseline variables on the y-axis. They are:", 
       code("baseline_condition"), 
       code("baseline_temp"),
       code("baseline_esr"),
       code("baseline_cavitation"), ".",
      "Select any of the baseline variables will show the difference between male and female participants' change in health status between the time they first entered the study and by the time study finished to see if gender plays an effect on study outcome."),
    
    # Generate a row with a sidebar
    sidebarLayout(
      # Define the sidebar with one input
      sidebarPanel(
        
        radioButtons(
          inputId = "Case_VS_control",
          label = "Case or placebo:",
          choices = c("Case (Streptomycin)" = "Streptomycin",
                      "Placebo" = "Placebo")
        ),
        
        helpText(strong("To see if resistance to streptomycin plays an effect on treatment outcome.")),
        helpText("Scatter plot is filtered by case and placebo group for study outcome. Select any of the case or placebo group will show study participant's resistance to streptomycin status and its improvement status accordingly."),
        helpText(em("For x-axis: 1=Death, 2=Considerable Deterioration, 3=Moderate deterioration, 4=No change, 5=Moderate improvement, 6=Considerable improvement")),
        
        radioButtons(
          inputId = "improved",
          label = "Patients whose condition improved or not:",
          choices = c("Improved" = "TRUE",
                      "Not improved" = "FALSE")
        ),
        
        helpText(strong("To see if streptomycin is effective to treat tuberculosis.")),
        
        selectInput(
          inputId = "baseline",
          label = "Baseline Variables:",
          list(
            "Baseline Condition" = list("1_Good", "2_Fair", "3_Poor"),
            "Baseline Temperature" = list("1_98-98.9F", "2_99-99.9F", "3_100-100.9F", "4_100F+"),
            "Baseline Sedimentation Rate" = list("1_1-10", "2_11-20", "3_21-50", "4_51+"),
            "Baseline Cavitation" = list("Yes", "No"))
        ),
        
        helpText(strong("To see if gender plays an effect on study outcome.")),
        helpText("Scatter plot is filtered by 4 baseline variables on the y-axis. They are:", 
                 code("baseline_condition"), 
                 code("baseline_temp"),
                 code("baseline_esr"),
                 code("baseline_cavitation"), ".",
                 "Select any of the baseline variables will show the difference between male and female participants' change in health status between the time they first entered the study and by the time study finished to see if gender plays an effect on study outcome.")
      ),
      
      # Create a spot for the bar plot
      mainPanel(plotlyOutput("plot1"),
                plotlyOutput("plot2"),
                plotlyOutput("plot3"))
    )
  )
)