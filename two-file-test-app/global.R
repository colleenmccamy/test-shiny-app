# load packages ----
library(shiny)
library(lterdatasampler)
library(tidyverse)
library(shinyWidgets)
library(shinycssloaders)

#source("file/path/to fi")

# data wrangling -----

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


