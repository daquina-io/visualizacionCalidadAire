library(shiny)
library(leaflet)

## Define UI for dataset viewer application
ui <- function(request) {  leafletOutput("apariciones_mapa") }
