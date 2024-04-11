#' Get Finnish Population grid in two different resolutions for years 2010-2022
#
#' Thin wrapper around Finnish population grid data provided by
#' [Statistics Finland](https://www.stat.fi/org/avoindata/paikkatietoaineistot/vaestoruutuaineisto_1km_en.html).
#'
#'
#' @param year A numeric for year of the population grid. Years available 2005 and 2010-2022.
#' @param resolution 1 (1km x 1km) or 5 (5km x 5km)
#'
#' @return sf object
#'
#' @author Markus Kainu <markus.kainu@@kela.fi>, Joona Lehtomäki <joona.lehtomaki@@iki.fi>
#'
#' @details
#' More information about the dataset from [Paikkatietohakemisto](https://www.paikkatietohakemisto.fi/geonetwork/srv/eng/catalog.search#/metadata/a901d40a-8a6b-4678-814c-79d2e2ab130c)
#'
#' @examples
#'  \dontrun{
#'  f <- get_population_grid(year=2017)
#'  plot(f)
#'  }
#'
#' @rdname get_population_grid
#' @export

get_population_grid <- function(year = 2022, resolution = 5){

  # Check if you have access to http://geo.stat.fi/geoserver/wfs
  if (!check_api_access()){
    message("You have no access to http://geo.stat.fi/geoserver/wfs.
Please check your connection, firewall settings and/or review your proxy settings")
  } else {

  # Standard and compulsory query parameters
  base_queries <- list("service" = "WFS", "version" = wfs_providers$Tilastokeskus$version)
  layer <-  paste0(wfs_providers$Tilastokeskus$layer_typename$get_population_grid, year, "_", resolution, "km")
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
