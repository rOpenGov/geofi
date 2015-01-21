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

#' @title An abstract class for referencing a WFS or a GML document
#' @description This class should be inherited and the abstract method \code{getDataSource} overloaded
#' in a subclass to provide a reference.
#' @seealso \code{\link{WFSClient}}, \code{\link{GMLFile}}
#' @usage NULL
#' @format NULL
#' @import R6
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSRequest
#' @export WFSRequest
WFSRequest <- R6::R6Class(
  "WFSRequest",
  public = list(
    getDataSource = function() {
      stop("getDataSource() must be implemented by the subclass.", call.=FALSE)
    },
    
    print = function(...) {
      cat(self$getDataSource(), "\n")
      return(invisible(self))
    }
  )
)

#' @title An abstract class for building a URL reference to a WFS
#' @import R6
#' @usage NULL
#' @format NULL
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSStreamingRequest
#' @export WFSStreamingRequest
WFSStreamingRequest <- R6::R6Class(
  "WFSStreamingRequest",
  inherit = WFSRequest,
  private = list(
    path = NULL,
    parameters = NULL,
    
    getPathString = function() {
      if (is.null(private$path) | length(private$path) == 0) return("")
      p <- paste(private$path, collapse="/")
      return(p)
    },
    
    getParametersString = function() {
      private$parameters[sapply(private$parameters, is.null)] <- NULL
      if (is.null(private$parameters) | length(private$parameters) == 0) return("")
      x <- lapply(seq_along(private$parameters),
                  function(i) paste(names(private$parameters)[[i]], private$parameters[[i]], sep="="))
      p <- paste(x, collapse="&")
      return(p)
    }
    
    #getStreamURL = function() {
    #  return(paste0("WFS:", self$getURL()))
    #},
    
  ),
  public = list(
    setPath = function(path) {
      private$path <- path
      return(invisible(self))
    },
    
    setParameters = function(...) {
      private$parameters <- list(...)
      return(invisible(self))
    },
    
    # Operations supported for WFS 1.0.0, see more info:
    # http://docs.geoserver.org/stable/en/user/services/wfs/reference.html
    
    getCapabilities = function(version="1.0.0", ...) {
      self$setParameters(service="WFS", version=version, request="GetCapabilities", ...)
      return(invisible(self))
    },
    
    getFeature = function(version="1.0.0", typeName, ...) {
      if (missing(typeName))
        stop("Argument 'typeName' missing.")
      self$setParameters(service="WFS", version=version, request="GetFeature", typeName=typeName, ...)
    }
  )
)

#' @title An abstract class for building a URL reference to a WFS with a caching
#' @description The abstract method \code{getURL} must be overloaded in a subclass to provide a request URL to a WFS service.
#' @usage NULL
#' @format NULL
#' @import R6
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSCachingRequest
#' @export WFSCachingRequest
WFSCachingRequest <- R6::R6Class(
  "WFSCachingRequest",
  inherit = WFSStreamingRequest,
  private = list(
    getURL = function() {
      stop("getURL() must be implemented by the subclass.", call.=FALSE)
    }
  ),
  public = list(
    getDataSource = function() {
      destFile <- tempfile()
      success <- download.file(private$getURL(), destFile, "internal")
      if (success != 0) {
        warning("Query failed.")
        return(character(0))
      }
      return(destFile)      
    },
    
    print = function(...) {
      cat(private$getURL(), "\n")
      return(invisible(self))
    }
  )
)

#' @title A class for providing a file name reference to a GML document
#' @usage NULL
#' @format NULL
#' @import R6
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass GMLFile
#' @export GMLFile
GMLFile <- R6::R6Class(
  "GMLFile",
  inherit = WFSRequest,
  private = list(
    srcFile = NULL        
  ),
  public = list(
    initialize = function(srcFile) {
      if (missing(srcFile))
        stop("Required argument 'srcFile' missing.")
      if (!file.exists(srcFile))
        stop(paste0("File '", srcFile, "' does not exist."))
      private$srcFile <- srcFile
    },
    
    getDataSource = function() {
      return(private$srcFile)
    }
  )
)

