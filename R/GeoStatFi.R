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
#'
#' @title Builds a WFS request to the \code{stat.fi} geospatial API.
#' 
#' @description Builds a WFS request to the \code{stat.fi} geospatial API. The request is submitted with
#' \code{\link{GeoStatFiWFSClient}} to retrieve the data.
#' For more information about the API, see \url{http://www.stat.fi/tup/rajapintapalvelut/index_en.html}.
#' For General Terms of Use, see \url{http://www.stat.fi/org/lainsaadanto/yleiset_kayttoehdot_en.html/}. 
#'
#' @section Currently supported data sets:
#' \itemize{
#'   \item Population densities in various demographic groups
#'   \item Production and industrial facilities
#'   \item Educational institutions
#'   \item Road accidents
#' }
#'
#' @section Methods:
#' \itemize{
#'   \item\code{getPopulationLayers()}: A request for a list of available population grid data sets (layers).
#'   \item\code{getPopulation(layer)}: A request for population grid data \code{layer}.
#'   \item\code{getProductionAndIndustrialFacilities()}: A request for production and industrial facilities.
#'   \item\code{getEducationalInstitutions()}: A request for educational institutions.
#'   \item\code{getRoadAccidentsLayers()}: A request for a list of available road accident data sets as a character vector.
#'   \item\code{getRoadAccidents(layer)}: A request for road accident data \code{layer}.
#'   \item\code{getPostalCodeAreaLayers()}: A request for a list of available postal code area data sets as a character vector.
#'   \item\code{getPostalCodeArea(layer)}: A request for postal code area data \code{layer}.
#' }
#' 
#' @usage NULL
#' @format NULL
#' @import R6
#' @references See citation("gisfin")
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @examples
#' # See the vignette.
#' @seealso \code{\link{GeoStatFiWFSClient}} \code{\link{WFSStreamingRequest}}
#' @exportClass GeoStatFiWFSRequest
#' @export GeoStatFiWFSRequest
GeoStatFiWFSRequest <- R6::R6Class(
  "GeoStatFiWFSRequest",
  inherit = gisfin::WFSStreamingRequest,
  private = list(
    getURL = function() {
      url <- paste0("http://geo.stat.fi/geoserver/", private$getPathString(), "/wfs?", private$getParametersString())
      return(url)
    }
  ),
  public = list(
    getDataSource = function() private$getURL(),
    
    getGeoStatFiLayers = function(path) {
      if (missing(path))
        stop("Required argument 'path' missing.")      
      return(self$setPath(path)$getCapabilities())
    },

    getGeoStatFiLayer = function(path, layer) {
      if (missing(path))
        stop("Required argument 'path' missing.")      
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      return(self$setPath(path)$getFeature(typeName=layer))
    },
    
    getPopulationLayers = function() self$getGeoStatFiLayers("vaestoruutu"),
    getPopulation = function(layer) self$getGeoStatFiLayer("vaestoruutu", layer),
    getProductionAndIndustrialFacilitiesLayers = function() self$getGeoStatFiLayers("ttlaitokset/ttlaitokset:toimipaikat"),
    getProductionAndIndustrialFacilities = function(layer="ttlaitokset:toimipaikat") self$getGeoStatFiLayer("ttlaitokset/ttlaitokset:toimipaikat", layer),
    getEducationalInstitutionsLayers = function() self$getGeoStatFiLayers("oppilaitokset/oppilaitokset:oppilaitokset"),
    getEducationalInstitutions = function(layer="oppilaitokset:oppilaitokset") self$getGeoStatFiLayer("oppilaitokset/oppilaitokset:oppilaitokset", layer),
    getRoadAccidentsLayers = function() self$getGeoStatFiLayers("tieliikenne"),
    getRoadAccidents = function(layer) self$getGeoStatFiLayer("tieliikenne", layer),
    getPostalCodeAreaLayers = function() self$getGeoStatFiLayers("postialue"),
    getPostalCodeArea = function(layer) self$getGeoStatFiLayer("postialue", layer)
  )
)

#' @title Retrieves geospatial data from \code{stat.fi}.
#' 
#' @description Retrieves geospatial data from Statistics Finland (\url{http://www.stat.fi}). A request object
#' to retrieve data is constructed from the class \code{\link{GeoStatFiWFSRequest}}. Layer lists are
#' returned as \code{character} vectors and map data (layers) as \code{Spatial*} objects.
#' 
#' @usage NULL
#' @format NULL
#' @import R6
#' @return In case the service at \code{stat.fi} cannot be reached, the relevant methods return \code{character(0)}.
#' @references See citation("gisfin")
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @examples
#' # See the vignette.
#' @seealso \code{\link{GeoStatFiWFSRequest}} \code{\link{WFSStreamingClient}}
#' @exportClass GeoStatFiWFSClient
#' @export GeoStatFiWFSClient
GeoStatFiWFSClient <- R6::R6Class(
  "GeoStatFiWFSClient",
  inherit = gisfin::WFSStreamingClient,
  public = list(
  )
)
