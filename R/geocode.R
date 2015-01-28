# This file is a part of the helsinki package (http://github.com/rOpenGov/helsinki)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2010-2014 Juuso Parkkinen / Louhos <louhos.github.com>. 
# All rights reserved.

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
#' @return A list with coordinates (lat, long) of the first output, and the raw output list
#' @importFrom rjson fromJSON
#' @export
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @references See citation("gisfin")
#' @examples gc <- get_geocode("Mannerheimintie 100, Helsinki"); 
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
      res <- list(lat=as.numeric(res.list[[1]]$lat),
                  lon=as.numeric(res.list[[1]]$lon),
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
        
  } else {
    stop("Invalid geocode service given")
  }
  return(res)
}