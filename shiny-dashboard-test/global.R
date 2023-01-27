# LOAD Packages -----
library(shiny)
library(shinydashboard) #need both for building shiny dashboards
library(shinythemes)
library(tidyverse)
library(leaflet)
library(shinycssloaders)


# Read in the data -----

lake_data <- read_csv("data/lake_data_processed.csv") # file path is relative to your folder of your app

