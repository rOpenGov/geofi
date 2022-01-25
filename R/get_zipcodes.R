#' Get Finnish zip code (multi)polygons for different years.
#'
#' Thin wrapper around Finnish zip code areas provided by
#' [Statistics Finland](https://www.tilastokeskus.fi/tup/karttaaineistot/postinumeroalueet.html).
#'
#' @param year A numeric for year of the zipcodes. Years available 2015-2022.
#' @param extend_to_sea_areas A logical. Extend the data to show also the sea areas.
#'
#' @return sf object
#'
#' @author Markus Kainu <markus.kainu@@kela.fi>, Joona Lehtomäki <joona.lehtomaki@@iki.fi>
#'
#' @export
#'
#' @examples
#'  \dontrun{
#'  f <- get_zipcodes(year=2022)
#'  plot(f)
#'  }
#'
#' @rdname get_zipcodes
#' @export

get_zipcodes <- function(year = 2022, extend_to_sea_areas = FALSE){

  # Check if you have access to http://geo.stat.fi/geoserver/wfs
  if (!check_api_access()){
    message("You have no access to http://geo.stat.fi/geoserver/wfs.
Please check your connection, firewall settings and/or review your proxy settings")
  } else {

  # Standard and compulsory query parameters
  base_queries <- list("service" = "WFS", "version" = wfs_providers$Tilastokeskus$version)
  if (extend_to_sea_areas){
    layer <-  paste0(wfs_providers$Tilastokeskus$layer_typename$get_zipcodes,"meri_", year)
  } else {
    layer <-  paste0(wfs_providers$Tilastokeskus$layer_typename$get_zipcodes, year)
  }
  # Note that there should be at least one parameter: request type.
  queries <- append(base_queries, list(request = "getFeature", typename = layer))

  api_obj <- wfs_api(base_url= wfs_providers$Tilastokeskus$URL, queries = queries)

  sf_obj <- to_sf(api_obj)
  # If the data retrieved has no CRS defined, use ETRS89 / TM35FIN
  # (epsg:3067)
  if (is.na(sf::st_crs(sf_obj))) {
    warning("Coercing CRS to epsg:3067 (ETRS89 / TM35FIN)", call. = FALSE)
    sf::st_crs(sf_obj) <- 3067
  }
  message("Data is licensed under: ", wfs_providers$Tilastokeskus$license)

  return(sf_obj)
  }
}
