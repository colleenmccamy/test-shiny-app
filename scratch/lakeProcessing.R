library(tidyverse)
library(leaflet)
library(janitor)

# read in the data ------
lake_mon_data <- read_csv("/Users/colleenmccamy/Documents/MEDS/Workshops/test-shiny-app/raw-data/FCWO_lakemonitoringdata_2011_2022_daily.csv") |> 
  janitor::clean_names()

# calculate averages -----
avg_depth_temp <- lake_mon_data |> 
  select(site, depth, bed_temperature) |> 
  filter (depth != "NaN") |> 
  drop_na(bed_temperature) |>  # only drop it from the bed temperature column
  group_by(site) |> 
  summarize(avg_depth = round(mean(depth), 1),
            avg_temp = round(mean(bed_temperature), 1))

# full join to add lat and long ------
lake_mon_data <- full_join(lake_mon_data, avg_depth_temp)

# selecting just the columns
unique_lakes <- lake_mon_data |> 
  select(site, latitude, longitude, elevation, avg_depth, avg_temp) |> 
  distinct() # pulls out the distinct rows (SUPER COOL)

# creating a csv in a new folder (WOWZA)
write_csv(unique_lakes, "shiny-dashboard-test/data/lake_data_processed.csv")
# saving it as an RDS file for 
saveRDS(unique_lakes, "shiny-dashboard-test/data/lake_data_processed.rds")
