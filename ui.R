library(shiny)
library(leaflet)

## Define UI for dataset viewer application
ui <- function(request) {fluidPage(
                           leafletOutput("apariciones_mapa")

                         )
}
