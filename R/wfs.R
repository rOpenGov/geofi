#' @title Get geospatial data from a specified web features service (WFS).
#' 
#' `wfs()` retrieves geospatial data from a WFS source and turns the retrieved
#' data into a `sf` object.
#' 
#' Function assumes that the structure of WFS, including e.g. feature layer
#' name, is known by the user. In case you need to probe the WFS layer, have
#' a look at package \link[ows4R].
#' 
#' @note In case the retrieved data does not have a coordinate reference 
#' system (CRS) defined, [ETRS89 / TM35FIN](https://epsg.io/3067) is assumed and 
#' coerced.
#' 
#' @author Markus Kainu <markus.kainu@@kela.fi>, 
#'         Joona Lehtomäki <joona.lehtomaki@@iki.fi>
#'         
#' @param url Character source WFS URL
#' @param layer Character feature layer name
#' @param serviceVersion Character service version (default: "1.0.0")
#' @param logger Character logging level (default: "INFO")
#' 
#' @return sf object
#' 
#' @examplesq
#'  \dontrun{
#'  url <- http://geo.stat.fi/geoserver/wfs
#'  layer <- paste0("tilastointialueet:kunta", 4500, "k_", 2019)
#'  version <- "1.0.0"
#'  sp_dat <- wfs(url, layer, version)
#'  }
#'
#' @rdname wfs
#' @export
#' 
wfs <- function(url, layer, serviceVersion = "1.0.0", logger = "INFO"){
  # Create a WFS client and query capabilities from the server
  wfs <- WFSClient$new(url, serviceVersion = serviceVersion, logger = logger)
  caps <- wfs$getCapabilities()
  # Get the desired feature layer using an exact match of the provided name
  ft <- caps$findFeatureTypeByName(layer, exact = TRUE)
  # Retrieve the spatial data
  shape <- ft$getFeatures()
  # If the data retrieved has no CRS defined, use ETRS89 / TM35FIN 
  # (epsg:3067)
  if (is.na(sf::st_crs(shape))) {
    warning("Coercing CRS to epsg:3067 (ETRS89 / TM35FIN)", call. = FALSE)
    sf::st_crs(shape) <- 3067
  }
  return(shape)
}