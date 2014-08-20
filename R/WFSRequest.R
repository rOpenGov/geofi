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

#' An abstract class to build WFS request URL's.
#'
#' @import methods
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSRequest
#' @export WFSRequest
WFSRequest <- setRefClass(
  "WFSRequest",
  fields = list(
    path = "list",
    parameters = "list"
  ),
  methods = list(
    setPath = function(path) {
      path <<- path
      return(invisible(.self))
    },
    
    setParameters = function(...) {
      parameters <<- list(...)
      return(invisible(.self))
    },
    
    getPathString = function() {
      if (length(path) == 0) return("")
      p <- paste(path, collapse="/")
      return(p)
    },
    
    getParametersString = function() {
      if (length(parameters) == 0) return("")
      x <- lapply(seq_along(parameters), function(i) paste(names(parameters)[[i]], parameters[[i]], sep="="))
      p <- paste(x, collapse="&")
      return(p)
    },
    
    getURL = function(operation) {
      stop("Unimplemented method.")
    },
    
    getStreamURL = function(operation) {
      return(paste0("WFS:", getURL()))
    }
  )
)
