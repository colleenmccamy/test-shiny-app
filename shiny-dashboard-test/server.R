# establishing a server function for shiny; input and output are lists so they are different than typical functions lists instead of variables are being used in this case

server <- function(input, output){
  
  # filter lakes data
  
  filtered_lakes <- reactive({
    lake_data |> 
      filter(elevation >= input$elevation_slider_input[1] & elevation <= input$elevation_slider_input[2]) # indexing to call the lower and upper bounds
  })
  
  
  
  # build leaflet map -----
  
  output$lake_map <- renderLeaflet( {
    leaflet() |>  # establishing the place to build the map
      
      # add provider tiles
      addProviderTiles("Esri.NatGeoWorldMap") |> 
      
      # set view of area of interest
      setView(lng = -152,
              lat = 70,
              zoom = 6) |> 
      
      # add mini map
      addMiniMap(toggleDisplay = TRUE, minimized = TRUE) |> 
      
      # adding markers with pop-up information
      addMarkers(data = filtered_lakes(),
                 lng = filtered_lakes()$longitude,
                 lat = filtered_lakes()$latitude,
                 popup = paste("<img src = ", "/Users/colleenmccamy/Documents/MEDS/Workshops/test-shiny-app/shiny-dashboard-test/www/arctic_lake.png", ">", "<br>",
            "Site Name:", filtered_lakes()$site, "<br>", # adding a break
            "Elevation:", filtered_lakes()$elevation, "meters (above SL)", "<br>",
            "Avg Depth", filtered_lakes()$avg_depth, "meters", "<br>",
            "Avg Lake Bed Temp:", filtered_lakes()$avg_temp, "deg Celsius"
                 ))
  })
  
}


# "<img src = ", "/Users/colleenmccamy/Documents/MEDS/Workshops/test-shiny-app/shiny-dashboard-test/www/arctic_lake.png", ">", "<br>",