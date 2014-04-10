# This file is a part of the sorvi program (http://louhos.github.com/sorvi/)

# Copyright (C) 2010-2013 Louhos <louhos.github.com>. All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#' Get geocode for given query
#'
#' Get gecode for given query from one of the geocoding services:
#' OKF.fi Geocoding API Test Console: http://data.okf.fi/console/
#' OpenStreetMap Nominatim
#' (usage policy: http://wiki.openstreetmap.org/wiki/Nominatim_usage_policy)
#' Google Maps API
#' See Terms and Conditions from http://code.google.com/apis/maps/documentation/geocoding/
#' 
#' @param query Either a street address, e.g. 'Mannerheimintie 100, Helsinki'
#' or place, e.g. 'Eduskuntatalo'
#' @param service Geocoding service to use, one of 'okf', 'openstreetmap' or 'google' 
#'
#' @return list Coordinates (lat, long) of first output, and the raw output list
#' @importFrom RCurl getURI
#' @importFrom rjson fromJSON
#' @export
#' 
#' @references See citation("fingis")
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples # gc <- get_geocode("Mannerheimintie 100, Helsinki"); 
get_geocode <- function(query, service="okf") {
  
  ## TODO: process outpus into similar format
  
  # Replace spaces with '+'
  query <- gsub(" ", "+", query)
  
  if (service=="okf") {
    # Access OKF geocode API
    uri <- paste0("http://api.okf.fi/gis/1/geocode.json?address=",query,"&lat=&lng=&language=fin")
    res.json <- RCurl::getURI(uri)
    res.list <- rjson::fromJSON(res.json)
    if (res.list$status!="OK") {
      stop("No geocode found")
    } else {
      res <- list(lat=res.list$results[[1]]$geometry$location$lat,
                  lon=res.list$results[[1]]$geometry$location$lng,
                  raw.list=res.list)
    }
    
  } else if (service=="openstreetmap") {
    # Access OpenStreetMap Nominatim API
    uri <- paste0("http://nominatim.openstreetmap.org/search?format=json&q=",query)
    res.json <- RCurl::getURI(uri)
    res.list <- rjson::fromJSON(res.json)
    if (length(res.list)==0) {
      stop("No geocode found")
    } else {
      res <- list(lat=res.list[[1]]$lat,
                  lon=res.list[[1]]$lon,
                  raw.list=res.list)
      #       res <- t(sapply(res.list, function(x) as.numeric(c(x$lat, x$lon))))
      #       colnames(res) <- c("lat", "lon")
    }
    
  } else if (service=="google") {
    # Access The Google Geocoding API
    uri <- paste0("http://maps.google.com/maps/api/geocode/json?sensor=false&address=",query)
    res.json <- RCurl::getURI(uri)
    res.list <- rjson::fromJSON(res.json)
    if (res.list$status!="OK") {
      stop("No geocode found")
    } else {
      res <- list(lat=res.list$results[[1]]$geometry$location$lat,
                  lon=res.list$results[[1]]$geometry$location$lng,
                  raw.list=res.list)
    }
    
#     u <- paste('http://maps.google.com/maps/api/geocode/xml?sensor=false&address=', query)
#     doc <- XML::xmlTreeParse(u, useInternal=TRUE)
#     lat <- sapply(XML::getNodeSet(doc, "/GeocodeResponse/result/geometry/location/lat"), function(el) XML::xmlValue(el))
#     lon <- sapply(XML::getNodeSet(doc, "/GeocodeResponse/result/geometry/location/lng"), function(el) XML::xmlValue(el))
#    res <- c("lat"=lat, "lon"=lon)
#     if (length(res)==0)
#       stop("No geocode found")
    
  } else {
    stop("Invalid geocode service given")
  }
  return(res)
}


## TO BE DELETED, included in get_geocode()

# ---------------------------------------------------------

# #' Get geo code from Google Map
# #'
# #' Get gecode for given street address from Google Maps API
# #' See Terms and Conditions from http://code.google.com/apis/maps/documentation/geocoding/
# #'
# #' @param str Street address, e.g. 'Mannerheimintie, 00100, FI'
# #'
# #' @return coordinates (lat, lon)
# #' 
# #' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
# #' @export
# GetGeocodeGoogleMaps <- function(str) {
# 
#   .InstallMarginal("XML")
# 
#   u <- paste('http://maps.google.com/maps/api/geocode/xml?sensor=false&address=',str)
#   doc <- XML::xmlTreeParse(u, useInternal=TRUE)
#   lat <- sapply(XML::getNodeSet(doc, "/GeocodeResponse/result/geometry/location/lat"), function(el) XML::xmlValue(el))
#   lon <- sapply(XML::getNodeSet(doc, "/GeocodeResponse/result/geometry/location/lng"), function(el) XML::xmlValue(el))
#   return(c(lat,lon))
# }
# 
# 
# #' Get geo code from OpenStreetMap
# #'
# #' Get gecode for given plave from OpenStreetMap Nominatim
# #' See http://wiki.openstreetmap.org/wiki/Nominatim
# #'
# #' @param query Either a street address, e.g. 'Mannerheimintie+100,Helsinki' or place, e.g. 'Eduskuntatalo'
# #'
# #' @return coordinates (lat, lon)
# #' 
# #' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
# #' @export
# GetGeocodeOpenStreetMap <- function(query) {
#   
#   .InstallMarginal("RCurl")
#   .InstallMarginal("rjson")
# 
#   u <- paste("http://nominatim.openstreetmap.org/search?q=",query,"&format=json", sep="")
#   val <- RCurl::getURI(u)
#   res <- rjson::fromJSON(val)
#   if (length(res)>0)
#     return(as.numeric(c(res[[1]]$lat, res[[1]]$lon)))
#   else # Geocode not found
#     return(NULL)
# }



