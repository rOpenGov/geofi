request <- gisfin::GeoStatFiWFSRequest$new()$getPopulationLayers()
client <- gisfin::GeoStatFiWFSClient$new(request)
layers <- client$listLayers()
layers

request$getPopulation(layers[11])
client <- gisfin::GeoStatFiWFSClient$new(request)
population <- client$getLayer(layers[11])
if (length(population) > 0) {
  x <- sp::SpatialPixelsDataFrame(coordinates(population), population@data, proj4string=population@proj4string)
  population <- raster::stack(x)
  plot(log(population[["vaesto"]]))
}



request <- gisfin::GeoStatFiWFSRequest$new()$getProductionAndIndustrialFacilitiesLayers()
client <- gisfin::GeoStatFiWFSClient$new(request)
layers <- client$listLayers(); layers
request <- gisfin::GeoStatFiWFSRequest$new()$getProductionAndIndustrialFacilities(layers[1])
client <- gisfin::GeoStatFiWFSClient$new(request)
layer <- client$getLayer(layers[1]); layer


request <- gisfin::GeoStatFiWFSRequest$new()$getEducationalInstitutionsLayers()
client <- gisfin::GeoStatFiWFSClient$new(request)
layers <- client$listLayers(); layers
request <- gisfin::GeoStatFiWFSRequest$new()$getEducationalInstitutions(layers[1])
client <- gisfin::GeoStatFiWFSClient$new(request)
layer <- client$getLayer(layers[1]); layer


request <- gisfin::GeoStatFiWFSRequest$new()$getRoadAccidentsLayers()
client <- gisfin::GeoStatFiWFSClient$new(request)
layers <- client$listLayers(); layers
request <- gisfin::GeoStatFiWFSRequest$new()$getRoadAccidents(layers[1])
client <- gisfin::GeoStatFiWFSClient$new(request)
layer <- client$getLayer(layers[1]); layer

