# load package ----
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)
library(shinythemes)

# UI ----
ui <- fluidPage(
  
  # app title ----
  tags$h1("My app title"), # can also do h1("my app title")
  
  # app subtitle ----
  tags$p(tags$strong(tags$em("Exploring Antarctic Penguin Data"))), #paragraph, bold and italic 
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "body_mass_input", 
                  label = "Select a range of body masses (g):",
                  min = 2700,
                  max = 6300, 
                  value = c(3000, 4000))), # adding Id, label and values for two sliders
  
  # # body mass sliderInput ----
  # sliderInput(inputId = "body_mass_input", 
  #             label = "Select a range of body masses (g):",
  #             min = 2700,
  #             max = 6300, 
  #             value = c(3000, 4000)), # adding Id, label and values for two sliders

  mainPanel(
    plotOutput(outputId = "bodyMass_scatterPlot"),
    DT::dataTableOutput(outputId = "year_penguins_table"))),
  # body mass plot output ----
  # plotOutput(outputId = "bodyMass_scatterPlot"),

# data table input
checkboxGroupInput(inputId = "year_table_input",
                   label = "Select years to filter",
                   choices = c("The year 2007" = "2007", "2008", "2009"),
                   selected = c("2007", "2008")),  #unique(penguins$year) to make them responses choices in the check boxes
  # table year output ----
theme = shinytheme("superhero")) # END fluidPage


# SERVER ----
server <- function(input, output) {
  
  # filter data ----
  body_mass_df <- reactive({
    
    penguins |> 
      filter(body_mass_g %in% input$body_mass_input[1]:input$body_mass_input[2])
    
  }) # need to tell it that it is reactive 
  
  #render scatter plot ----
  output$bodyMass_scatterPlot <- renderPlot({
    
    # ggplot code for the visualization
    ggplot(data = na.omit(body_mass_df()), # NEED TO PUT OPEN/CLOSED () AFTER REACTIVE DATAFRAME
           aes(x = flipper_length_mm,
               y = bill_length_mm,
               col = species, shape = species)) +
      geom_point() + 
      scale_color_manual(values = c("Adelie" = "#fea346",
                                    "Chinstrap" = "#B251F1", 
                                    "Gentoo" = "#4BA4A4")) +
      scale_shape_manual(values = c("Adelie" = 19,
                                    "Chinstrap" = 17,
                                    "Gentoo" = 15)) +
      theme_minimal() +
      labs(x = "Bill Length (mm)", 
           y = "Flipper Length (mm)",
           title = "Flipper length & bill length of Antartic Data")
    
    
  }) # END render scatterplot
  
  penguins_input <- reactive({
    penguins |> 
      filter(year %in% input$year_table_input)
  })
  
  # rendering the table
  output$year_penguins_table <- DT::renderDataTable({
    
    DT::datatable(penguins_input(),
                  style = "bootstrap")
    
  }) #END render table
  
} # END server

# combine ui & server ---- 
shinyApp(ui = ui, 
         server = server)
