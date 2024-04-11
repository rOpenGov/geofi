#' Get Finnish municipality (multi)polygons for different years and/or scales.
#'
#' Thin wrapper around Finnish zip code areas provided by
#' [Statistics Finland](https://www.stat.fi/org/avoindata/paikkatietoaineistot/kuntapohjaiset_tilastointialueet_en.html).
#'
#' @param year A numeric for year of the administrative borders. Available are
#'             2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023 and 2024.
#' @param scale A scale or resolution of the shape. Two options: \code{1000}
#'             equals 1:1 000 000 and \code{4500} equals 1:4 500 000.
#' @param codes_as_character A logical determining if the region codes should
#'             be returned as strings of equal width as originally provided by
#'             Statistics Finland instead of integers.
#'
#' @return sf object
#'
#' @importFrom dplyr left_join
#' @importFrom dplyr %>%
#' @importFrom dplyr mutate
#' @importFrom rlang .data
#'
#' @author Markus Kainu <markus.kainu@@kela.fi>, Joona Lehtomäki <joona.lehtomaki@@iki.fi>
#'
#' @examples
#'  \dontrun{
#'  f <- get_municipalities(year=2016, scale = 4500)
#'  plot(f)
#'  }
#'
#' @rdname get_municipalities
#' @export

get_municipalities <- function(year = 2024, scale = 4500, codes_as_character = FALSE){

  # Check if you have access to http://geo.stat.fi/geoserver/wfs
  if (!check_api_access()) {
    message("You have no access to http://geo.stat.fi/geoserver/wfs.
Please check your connection, firewall settings and/or review your proxy settings")
  } else {

  # Standard and compulsory query parameters
  base_queries <- list("service" = "WFS", "version" = wfs_providers$Tilastokeskus$version)
  layer <-  paste0(wfs_providers$Tilastokeskus$layer_typename$get_municipalities, scale, "k_", year)
  # Note that there should be at least one parameter: request type.
  queries <- append(base_queries, list(request = "getFeature", typename = layer))

  api_obj <- wfs_api(base_url = wfs_providers$Tilastokeskus$URL, queries = queries)

  sf_obj <- to_sf(api_obj)
  # If the data retrieved has no CRS defined, use ETRS89 / TM35FIN
  # (epsg:3067)
  if (is.na(sf::st_crs(sf_obj))) {
    warning("Coercing CRS to epsg:3067 (ETRS89 / TM35FIN)", call. = FALSE)
    sf::st_crs(sf_obj) <- 3067
  }

  # Check if dataset is found (if package is loaded)
  dataset <- paste0("municipality_key_", year)
  if (!exists(dataset)) {
    library(geofi)
  }

  if (codes_as_character){
    muni_key <- convert_municipality_key_codes(get(paste0("municipality_key_", year)))
  } else {
    muni_key <- get(paste0("municipality_key_", year))
    }

  # Join the attribute data
  sf_obj <- left_join(sf_obj %>%
                        mutate(kunta = as.integer(as.character(.data$kunta))),
            muni_key,
            by = c("kunta" = "kunta"))

  message("Data is licensed under: ", wfs_providers$Tilastokeskus$license)

  return(sf_obj)
  }
}




