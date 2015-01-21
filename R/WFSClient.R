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

#' @title WFS client abstract class
#' @seealso \code{\link{WFSStreamingClient}}, \code{\link{WFSCachingClient}}, \code{\link{WFSRequest}}
#' @usage NULL
#' @format NULL
#' @import R6
#' @import sp
#' @import rgdal
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSClient
#' @export WFSClient
WFSClient <- R6::R6Class(
  "WFSClient",
  private = list(
    request = NULL,
    
    .listLayers = function(dataSource) {
      if (missing(dataSource))
        stop("Required argument 'dataSource' missing.")
      if (!inherits(dataSource, "character"))
        stop("Argument 'dataSource' must be a descendant of class 'character'.")
      
      layers <- try(rgdal::ogrListLayers(dsn=dataSource)) 
      if (inherits(layers, "try-error")) {
        if (length(grep("Cannot open data source", layers)) == 1) {
          # GDAL < 1.11.0 returns "Cannot open data source" for connection problems and zero layer responses
          # GDAL >= 1.11.0 returns no layers for zero layer responses
          warning("Unable to connect to the data source or error in query result.")
          return(character(0))
        }
        else stop("Fatal error.")
      }
      
      return(layers)
    },
    
    .getLayer = function(dataSource, layer, crs=NULL, swapAxisOrder=FALSE) {
      if (missing(dataSource))
        stop("Required argument 'dataSource' missing.")
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      if (!inherits(dataSource, "character"))
        stop("Argument 'dataSource' must be a descendant of class 'character'.")
      
      #response <- try(rgdal::readOGR(dsn=dataSource, layer=layer, p4s=crs, swapAxisOrder=swapAxisOrder, stringsAsFactors=FALSE)) # Works only in rgdal >= 0.9
      response <- try(rgdal::readOGR(dsn=dataSource, layer=layer, p4s=crs, stringsAsFactors=FALSE))
      if (inherits(response, "try-error")) {
        if (length(grep("Cannot open data source", response)) == 1) {
          warning("Unable to connect to the data source or error in query result.")
          return(character(0))
        }
        else stop("Fatal error.")
      }
      
      # Hack and will be removed once rgdal 0.9 becomes available in CRAN
      if (swapAxisOrder) {
        xy <- sp::coordinates(response)
        response@coords <- xy[,2:1]
        response@bbox <- response@bbox[2:1,]
        rownames(response@bbox) <- rownames(response@bbox)[2:1]
      }
      
      return(response)
    },
    
    getRasterURL = function(parameters) {
      stop("Unimplemented method.", call.=FALSE)
    },
    
    importRaster = function(destFile) {
      raster <- raster::brick(destFile)
      return(raster)
    }
  ),
  public = list(
    initialize = function(request) {
      self$setRequest(request=request)
      return(invisible(self))
    },
    
    setRequest = function(request) {
      if (missing(request))
        stop("Required argument 'request' missing.")
      if (!inherits(request, "WFSRequest"))
        stop("Argument 'request' must be a descedant of class 'WFSRequest'")
      private$request <- request
      return(invisible(self))
    },
    
    listLayers = function() {
      stop("Unimplemented method.", call.=FALSE)
    },
    
    getLayer = function(layer, crs=NULL, swapAxisOrder=FALSE, parameters) {
      stop("Unimplemented method.")
    },
    
    getRaster = function(parameters) {
      rasterURL <- private$getRasterURL(parameters=parameters)
      if (length(rasterURL) == 0) return(character())
      
      destFile <- tempfile()
      success <- download.file(rasterURL, destfile=destFile)
      if (success != 0) {
        warning("Failed to download raster file.")
        return(character())
      }
      
      raster <- private$importRaster(destFile)
      return(raster)
    }
  )
)

#' @title Streams response from a WFS
#' @description Dispatches a WFS request and parses response from the stream directly.
#' @seealso \code{\link{WFSRequest}}, \code{\link{WFSCachingClient}}
#' @usage NULL
#' @format NULL
#' @import R6
#' @import rgdal
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSStreamingClient
#' @export WFSStreamingClient
WFSStreamingClient <- R6::R6Class(
  "WFSStreamClient",
  inherit = WFSClient,
  public = list(
    listLayers = function() {
      layers <- private$.listLayers(dataSource=private$request$getDataSource())
      return(layers)
    },
    
    getLayer = function(layer, crs=NULL, swapAxisOrder=FALSE, parameters) {
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      
      response <- private$.getLayer(dataSource=private$request$getDataSource(), layer=layer, crs=crs, swapAxisOrder=swapAxisOrder)
      return(response)
    }
  )
)

#' @title Downloads response from a WFS and parses the intermediate file
#' @description Dispatches a WFS request, saves the response to a file and parses the file. The data can be converted
#' using ogr2ogr of RGDAL. Provides a caching mechanism for subsequent queries on the same data.
#' @seealso \code{\link{WFSRequest}}, \code{\link{WFSStreamingClient}}
#' @usage NULL
#' @format NULL
#' @import R6
#' @import rgdal
#' @import digest
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSCachingClient
#' @export WFSCachingClient
WFSCachingClient <- R6::R6Class(
  "WFSCachingClient",
  inherit = WFSClient,
  private = list(
    cachedResponseFile = NULL,
    requestHash = NULL, # Save the hash of the request object to detect changed request
    
    cacheResponse = function() {
      if (is.null(private$cachedResponseFile) || private$requestHash != digest(private$request)) {
        destFile <- private$request$getDataSource()
        if (length(destFile) == 0) return(character(0))      
        private$cachedResponseFile <- destFile
        private$requestHash <- digest(private$request)
      }
      return(invisible(self))
    }
  ),
  public = list(
    saveGMLFile = function(destFile) {
      "Saves cached response to a file in GML format."
      if (missing(destFile))
        stop("Required argument 'destFile' missing.")
      if (private$cachedResponseFile == "" || !file.exists(private$cachedResponseFile))
        stop("Response file missing. No query has been made?")
      file.copy(private$cachedResponseFile, destFile)
      return(invisible(self))
    },
    
    loadGMLFile = function(fromFile) {
      "Loads saved GML file into the object for parsing."
      if (missing(fromFile))
        stop("Required argument 'fromFile' missing.")
      if (!file.exists(fromFile))
        stop("File does not exist.")
      private$cachedResponseFile <<- fromFile
      return(invisible(self))
    },
    
    listLayers = function() {
      if (is.character(private$cacheResponse())) return(character(0))
      layers <- private$.listLayers(dataSource=private$cachedResponseFile)
      return(layers)
    },
    
    getLayer = function(layer, crs=NULL, swapAxisOrder=FALSE, parameters) {
      if (is.character(private$cacheResponse())) return(character(0))
      
      sourceFile <- private$cachedResponseFile
      if (!missing(parameters)) {
        ogr2ogrParams <- ""
        # -splitlistfields not needed for rgdal >= 0.9.1
        if (!is.null(parameters$splitListFields) && parameters$splitListFields)
          ogr2ogrParams <- paste(ogr2ogrParams, "-splitlistfields")
        if (!is.null(parameters$explodeCollections) && parameters$explodeCollections)
          ogr2ogrParams <- paste(ogr2ogrParams, "-explodecollections")
        if (ogr2ogrParams != "")
          sourceFile <- convertOGR(sourceFile=private$cachedResponseFile, layer=layer, parameters=ogr2ogrParams)
      }
      
      response <- private$.getLayer(dataSource=sourceFile, layer=layer, crs=crs, swapAxisOrder=swapAxisOrder)
      return(response)
    }
  )
)

