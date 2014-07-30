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

FMI <- setRefClass(
  Class = "FMI",
  fields = list(
  ),
  methods = list(
    POSIXt2QueryDate = function(dt) {
      return(strftime(dt, "%Y-%d-%mT%H:%M:%SZ"))
    },
    
    getFeature = function(storedQueryId, parameters, apiKey) {
      if (missing(storedQueryId))
        stop("Required argument 'storedQueryId' missing.")
      if (missing(parameters))
        stop("Required argument 'parameters' missing.")
      if (missing(apiKey))
        stop("Required argument 'apiKey' missing.")
      
      x <- lapply(seq_along(parameters), function(i) paste(names(parameters)[[i]], parameters[[i]], sep="="))
      queryParameters <- paste(x, collapse="&")
      query <- paste0("http://data.fmi.fi/fmi-apikey/", apiKey, "/wfs?request=getFeature&storedquery_id=", storedQueryId, "&", queryParameters)
      fileName <- tempfile()
      # TODO: Handle XML response on error.
      success <- download.file(query, fileName, "internal")
      if (success != 0)
        stop("Query failed.")
      
      return(fileName)
    },
    
    # Thin-plate spline interpolation
    interpolateTPS = function(xyz, templateRaster, zeroPositive=FALSE) {
      library(fields)
      z <- if (zeroPositive) xyz[,3]^2 else xyz[,3] # Square transformation ensures no negative values
      fit <- fields::Tps(xyz[,1:2], z)
      interpolated <- raster::interpolate(templateRaster, fit)
      interpolated <- if (zeroPositive) raster::calc(interpolated, sqrt) else interpolated
      return(interpolated)
    }
    
    #interpolate = function() {
    #  stop("Unimplemented abstract method.")
    #}
  )
)

# Parses result XML of the stored query fmi::observations::weather::daily::multipointcoverage in SAX fashion.
#' @import XML
#' @import sp
FMIObservationsWeatherDailyMultiPointCoverageParse <- function(fileName) {
  positionsTag <- F
  weatherTag <- F
  positions <- ""
  weather <- ""
  
  startElement <- function(tag, attrs) {
    if (tag == "gmlcov:positions") positionsTag <<- T
    else if (tag == "gml:doubleOrNilReasonTupleList") weatherTag <<- T
  }
  
  text <- function(content) {
    if (positionsTag) positions <<- paste(positions, content, sep="")
    else if (weatherTag) weather <<- paste(weather, content, sep="")
  }
  
  endElement <- function(tag) {
    if (tag == "gmlcov:positions") positionsTag <<- F
    else if (tag == "gml:doubleOrNilReasonTupleList") weatherTag <<- F
  }
  
  handlers <- list(startElement=startElement, text=text, endElement=endElement)
  xmlEventParse(fileName, handlers, useTagName=FALSE, addContext=FALSE, trim=FALSE)
  
  str <- strsplit(positions, "\\s+", fixed=F)[[1]]
  str <- str[nchar(str) > 0]
  y <- as.numeric(str[seq(1, length(str), by=3)])
  x <- as.numeric(str[seq(2, length(str), by=3)])
  epoch <- as.integer(str[seq(3, length(str), by=3)])
  date <- as.POSIXct(epoch, origin = "1970-01-01")
  
  str <- strsplit(weather, "\\s+", fixed=F)[[1]]
  str <- str[nchar(str) > 0]
  numVariables <- 5
  
  rrday <- str[seq(1, length(str), by=numVariables)]
  rrday <- as.numeric(rrday)
  rrday[rrday < 0] <- 0
  rrday[is.nan(rrday)] <- NA
  
  tday <- str[seq(2, length(str), by=numVariables)]
  tday <- as.numeric(tday)
  tday[is.nan(tday)] <- NA
  
  snow <- str[seq(3, length(str), by=numVariables)]
  snow <- as.numeric(snow)
  snow[snow < 0] <- 0
  snow[is.nan(snow)] <- NA
  
  tmin <- str[seq(4, length(str), by=numVariables)]
  tmin <- as.numeric(tmin)
  tmin[is.nan(tmin)] <- NA
  
  tmax <- str[seq(5, length(str), by=numVariables)]
  tmax <- as.numeric(tmax)
  tmax[is.nan(tmax)] <- NA
  
  weather <- SpatialPointsDataFrame(coords=cbind(x, y),
                                    data=data.frame(date=date, rrday=rrday, tday=tday, snow=snow, tmin=tmin, tmax=tmax),
                                    proj4string=CRS("+init=epsg:4326"))
  return(weather)
}

#' Retrieves daily weather time-series from weather stations in Finland.
#' 
#' Reference class for retrieving daily weather time-series from weather station in Finland provided
#' by Finnish Meteorological Institute.
#' You need to obtain API key in order to access the FMI open data,
#' https://ilmatieteenlaitos.fi/rekisteroityminen-avoimen-datan-kayttajaksi.
#' For more information, see https://en.ilmatieteenlaitos.fi/open-data.
#' For the FMI Open Data License, see http://en.ilmatieteenlaitos.fi/open-data-licence.
#'
#' The retrieved data contains the following fields:
#' \describe{
#'   \item{coordinates}{Coordinates of the weather stations.}
#'   \item{date}{Observation date.}
#'   \item{rrday}{Precipitation.}
#'   \item{tday}{Mean temperature.}
#'   \item{snow}{Snow cover depth.}
#'   \item{tmin}{Minimum temperature.}
#'   \item{tmax}{Maximum temperature.}
#' }
#' Missing data are marked with NA.
#' 
#' @import methods
#' @import raster
#' @import rgdal
#' @references See citation("gisfin")
#' @author Jussi Jousimo \email{louhos@@googlegroups.com}
#' @examples \donttest{ fmiApiKey <- "SPECIFY YOUR API KEY HERE";
#' x <- DailyWeather()
#' x$query(startDateTime=as.POSIXlt("2014-01-01"), endDateTime=as.POSIXlt("2014-01-01"), apiKey=fmiApiKey);
#' hist(x$getSPDF()@@data$tday, xlab="Temperature");
#' y <- x$interpolate();
#' plot(y[["snow"]]);
#' plot(x$getSPDF(), add=T); }
#' @exportClass DailyWeather
#' @export DailyWeather
DailyWeather <- setRefClass(
  Class = "DailyWeather",
  contains = "FMI",
  fields = list(
    spdf = "SpatialPointsDataFrame"
  ),
  methods = list(
    query = function(startDateTime, endDateTime, bbox=raster::extent(c(19.0900,59.3000,31.5900,70.130)), apiKey) {
      "Retrieves daily weather time-series from FMI. Time interval is specified with \\code{startDateTime} and \\code{endDateTime} as POSIXt objects and spatial coverage with \\code{bbox} as an extent object (defaults to whole Finland, CRS = WGS84). API key is given by \\code{apiKey}."
      
      if (missing(startDateTime))
        stop("Required argument 'startDateTime' missing.")
      if (missing(endDateTime))
        stop("Required argument 'endDateTime' missing.")
      if (missing(apiKey))
        stop("Required argument 'apiKey' missing.")
      
      storedQueryId <- "fmi::observations::weather::daily::multipointcoverage"
      parameters <- list(startTime=POSIXt2QueryDate(startDateTime),
                         endTime=POSIXt2QueryDate(endDateTime),
                         bbox=with(attributes(bbox), paste(xmin, xmax, ymin, ymax, sep=",")),
                         crs="EPSG::4326")
      fileName <- getFeature(storedQueryId=storedQueryId, parameters=parameters, apiKey=apiKey)
      x <- FMIObservationsWeatherDailyMultiPointCoverageParse(fileName)
      spdf <<- sp::spTransform(x, CRSobj=sp::CRS("+init=epsg:3067"))
      
      return(invisible(.self))
    },
    
    getSPDF = function() {
      "Returns retrieved weather data as a SpatialPointsDataFrame object."
      return(spdf)
    },
        
    # Interpolates selected field in the SPDF
    interpolateField = function(field, zeroPositive, templateRaster) {
      message("Interpolating field ", field, "...")
      xyz <- cbind(sp::coordinates(spdf), spdf@data[,field])
      interpolated <- interpolateTPS(xyz, templateRaster=templateRaster, zeroPositive=T)
      names(interpolated) <- field
      return(interpolated)
    },
    
    interpolate = function(templateRaster=raster::raster(extent(85000, 726000, 6629000, 7777000), nrows=1148, ncols=641, crs=sp::CRS("+init=epsg:3067"))) {
      "Quick & dirty interpolation of the weather data. You might want to consider other approaches for better results. Returns a RasterStack object."
      
      rasters <- raster::addLayer(raster::stack(),
                                  interpolateField("rrday", zeroPositive=T, templateRaster=templateRaster),
                                  interpolateField("tday", zeroPositive=F, templateRaster=templateRaster),
                                  interpolateField("snow", zeroPositive=T, templateRaster=templateRaster),
                                  interpolateField("tmin", zeroPositive=F, templateRaster=templateRaster),
                                  interpolateField("tmax", zeroPositive=F, templateRaster=templateRaster))
      return(rasters)
    }
  )
)
