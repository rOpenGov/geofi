# This file is a part of the gisfin package (http://github.com/rOpenGov/gisfin)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2014 Jussi Jousimo / Louhos <louhos.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#' Retrieves geospatial data from stat.fi.
#' 
#' Retrieves geospatial data from Statistics Finland (http://www.stat.fi).
#' For more information, see http://www.stat.fi/tup/rajapintapalvelut/index_en.html.
#' For General Terms of Use, see http://www.stat.fi/org/lainsaadanto/yleiset_kayttoehdot_en.html/. 
#'
#' Currently available data sets include:
#' \itemize{
#'   \item Population densities in various demographic groups
#'   \item Production and industrial facilities
#'   \item Educational institutions
#'   \item Road accidents
#' }
#' 
#' @import methods
#' @import rgdal
#' @import sp
#' @import raster
#' @references See citation("gisfin")
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @examples 
#' # See the vignette.
#' @exportClass GeoStatFi
#' @export GeoStatFi
GeoStatFi <- setRefClass(
  Class = "GeoStatFi",
  fields = list(
    verbose = "logical"  
  ),
  methods = list(
    initialize = function(verbose=TRUE, ...) {
      callSuper(...)
      verbose <<- verbose
    },
    
    listLayers = function(feature) {
      if (missing(feature))
        stop("Required argument 'feature' missing.")
      url <- paste("WFS:http://geo.stat.fi/geoserver", feature, "wfs", sep="/")
      if (verbose)
        message(paste("Retrieving data set listing from", url))
      layers <- rgdal::ogrListLayers(url)
      return(layers)
    },
    
    getLayer = function(feature, layer) {
      if (missing(feature) | missing(layer))
        stop("Required arguments 'feature' and/or 'layer' missing.")
      url <- paste("WFS:http://geo.stat.fi/geoserver", feature, "wfs", sep="/")
      if (verbose)
        message(paste("Retrieving data set from", url))
      layer <- rgdal::readOGR(dsn=url, layer=layer, verbose=verbose)
      return(layer)
    },
    
    getRaster = function(layer, template=raster(extent(85000, 726000, 6629000, 7777000), nrows=1148, ncols=641, crs=CRS("+proj=utm +zone=35 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")), fun="count") {
      "Converts SpatialPolygonsDataFrame object 'layer' to Raster* object or rasterizes SpatialPointsDataFrame onto 'template' raster with 'fun' function."
      
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      
      raster <- if (inherits(layer, "SpatialPolygonsDataFrame")) {
        pixels <- sp::SpatialPixelsDataFrame(coordinates(layer), layer@data, proj4string=layer@proj4string)
        raster::stack(pixels)               
      }
      else if (inherits(layer, "SpatialPointsDataFrame")) {
        if (missing(template) | missing(fun))
          stop("Required arguments 'template' and/or 'fun' missing.")
        raster::rasterize(layer, template, fun=fun)
      }
      else stop("Unsupported layer type.")
      
      return(raster)
    },
    
    listPopulationLayers = function() {
      "List population grid data sets."
      return(listLayers(feature="vaestoruutu"))
    },
    
    getPopulation = function(layer) {
      "Get population grid data set 'layer'."
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      return(getLayer(feature="vaestoruutu", layer=layer))
    },
    
    listProductionAndIndustrialFacilitiesLayers = function() {
      return(listLayers(feature="ttlaitokset/ttlaitokset:toimipaikat"))
    },
    
    getProductionAndIndustrialFacilities = function(layer="ttlaitokset:toimipaikat") {
      "Get production and industrial facilities."
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      return(getLayer(feature="ttlaitokset/ttlaitokset:toimipaikat", layer=layer))
    },
    
    listEducationalInstitutionsLayers = function() {
      return(listLayers(feature="oppilaitokset/oppilaitokset:oppilaitokset"))
    },
    
    getEducationalInstitutions = function(layer="oppilaitokset:oppilaitokset") {
      "Get educational institutions."
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      return(getLayer(feature="oppilaitokset/oppilaitokset:oppilaitokset", layer=layer))      
    },
    
    listRoadAccidentsLayers = function() {
      "List road accident data sets."
      return(listLayers(feature="tieliikenne"))
    },
    
    getRoadAccidents = function(layer) {
      "Get road accident data set 'layer'."
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      return(getLayer(feature="tieliikenne", layer=layer))      
    }
  )
)
