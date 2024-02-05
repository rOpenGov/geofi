#' Get Number of population by Finnish municipality (multi)polygons for different years.
#'
#' Thin wrapper around Finnish zip code areas provided by
#' [Statistics Finland](https://www.stat.fi/org/avoindata/paikkatietoaineistot/vaesto_tilastointialueittain_en.html).
#'
#' The number of population on the last day of the reference year combined with municipality borders from year after.
#' Calling the function with year = 2019 returns population data from 2019-12-31 with spatial data from 2020.
#'
#' The statistical variables in the data are: total population (vaesto), share of the total population (vaesto_p), number of men (miehet), men's share of the population in an area (miehet_p) and women (naiset), women's share (naiset_p), those aged under 15: number (ika_0_14), share (ika_0_14p), those aged 15 to 64: number (ika_15_64), share (ika_15_64p), and aged 65 or over: number (ika_65_), share (ika_65_p).
#'
#' @param year A numeric for year of the administrative borders. Available are
#'             2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021 and 2022.
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
#'  f <- get_municipality_pop(year=2020)
#'  plot(f)
#'  }
#'
#' @rdname get_municipality_pop
#' @export

get_municipality_pop <- function(year = 2022, codes_as_character = FALSE){

  # Check if you have access to http://geo.stat.fi/geoserver/wfs
  if (!check_api_access()) {
    message("You have no access to http://geo.stat.fi/geoserver/wfs.
Please check your connection, firewall settings and/or review your proxy settings")
  } else {

  # Standard and compulsory query parameters
  base_queries <- list("service" = "WFS", "version" = wfs_providers$Tilastokeskus$version)
  layer <-  paste0(wfs_providers$Tilastokeskus$layer_typename$get_municipality_pop, year)
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




