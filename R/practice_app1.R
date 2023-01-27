# load packages ----
library(palmerpenguins)
library(tidyverse)
library(DT)

# filter data ----

body_mass_df <- penguins |> 
  filter(body_mass_g%in% 3000:4000)

# plot 

ggplot(data = na.omit(penguins), 
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
  theme_minimal()

# filtered years
penguins_input <- penguins |> 
  filter(year %in% c(2007, 2008))

# making a DT table
DT::datatable(penguins_input, style = bootstrapLib(theme = ))


