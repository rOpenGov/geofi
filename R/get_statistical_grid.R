#' Get Statistical grid data polygons at two different resolution
#'
#' Thin wrapper around Finnish statistical grid data provided by
#' [Statistic Finland](https://www.stat.fi/org/avoindata/paikkatietoaineistot/vaestoruutuaineisto_1km_en.html).
#'
#' @param resolution integer 1 (1km x 1km) or 5 (5km x 5km)
#' @param auxiliary_data logical Whether to include auxiliary data containing municipality membership data. Default \code{FALSE}
#'
#' @return sf object
#'
#' @author Markus Kainu <markus.kainu@@kela.fi>, Joona Lehtomäki <joona.lehtomaki@@iki.fi>
#'
#' @export
#'
#' @examples
#'  \dontrun{
#'  f <- get_statistical_grid(resolution = 5, auxiliary_data = FALSE)
#'  plot(f)
#'  }
#'
#' @rdname get_statistical_grid
#' @export

get_statistical_grid <- function(resolution = 5, auxiliary_data = FALSE){

  # Check if you have access to http://geo.stat.fi/geoserver/wfs
  if (!check_api_access()){
    message("You have no access to http://geo.stat.fi/geoserver/wfs.
Please check your connection, firewall settings and/or review your proxy settings")
  } else {

  # Standard and compulsory query parameters
  base_queries <- list("service" = "WFS", "version" = wfs_providers$Tilastokeskus$version)
  layer <-  paste0(wfs_providers$Tilastokeskus$layer_typename$get_statistical_grid, resolution, "km")
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

  if (auxiliary_data){
    aux_data <- utils::read.csv(paste0("http://geo.stat.fi/geoserver/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=tilastointialueet:hila",resolution,"km_linkki&outputFormat=csv"))
    sf_obj <- dplyr::left_join(sf_obj, aux_data)
  }

  message("Data is licensed under: ", wfs_providers$Tilastokeskus$license)

  return(sf_obj)
  }
}
