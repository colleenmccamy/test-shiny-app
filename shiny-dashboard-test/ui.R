# create dashboard header --------------------
header <- dashboardHeader(
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400) # END header

# create dashboard sidebar --------------------
sidebar <- dashboardSidebar(
  # side bar menu -----
  sidebarMenu(
    menuItem(
      text =  "Welcome",
      tabName = "welcome",
      icon = icon("star")
    ),
    menuItem(
      text = "Dashboard",
      tabName = "dashboard",
      icon = icon("droplet")
    ) 
  ) # END sidebar menu
) # END sidebar menu # END dashboardSidebar

# create dashboard body --------------------
body <- dashboardBody(tabItems(
  # welcome tab item -------
  tabItem(
    tabName = "welcome",
    column(width = 6,
           box(width = NULL,
               "background info here"), # END left box
    ), # END left column
    
    # start new column -----
    column(width = 6,
           fluidRow(box(
             width = NULL,
             "Data Citation here"
           ) # END box
           ), # END top Row
           fluidRow(box(width = NULL,
                        "disclaimer here"
                        ) # END fluid row bottom
                    ) # END fluid row) # END Column
           ), # END welcome tab 
    ), # END welcome tab item
  # dashboard tabItem ------
  tabItem(tabName = "dashboard",
          # fluidRow 1 -------
          fluidRow(
            # input box -----
            box(width = 4,
                title = tags$strong("Adjust lake parameters ranges:"
                ),
                # sliderInput
                sliderInput(inputId = "elevation_slider_input",
                            label = "Elevation (meters above SL):",
                            min = min(lake_data$elevation),
                            max = max(lake_data$elevation),
                            value = c(min(lake_data$elevation),
                            max(lake_data$elevation)))), # END input box
            # START Leaflet Box
            box (width = 8,
                 title = tags$strong("Monitored lakes within Fish Creek Watershed"),
                 # leaflet output
                 leafletOutput(outputId = "lake_map") |>
                   withSpinner(type = 1, color = "blue")) # END leaflet box
          ) # END fluid row
  ) # END dashbaord tabItem
) # END tabItem
) # END tab item 


# combining to create a dashboard page --------------------
dashboardPage(header, sidebar, body)

