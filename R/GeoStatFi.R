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

#' @include WFSClient.R

#' Builds WFS request to the stat.fi geospatial API.
#'
#' @import methods
#' @references See citation("gisfin")
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @exportClass GeoStatFiWFSRequest
#' @export GeoStatFiWFSRequest
GeoStatFiWFSRequest <- setRefClass(
  "GeoStatFiWFSRequest",
  contains = "WFSRequest",
  methods = list(
    getURL = function() {
      if (getPathString() == "")
        stop("Required field 'path' has not been specified for the constructor.")
      url <- paste0("http://geo.stat.fi/geoserver/", getPathString(), "/wfs?", getParametersString())
      return(url)
    }
  )
)

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
#' @return In case the service at stat.fi cannot be reached, the relevant methods return \code{character(0)}.
#' @references See citation("gisfin")
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @examples 
#' # See the vignette.
#' @exportClass GeoStatFiWFSClient
#' @export GeoStatFiWFSClient
GeoStatFiWFSClient <- setRefClass(
  Class = "GeoStatFiWFSClient",
  contains = "WFSStreamClient",
  fields = list(
  ),
  methods = list(
    listPopulationLayers = function() {
      "Returns a list of available population grid data sets as a character vector."
      
      request <- GeoStatFiWFSRequest(path=list("vaestoruutu"))
      layers <- listLayers(request)
      return(layers)
    },
    
    getPopulation = function(layer) {
      "Retrieves population grid data \\code{layer} as a Spatial* object."
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      
      request <- GeoStatFiWFSRequest(path=list("vaestoruutu"))
      response <- getLayer(request, layer=layer)
      return(response)
    },
    
    listProductionAndIndustrialFacilitiesLayers = function() {
      request <- GeoStatFiWFSRequest(path=list("ttlaitokset/ttlaitokset:toimipaikat"))
      layers <- listLayers(request)
      return(layers)
    },
    
    getProductionAndIndustrialFacilities = function(layer="ttlaitokset:toimipaikat") {
      "Retrieves production and industrial facilities as a Spatial* object."
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      request <- GeoStatFiWFSRequest(path=list("ttlaitokset/ttlaitokset:toimipaikat"))
      response <- getLayer(request, layer=layer)
      return(response)
    },
    
    listEducationalInstitutionsLayers = function() {
      request <- GeoStatFiWFSRequest(path=list("oppilaitokset/oppilaitokset:oppilaitokset"))
      layers <- listLayers(request)
      return(layers)
    },
    
    getEducationalInstitutions = function(layer="oppilaitokset:oppilaitokset") {
      "Retrieves educational institutions as a Spatial* object."
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      request <- GeoStatFiWFSRequest(path=list("oppilaitokset/oppilaitokset:oppilaitokset"))
      response <- getLayer(request, layer=layer)
      return(response)
    },
    
    listRoadAccidentsLayers = function() {
      "Returns a list of available road accident data sets as a character vector."
      request <- GeoStatFiWFSRequest(path=list("tieliikenne"))
      layers <- listLayers(request)
      return(layers)
    },
    
    getRoadAccidents = function(layer) {
      "Retrieves road accident data \\code{layer} as a Spatial* object."
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      request <- GeoStatFiWFSRequest(path=list("tieliikenne"))
      response <- getLayer(request, layer=layer)
      return(response)
    }
  )
)
