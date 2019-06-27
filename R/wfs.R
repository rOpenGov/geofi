#' @title Get geospatial data at kunta, maakunta, etc leves from MML
#' @description preprocessed geospatial data sf-objects
#' @author Markus Kainu <markus.kainu@kela.fi>
#' @param url Source data URL
#' @param layer TBA
#' @param serviceVersion Service version
#' @param logger TBA
#' @return sf-object
#' @examples
#'  \dontrun{
#'  f <- get_geo(year=2016,level="kunta")
#'  plot(f)
#'  }
#'
#' @rdname wfs
#' @export
wfs <- function(url, layer, serviceVersion = "1.0.0", logger = "INFO"){
  
  wfs <- WFSClient$new(url, serviceVersion = serviceVersion, logger = logger)
  caps <- wfs$getCapabilities()
  ft <- caps$findFeatureTypeByName(layer, exact = TRUE)
  shape <- ft$getFeatures()
  if (is.na(attributes(shape$geom)$crs[[1]])) sf::st_crs(shape) <- "+init=epsg:3067"
  return(shape)
}