# This file is a part of the sorvi program (http://louhos.github.com/sorvi/)

# Copyright (C) 2010-2013 Louhos <louhos.github.com>. All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.




# ---------------------------------------------------------

#' Get geo code from Google Map
#'
#' Get gecode for given street address from Google Maps API
#' See Terms and Conditions from http://code.google.com/apis/maps/documentation/geocoding/
#'
#' @param str Street address, e.g. 'Mannerheimintie, 00100, FI'
#'
#' @return coordinates (lat, lon)
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @export
GetGeocodeGoogleMaps <- function(str) {

  .InstallMarginal("XML")

  u <- paste('http://maps.google.com/maps/api/geocode/xml?sensor=false&address=',str)
  doc <- XML::xmlTreeParse(u, useInternal=TRUE)
  lat <- sapply(XML::getNodeSet(doc, "/GeocodeResponse/result/geometry/location/lat"), function(el) XML::xmlValue(el))
  lon <- sapply(XML::getNodeSet(doc, "/GeocodeResponse/result/geometry/location/lng"), function(el) XML::xmlValue(el))
  return(c(lat,lon))
}


#' Get geo code from OpenStreetMap
#'
#' Get gecode for given plave from OpenStreetMap Nominatim
#' See http://wiki.openstreetmap.org/wiki/Nominatim
#'
#' @param query Either a street address, e.g. 'Mannerheimintie+100,Helsinki' or place, e.g. 'Eduskuntatalo'
#'
#' @return coordinates (lat, lon)
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @export
GetGeocodeOpenStreetMap <- function(query) {
  
  .InstallMarginal("RCurl")
  .InstallMarginal("rjson")

  u <- paste("http://nominatim.openstreetmap.org/search?q=",query,"&format=json", sep="")
  val <- RCurl::getURI(u)
  res <- rjson::fromJSON(val)
  if (length(res)>0)
    return(as.numeric(c(res[[1]]$lat, res[[1]]$lon)))
  else # Geocode not found
    return(NULL)
}


#' Get map theme
#'
#' Get black map theme for ggplot2
#'
#' @return theme_map A ggplot2 theme object
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @export
GetThemeMap <- function() {
  
  .InstallMarginal("ggplot2")
  
  theme_map <- ggplot2::theme_bw()
  theme_map$panel.background <- ggplot2::element_blank()
  theme_map$panel.grid.major <- ggplot2::element_blank()
  theme_map$panel.grid.minor <- ggplot2::element_blank()
  theme_map$axis.ticks <- ggplot2::element_blank()
  theme_map$axis.text.x <- ggplot2::element_blank()
  theme_map$axis.text.y <- ggplot2::element_blank()
  theme_map$axis.title.x <- ggplot2::element_blank()
  theme_map$axis.title.y <- ggplot2::element_blank()

  return(theme_map)  
}

