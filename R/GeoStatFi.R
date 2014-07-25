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


#' Abstract reference class for grid statistics provided by Statistics Finland.
#' 
#' Abstract reference class for grid statistics provided by Statistics Finland. See the currently implemented
#' classes for the available data queries: \code{\link{Population1}}.
#' For more information, see http://www.stat.fi/tup/rajapintapalvelut/index_en.html.
#' For General Terms of Use, see http://www.stat.fi/org/lainsaadanto/yleiset_kayttoehdot_en.html/. 
#'
#' @import methods
#' @import raster
#' @import sp
#' @import rgdal
#' @references See citation("gisfin") 
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @seealso \code{\link{Population1}}
GeoStatFi <- setRefClass(
  Class = "GeoStatFi",
  fields = list(
    rasters = "RasterStack"
  ),
  methods = list(
    initialize = function() {
      rasters <<- raster::stack()
    },
        
    save = function(fileName) {
      "Save rasters to location \\code{fileName} for later access, so no need to download the data again."
      
      if (missing(fileName))
        stop("Missing required argument 'fileName'.")
      
      raster::writeRaster(rasters, filename=fileName, overwrite=TRUE)
      return(invisible(.self))
    },
    
    load = function(fileName) {
      "Load rasters into the object from \\code{fileName}."
      
      if (missing(fileName))
        stop("Missing required argument 'fileName'.")
      
      rasters <<- raster::stack(fileName)
      return(invisible(.self))
    },

    getRaster = function(field, year) {
      "Returns a raster layer object for \\code{field} in \\code{year}."
      
      if (missing(field))
        stop("Missing required argument 'field'.")
      if (missing(year))
        stop("Missing required argument 'year'.")
      
      index <- paste0(field, year)
      return(rasters[[index]])
    },
    
    getCRS = function() {
      "Returns the grid coordinate reference system as a CRS object."
      return(rasters@crs)
    },
    
    extract = function(xy, field, year) {
      "Extract values of field \\code{field} at coordinates \\code{xy} of type Spatial* in year \\code{year}. Does not check if coordinates are outside Finland. Returns a vector of the extracted values."
      
      if (missing(xy))
        stop("Missing required argument 'xy'.")
      if (missing(field))
        stop("Missing required argument 'field'.")
      if (missing(year))
        stop("Missing required argument 'year'.")

      rasterValues <- raster::extract(getRaster(field, year), xy)
      
      return(rasterValues)
    }
  )
)

#' Retrieves population density in Finland on a grid.
#' 
#' Reference class for retrieving population density in Finland on a 1 km x 1 km grid provided by Statistics Finland.
#' For inherited methods, see the base class \code{\link{GeoStatFi}} help.
#' For more information, see http://www.stat.fi/tup/rajapintapalvelut/index_en.html.
#' For General Terms of Use, see http://www.stat.fi/org/lainsaadanto/yleiset_kayttoehdot_en.html/.
#'
#' The data is currently available for the years 2005, 2010, 2011, 2012 and 2013 and contains the following fields:
#' \describe{
#'   \item{VAESTO}{Total population density (km^2).}
#'   \item{MIEHET}{Population density of males (km^2).}
#'   \item{NAISET}{Population density of females (km^2).}
#'   \item{IKA_0_14}{Population density of individuals aged <15 years.}
#'   \item{IKA_15_64}{Population density of individuals aged 15--64 years.}
#'   \item{IKA_65_}{Population density of individuals aged >64 years.}
#' }
#' Unoccupied grid cells are marked with value -1 as well as cells outside Finland. For the cells with <10 individuals,
#' only total population density (VAESTO) is provided.
#'
#' @import methods
#' @import raster
#' @import sp
#' @import rgdal
#' @references See citation("gisfin")
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @seealso \code{\link{GeoStatFi}}
#' @examples x <- Population1()
#' x$query(c(2012, 2013))
#' plot(x$getRaster("VAESTO", 2012))
#' plot(x$getRaster("VAESTO", 2013))
#' @exportClass Population1
#' @export Population1
Population1 <- setRefClass(
  Class = "Population1",
  contains = "GeoStatFi",
  methods = list(
    query = function(years, saveMetadata=FALSE) {
      "Retrieves population grid for the years specified in vector \\code{years}. To retain metadata for each grid cell, set \\code{saveMetadata=TRUE}."
      
      if (missing(years))
        stop("Missing required argument 'years'.")
      
      baseDir <- tempdir()
      
      for (year in years) {
        # Download shapefile to temp dir
        query <- paste0("http://www.stat.fi/tup/rajapintapalvelut/vaki", year, "_1km.zip")
        fileName <- file.path(baseDir, paste("statfi", year, sep=""))
        success <- download.file(query, fileName, "internal")
        if (success != 0)
          stop("Downloading population data for year ", year, " failed. Data does not exist for the year?")
        unzip(fileName, exdir=baseDir)
        
        x <- readOGR(baseDir, paste0("vaki", year, "_1km")) # Read shapefile as SpatialPointsDataFrame object
        if (!saveMetadata) { # Remove metadata if not needed to save space
          x$GRD_ID <- NULL
          x$ID_NRO <- NULL
          x$XKOORD <- NULL
          x$YKOORD <- NULL
          x$KUNTA <- NULL
        }
        names(x@data) <- paste0(names(x@data), year) # Add year to the field names to differentiate between years
        
        # Convert to RasterStack object
        y <- sp::SpatialPixelsDataFrame(coordinates(x), x@data, proj4string=x@proj4string)
        z <- raster::stack(y)
        rasters <<- raster::stack(rasters, z)
      }
      
      return(invisible(.self))
    }
  )
)
