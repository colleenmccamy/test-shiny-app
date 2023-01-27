# load libraries -----

library(tidyverse)
library(lterdatasampler)


#filtering and cleaning the data

clean_trout <- and_vertebrates |> 
  filter(species == "Cutthroat trout") |> 
  select(sampledate, 
         section, 
         species, 
         length_mm = length_1_mm, 
         weight_g,
         channel_type = unittype) |> 
  mutate(section = case_when(
    section == "CC" ~ "clear cut forest",
    section == "OG" ~ "old growth forest"
  )) |> 
  drop_na()
  

# practice filtering
trout_filtered_df <- clean_trout |> 
  filter(channel_type %in% c("R", "C")) |> 
  filter(section %in% c("clear cut forest"))

# updating the number of bins

ggplot(data = penguins, aes(x = flipper_length_mm)) +
  geom_histogram(bins = 10)


ggplot(na.omit(trout_filtered_df), aes(x = length_mm,
                        y = weight_g,
                        color = channel_type)) +
  geom_point(alpha = 0.5, size = 5) +
  theme_minimal() +
  scale_color_manual(values = c("R" = "#8ecae6",
                       "C" = "#99ca3c",
                       "S" = "#126782",
                       "P" = "#023047",
                       "SC" = "#ffb703",
                       "I" = "#fd9e02",
                       "IP" = "#fb8500"
                       )) +
  labs(x = "Weight (g)",
       y = "Length (mm)",
       title = "Trout Length & Weight")



