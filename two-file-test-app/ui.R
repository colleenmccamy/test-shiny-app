# creating a ui object and assigning a fluidPage option
ui <- navbarPage(
  title = "LTER Animal Data Explorer",
  # page 1: Intro tabPanel ----
  tabPanel(title = "About this App",
           "background info here"
  ), # END page 1 tabPanel
  # page 2: data tabPanel
  tabPanel(title = "Explore the Data",
           #tabsetPanel ----
           tabsetPanel(
             tabPanel(title = "Trout",
                      fluidRow(
                        column(4, 
                               # channel type pickerInpput
                               pickerInput(inputId = "channel_type_input",
                                           label = "Select channel type(s):",
                                           choices = unique(clean_trout$channel_type),
                                           width = "75%",
                                           options = pickerOptions(actionsBox = TRUE), 
                                           selected = c("C", "S"),
                                           multiple = TRUE
                               ),
                               # checkbox group button
                               checkboxGroupButtons(inputId = "section_input",
                                                    label = "Select a Sampling Section(s):",
                                                    choices = unique(clean_trout$section),
                                                    selected = c("clear cut forest"),
                                                    individual = TRUE,
                                                    size = 'sm',
                                                    checkIcon = list(yes = icon("ok",
                                                                                lib = "glyphicon"),
                                                                     no = icon("remove",
                                                                               lib = 'glyphicon'))
                               ) #END of checkboxGroupInput
                               ), #END of Column
                        column(8,
                               plotOutput(outputId = "trout_scatterplot") |> 
                                 withSpinner(type = 1,
                                             color = "grey")
                               )),# END fluidRow 1
                      tags$img(src = "rainbow_trout.png")
                      ), # END tabPanel Trout
             tabPanel(title = "Penguins",
                      sidebarLayout(
                        sidebarPanel( 
                          "penguins widgets here"), # END penguin SideBar
                        mainPanel = (
                          "penguin output here"
                        )
                      ),# END side bar panel
                      # START New ROW
                      fluidRow(
                        column(8, 
                               "what does this look like"),
                        column(4, 
                               "penguin image placeholder")
                      ) # END test row
             )# END penguin tab
             
           ) # END 
  ), # END tabPanel
  
  theme = shinytheme("superhero")) # END Nav Bar Page
