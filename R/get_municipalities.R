#' Get Finnish municipality (multi)polygons for different years and/or scales.
#' 
#' Thin wrapper around Finnish zip code areas provided by 
#' [Statistic Finland](https://www.stat.fi/org/avoindata/paikkatietoaineistot/kuntapohjaiset_tilastointialueet_en.html).  
#' 
#' @param year A numeric for year of the administerative borders. Available are 
#'             2013, 2014, 2015, 2016, 2017, 2018 and 2019.
#' @param scale A scale or resolution of the shape. Two options: \code{1000} 
#'              equals 1:1 000 000 and \code{4500} equals 1:4 500 000.
#' @param ... Additional arguments passed to \code{\link{get_wfs_layer}}.
#' 
#' @return sf object
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

get_municipalities <- function(year = 2017, scale = 4500, ...){
  
  
  # Set the user agent
  ua <- httr::user_agent("https://github.com/rOpenGov/geofi")
  
  # Unmutable base URL
  base_url <- "http://geo.stat.fi/geoserver/wfs"
  # Standard and compulsory query parameters
  base_queries <- list("service" = "WFS", "version" = "1.0.0")
  
  request <- "GetFeature"
  typename <-  paste0("tilastointialueet:kunta", scale, "k_", year)
  
  # Note that there should be at least one parameter: request type.
  queries <- append(base_queries, list(request = request, typename = typename))
  
  # Construct the query URL
  url <- httr::modify_url(base_url, query = queries)
  
  # Get the response and check the response.
  resp <- httpcache::GET(url, ua)
  
  # Parse the response XML content
  content <- xml2::read_xml(resp$content)
  # Strip the namespace as it will be only trouble
  xml2::xml_ns_strip(content)
  
  api_obj <- structure(
    list(
      url = url,
      response = resp
    ),
    class = "fmi_api"
  )
  
  api_obj$content <- content

  sf_obj <- to_sf(api_obj)
  # sf_obj <- sf_obj %>%
  #   dplyr::select(time = .data$Time, variable = .data$ParameterName,
  #                 value = .data$ParameterValue) %>%
  #   dplyr::mutate(time = lubridate::parse_date_time(.data$time, "Ymd HMS"),
  #                 variable = as.character(.data$variable),
  #                 # Factor needs to be coerced into character first
  #                 value = as.numeric(as.character(.data$value))) %>%
  #   dplyr::mutate(value = ifelse(is.nan(.data$value), NA, .data$value))
  
  # If the data retrieved has no CRS defined, use ETRS89 / TM35FIN
  # (epsg:3067)
  if (is.na(sf::st_crs(sf_obj))) {
    warning("Coercing CRS to epsg:3067 (ETRS89 / TM35FIN)", call. = FALSE)
    sf::st_crs(sf_obj) <- 3067
  }
  return(sf_obj)

}



