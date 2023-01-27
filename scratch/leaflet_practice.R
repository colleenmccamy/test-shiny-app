library(tidyverse)

# reading in the data
filtered_lakes <- read_csv("shiny-dashboard-test/data/lake_data_processed.csv")

# practice filtering
lakes_new <- filtered_lakes |> 
  filter(avg_temp >= 4 & avg_temp <= 6)

# building leaflet map -------
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
  addMarkers(data = filtered_lakes,
             lng = filtered_lakes$longitude,
             lat = filtered_lakes$latitude,
             popup = paste("<img src = ", "/Users/colleenmccamy/Documents/MEDS/Workshops/test-shiny-app/shiny-dashboard-test/www/arctic_lake.png", ">", "<br>",
               "Site Name:", filtered_lakes$site, "<br>", # adding a break
               "Elevation:", filtered_lakes$elevation, "meters (above SL)", "<br>",
               "Avg Depth", filtered_lakes$avg_depth, "meters", "<br>",
               "Avg Lake Bed Temp:", filtered_lakes$avg_temp, "deg Celsius", 
               "<br>"
             ))
  
  
  
  
  
  
  