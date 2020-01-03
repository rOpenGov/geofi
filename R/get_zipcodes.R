#' Get Finnish zip code (multi)polygons for different years.
#' 
#' Thin wrapper around Finnish zip code areas provided by 
#' [Statistic Finland](https://www.tilastokeskus.fi/tup/karttaaineistot/postinumeroalueet.html).   
#' 
#' @param year A numeric for year of the administerative borders. Available are 
#'             2006, 2010, 2011, 2012, 2014, 2015, 2016, 2017.
#' @param ... Additional arguments passed to \code{\link{get_wfs_layer}}.
#' 
#' @return sf object
#' 
#' @author Markus Kainu <markus.kainu@@kela.fi>, Joona Lehtomäki <joona.lehtomaki@@iki.fi>
#' 
#' @seealso \code{\link{get_wfs_layer}} for how data is accessed from the 
#' source WFS.
#' 
#' @export
#' 
#' @examples
#'  \dontrun{
#'  f <- get_zipcodes(year=2017)
#'  plot(f)
#'  }
#'
#' @rdname get_zipcodes
#' @export

get_zipcodes <- function(year = 2017){
  
  # Unmutable base URL
  base_url <- "http://geo.stat.fi/geoserver/wfs"
  # Standard and compulsory query parameters
  base_queries <- list("service" = "WFS", "version" = "1.0.0")
  typename <-  paste0("postialue:pno_", year)
  
  # Note that there should be at least one parameter: request type.
  queries <- append(base_queries, list(request = request, typename = typename))
  
  api_obj <- wfs_api(base_url = base_url, request = "getFeature", queries = queries)
  
  sf_obj <- to_sf(api_obj)
  # If the data retrieved has no CRS defined, use ETRS89 / TM35FIN
  # (epsg:3067)
  if (is.na(sf::st_crs(sf_obj))) {
    warning("Coercing CRS to epsg:3067 (ETRS89 / TM35FIN)", call. = FALSE)
    sf::st_crs(sf_obj) <- 3067
  }
  return(sf_obj)
  
}