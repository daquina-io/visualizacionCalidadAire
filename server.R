library(shiny)
library(dplyr)
library(leaflet)

shinyServer(function(input, output, session) {
  output$apariciones_mapa <- renderLeaflet({

######## aire #######
x <- read.csv('./data/points.csv', sep=',',header=TRUE, stringsAsFactors=FALSE)
coorPm <-cbind(as.numeric(x[[1]]),as.numeric(x[[2]]),as.numeric(x[[10]]))
addressPoints <- data.frame( coorPm  )
colnames( addressPoints ) <- c( "lat", "lng", "value" )
## detecta coordenadas repetidas y calcula el valor promedio para cada coordenada única
meansAddressPoints <- addressPoints %>% group_by(lat,lng) %>% summarise(value=mean(value))
## TODO:filtrar en un rango

maximo <- max(addressPoints$value)
minimo <- min(addressPoints$value)

## ## experimentar con el gradiente 
## color = colorNumeric("RdYlBu", 0:1)
## gradient <- as.list(color(0:20 / 20))
## names(gradient) <- as.character(0:20 / 20)
print(meansAddressPoints)
leaflet( meansAddressPoints[-dim(meansAddressPoints)[1], ] ) %>%
  addTiles() %>%
  setView(  -74.58, 6.2454, 10 ) %>%
  addHeatmap(
    lat = ~lat,
    lng = ~lng,
    intensity = ~value/maximo,
    radius = 18,
    blur = 15,
    maxZoom = 20
    ##gradient = gradient
  )

leaflet()

  })
})
