#' @title Get geocode for given query
#' @description Get gecode for given query from one of the geocoding services:
#' OKF.fi Geocoding API Test Console: http://data.okf.fi/console/
#' OpenStreetMap Nominatim
#' (usage policy: \url{http://wiki.openstreetmap.org/wiki/Nominatim_usage_policy})
#' Google Maps API
#' See Terms and Conditions from \url{http://code.google.com/apis/maps/documentation/geocoding/}
#' 
#' @param query Either a street address, e.g. 'Mannerheimintie 100, Helsinki'
#' or place, e.g. 'Eduskuntatalo'
#' @param service Geocoding service to use, one of 'okf', 'openstreetmap' or 'google' 
#' @param raw_query If true, don't prepend / append some default parameters to query.  Except for the ones specifying json format, send the query to API as-it-is
#' @return A list with coordinates (lat, long) of the first output, and the raw output list
#' @importFrom rjson fromJSON
#' @export
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}, minor updates by Aaro Salosensaari \email{aaro.salosensaari@@helsinki.fi} and Leo Lahti.
#' @references See citation("gisfin")
#' @examples
#'  \dontrun{
#'    # Geocode for a street address:
#'    gc1 <- get_geocode("Mannerheimintie 100, Helsinki");
#' 
#'    # Geocode for a place name
#'    gc2 <- get_geocode("&city=Helsinki", service="openstreetmap", raw_query=T)
#' }
get_geocode <- function(query, service="okf", raw_query=F) {
  
  ## TODO: process outpus into similar format
  
  # Replace spaces with '+'
  query <- gsub(" ", "+", query)
  
  if (service=="okf") {
    # Access OKF geocode API
    base_uri <- "http://api.okf.fi/gis/1/geocode.json?"
    if (raw_query) {
      uri <- paste0(base_uri, query)
    } else {
      uri <- paste0(base_uri, "address=", query,"&lat=&lng=&language=fin")
    }
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
    base_uri <- "http://nominatim.openstreetmap.org/search?format=json"
    if (raw_query) {
      uri <- paste0(base_uri, query)
    } else {
      uri <- paste0(base_uri, "&q=",query)
    }
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
    base_uri <- paste0("http://maps.google.com/maps/api/geocode/json?")
    if (raw_query) {
      uri <- paste0(base_uri, query)
    } else {
      uri <- paste0(base_uri, "sensor=false&address=", query)
    }
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
