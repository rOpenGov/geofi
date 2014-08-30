# This file is a part of the rwfs package (http://github.com/rOpenGov/rwfs)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2014 Jussi Jousimo
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#' @include WFSRequest.R

#' An abstract class to make requests to a WFS.
#'
#' @import methods
#' @import rgdal
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSClient
#' @export WFSClient
WFSClient <- setRefClass(
  "WFSClient",
  methods = list(
    .private.listLayers = function(dataSource) {
      if (missing(dataSource))
        stop("Required argument 'dataSource' missing.")
      if (!inherits(dataSource, "character"))
        stop("Argument 'dataSource' must be a descendant of class 'character'.")
      
      layers <- try(rgdal::ogrListLayers(dsn=dataSource))
      if (inherits(layers, "try-error")) {
        if (length(grep("Cannot open data source", layers)) == 1) {
          warning("Unable to connect to the data source or error in query result.")
          return(character(0))
        }
        else stop("Fatal error.")
      }
      
      return(layers)
    },
    
    .private.getLayer = function(dataSource, layer, crs=NULL) {
      if (missing(dataSource))
        stop("Required argument 'dataSource' missing.")
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      if (!inherits(dataSource, "character"))
        stop("Argument 'dataSource' must be a descendant of class 'character'.")
      
      response <- try(rgdal::readOGR(dsn=dataSource, layer=layer, p4s=crs, stringsAsFactors=FALSE))
      if (inherits(response, "try-error")) {
        if (length(grep("Cannot open data source", response)) == 1) {
          warning("Unable to connect to the data source or error in query result.")
          return(character(0))
        }
        else stop("Fatal error.")
      }
      
      return(response)
    },
    
    listLayers = function(request) {
      stop("Unimplemented method.")
    },
    
    getLayer = function(request, layer, crs=NULL, parameters) {
      stop("Unimplemented method.")
    },
    
    getRaster = function(request, crs, NAvalue) {
      stop("Unimplemented method.")
    }
  )
)

#' Streams response from a WFS.
#'
#' @import methods
#' @import rgdal
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSStreamClient
#' @export WFSStreamClient
WFSStreamClient <- setRefClass(
  "WFSStreamClient",
  contains = "WFSClient",
  methods = list(
    listLayers = function(request) {
      if (missing(request))
        stop("Required argument 'request' missing.")
      if (!inherits(request, "WFSRequest"))
        stop("Argument 'request' must be a descendant of class 'WFSRequest'.")
      
      dataSourceURL <- request$getStreamURL()
      layers <- .private.listLayers(dataSource=dataSourceURL)
      return(layers)
    },
    
    getLayer = function(request, layer, crs=NULL, swapAxisOrder=FALSE, parameters) {
      if (missing(request))
        stop("Required argument 'request' missing.")
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      if (!inherits(request, "WFSRequest"))
        stop("Argument 'request' must be a descendant of class 'WFSRequest'.")
      
      dataSourceURL <- request$getStreamURL()
      response <- .private.getLayer(dataSource=dataSourceURL, layer=layer, crs=crs)
      return(response)
    }
  )
)
