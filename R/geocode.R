#' Geocode Finnish place names or street addresses using Finnish National Land Survey geocoding service
#
#' Thin wrapper around geocoding REST -api by [National Land Survey](https://www.maanmittauslaitos.fi/kartat-ja-paikkatieto/ammattilaiskayttajille/paikkatietojen-rajapintapalvelut/geokoodauspalvelu) documented at
#' [technical description geocoding service REST](https://www.maanmittauslaitos.fi/kartat-ja-paikkatieto/ammattilaiskayttajille/paikkatietojen-rajapintapalvelut/geokoodauspalvelu).
#'
#'
#' @param search_string string place name or an address
#' @param source string Source of data. One of 'interpolated-road-addresses','geographic-names', 'addresses','mapsheets-tm35' and 'cadastral-units'
#' @param output_crs string CRS of the output sf object. One of 'EPSG:3067' or 'EPSG:4326'
#' @param lang string language for values in classification api fi, sv, en
#' @param size numeric Number of hits returned
#' @param options options
#' @param api_key MML api key
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#' @export
#'
#' @return sf object
#' @examples
# geocode(search_string = "Suomenlinna",
#             source = "geographic-names",
#             api_key = Sys.getenv("MML_API_KEY"))
geocode <- function(search_string,
                    source = "interpolated-road-addresses",
                    output_crs = "EPSG:3067",
                    lang = "fi",
                    size = NULL,
                    options = NULL,
                    api_key = getOption("geofi_mml_api_key")) {

  if (!exists(x = "search_string")) stop("a search string must be provided")

  if (!source %in% c("interpolated-road-addresses",
                     "geographic-names",
                     "addresses",
                     "mapsheets-tm35",
                     "cadastral-units")){
    stop("source must be one of 'interpolated-road-addresses','geographic-names', 'addresses','mapsheets-tm35','cadastral-units'")
  }
  if (!output_crs %in% c("EPSG:3067","EPSG:4326")){
    stop("output_crs must be one of 'EPSG:3067','EPSG:4326'")
  }
  if (!lang %in% c("fi","sv","en")){
    stop("lang must be one of 'fi','se' or 'en'")
  }
  if (is.null(api_key) | api_key == ""){
    stop("api_key must be provided")
  }

  base_url = "https://avoin-paikkatieto.maanmittauslaitos.fi/geocoding/v2/pelias/search"
  queries <- paste0("?text=",
                    URLencode(search_string),
                    "&sources=",source,
                    "&crs=",output_crs,
                    "&lang=",lang,
                    "&api-key=", api_key)
  if (!is.null(size)){
    queries <- paste0(queries, "&size=", size)
  }
  if (!is.null(options)){
    queries <- paste0(queries, "&options=", options)
  }

  # Set the user agent
  ua <- httr::user_agent("https://github.com/rOpenGov/geofi")
  # Construct the query URL
  urls <- paste0(base_url, queries)

  query_geocode <- function(x, query_ua = ua, crs1=output_crs){
    # Get the response and check the response.
    resp <- httpcache::GET(x, query_ua)

    if (httr::http_error(resp)) {
      status_code <- httr::status_code(resp)
      stop(
        sprintf(
          "OGC API %s request failed\n[%s]",
          paste(x),
          httr::http_status(status_code)$message#,
        ),
        call. = FALSE
      )
    }
    resp_sf <- suppressWarnings(sf::st_read(resp, crs = as.integer(sub(".+:", "", crs1)), quiet = TRUE))
    if (nrow(resp_sf) == 0){
      return()
    } else {
      resp_sf$query <- x
      return(resp_sf)
    }
  }
  dat <- lapply(urls, query_geocode) |>
    (\(.) do.call("rbind", .))()

  return(dat)
}



#' Reverse geocode geographic locations into Finnish place names or street addresses using Finnish National Land Survey geocoding service
#
#' Thin wrapper around geocoding REST -api by [National Land Survey](https://www.maanmittauslaitos.fi/kartat-ja-paikkatieto/ammattilaiskayttajille/paikkatietojen-rajapintapalvelut/geokoodauspalvelu) documented at
#' [technical description geocoding service REST](https://www.maanmittauslaitos.fi/kartat-ja-paikkatieto/ammattilaiskayttajille/paikkatietojen-rajapintapalvelut/geokoodauspalvelu).
#'
#'
#' @param point string location plane name or an address
#' @param boundary_circle_radius numeric Boundary
#' @param size numeric
#' @param layers string
#' @param sources string
#' @param boundary_country string
#' @param api_key string  MML api key
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#'
#' @return sf object or list
#' @export
#'
#' @examples
#' suomenlinna <- data.frame(lon = 24.933333, lat = 60.1725) |>
#'   (\(.) sf::st_as_sf(., coords = c("lon","lat"), crs = 4326))()
#' geocode_reverse(point = suomenlinna,
#'             source = "geographic-names")
geocode_reverse <- function(point,
                            boundary_circle_radius = NULL,
                            size = NULL,
                            layers = NULL,
                            sources = NULL,
                            boundary_country = NULL,
                            return = "sf", # json
                            api_key = getOption("geofi_mml_api_key")) {

  if (is.null(api_key) | api_key == ""){
    stop("api_key must be provided")
  }

  if (!all(sf::st_is_valid(point))) stop("location is not a valid sf-object")

  create_queries <- function(x){
    coords <- sf::st_coordinates(x)
    query <- paste0("?point.lat=",coords[[2]],
                    "&point.lon=",coords[[1]],
                    "&api-key=", api_key)

    if (!is.null(boundary_circle_radius)){
      query <- paste0(query, "&boundary.circle.radius=", boundary_circle_radius)
    }
    if (!is.null(size)){
      query <- paste0(query, "&size=", size)
    }
    if (!is.null(layers)){
      query <- paste0(query, "&layers=", layers)
    }
    if (!is.null(sources)){
      query <- paste0(query, "&sources=", sources)
    }
    if (!is.null(boundary_country)){
      query <- paste0(query, "&boundary.country=", boundary_country)
    }
    return(query)
  }

  lst <- list()
  for (i in 1:nrow(point)){
    lst[[i]] <- create_queries(x = point[i,])
  }
  queries <- do.call("c", lst)

  ua <- httr::user_agent("https://github.com/rOpenGov/geofi")
  # Construct the query URL
  base_url = "https://avoin-paikkatieto.maanmittauslaitos.fi/geocoding/v2/pelias/reverse"
  urls <- paste0(base_url, queries)

  # Print out the URL
  # message("Requesting response from: ", url)

  query_geocode <- function(x, query_ua = ua){
    # Get the response and check the response.
    resp <- httpcache::GET(x, query_ua)
    if (return == "sf"){
      ddat <- sf::st_read(resp, quiet = TRUE)
    } else {
      ddat <- httr::content(resp, as = "parsed")
    }
  }
  if (return == "sf"){
    dat <- lapply(urls, query_geocode) |>
      (\(.)do.call("rbind", .))()
  } else {
    dat <- lapply(urls, query_geocode)
  }
  return(dat)
}




